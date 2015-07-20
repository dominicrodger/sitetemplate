#!/bin/bash
set -o nounset
set -o errexit

# Create the basic directories we'll need
cat initialize_directories.sh | ssh {{ cookiecutter.ssh_path }}

# Copy some files around
# TODO

# Set up the virtualenv, postgres, and reload configurations
cat post_initialize.sh | ssh {{ cookiecutter.ssh_path }}
