from django.db import models
from hirunner.enum import Enum_table_base_status, Enum_release_plan_status, Enum_test_plan_stage


# Create your models here.
class BaseTable(models.Model):
    class Meta:
        abstract = True
        db_table = 'BaseTable'

    created_at = models.DateTimeField('创建时间', auto_now_add=True)
    updated_at = models.DateTimeField('更新时间', auto_now=True)


class ProductTable(BaseTable):
    class Meta:
        db_table = "product"

    # id = models.IntegerField("dpms_id",primary_key=True,null=False) # 注释不写
    product_id = models.IntegerField("产品id", null=False)
    name = models.CharField("产品名称", unique=True, max_length=100, null=False)
    release_plan_name_kw = models.CharField("发布计划名称关键字", max_length=100, null=True,
                                            blank=True)  # null=True和blank=True,使得None在序列化时转为空学符串
    dev_users = models.CharField("开发负责人", max_length=100, null=False)
    test_users = models.CharField("测试负责人", max_length=100, null=False)
    # git_repository = models.CharFiled("Git仓库，max_Length=oo,nuu=False) # 不用了
    # git_branch = models.CharField(Git分支max_Length=ioo,nul=False)  # 不用了
    status = models.IntegerField("状态", null=True, blank=True, choices=Enum_table_base_status, default=1)


class ProductPlanConfigModel(BaseTable):
    class Meta:
        db_table = "product_plan_config"

    product_id = models.IntegerField("产品id", null=False)
    release_plan_name_kw = models.CharField("发布计划名称关键字", max_length=100, null=True,
                                            blank=True)  # null=True和blank=True会使得None在序列化时转为空字符串
    product_name = models.CharField("产品名称", max_length=100, null=False)
    stage = models.CharField("测试阶段", max_length=20, null=False, choices=Enum_test_plan_stage)
    plan_alias_name = models.CharField("测试计划别名", max_length=100, null=False)
    git_repository = models.CharField("git仓库", max_length=100, null=True, blank=True)
    git_branch = models.CharField("git分支", max_length=100, null=True, blank=True)
    run_cmd = models.TextField("执行python命令", max_length=300, null=True, blank=True)
    crontab_switch = models.IntegerField("定时任务开关", null=False, default="0")
    crontab_expression = models.CharField("定时任务表达式", max_length=20, null=True, blank=True)
    email_switch = models.IntegerField("邮件开关", null=False, default="0")
    email_sendto = models.CharField("邮件发送人", max_length=100, null=False)
    jenkins_node = models.CharField("jenkins node节点", max_length=100, null=False)


class ReleasePlanTable(BaseTable):
    class Meta:
        db_table = "release_plan"

    # id=models.IntegerField("发布计划id",primary_key=True,null=False)
    product_id = models.IntegerField("产品id", null=False)
    release_plan_name_kw = models.CharField("发布计划名称关键字", max_length=100, null=True,
                                            blank=True)  # null=True和bLank=True会使得None在序列化时转为空字符串
    release_plan_id = models.IntegerField("发布计划id", null=False)
    name = models.CharField("发布计划名称", max_length=100, null=False)
    start_date = models.DateField("开始日期", null=True, blank=True)
    end_date = models.DateField("结东日期", null=True, blank=True)
    uat_end_date = models.DateField("UAT计划结束日期", null=True, blank=True)
    start_release_date = models.DateField("开始发布日期", null=False)
    actual_end_date = models.DateField("实际结束日期", null=True, blank=True)
    start_test_date = models.DateField("开始测日期", null=True, blank=True)
    start_uat_test_date = models.DateField("UAT测试开始日期", null=True, blank=True)
    status = models.IntegerField("状态", null=True, blank=True, choices=Enum_release_plan_status)
    version_no = models.CharField("版本号", max_length=30, null=False)


class TestPlanRunHistoryTable(BaseTable):
    class Meta:
        db_table = "test_plan_run_history"

    test_plan_id = models.IntegerField("测i计划id", null=False)
    result = models.CharField("运行结果:", max_length=50, null=True, blank=True)
    elapsed = models.CharField("耗时", max_length=50, null=True, blank=True)
    output = models.TextField("输出日志", null=True, blank=True, default="")
    case_num_all = models.CharField("总用例数", max_length=10, null=True, blank=True)
    case_num_success = models.CharField("成功用例数", max_length=10, null=True, blank=True)
    report_url = models.CharField("测i试报告连接", max_length=100, null=True, blank=True)
    run_user_nickname = models.CharField("运行用户昵称", null=True, blank=True, max_length=64)
    run_time = models.DateTimeField("运行时间", auto_now=True, blank=True)
    status = models.IntegerField("状态", null=False, choices=Enum_table_base_status)
    jenkins_log_url = models.CharField("jenkins作业执行详情连接", max_length=100, null=True, blank=True)


class TestPlanTable(BaseTable):
    class Meta:
        db_table = "test_plan"

    # id = modeLs.IntegerField("测试计划id",primary_key=True，null=False) #不需要外部传入的id，就不要在这里注册了否则会引起报错
    name = models.CharField("测试计划名称", max_length=200, null=False)
    release_plan_id = models.IntegerField("发布计划id", null=True, blank=True)
    version_no = models.CharField("版本号", max_length=30, null=False)
    product_id = models.IntegerField("产品id", null=False)
    stage = models.CharField("测试阶段", max_length=20, null=False, choices=Enum_test_plan_stage)
    dev_users = models.CharField("开发负责人", max_length=100, null=True, blank=True)
    test_users = models.CharField("测试负责人", max_length=100, null=True, blank=True)
    git_repository = models.CharField("git仓库", max_length=100, null=True, blank=True)
    git_branch = models.CharField("git分支", max_length=100, null=True, blank=True)
    run_cmd = models.TextField("执行python命令", max_length=300, null=True, blank=True)
    status = models.IntegerField("状态", null=False, choices=Enum_table_base_status)
    crontab_switch = models.IntegerField("定时任务开关", null=False, default="o")
    crontab_expression = models.CharField("定时任务表达式", max_length=20, null=True, blank=True)
    email_switch = models.IntegerField("邮件开关", null=False, default="o")
    email_sendto = models.CharField("邮件发送人", max_length=100, null=False)
    jenkins_node = models.CharField("jenkins node节点", max_length=100, null=False)

