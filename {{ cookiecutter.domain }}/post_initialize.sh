#!/bin/bash
set -o errexit
set -o nounset
set -o xtrace

# Let's install our own uwsgi
sudo pip install uwsgi

# Copy configuration files around
sudo cp ~/{{ cookiecutter.domain }}/nginx.conf /etc/nginx/sites-available/{{ cookiecutter.domain }}
sudo cp ~/{{ cookiecutter.domain }}/supervisord.conf /etc/supervisor/conf.d/{{ cookiecutter.domain }}.conf
cp -r ~/{{ cookiecutter.domain }}/invarwww/* /var/www/{{ cookiecutter.domain }}/

# Clean up our working directory
rm -rf ~/{{ cookiecutter.domain }}

# Set up our virtual environment, and install things every project
# will need.
virtualenv /var/www/{{ cookiecutter.domain }}/.venv

echo "/var/www/{{ cookiecutter.domain }}" > /var/www/{{ cookiecutter.domain }}/.venv/lib/python2.7/site-packages/proj.pth

set +o nounset # (https://github.com/pypa/virtualenv/issues/150)
source /var/www/{{ cookiecutter.domain }}/.venv/bin/activate
set -o nounset

pip install opbeat
pip install psycopg2
pip install Django

# Set up our database
sudo -u postgres psql -c "create database {{ cookiecutter.project_name }}"
sudo -u postgres psql -c "CREATE USER {{ cookiecutter.project_name }} WITH PASSWORD '{{ cookiecutter.db_password }}'"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE {{ cookiecutter.project_name }} TO {{ cookiecutter.project_name }}"

cd /var/www/{{ cookiecutter.domain }}
python manage.py migrate
python manage.py collectstatic --noinput

set +o nounset # (https://github.com/pypa/virtualenv/issues/150)
deactivate
set -o nounset

# Reload supervisor configuration, and start processes
sudo supervisorctl reread
sudo supervisorctl add {{ cookiecutter.project_name }}

# Configure nginx
sudo ln -s /etc/nginx/sites-available/{{ cookiecutter.domain }} /etc/nginx/sites-enabled/
sudo service nginx reload
