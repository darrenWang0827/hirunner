#!/usr/bin/python
# encoding=utf-8

from django.core.exceptions import ObjectDoesNotExist
from rest_framework import serializers

from hirunner.models import ProductTable, ProductPlanConfigModel, TestPlanTable, TestPlanRunHistoryTable, ReleasePlanTable
from hirunner.enum import Enum_table_base_status, Enum_release_plan_status, Enum_test_plan_stage, \
    Enum_table_base_task_status


class CustomChoiceField(serializers.ChoiceField):
    """overwrite ChoiceField"""

    def to_representation(self, obj):
        if obj == '' and self.allow_blank:
            return obj
        return self._choices[obj]

    def to_internal_value(self, data):
        """支持choice的key或value名称的写入"""
        for k, v in self._choices.items():
            # 这样无论用户POST上来但是CHOICES的Key还是Value都能被接受
            if k == data or str(k) == data or v == data:
                return k
        raise serializers.ValidationError("Acceptable values are {0}.".format(list(self._choices.values())))


class ProductSerializer(serializers.ModelSerializer):
    productId = serializers.IntegerField(source="product_id", required=True)
    devUsers = serializers.CharField(source="dev_users", allow_null=True, allow_blank=True)  # null=False的写法是Model里边的
    testUsers = serializers.CharField(source="test_users", allow_null=False, allow_blank=False)
    # gitRepository = serializers.CharField(source="git_repository",required=True,allow_null=False,allow_blank=False)
    # gitBranch=serializers.CharField(source="git_branch",required =True, allow_null = False, allow_blank=False)
    releasePlanNameKw = serializers.CharField(source="release_plan_name_kw", allow_null=True, allow_blank=True)
    status = CustomChoiceField(choices=Enum_table_base_status, default=1)

    class Meta:
        model = ProductTable
        exclude = [field.name for field in ProductTable._meta.fields if "_" in field.name]


class ProductPlanConfigSerializer(serializers.ModelSerializer):
    productId = serializers.IntegerField(source="product_id", required=True)
    productName = serializers.CharField(source="product_name", required=True)
    releasePlanNameKw = serializers.CharField(source="release_plan_name_kw", allow_null=True, allow_blank=True)
    stage = CustomChoiceField(choices=Enum_test_plan_stage)
    planAlasName = serializers.CharField(source="plan_alias_name", required=True)
    gitRepository = serializers.CharField(source="git_repository", required=False, allow_null=True, allow_blank=True)
    gitBranch = serializers.CharField(source="git_branch", required=False, allow_null=True, allow_blank=True)
    runCmd = serializers.CharField(source="run_cmd", required=False, allow_null=True, allow_blank=True)
    crontabSwitch = CustomChoiceField(source="crontab_switch", choices=Enum_table_base_status)
    crontabExpression = serializers.CharField(source="crontab_expression", required=False, allow_null=True,
                                              allow_blank=True)  # 非空字段要加allow_null=True，allow_blank=True
    emailSwitch = CustomChoiceField(source="email_switch", choices=Enum_table_base_status)
    emailsSendto = serializers.CharField(source="email_sendto", required=False, allow_null=True, allow_blank=True)
    jenkinsNode = serializers.CharField(source="jenkins_node", required=True, allow_null=False, allow_blank=False)

    class Meta:
        model = ProductPlanConfigModel
        exclude = [field.name for field in ProductPlanConfigModel._meta.fields if "_" in field.name]


