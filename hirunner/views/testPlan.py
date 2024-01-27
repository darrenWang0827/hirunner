from rest_framework.viewsets import ModelViewSet
from hirunner.models import TestPlanTable, TestPlanRunHistoryTable, ReleasePlanTable
from django.db.models import Q
from hirunner.serializers import TestPlanSerializer, TestPlanRunHistorySerializer
from rest_framework.response import Response
import rest_framework.status
from hirunner.views.task import scheduler
from apscheduler.triggers.cron import CronTrigger
from hirunner.views.run import run_testPlan_via_jenkins_engine
from apscheduler.jobstores.base import JobLookupError

from hirunner.log import d_log

logger = d_log(__name__)


class TestPlanViewSet(ModelViewSet):
    queryset = TestPlanTable.objects.all()
    serializer_class = TestPlanSerializer

    def create(self, request, *args, **kwargs):
        product_id = request.data.get("productId")
        version_no = request.data.get("versionNo")
        releasePlan = ReleasePlanTable.objects.get(product_id=product_id, name=version_no)
        data = dict(request.data)
        data["releasePlanId"] = releasePlan.release_plan_id
        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)

        data = serializer.data

        id = serializer.instance.id
        release_plan_id = request.data.get("releasePlanId")
        git_repository = request.data.get("gitRepository")
        git_branch = request.data.get("gitBranch")
        status = request.data.get("status")
        run_cmd = request.data.get("runCmd")
        crontab_switch = request.data.get("crontabSwith")
        crontab_expression = request.data.get("crontabExpression")
        crontab_email = request.data.get("crontabEmail")
        email_switch = request.data.get("emailSwitch")
        email_sendto = request.data.get("emailSendto")
        jenkins_node = request.data.get("jenkinsNode")
        task_added = ""
        if status in ["已开启", 1]:
            if crontab_switch in ["已开启", 1]:
                run_user_nickname = "定时任务"
                task_added = scheduler.add_job(func=run_testPlan_via_jenkins_engine,
                                               trigger=CronTrigger.from_crontab(crontab_expression),
                                               id="testplan_" + str(id),
                                               args=[run_user_nickname, product_id, release_plan_id, id,
                                                     git_repository, git_branch, run_cmd, email_switch, email_sendto,
                                                     jenkins_node],
                                               max_instances=1,
                                               replace_existing=True)
            elif crontab_switch in ["已关闭", 0]:
                try:
                    task_added = scheduler.remove_job("testplan_" + str(id))
                except JobLookupError:
                    task_added = "task removed"
        headers = self.get_success_headers(serializer.data)
        data["taskAdded"] = str(task_added)
        # 疑问：数据库怎么入库的呢？viewSet的create方法中有个performcreate函数，这个函数中调用了serializer.save
        return Response(data, status=rest_framework.status.HTTP_201_CREATED, headers=headers)

    def update(self, request, *args, **kwargs):
        id = kwargs["pk"]
        product_id = request.data.get("productId")
        release_plan_id = request.data.get("releasePlanId")
        dev_users = request.data.get("devUsers")
        test_users = request.data.get("testUsers")
        git_repository = request.data.get("gitRepository")
        git_branch = request.data.get("gitBranch")
        run_cmd = request.data.get("runCmd")
        status = request.data.get("status")
        crontab_switch = request.data.get("crontabSwitch")
        crontab_expression = request.data.get("crontabExpression")
        email_switch = request.data.get("emailSwitch")
        email_sendto = request.data.get("emailSendto")
        jenkins_node = request.data.get("jenkinsNode")

        task_updated = ""
        if status in ["已开启", 1] and crontab_switch in ["已开启", 1]:
            try:
                scheduler.remove_job("testplan_" + str(id))
            except JobLookupError:
                pass
            run_user_nickname = "定时任务"
            task_added = scheduler.add_job(func=run_testPlan_via_jenkins_engine,
                                           trigger=CronTrigger.from_crontab(crontab_expression),
                                           id="testplan_" + str(id),
                                           args=[run_user_nickname, product_id, release_plan_id, id,
                                                 git_repository, git_branch, run_cmd, email_switch, email_sendto,
                                                 jenkins_node],
                                           max_instances=1,
                                           replace_existing=True)
        else:
            try:
                task_updated = scheduler.remove_job("testplan_" + str(id))
            except JobLookupError:
                task_updated = "task removed"

        partial = kwargs.pop('partial', False)
        instance = self.get_object()
        serializer = self.get_serializer(instance, data=request.data, partial=partial)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        if getattr(instance, '_prefetched_objects_cache', None):
            instance._prefetched_objects_cache = {}
        data = serializer.data
        logger.info(data)
        data["taskUpdated"] = str(task_updated)
        return Response(data)

    def list(self, request, *args, **kwargs):
        productId = request.GET.get("productId")
        releasePlanNameKw = request.GET.get("releasePlanNameKw")
        versionNo = request.GET.get("versionNo")
        releasePlan = ReleasePlanTable.objects.filter(product_id=productId, release_plan_name_kw=releasePlanNameKw,
                                                      name=versionNo)
        if releasePlan:
            query = Q(release_plan_id = releasePlan[0].release_plan_id)
            queryset = TestPlanTable.objects.filter(query).order_by('-id')
            page = self.paginate_queryset(queryset)
            if page is not None:
                serializer = self.get_serializer(page,many=True)
                return self.get_paginated_response(serializer.data)
            serializer = self.get_serializer(queryset,many=True)
            return Response(serializer.data)
        else:
            return Response({})

    def destroy(self,request,*args,**kwargs):
        id = kwargs["pk"]
        try:
            scheduler.remove_job("test_plan_"+str(id))
        except JobLookupError:
            pass
        instance = self.get_object()
        self.perform_destroy(instance)
        return Response(status = rest_framework.status.HTTP_204_NO_CONTENT)

class TestPlanRunHistorySet(ModelViewSet):
    queryset = TestPlanRunHistoryTable.objects.all()
    serializer_class = TestPlanRunHistorySerializer

    def list(self,request,*args,**kwargs):
        test_plan_id = kwargs["test_plan_id"]
        query = Q(test_plan_id=test_plan_id)
        queryset = TestPlanRunHistoryTable.objects.filter(query).order_by('run_time')
        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page,many=True)
            return self.get_paginated_response(serializer.data)
        serializer = self.get_serializer(queryset,many=True)
        return  Response(serializer.data)
