#!/bin/bash

# UBICARSE EN CARPETA DE PROJECTES DJANGO
echo "
francescxrs: Introdueix ruta per a carpeta de projectes Django (relativa desde \$HOME: ~/ruta)" 
read RUTA_PROYECTOS
cd $HOME/$RUTA_PROYECTOS

# CREAR CARPETA DE PROJECTE DJANGO
echo "
francescxrs: Introdueix nom per a carpeta de projecte Django"
read CARPETA_PROYECTO
mkdir $CARPETA_PROYECTO
cd $CARPETA_PROYECTO

# CREAR CARPETA PER A L'ENTORN
env="_env"
python3 -m venv $CARPETA_PROYECTO$env
echo "
francescxrs: Carpeta d'entorn creada"
# ACTIVAR CARPETA PER A L'ENTORN
source $CARPETA_PROYECTO$env/bin/activate

# INSTAL·LAR LLIBRERIES NECESSÀRIES EN ENTORN
# Psycopg: PostgreSQL database adapter for the Python programming language.
pip3 install psycopg2
# Django: web framework que respecta el patró de disseny MVC.
pip3 install django
echo "
francescxrs: Llibreria psycopg2 i framework django instal·lats"

# CREAR PROJECTE DJANGO
echo "
francescxrs: Introdueix nom de projecte Django"
read NOMBRE_PROYECTO
django-admin.py startproject $NOMBRE_PROYECTO .

# CREAR LA PRIMERA APLICACIÓ DEL PROJECTE
echo "
francescxrs: Introdueix nom de l'aplicació que desitjes crear per a projecte '$NOMBRE_PROYECTO'"
read APLICACION_DE_PROYECTO
python3 manage.py startapp $APLICACION_DE_PROYECTO

# CREAR CARPETA templates I static EN CARPETA DE L'APLICACIÓ
mkdir $APLICACION_DE_PROYECTO/templates
mkdir $APLICACION_DE_PROYECTO/static
echo "
francescxrs: Carpetes 'templates' i 'static' creades en aplicació"

# CODIFICACIÓ DE L'APLICATIU (ESCOLLIM pycharm)
pycharm-community >/dev/null 2>&1 & 
# & perquè pycharm corri en segón pla
# /dev/null: Black hole de linux...
# By default: stdin => 0, stdout => 1, stderr => 2
# In the script >/dev/null: stdin => 0, stdout => /dev/null, stderr => 2
# And then 2>&1: stdin => 0, stdout => /dev/null, stderr => stdout

# JA OBERT pycharm FER OPEN I ESCOLLIR CARPETA $RUTA_PROYECTOS.
echo "
francescxrs: Afegeix desde pycharm en l'arxiu settings.py dins la llista INSTALLED_APPS, \
l'aplicació creada prèviament '$APLICACION_DE_PROYECTO'. Prem qualsevol tecla per continuar"
read
echo "
francescxrs: Per a sortir de l'environment quan escaigui utilitza 'deactivate'. \
Prem qualsevol tecla per continuar"
read

echo "
francescxrs: Arranquem servidor en terminal apart"
# x-terminal-emulator -e "COMMAND" ens executa en una nova terminal COMMAND.
x-terminal-emulator -e "python3 manage.py runserver"

echo "
francescxrs: IMPORTANT: La configuració d'arxiu pg_hba.conf està feta?
Si és el 1r cop que creem projecte django modifica l'arxiu \
/etc/postgresql/11/main/pg_hba.conf, \
linea 90 aproximadament. Cambiarem el mode d'encriptació de peer a md5. \
L'encriptació peer amb l'usuari on ens trobem (oc-admin) no funcionarà \
entrant amb un altre usuari dels que s'hagin creat prèviament. \
Hauríem doncs de tancar sessió, entrar amb usuari concret i conectar amb aquest usuari concret. \
Amb md5 cambiem a una encriptació més simple que funciona per contrasenya. \
Un cop modificat pg_hba.conf prem qualsevol tecla."
read

cd ~/Escritorio/scripting
# Reiniciem servei psql
sudo service postgresql restart

