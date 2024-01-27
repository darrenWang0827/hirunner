from rest_framework.viewsets import ModelViewSet
from hirunner.models import ProductTable, ReleasePlanTable, ProductPlanConfigModel
from hirunner.serializers import ProductSerializer, ProductPlanConfigSerializer

from rest_framework.permissions import IsAdminUser
from rest_framework import status
from rest_framework.response import Response
from django.core.exceptions import ObjectDoesNotExist
from django.db.models import Q
from rest_framework.decorators import api_view

from hirunner.views.run import pull_release_version_engine, pull_release_version
from hirunner.views.task import scheduler
from apscheduler.triggers.cron import CronTrigger
from apscheduler.jobstores.base import JobLookupError
from django.conf import settings

from hirunner.log import d_log

logger = d_log(__name__)


class ProductViewSet(ModelViewSet):
    queryset = ProductTable.objects.all()
    serializer_class = ProductSerializer

    # permission_classes = [IsAdminUser]

    def list(self, request, *args, **kwargs):
        queryset = self.get_queryset()
        keyword = request.GET.get("keyword")
        if keyword:
            queryset = ProductTable.objects.filter(
                Q(name__icontains=keyword) | Q(release_plan_name_kw__icontains=keyword))

        queryset = self.filter_queryset(queryset)
        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)

    def create(self, request, *args, **kwargs):
        productId = request.data.get("productId")
        releasePlanNameKw = request.data.get("releasePlanNameKw")
        try:
            product = ProductTable.objects.get(product_id=productId, release_plan_name_kw=releasePlanNameKw)
            return Response(f"该产品{product}-{releasePlanNameKw}已经配置过，请勿重复配置",
                            status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        except ObjectDoesNotExist:
            pass

        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        instance = serializer.save()
        res_id = instance.id
        # self.perform_create(serializer)

        productName = request.data.get("name")
        pull_release_version_engine(product_id=productId, product_name=productName,
                                    release_plan_name_kw=releasePlanNameKw)
        taskadded = scheduler.add_job(func=pull_release_version,
                                      trigger=CronTrigger.from_crontab(settings.PRODUCT_PULL_VERSION_CRON),
                                      id="product_" + str(res_id),
                                      args=[productId, productName, releasePlanNameKw],
                                      max_instances=1,
                                      replace_existing=True)
        headers = self.get_success_headers(serializer.data)
        data = serializer.data
        data["taskAdded"] = str(taskadded)
        return Response(data=data, status=status.HTTP_201_CREATED, headers=headers)

    def destroy(self, request, *args, **kwargs):
        id = kwargs["pk"]
        # 删除定时任务
        # TODO
        instance = self.get_object()
        self.perform_destroy(instance)
        return Response(status=status.HTTP_204_NO_CONTENT)

    def update(self, request, *args, **kwargs):
        id = kwargs["kw"]
        try:
            ProductTable.objects.get(id=id)
        except ObjectDoesNotExist:
            return Response(f"{id}所在产品未配置或不存在", status=status.HTTP_500_INTERNAL_SERVER_ERROR)

        partial = kwargs.pop('partial', False)
        instance = self.get_object()
        serializer = self.get_serializer(instance, data=request.data, partial=partial)
        serializer.is_valid(raise_exception=True)
        self.perform_update(serializer)
        res_id = instance.id

        try:
            productId = request.data.get("productId")
            scheduler.remove_job("product_" + str(res_id))
        except JobLookupError:
            logger.info(f"the cron job for product {productId} does not exsit")
        finally:
            releasePlanNameKw = request.data.get("releasePlanNamekw")
            productName = request.data.get("name")
            scheduler.add_job(func=pull_release_version,
                              trigger=CronTrigger.from_crontab(settings.PRODUCT_PULL_VERSION_CRON),
                              id="product_" + str(res_id),
                              args=[productId, productName, releasePlanNameKw],
                              max_instances=1,
                              replace_existing=True)

            pull_release_version_engine(product_id=productId, product_name=productName,
                                        release_plan_name_kw=releasePlanNameKw)
        if getattr(instance, '_prefectched_objects_cache', None):
            instance._prefetched_objects_cache = {}
        return Response(data=serializer.data)


class ProductPlanConfigViewSet(ModelViewSet):
    queryset = ProductPlanConfigModel.objects.all()
    serializer_class = ProductPlanConfigSerializer

    def list(self, request, *args, **kwargs):
        product_id = kwargs["product_id"]
        release_plan_name_kw = request.query_params.get("releasePlanNameKw")
        logger.info(release_plan_name_kw)
        query = Q(product_id=product_id, release_plan_name_kw=release_plan_name_kw)
        queryset = ProductPlanConfigModel.objects.filter(query).order_by('-updated_at')
        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)
        serializer = self.get_serializer(queryset, many=True)
        return Response(data=serializer.data)

    def create(self, request, *args, **kwargs):
        # 开始保存数据
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
        data = serializer.data
        return Response(data=data, status=status.HTTP_201_CREATED, headers=headers)

    def destroy(self, request, *args, **kwargs):
        id = kwargs["pk"]
        # 删除定时任务
        # TODO

        instance = self.get_object()
        self.perform_destroy(instance)
        return Response(status=status.HTTP_204_NO_CONTENT)

    def update(self, request, *args, **kwargs):
        # 判断是否存在
        id = kwargs["pk"]
        try:
            ProductPlanConfigModel.objects.get(id=id)
        except ObjectDoesNotExist:
            return Response(f"{id}所在产品未配置或不存在", status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        # 开始保存，无需更新定时任务
        partial = kwargs.pop('partial', False)
        instance = self.get_object()
        serializer = self.get_serializer(instance, data=request.data, partial=partial)
        serializer.is_valid(raise_exception=True)
        self.perform_update(serializer)

        if getattr(instance, '_prefetched_objects_cache', None):
            instance._prefetched_objects_cache = {}
        return Response(data=serializer.data)


@api_view(['GET'])
def product_version(request, *args, **kwargs):
    data = {f"productVersionList": [], "curProductVersion": {}}
    products = ProductTable.objects.all()
    if not products:
        return Response(data, status=status.HTTP_200_OK)
    for product in products:
        data["productVersionList"].append({
            "productId": str(product.product_id),
            "releasePlanNameKw": product.release_plan_name_kw,
            "productName": product.name,
            "versionList": list(ReleasePlanTable.objects.filter(product_id=product.product_id,
                                                                release_plan_name_kw=product.release_plan_name_kw).order_by(
                '-start_release_date').values_list('name', flat=True)),
        })
    if data["productVersionList"]:
        data["curProductVersion"] = {
            "curProductId": str(products[0].product_id),
            "curReleasePlanNameKw":str(products[0].release_plan_name_kw),
            "curProductName":products[0].name,
            "curVersionNo":list(ReleasePlanTable.objects.filter(product_id=products.first().product_id).order_by('-version_no').values_list('name',flat=True))[0]
        }
    return Response(data,status = status.HTTP_200_OK)
