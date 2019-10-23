import socket

from .base import *
from .base import env

# GENERAL

DEBUG = True
SECRET_KEY = env('DJANGO_SECRET_KEY')

ALLOWED_HOSTS = [
    'relayer-service',
    env('HOST_RELAYER', default='localhost'),
]

# CACHES

CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.locmem.LocMemCache',
        'LOCATION': ''
    }
}

# DJANGO DEBUG TOOLBAR

INSTALLED_APPS += ['debug_toolbar']

MIDDLEWARE += ['debug_toolbar.middleware.DebugToolbarMiddleware',
               'debug_toolbar_force.middleware.ForceDebugToolbarMiddleware']

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
        'LOCATION': env('RELAYER_REDIS_URL'),
        'OPTIONS': {
            'CLIENT_CLASS': 'django_redis.client.DefaultClient',
            'IGNORE_EXCEPTIONS': True,
        }
    }
}

# Django CORS

CORS_ORIGIN_ALLOW_ALL = True

# SAFE

FIXED_GAS_PRICE = 1
SAFE_FUNDING_CONFIRMATIONS = 0
