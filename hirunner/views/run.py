#!/usr/bin/python
# encoding=utf-8
import json
import os
import re
import sys
from concurrent.futures.thread import ThreadPoolExecutor

import jwt
import yaml
from django.core.exceptions import ObjectDoesNotExist
from django.db.models import Q
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from hirunner.models import ProductTable, ProductPlanConfigModel, TestPlanTable, TestPlanRunHistoryTable, \
    ReleasePlanTable
from hirunner.serializers import (ProductSerializer, ProductPlanConfigSerializer, TestPlanSerializer,
                                  TestPlanRunHistorySerializer, ReleasePlanSerializer)

from util.MysqlTool import Mysql
from django.conf import settings
from hirunner.enum import Enum_test_plan_config_default
from util.Jenkins import Jenkins

from hirunner.log import d_log

logger = d_log(__name__)


def create_product_default_plan_config(product_id, product_name, release_plan_name_kw):
    product_plan_configs = ProductPlanConfigModel.objects.filter(product_id=product_id,
                                                                 release_plan_name_kw=release_plan_name_kw)
    # 没有默认配置的计划清单，则初始化创建几个
    if not product_plan_configs:
        logger.info(
            f"default plan config list of product {product_name}-{release_plan_name_kw} not exist, start to create")
        for stage in Enum_test_plan_config_default:
            data = {
                "productId": int(product_id),
                "releasePlanNameKw": release_plan_name_kw,
                "productName": product_name,
                "stage": stage[0],
                "planAliasName": stage[1] + "计划",
                "gitRepository": "",
                "gitBranch": "",
                "jenkinsNode": "node-192.168.1.9",
                "runCmd": "",
                "contabSwitch": 0,
                "crontabExpression": "",
                "emailSwitch": 0,
                "emailSendto": "",
            }
            logger.info(data)
            serializer = ProductPlanConfigSerializer(data=data)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            logger.info(f"default plan config {stage[1]}计划 of product {product_name}-{release_plan_name_kw} created")


def pull_release_version(product_id, product_name, release_plan_name_kw):
    create_product_default_plan_config(product_id, product_name, release_plan_name_kw)

    dpmsCdpDbConfig = settings.DPMS_DB_CONFIG
    dpmsCdpDb = Mysql(ip=dpmsCdpDbConfig["ip"], port=dpmsCdpDbConfig["port"], user=dpmsCdpDbConfig["user"],
                      password=dpmsCdpDbConfig["passwd"], database=dpmsCdpDbConfig["dbname"])
    sql = (f"select id as release_plan_id,name,product_id,start_date,end_date,uat_end_date,start_release_date,"
           f"actual_end_date,start_test_date,start_uat_test_date,status from t_release_plan where is_delete=0 and "
           f"product_id={product_id} and start_release_date is not NULL and status in (2,3)")
    if release_plan_name_kw:
        sql = sql + f" and name like '%{release_plan_name_kw}%' "
    table_datas = dpmsCdpDb.select(sql)
    for data in table_datas:
        dataNew = {
            "releasePlanId": int(data["release_plan_id"]),
            "productId": int(data["product_id"]),
            "name": data["name"],
            "startDate": str(data["start_date"]) if data["start_date"] else None,
            "endDate": str(data["end_date"]) if data["end_date"] else None,
            "uatEndDate": str(data["uat_end_date"]) if data["uat_end_date"] else None,
            "startReleaseDate": str(data["start_release_date"]) if data["start_release_date"] else None,
            "actualEndDate": str(data["actual_end_date"]) if data["actual_end_date"] else None,
            "startTestDate": str(data["start_test_date"]) if data["start_test_date"] else None,
            "startUatTestDate": str(data["start_uat_test_date"]) if data["start_uat_test_date"] else None,
            "status": int(data["status"]),
            "versionNo": "",
            "releasePlanNameKw": release_plan_name_kw
        }
        logger.info(f"pulled a release plan for {product_name}-{release_plan_name_kw}: {json.dumps(dataNew)}")
        try:
            instance = ReleasePlanTable.objects.filter(release_plan_id=dataNew["releasePlanId"])
            if instance:
                serializer = ReleasePlanSerializer(data=dataNew, instance=instance[0])
                serializer.is_valid(raise_exception=True)
                serializer.save()
            else:
                serializer = ReleasePlanSerializer(data=dataNew)
                serializer.is_valid()
                serializer.save()
                # 开始初始化测试执行计划
                product = ProductTable.objects.get(product_id=dataNew["productId"],
                                                   release_plan_name_kw=release_plan_name_kw)
                if dataNew["status"] in [3, 2]:
                    # 查找产品的默认配置计划清单
                    planConfigList = ProductPlanConfigModel.objects.filter(product_id=product_id,
                                                                           release_plan_name_kw=release_plan_name_kw)
                    if planConfigList:
                        logger.info(
                            f"the default plan config list of {product_name}-{release_plan_name_kw} exist, start to create plan")
                        for planConfig in planConfigList:
                            data = {
                                "name": dataNew["name"] + "——" + planConfig.plan_alias_name,
                                "releasePlanId": dataNew["releasePlanId"],
                                "productId": dataNew["productId"],
                                "releasePlanNameKw": release_plan_name_kw,
                                "stage": planConfig.stage,
                                "devUsers": planConfig.dev_users,
                                "testUsers": product.test_users,
                                "gitRepository": planConfig.git_repository,
                                "gitBranch": planConfig.git_branch,
                                "jenkinsNode": planConfig.jenkins_node,
                                "runCmd": planConfig.run_cmd,
                                "status": 0,
                                "crontabSwitch": planConfig.crontab_switch,
                                "crontabExpression": planConfig.crontab_expression,
                                "emailSwitch": planConfig.email_switch,
                                "emailSendto": planConfig.email_sendto,
                                "versionNo": dataNew["versionNo"]
                            }
                            serializer = TestPlanSerializer(data=data)
                            serializer.is_valid(raise_exception=True)
                            serializer.save()
                            logger.info(f"test plan {json.dumps(data)} created")
        except Exception as e:
            s = sys.exc_info()
            logger.info(f"create test plan failed at line {s[2].tb_lineno}: {e}")


