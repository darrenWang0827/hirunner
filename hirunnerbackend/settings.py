import os

# 环境配置
ENV = os.environ.get("HIRUNNER_ENV","dev")

if ENV == "dev":
    from .settings_dev import *
else:
    from .settings_prd import *