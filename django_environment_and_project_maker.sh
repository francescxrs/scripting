#!/bin/bash

# PREVIAMENTE...
# Run sudo apt upgrade refresh the list of available packages and upgrade all installed packages.
# sudo apt update

# INSTALAR POSTGRES
# sudo apt install libpq-dev postgresql postgresql-contrib

# INSTALAR MÓDULO VENV
# The venv module provides support for creating lightweight “virtual environments” 
# with their own site directories, optionally isolated from system site directories. 
# Each virtual environment has its own Python binary (which matches the version of the 
# binary that was used to create this environment) and can have its own independent set 
# of installed Python packages in its site directories.
# sudo apt-get install python3-venv

# NOS UBICAMOS EN LA RUTA (CARPETA) CONTENEDORA DE CARPETAS DE PROYECTOS
echo "Introduzca ruta de proyectos relativa a \$HOME (~/ruta):" 
read RUTA_PROYECTOS
cd $HOME/$RUTA_PROYECTOS

# CREAMOS CARPETA DE PROYECTO
echo "Introduzca nombre para carpeta de proyecto:"
read CARPETA_PROYECTO
mkdir $CARPETA_PROYECTO
cd $CARPETA_PROYECTO

# CREAMOS CARPETA PARA EL ENTORNO
env="_env"
python3 -m venv $CARPETA_PROYECTO$env
# ACTIVAMOS CARPETA PARA EL ENTORNO
source $CARPETA_PROYECTO$env/bin/activate

# INSTALAMOS LAS LIBRERIAS EN NUESTRO ENTORNO
pip3 install psycopg2
pip3 install django

# CREAMOS PROYECTO DJANGO
echo "Introduzca nombre de proyecto Django:"
read NOMBRE_PROYECTO
django-admin.py startproject $NOMBRE_PROYECTO .

# ARRANCAMOS SERVIDOR I COMPROVAMOS SI FUNICIONA
# python3 manage.py runserver

# ANEM A LOCALHOST I PORT PER DEFECTE DE DJANGO (8000)
# http://127.0.0.1:8000/ 

# Creamos la primera aplicación (pages) de nuestro proyecto
echo "Introduzca nombre de la aplicación para $NOMBRE_PROYECTO que desea crear"
read APLICACION_DE_PROYECTO
python3 manage.py startapp $APLICACION_DE_PROYECTO

# PARA SALIR
# deactivate
