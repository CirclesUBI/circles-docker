import socket

from .base import *  # noqa
from .base import env

# GENERAL

DEBUG = True
SECRET_KEY = env('DJANGO_SECRET_KEY')
ALLOWED_HOSTS = [
    "relay.circles.local",
    "localhost",
    "127.0.0.1",
    "0.0.0.0",
]

# CACHES

CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.locmem.LocMemCache',
        'LOCATION': ''
    }
}

# EMAIL

EMAIL_BACKEND = env('DJANGO_EMAIL_BACKEND', default='django.core.mail.backends.console.EmailBackend')
EMAIL_HOST = 'localhost'
EMAIL_PORT = 1025

# DJANGO DEBUG TOOLBAR

INSTALLED_APPS += ['debug_toolbar']  # noqa F405

MIDDLEWARE += ['debug_toolbar.middleware.DebugToolbarMiddleware',
               'debug_toolbar_force.middleware.ForceDebugToolbarMiddleware']  # noqa F405

DEBUG_TOOLBAR_CONFIG = {
    'DISABLE_PANELS': [
        'debug_toolbar.panels.redirects.RedirectsPanel',
    ],
    'SHOW_TEMPLATE_CONTEXT': True,
}

INTERNAL_IPS = ['127.0.0.1', '10.0.2.2']

# CELERY

CELERY_ALWAYS_EAGER = False

hostname, _, ips = socket.gethostbyname_ex(socket.gethostname())

INTERNAL_IPS += [ip[:-1] + '1' for ip in ips]

CACHES = {
    'default': {
        'BACKEND': 'django_redis.cache.RedisCache',
        'LOCATION': env('REDIS_URL'),
        'OPTIONS': {
            'CLIENT_CLASS': 'django_redis.client.DefaultClient',
            'IGNORE_EXCEPTIONS': True,
        }
    }
}

# SAFE

FIXED_GAS_PRICE = 1
SAFE_FUNDING_CONFIRMATIONS = 0
