#!/bin/bash
set -o errexit
set -o nounset
set -o xtrace

# Set up our virtual environment, and install things every project
# will need.
virtualenv /var/www/{{ cookiecutter.domain }}/.venv
source /var/www/{{ cookiecutter.domain }}/.venv
pip install opbeat
pip install psycopg2
pip install {{ cookiecutter.root_app_path }}


cd /var/www/{{ cookiecutter.domain }}
python manage.py migrate
python manage.py collectstatic

deactivate

# Set up our database
sudo -u postgres psql -c "create database {{ cookiecutter.project_name }}"
sudo -u postgres psql -c "CREATE USER {{ cookiecutter.project_name }} WITH PASSWORD '{{ cookiecutter.db_password }}'"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE {{ cookiecutter.project_name }} TO {{ cookiecutter.project_name }}"


# Restart supervisor
sudo service supervisor stop
sudo service supervisor start

# Configure nginx
sudo ln -s /etc/nginx/sites-available/{{ cookiecutter.domain }} /etc/nginx/sites-enabled/
sudo service nginx reload
