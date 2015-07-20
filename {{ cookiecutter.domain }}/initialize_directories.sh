#!/bin/bash
set -o errexit
set -o nounset
set -o xtrace

# Set up our site root directory, and make sure we can write to it
# without being root.
sudo mkdir /var/www/{{ domain }}
sudo chown -R {{ deployment_user }}:{{ deployment_user }} /var/www/{{ domain }}

# Set up the media directory, and make sure the www-data user can
# write to it.
mkdir /var/www/{{ domain }}/media
sudo chown -R www-data:www-data /var/www/{{ domain }}/media

# Set up our static directory
mkdir /var/www/{{ domain }}/static

# Set up our log directory for nginx
sudo mkdir /var/log/nginx/{{ domain }}
