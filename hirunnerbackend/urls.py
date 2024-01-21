"""hirunnerbackend URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.urls import path, include

# from hirunner.views.case import CaseResultView

urlpatterns = [
    path('api/users/', include('user.urls')),
    path('api/hirunner/', include('hirunner.urls')),
]

# Websocket路由
websocket_urlpatterns = [
    # path(r'ws/hirunner/cases/<int:case_id>/result/', CaseResultView.as_asgi()),
]

# 添加swag生成接口文档
from drf_yasg.views import get_schema_view
from drf_yasg import openapi
from django.urls import path

schema_view = get_schema_view(
    # API 信息
    openapi.Info(
        title="API",
        default_version="V1.0.1",
        description="接口文档",
        contact=openapi.Contact(email="darrenwangcheng@163.com"),
    ),
    public=True,
    # permission_classes= (permissions.AllowAny) # 这里不要写，否则会出现鉴权问题
)

# 这里追加url，但是登录鉴权那里要绕过
urlpatterns = urlpatterns + [
    path('swagger/', schema_view.with_ui('swagger', cache_timeout=0), name='schema-swagger-ui'),  # 互动模式,
    path('redoc/', schema_view.with_ui('redoc', cache_timeout=0), name='schema-redoc'),  # 文档模式
]
