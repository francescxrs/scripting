#!/bin/bash

# PREVIAMENT, refresh the list of available packages and upgrade all installed packages.
sudo apt update

# INSTAL·LAR EDITOR PYCHARM
sudo apt install -y snap
sudo snap install -y --classic pycharm-community
sudo snap install -y --classic code

# INSTAL·LAR PAQUET libpq-dev. 
# Header files for libpq5 (PostgreSQL library) and static library for compiling C programs 
# to link with the libpq library in order to communicate with a PostgreSQL database backend.
sudo apt install -y libpq-dev

# INSTAL·LAR PostgreSQL. PostgreSQL is an object-relational SQL database management system.
sudo apt install -y postgresql

# INSTAL·LAR PAQUET postgresql-contrib
# The postgresql-contrib package includes extensions and additions that are distributed along 
# with the PostgreSQL sources, but are not (yet) officially part of the PostgreSQL core.
sudo apt install -y postgresql-contrib

# INSTAL·LAR GESTOR DE LLIBRERIES/PAQUETS pip3
# Standard package-management system used to install and manage software packages written in
# Python. python 3.4 and later include pip (pip3 for Python 3) by default.
sudo apt install -y python3-pip

# INSTAL·LAR MÒDUL venv
# The venv module provides support for creating lightweight “virtual environments” 
# with their own site directories, optionally isolated from system site directories. 
# Each virtual environment has its own Python binary (which matches the version of the 
# binary that was used to create this environment) and can have its own independent set 
# of installed Python packages in its site directories.
sudo apt install -y python3-venv

# INSTAL·LAR Llibreries python
pip3 install psycopg2
pip3 install django
