#!/bin/bash
set -o nounset
set -o errexit
set -o xtrace

# Create the basic directories we'll need
cat initialize_directories.sh | ssh {{ cookiecutter.ssh_user }}@{{ cookiecutter.ssh_hostname }}

# Copy some files to our staging area
scp nginx.conf {{ cookiecutter.ssh_user }}@{{ cookiecutter.ssh_hostname }}:{{ cookiecutter.domain }}/
scp supervisord.conf {{ cookiecutter.ssh_user }}@{{ cookiecutter.ssh_hostname }}:{{ cookiecutter.domain }}/
scp -r invarwww {{ cookiecutter.ssh_user }}@{{ cookiecutter.ssh_hostname }}:{{ cookiecutter.domain }}/

# Set up the virtualenv, postgres, and reload configurations
cat post_initialize.sh | ssh {{ cookiecutter.ssh_user }}@{{ cookiecutter.ssh_hostname }}
