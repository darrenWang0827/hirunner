Enum_table_base_status = [
    (0,"已关闭"),
    (1,"已开启"),
]

Enum_table_base_task_status = [
    (0,"执行中"),
    (1,"已完成"),
    (4,"异常"),
]

Enum_release_plan_status = [
    (3,"实现中"),
    (4,"已发布"),
    (2,"新建"),
]

Enum_test_plan_stage = [
    ("smoke","冒烟测试"),
    ("sit","SIT测试"),
    # ("uat","UAT测试"),
    ("regress","回归测试"),
    ("gray","灰度测试"),
    # ("compatibiity","兼容性测试")，
    ("other","其他测试"),
]

Enum_test_plan_config_default = [
    # ("smoke","冒烟测试"),
    # ("sit","SIT测试),
    # ("reqress","回归测试"),
    ("other","每日全量执行"),
    ("other","开发自测专用"),
]