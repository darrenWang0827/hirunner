import os
import multiprocessing

bind = '0.0.0.0:8000'
backlog = 2048

workers = multiprocessing.cpu_count() * 2 + 1
workers = 1 # 临时解决多个进程执行定时任务时会触发多个定时任务的问题
worker_class = 'gthread'
worker_connections = 1000

threads = int(480 / workers)
timeout = 60
graceful_timeout = 60
keepalive = 2
limit_request_line = 4096
limit_request_fields = 100
limit_request_fields_size = 8190

reload = False
daemon = False
# max_requests = 1000
# max_requests_jitter = 50
pidfile = '/tmp/gunicorn.pid'

# keyfile = '.../server.key'
# certfile = '.../server.crt'

accesslog = '-'
access_log_format = '%(t)s %(h)s "%(r)s" %(s)s %(b)s "%(f)s" "%(L)s"'
errorlog = './logs/gunicorn.log'
# loglevel = '-'

pythonpath = 'python3 -u'
project_name = 'hirunnerbackend'
proc_name = 'gunicorn_%s'
os.environ.setdefault('DJANGO_SETTINGS_MODULE','%s.settings' % project_name)
os.environ.setdefault('WERKZEUG_RUN_MAIN','true')


