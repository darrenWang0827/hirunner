#!/usr/bin/python
# encoding=utf-8

from django.urls import path

from hirunner.views import run, product, testPlan

urlpatterns = [
    path(r"products", product.ProductViewSet.as_view({
        "get": "list",
        "post": "create"
    })),
    path(r"products/<int:pk>", product.ProductViewSet.as_view({
        "get": "retrieve",
        "put": "update",
        "delete": "destroy",
    })),
    path(r"products/<int:product_id>/planConfigList", product.ProductPlanConfigViewSet.as_view({
        "get": "list",
    })),
    path(r"planConfigList", product.ProductPlanConfigViewSet.as_view({
        "post": "create"
    })),
    path(r"planConfigList/<int:pk>", product.ProductPlanConfigViewSet.as_view({
        "get": "retrieve",
        "put": "update",
        "delete": "destroy",
    })),

    path(r"products/version", product.product_version),
    path(r"testPlans", testPlan.TestPlanViewSet.as_view({
        "get": "list",
        "post": "create",
    })),
    path(r"testPlans/<int:pk>", testPlan.TestPlanViewSet.as_view({
        "put": "update",
        "get": "retrieve",
        "delete": "destroy",
    })),
    path(r"testPlans/<int:test_plan_id>/runHistory", testPlan.TestPlanRunHistorySet.as_view({
        "get": "list",
    })),
    path(r"testPlans/<int:pk>/run", run.run_testPlan),
    path(r"runHistory/<int:pk>", testPlan.TestPlanRunHistorySet.as_view({
        "get": "retrieve",
    }))

]
