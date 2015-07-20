"""
Django settings for {{ cookiecutter.domain }} project.
"""

import os

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

SECRET_KEY = '{{ cookiecutter.secret_key }}'

DEBUG = False

ALLOWED_HOSTS = [
    'www.{{ cookiecutter.domain }}',
]

INSTALLED_APPS = (
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'opbeat.contrib.django',
)

MIDDLEWARE_CLASSES = (
    'opbeat.contrib.django.middleware.OpbeatAPMMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.auth.middleware.SessionAuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'django.middleware.security.SecurityMiddleware',
)

ROOT_URLCONF = 'proj.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'proj.wsgi.application'

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'HOST': 'localhost',
        'NAME': '{{ cookiecutter.project_name }}',
        'USER': '{{ cookiecutter.project_name }}',
        'PASSWORD': '{{ cookiecutter.db_password }}'
    }
}

LANGUAGE_CODE = 'en-gb'
TIME_ZONE = 'UTC'
USE_I18N = True
USE_L10N = True
USE_TZ = True

STATIC_URL = 'https://static.{{ cookiecutter.domain }}/'
STATIC_ROOT = os.path.join(BASE_DIR, 'static')
MEDIA_URL = 'https://media.{{ cookiecutter.domain }}/'
MEDIA_ROOT = os.path.join(BASE_DIR, 'media')

STATICFILES_STORAGE = 'django.contrib.staticfiles.storage.ManifestStaticFilesStorage'

EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = '{{ cookiecutter.email_host }}'
EMAIL_HOST_USER = '{{ cookiecutter.email_username }}'
EMAIL_HOST_PASSWORD = '{{ cookiecutter.email_password }}'
DEFAULT_FROM_EMAIL = '{{ cookiecutter.email_default_from }}'
EMAIL_PORT = {{ cookiecutter.email_port }}
