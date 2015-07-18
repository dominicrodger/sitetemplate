#!/bin/bash
set -o errexit
set -o nounset
set -o xtrace

# Set up our virtual environment, and install things every project
# will need.
virtualenv /var/www/{{ domain }}/.venv
source /var/www/{{ domain }}/.venv
pip install opbeat
pip install psycopg2
pip install {{ root_app_path }}


cd /var/www/{{ domain }}
python manage.py migrate
python manage.py collectstatic

deactivate

# Set up our database
sudo -u postgres psql -c "create database {{ project_name }}"
sudo -u postgres psql -c "CREATE USER {{ project_name }} WITH PASSWORD '{{ db_password }}'"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE {{ project_name }} TO {{ project_name }}"


# Restart supervisor
sudo service supervisor stop
sudo service supervisor start

# Configure nginx
sudo ln -s /etc/nginx/sites-available/{{ domain }} /etc/nginx/sites-enabled/
sudo service nginx reload