echo "
francescxrs: Reiniciem servei postgres"

# Variables bash per a usuari i base de dades
echo "
francescxrs: Introdueix nom de base de dades"
read DB
echo "
francescxrs: Introdueix nom per a usuari"
read DB_USER
echo "
francescxrs: Introdueix contrasenya d'usuari"
read DB_USER_PASSWORD

# Creem arxiu _delete_db_and_users_$DB.
cat << endOfFile > $HOME/$RUTA_PROYECTOS/$CARPETA_PROYECTO/_delete_db_and_users_$DB.sql
-- Eliminem db
DROP DATABASE IF EXISTS $DB;
-- Eliminem usuaris associats a la db
DROP ROLE IF EXISTS $DB_USER;
endOfFile

echo "
francescxrs: Arxiu _delete_db_and_users_$DB creat"

# Creem arxiu create_db_and_users_$DB.
cat << endOfFile > $HOME/$RUTA_PROYECTOS/$CARPETA_PROYECTO/_create_db_and_users_$DB.sql
CREATE DATABASE $DB;
\c $DB;
CREATE USER $DB_USER WITH PASSWORD '$DB_USER';
ALTER ROLE $DB_USER SET client_encoding TO 'utf8';
ALTER ROLE $DB_USER SET default_transaction_isolation TO 'read committed';
ALTER ROLE $DB_USER SET timezone TO 'UTC';
GRANT ALL PRIVILEGES ON DATABASE $DB TO $DB_USER;
CREATE SEQUENCE enum_enters_seq START WITH 1 INCREMENT BY 1;
CREATE TABLE models(
    id NUMERIC(6) DEFAULT nextval('enum_enters_seq') PRIMARY KEY,
    nom VARCHAR(60) NOT NULL
);
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO $DB_USER;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO $DB_USER;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO $DB_USER;
-- Inserts serien tal que: INSERT INTO models(id,nom) VALUES(DEFAULT,'...');
endOfFile

echo "
francescxrs: Arxiu _create_db_and_users_$DB creat"

# Reiniciem servei psql
echo "
francescxrs: Reiniciem servei postgres"
sudo service postgresql restart

# Canviem a usuari postgres per crear base de dades.
echo "
francescxrs: Si existeix bd amb el mateix nom serà eliminada. Continuem? 
Si és així prem qualsevol tecla"
read
sudo -u postgres psql -f $HOME/$RUTA_PROYECTOS/$CARPETA_PROYECTO/_delete_db_and_users_$DB.sql
sudo -u postgres psql -f $HOME/$RUTA_PROYECTOS/$CARPETA_PROYECTO/_create_db_and_users_$DB.sql

# Reiniciem servei psql
echo "
francescxrs: Reiniciem servei postgres"
sudo service postgresql restart

# Creem arxiu py de test de connexió a base de dades i l'executem.
cat << endOfFile > $HOME/$RUTA_PROYECTOS/$CARPETA_PROYECTO/_test_connection.py
import psycopg2
conn = psycopg2.connect(dbname="$DB", user="$DB_USER", password="$DB_USER_PASSWORD")
print("\nfrancescxrs: Connexió a base de dades $DB amb usuari $DB_USER correcta")
endOfFile
python3 $HOME/$RUTA_PROYECTOS/$CARPETA_PROYECTO/_test_connection.py

# Creem arxiu _init_django_project_$NOMBRE_PROYECTO.
cat << endOfFile > $HOME/$RUTA_PROYECTOS/$CARPETA_PROYECTO/_init_django_project_$NOMBRE_PROYECTO.sh
cd $HOME/$RUTA_PROYECTOS/$CARPETA_PROYECTO
source $CARPETA_PROYECTO$env/bin/activate
x-terminal-emulator -e "python3 manage.py runserver"
x-terminal-emulator -e "psql -U $DB_USER $DB"
pycharm-community >/dev/null 2>&1 &
endOfFile

# Obrim terminal en paral·les postgres per a usuari creat
x-terminal-emulator -e "psql -U $DB_USER $DB"

echo "francescxrs: Fi de procés django_total_recall."


