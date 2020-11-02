#!/bin/bash

# Utilitzarem variable per determinar si el node és raspberrypi
nodename=$(uname -n)

# Segons versió del OS (raspbian/ubuntu/...) seguirem un procés o altre. 
if [ "${nodename}" != "raspberrypi" ]
then 
echo -e "\e[95m\nNode name del sistema: $nodename\e[0m"

# Prèviament, refresh the list of available packages and upgrade all installed packages.
sudo apt update

# Instal·lar editor Visual Studio Code
sudo apt install -y snap
# sudo snap install -y --classic pycharm-community
sudo snap install -y --classic code

# Instal·lar paquet libpq-dev. 
# Header files for libpq5 (PostgreSQL library) and static library for compiling C programs 
# to link with the libpq library in order to communicate with a PostgreSQL database backend.
sudo apt install -y libpq-dev

# Instal·lar PostgreSQL. PostgreSQL is an object-relational SQL database management system.
sudo apt install -y postgresql

# Instal·lar paquet postgresql-contrib
# The postgresql-contrib package includes extensions and additions that are distributed along 
# with the PostgreSQL sources, but are not (yet) officially part of the PostgreSQL core.
sudo apt install -y postgresql-contrib

# Instal·lar gestor de llibreries/paquets pip3
# Standard package-management system used to install and manage software packages written in
# Python. python 3.4 and later include pip (pip3 for Python 3) by default.
sudo apt install -y python3-pip

# Instal·lar mòdul venv
# The venv module provides support for creating lightweight “virtual environments” 
# with their own site directories, optionally isolated from system site directories. 
# Each virtual environment has its own Python binary (which matches the version of the 
# binary that was used to create this environment) and can have its own independent set 
# of installed Python packages in its site directories.
sudo apt install -y python3-venv

# Instal·lar Llibreries python
pip3 install psycopg2
pip3 install django

# Instal·lar Java Development Kit (jdk) i Java Runtime Environment (jre) en diferents versions.
sudo apt install default-jre
sudo apt install default-jdk
sudo apt install openjdk-8-jdk

# Afegim repositori universe de l'instal·lador apt i actualitzem apt.
sudo add-apt-repository universe
sudo apt update
# Instal·lem alien. Alien converts different Linux package distribution file formats to Debian and viceversa.
# Packages: Linux Standard Base, RPM, deb, Stampede (.slp) and Slackware (tgz).
sudo apt install alien

# Afegim unzip
sudo apt install unzip

else
echo  -e "\e[95m\nNode name del sistema: $nodename\e[0m"

fi

