#!/bin/bash

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
django-admin.py startproject $NOMBRE_PROYECTO.

# CREEM LA PRIMERA APLICACIÓ (pages) DEL PROJECTE
echo "Introdueix nom de l'aplicació per $NOMBRE_PROYECTO que desitjes crear"
read APLICACION_DE_PROYECTO
python3 manage.py startapp $APLICACION_DE_PROYECTO

# Creem carpeta templates i static en carpeta de l'aplicació
mkdir $APLICACION_DE_PROYECTO/templates
mkdir $APLICACION_DE_PROYECTO/static
echo "Carpetes templates i static creades en aplicació"

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
echo "Afegeix desde pycharm a settings.py > INSTALLED_APPS, l'aplicació: $APLICACION_DE_PROYECTO"
echo "Prem qualsevol tecla per continuar"
read

# Per sortir de environment en shell fer:
# deactivate
echo "Per a sortir de l'environment quan escaigui utilitza 'deactivate'"
echo "Prem qualsevol tecla per continuar"
read

echo "Arranquem servidor en terminal apart..."
# x-terminal-emulator -e "COMMAND" ens executa en una nova terminal COMMAND.
x-terminal-emulator -e "python3 manage.py runserver"





