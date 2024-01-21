import jenkins
import requests
from requests.auth import HTTPBasicAuth
import time

from django.conf import settings


class Jenkins:
    __attrs__ = ["session", "baseUrl", "username", "password", "apiToken"]

    def __init__(self):
        self.baseUrl = settings.JENKINS_BASE_URL
        self.username = "admin"
        self.password = "Ch8d%hdhxt"
        self.apiToken = "1cb61ee4346f17750e7efc3efdc03cb6c"
        self.server = jenkins.Jenkins(url=self.baseUrl, username=self.username, password=self.apiToken)

    def start_job(self, job_name="hirunner_run_python_job", node="node-19.168.1.9",
                  git_repository="https://github.com/darrenWang0827/hirunner-backend.git", git_branch="master",
                  runner_dir="D:/jenkins/hirunner/", src_dir="/jenkins/hirunner/hitest/", git_pull="true",
                  run_cmd="python3 run_test.py", git_name="hitest", execute_info='''
    {
        "execute_id":"执行记录id"
    }
    '''):
        """
        启动作业
        :param job_name:
        :param node:
        :param git_repository:
        :param git_branch:
        :param runner_dir:
        :param src_dir:
        :param git_pull:
        :param run_cmd:
        :param git_name:
        :param execute_info:
        :return:失败返回(None,None),成功返回('SUCCESS',build_number)
        """
        parameters = {
            "NODE": node,
            "GIT_REPOSITORY": git_repository,
            "GIT_BRANCH": git_branch,
            "RUNNER_DIR": runner_dir,
            "GIT_NAME": git_name,
            "SRC_DIR": src_dir,
            "GIT_PULL": git_pull,
            "RUN_CMD": run_cmd,
            "EXCUTE_INFO": execute_info
        }
        queue_id = self.server.build_job(job_name, parameters=parameters)
        return queue_id

    def check_if_job_started(self,queue_id):
        ifDone = False
        while not ifDone:
            rsp = requests.get(self.baseUrl+f"/queue/item/{queue_id}/api/json",auth=HTTPBasicAuth(username=self.username,password=self.apiToken))
            if rsp.status_code == 200:
                build_info = rsp.json()
                executable = build_info.get("executable")
                if executable:
                    ifDone = True
                    build_number = executable.get("number")
                    job_name = executable.get("url").split("/")[-3]
                    return job_name,build_number
            elif rsp.status_code == 404:
                ifDone = True
                return None,None
            time.sleep(1)
        return None,None

    def check_if_job_done(self,job_name:str="hirunner_run_python_job",build_number:int=None):
        """
        根据作业的构建号，查询执行结果是否结束
        :param job_name:
        :param build_number:
        :return: 失败返回(None,None),成功返回('SUCCESS',output)
        """
        ifDone = False
        while not ifDone:
            build_response = requests.get(self.baseUrl+f"/job/{job_name}/{build_number}/api/json",auth=HTTPBasicAuth(username=self.username,password=self.apiToken))
            if build_response.status_code == 200:
                build_result = build_response.json().get("result")
                if build_result:
                    output = self.server.get_build_console_output(name=job_name,number=build_number)
                    return build_result,output
            time.sleep(60)
        return None,None

    def check_if_node_online(self,nodename):
        """
        检查node是否在线
        :param nodename:
        :return:
        """
        if not nodename or not self.server.node_exists(name=nodename):
            node = self.server.get_node_info(name=nodename)
        if not node["offline"]:
            return True
        return False