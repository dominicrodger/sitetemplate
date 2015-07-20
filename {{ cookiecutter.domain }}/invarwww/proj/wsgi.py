"""
WSGI config for {{ cookiecutter.project_name }} project.
"""

import os

from django.core.wsgi import get_wsgi_application

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "proj.settings")

application = get_wsgi_application()
