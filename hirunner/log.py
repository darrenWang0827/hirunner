import logging
import threading
import os
from hirunnerbackend.settings import LOGGING_DIR


class CustomFormatter(logging.Formatter):
    def format(self, record):
        process_id = os.getpid()
        thread_id = threading.get_ident()
        record.process_id = process_id
        record.thread_id = thread_id
        return super().format(record)


def d_log(name):
    logger = logging.getLogger(name)
    logger.setLevel(logging.INFO)
    file_handler = logging.FileHandler(os.path.join(LOGGING_DIR, 'record.log'), encoding='utf-8')
    file_handler.setLevel(logging.INFO)
    console_handle = logging.StreamHandler()
    console_handle.setLevel(logging.INFO)
    formatter = CustomFormatter(
        '%(asctime)s [%(levelname)s][%(name)s:%(lineno)d][%(process_id)s:%(thread_id)s]:%(message)s')
    file_handler.setFormatter(formatter)
    console_handle.setFormatter(formatter)
    logger.addHandler(file_handler)
    logger.addHandler(console_handle)
    return logger
