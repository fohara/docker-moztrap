from os import environ

#DB_PORT_3306_TCP_ADDR is pulled from the docker link alias.
#See README.md for usage.

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.mysql",
        "NAME": "moztrap",
        "USER": "moztrap",
        "HOST": environ.get("DB_PORT_3306_TCP_ADDR", ""),
        "PASSWORD": "moztrap",
        "STORAGE_ENGINE": "InnoDB",
        "OPTIONS": {
            "init_command": "SET default_storage_engine=InnoDB"
        }
    }
}

CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',
        'LOCATION': '127.0.0.1:11211',
    }
}


DEFAULT_FROM_EMAIL = ""
EMAIL_HOST = "smtp.gmail.com"
EMAIL_HOST_USER = ""
EMAIL_HOST_PASSWORD = ""
EMAIL_PORT = 587
EMAIL_SUBJECT_PREFIX = "[MozTrap]"
EMAIL_USE_TLS = True

USE_BROWSERID = False