def pull_release_version_engine(product_id, product_name, release_plan_name_kw):
    thread_pool = ThreadPoolExecutor()
    args = (pull_release_version, product_id, product_name, release_plan_name_kw)
    thread_pool.submit(*args)


def run_testPlan_via_jenkins_engine(run_user_nickname, test_plan_id, git_repository, git_branch, run_cmd, email_switch,
                                    email_sendto, jenkins_node):
    data = {
        "testPlanId": test_plan_id,
        "result": "",
        "elapsed": "",
        "output": "",
        "caseNumAll": "",
        "caseNumSuccess": "",
        "reportUrl": "",
        "runUserNickname": run_user_nickname,
        "status": 0
    }
    run_his = TestPlanRunHistorySerializer(data=data)
    if run_his.is_valid(raise_exception=True):
        run_his.save()
    execute_id = run_his.instance.id
    thread_pool = ThreadPoolExecutor()
    args = (
        run_testPlan_via_jenkins, git_repository, git_branch, run_cmd, test_plan_id, run_user_nickname, email_switch,
        email_sendto, execute_id, jenkins_node)
    thread_pool.submit(*args).add_done_callback(save_testPlan_result_jenkins)


def run_testPlan_via_jenkins(git_repository, git_branch, run_cmd, test_plan_id, run_user_nickname, email_switch,
                             email_sendto, execute_id, jenkins_node):
    myjenkins = Jenkins()
    hasError = True
    if not myjenkins.check_if_node_online(nodename=jenkins_node):
        output = f"jenkins节点{jenkins_node}不在线，请检查"
        hasError = True
        return output, run_user_nickname, email_switch, email_sendto, execute_id, hasError
    git_name = re.findall(r"^.*/(.*).git", git_repository)[0]
    ret = myjenkins.start_job(job_name=settings.JENKINS_JOB_NAME,
                              node=jenkins_node,
                              git_repository=git_repository,
                              git_branch=git_branch,
                              runner_dir=f"D:/jenkins/hirunner/{test_plan_id}/",
                              src_dir=f"D:/jenkins/hirunner/{test_plan_id}/{git_name}/",
                              git_pull="true",
                              run_cmd=run_cmd,
                              git_name=git_name,
                              execute_info=json.dumps({"execute_id": execute_id})
                              )
    job_name, build_number = myjenkins.check_if_job_started(queue_id=ret)
    build_result, output = ("FAILURE", "")
    if build_number:
        run_his = TestPlanRunHistoryTable.objects.get(id=execute_id)
        run_his.jenkins_log_url = settings.JENKINS_JOB_EXCUTE_URL + f"/{build_number}/console"
        run_his.save()
        build_result, output = myjenkins.check_if_job_done(job_name, build_number)
    return output, test_plan_id, run_user_nickname, email_switch, email_sendto, execute_id, hasError, build_number


def save_testPlan_result_jenkins(result):
    output, test_plan_id, run_user_nickname, email_switch, email_sendto, execute_id, hasError, build_number = result.result()
    data = {
        "testPlanId": int(test_plan_id),
        "result": "",
        "output": output,
        "elapsed": "",
        "caseNumAll": "",
        "caseNumSuccess": "",
        "reportUrl": "",
        "runUserNickname": run_user_nickname,
        "status": 1,
    }
    run_his = TestPlanRunHistoryTable.objects.get(id=execute_id)
    if hasError:
        data["status"] = 4
    serializer = TestPlanRunHistorySerializer(run_his, data=data, partial=True)
    serializer.is_valid(raise_exception=True)
    serializer.save()
    # 其他邮件异步回调通知等


@api_view(['POST'])
def run_testPlan(request, *args, **kwargs):
    test_plan_id = kwargs["pk"]
    # 防重入
    run_his = TestPlanRunHistoryTable.objects.filter(test_plan_id=test_plan_id, status=0)
    if len(run_his) > 0:
        return Response({"msg": "当前计划存在执行未结束的作业，请等待一段时间后执行"})
    testPlan = TestPlanTable.objects.get(id=test_plan_id)
    product_id = testPlan.product_id
    release_plan_id = testPlan.release_plan_id
    git_repository = testPlan.git_repository
    run_cmd = testPlan.run_cmd
    git_branch = testPlan.git_branch
    jenkins_node = testPlan.jenkins_node
    email_switch = testPlan.email_switch
    email_sendto = testPlan.email_sendto
    request_jwt = request.headers.get("Authorization").replace("Bearer ", "")
    request_jwt_decoded = jwt.decode(request_jwt, verify=False, algorithms=['HS512'])
    run_user_nickname = request_jwt_decoded["username"]
    run_testPlan_via_jenkins_engine(run_user_nickname, test_plan_id, git_repository, git_branch, run_cmd, email_switch,
                                    email_sendto, jenkins_node)

    return Response({"msg": "计划启动成功,请等待结果通知"}, status=status.HTTP_200_OK)
