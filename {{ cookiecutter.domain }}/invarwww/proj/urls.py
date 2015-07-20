"""{{ cookiecutter.project_name }} URL Configuration
"""
from django.conf.urls import include, url
from django.contrib import admin

urlpatterns = [
    url(r'^admin/', include(admin.site.urls)),
    url(r'^', include('{{ cookiecutter.root_app }}.urls')),
]
