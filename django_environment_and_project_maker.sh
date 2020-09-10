#!/bin/bash

# PREVIAMENT, refresh the list of available packages and upgrade all installed packages.
# sudo apt update

# INSTAL·LAR EDITOR PYCHARM
# sudo apt install snap
# sudo snap install pycharm-community --classic

# INSTAL·LAR PAQUET libpq-dev. 
# Header files for libpq5 (PostgreSQL library) and static library for compiling C programs 
# to link with the libpq library in order to communicate with a PostgreSQL database backend. 
# sudo apt install libpq-dev

# INSTAL·LAR PostgreSQL. PostgreSQL is an object-relational SQL database management system. 
# sudo apt install postgresql

# INSTAL·LAR PAQUET postgresql-contrib
# The postgresql-contrib package includes extensions and additions that are distributed along 
# with the PostgreSQL sources, but are not (yet) officially part of the PostgreSQL core. 
# sudo apt install postgresql-contrib

# INSTAL·LAR GESTOR DE LLIBRERIES/PAQUETS pip3
# Standard package-management system used to install and manage software packages written in
# Python. python 3.4 and later include pip (pip3 for Python 3) by default.
# sudo apt install python3-pip

# INSTAL·LAR MÒDUL venv
# The venv module provides support for creating lightweight “virtual environments” 
# with their own site directories, optionally isolated from system site directories. 
# Each virtual environment has its own Python binary (which matches the version of the 
# binary that was used to create this environment) and can have its own independent set 
# of installed Python packages in its site directories.
# sudo apt-get install python3-venv

# ENS UBIQUEM EN RUTA (CARPETA) CONTENIDORA DE PROJECTES DJANGO
echo "Introdueix ruta per a carpeta de projectes Django (relativa desde \$HOME, ~/ruta)" 
read RUTA_PROYECTOS
cd $HOME/$RUTA_PROYECTOS

# CREEM LA CARPETA DEL PROJECTE DJANGO
echo "Introdueix nom per a carpeta de projecte Django"
read CARPETA_PROYECTO
mkdir $CARPETA_PROYECTO
cd $CARPETA_PROYECTO

# CREEM LA CARPETA PER A L'ENTORN
env="_env"
python3 -m venv $CARPETA_PROYECTO$env
# ACTIVEM CARPETA PER A L'ENTORN
source $CARPETA_PROYECTO$env/bin/activate

# INSTAL·LEM LLIBRERIES NECESSÀRIES
# Psycopg: PostgreSQL database adapter for the Python programming language.
pip3 install psycopg2
# Django: web framework que respecta el patró de disseny MVC.
pip3 install django

# CREEM PROJECTE DJANGO
echo "Introdueix nom de projecte Django"
read NOMBRE_PROYECTO
django-admin.py startproject $NOMBRE_PROYECTO .

# PODEM ARRANCAR SERVIDOR PER COMPROVAR FUNCIONAMIENT
# python3 manage.py runserver
# COMPROVEM EN NAVEGADOR (PORT PER DEFECTE DJANGO: 8000): http://127.0.0.1:8000/ 

# CREEM LA PRIMERA APLICACIÓ (pages) DEL PROJECTE
echo "Introdueix nom de l'aplicació per $NOMBRE_PROYECTO que desitjes crear"
read APLICACION_DE_PROYECTO
python3 manage.py startapp $APLICACION_DE_PROYECTO

# Podem començar a codificar la nostra aplicació.
pycharm-community >/dev/null 2>&1 & 
# & perquè pycharm corri en segón pla
# /dev/null: Black hole de linux...
# By default: stdin => 0, stdout => 1, stderr => 2
# In the script >/dev/null: stdin => 0, stdout => /dev/null, stderr => 2
# And then 2>&1: stdin => 0, stdout => /dev/null, stderr => stdout


# Un cop obert pycharm clickem open i indiquem la nostra carpeta RUTA_PROYECTOS.
# Obrim la carpeta del projecte que ens interessi i el seu arxiu settings.py
# En settings.py busquem INSTALLED_APPS
# Afegim a INSTALLED_APPS l'aplicació creada (APLICACION_DE_PROYECTO) tal que:
# 'APLICACION_DE_PROYECTO',

# Per sortir de environment en shell fer:
# deactivate