class ReleasePlanSerializer(serializers.ModelSerializer):
    releasePlanId = serializers.IntegerField(source="release_plan_id", required=True)
    productId = serializers.IntegerField(source="product_id",
                                         required=True)  # 看源码，int类型没有,allow_null=False,allow_blank=False
    releasePlanNameKw = serializers.CharField(source="release_plan_name_kw", allow_null=True, allow_blank=True)
    startDate = serializers.DateField(source="start_date",
                                      allow_null=True)  # 这个allow_null默认是False，如果是允许为空则必须填写，不然序列号检查时如果有None数据会报销
    endDate = serializers.DateField(source="end_date", allow_null=True)
    uatEndDate = serializers.DateField(source="uat_end_date", allow_null=True)
    startReleaseDate = serializers.DateField(source="start_release_date", allow_null=True)
    actualEndDate = serializers.DateField(source="actual_end_date", allow_null=True)
    startTestDate = serializers.DateField(source="start_test_date", allow_null=True)
    startUatTestDate = serializers.DateField(source="start_uat_test_date", allow_null=True)
    versionNo = serializers.CharField(source="version_no", required=True, allow_null=False, allow_blank=False)
    status = CustomChoiceField(choices=Enum_release_plan_status)

    class Meta:
        model = ReleasePlanTable
        exclude = [field.name for field in ReleasePlanTable._meta.fields if "_" in field.name]

    def get_startDate(self, instance):
        return instance.start_date.strftime("%y-%m-%d") if instance.start_date else ""

    def get_endDate(self, instance):
        return instance.end_date.strftime("%y-%m-%d") if instance.end_date else ""

    def get_startReleaseDate(self, instance):
        return instance.start_release_date.strftime("%Y-%m-%d") if instance.start_release_date else ""

    def get_actualEndDate(self, instance):
        return instance.actual_end_date.strftime("%y-%m-%d") if instance.actual_end_date else ""

    def get_startTestDate(self, instance):
        return instance.start_date.strftime("%Y-%m%d") if instance.start_date else ""

    def get_startUatTestDate(self, instance):
        return instance.start_test_date.strftime("%Y-%m-%d") if instance.start_test_date else ""

    def get_uatEndDate(self, instance):
        return instance.uat_end_date.strftime("%Y-%m-%d") if instance.uat_end_date else ""


class TestPlanSerializer(serializers.ModelSerializer):
    testUsers = serializers.CharField(source="test_users", required=False, allow_null=True, allow_blank=True)
    releasePlanId = serializers.IntegerField(source="release_plan_id", required=False)
    versionNo = serializers.CharField(source="version_no", required=True, allow_null=False, allow_blank=False)
    productId = serializers.IntegerField(source="product_id", required=True)
    devUsers = serializers.CharField(source="dev_users", required=False, allow_null=True, allow_blank=True)
    gitRepository = serializers.CharField(source="git_repository", required=False, allow_null=True, allow_blank=True)
    gitBranch = serializers.CharField(source="git_branch", required=False, allow_null=True, allow_blank=True)
    runCmd = serializers.CharField(source="run_cmd", required=False, allow_null=True, allow_blank=True)
    crontabSwitch = CustomChoiceField(source="crontab_switch", choices=Enum_table_base_status)
    crontabExpression = serializers.CharField(source="crontab_expression", required=False, allow_null=True,
                                              allow_blank=True)  # 非空字段要加 allow_null= True,l=
    emailSwitch = CustomChoiceField(source="email_switch", choices=Enum_table_base_status)
    emailSendto = serializers.CharField(source="email_sendto", required=False, allow_null=True, allow_blank=True)
    stage = CustomChoiceField(choices=Enum_test_plan_stage)
    status = CustomChoiceField(choices=Enum_table_base_status)
    jenkinsNode = serializers.CharField(source="jenkins_node", required=True, allow_null=False, allow_blank=False)

    class Meta:
        model = TestPlanTable
        exclude = [field.name for field in TestPlanTable._meta.fields if "_" in field.name]


class TestPlanRunHistorySerializer(serializers.ModelSerializer):
    testPlanId = serializers.IntegerField(source="test_plan_id", required=True)
    caseNumAll = serializers.CharField(source="case_num_all", required=False, allow_null=True, allow_blank=True)
    caseNumSuccess = serializers.CharField(source="case_num_success", required=False, allow_null=True, allow_blank=True)
    reportUrl = serializers.CharField(source="report_url", required=False, allow_null=True, allow_blank=True)
    runUserNickname = serializers.CharField(source="run_user_nickname", required=False, allow_null=True,
                                            allow_blank=True)
    runTime = serializers.SerializerMethodField()  # 需要转换的报文参数
    status = CustomChoiceField(choices=Enum_table_base_task_status)
    jenkinsLogUrl = serializers.CharField(source="jenkins_log_url", required=False, allow_null=True, allow_blank=True)

    class Meta:
        model = TestPlanRunHistoryTable
        exclude = ["output"] + [field.name for field in TestPlanRunHistoryTable._meta.fields if "_" in field.name]

    def get_runTime(self, instance):
        return TestPlanRunHistoryTable.objects.get(id=instance.id).runtime.strftime("%y-%m-%d %H:%M:%S")

