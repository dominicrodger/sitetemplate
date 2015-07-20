#!/bin/bash
set -o errexit
set -o nounset
set -o xtrace

# Set up our site root directory, and make sure we can write to it
# without being root.
sudo mkdir /var/www/{{ cookiecutter.domain }}
sudo chown -R {{ cookiecutter.deployment_user }}:{{ cookiecutter.deployment_user }} /var/www/{{ cookiecutter.domain }}

# Set up the media directory, and make sure the www-data user can
# write to it.
mkdir /var/www/{{ cookiecutter.domain }}/media
sudo chown -R www-data:www-data /var/www/{{ cookiecutter.domain }}/media

# Set up our static directory
mkdir /var/www/{{ cookiecutter.domain }}/static

# Set up our log directory for nginx
sudo mkdir /var/log/nginx/{{ cookiecutter.domain }}
