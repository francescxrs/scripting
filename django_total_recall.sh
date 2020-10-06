#!/bin/bash

# UBICARSE EN CARPETA DE PROJECTES DJANGO
echo -e "\e[95m\nIntrodueix ruta per a carpeta de projectes Django (relativa desde \$HOME: ~/ruta).\e[0m" 
read RUTA_PROYECTOS
cd $HOME/$RUTA_PROYECTOS

# CREAR CARPETA DE PROJECTE DJANGO
echo -e "\e[95m\nIntrodueix nom per a carpeta de projecte Django.\e[0m"
read CARPETA_PROYECTO
mkdir $CARPETA_PROYECTO
cd $CARPETA_PROYECTO

# CREAR CARPETA PER A L'ENTORN
env="_env"
python3 -m venv $CARPETA_PROYECTO$env
echo -e "\e[95m\nCarpeta d'entorn creada.\e[0m"
# ACTIVAR CARPETA PER A L'ENTORN
source $CARPETA_PROYECTO$env/bin/activate

# INSTAL·LAR LLIBRERIES NECESSÀRIES EN ENTORN
# Psycopg: PostgreSQL database adapter for the Python programming language.
pip3 install psycopg2
# Django: web framework que respecta el patró de disseny MVC.
pip3 install django
echo -e "\e[95m\nLlibreria psycopg2 i framework django instal·lats.\e[0m"

# CREAR PROJECTE DJANGO
echo -e "\e[95m\nIntrodueix nom de projecte Django.\e[0m"
read NOMBRE_PROYECTO
django-admin.py startproject $NOMBRE_PROYECTO .

# CREAR LA PRIMERA APLICACIÓ DEL PROJECTE
echo -e "\e[95m\nIntrodueix nom de l'aplicació que desitjes crear per a projecte '$NOMBRE_PROYECTO'.\e[0m"
read APLICACION_DE_PROYECTO
python3 manage.py startapp $APLICACION_DE_PROYECTO

# CREAR CARPETA templates I static EN CARPETA DE L'APLICACIÓ
mkdir $APLICACION_DE_PROYECTO/templates
mkdir $APLICACION_DE_PROYECTO/static
echo -e "\e[95m\nCarpetes 'templates' i 'static' creades en aplicació.\e[0m"

# CODIFICACIÓ DE L'APLICATIU (ESCOLLIM visual studio code)
code $HOME/$RUTA_PROYECTOS/$CARPETA_PROYECTO >/dev/null 2>&1 & 
# & perquè visual studio code corri en segón pla
# /dev/null: Black hole de linux...
# By default: stdin => 0, stdout => 1, stderr => 2
# In the script >/dev/null: stdin => 0, stdout => /dev/null, stderr => 2
# And then 2>&1: stdin => 0, stdout => /dev/null, stderr => stdout

# JA OBERT visual studio code FER OPEN I ESCOLLIR CARPETA $RUTA_PROYECTOS.
echo -e "\e[95m\nAfegeix desde code en l'arxiu settings.py dins la llista INSTALLED_APPS, \
l'aplicació creada prèviament '$APLICACION_DE_PROYECTO'. Prem qualsevol tecla per continuar.\e[0m"
read
echo -e "\e[95m\nPer a sortir de l'environment quan escaigui utilitza 'deactivate'. \
Prem qualsevol tecla per continuar.\e[0m"
read

echo -e "\e[95m\nArranquem servidor en terminal apart.\e[0m"
# x-terminal-emulator -e "COMMAND" ens executa en una nova terminal COMMAND.
x-terminal-emulator -e "python3 manage.py runserver"

echo -e "\e[95m\nIMPORTANT: La configuració de l'arxiu pg_hba.conf està correctament feta?
Si és el 1r cop que creem projecte django o és un nou entorn del sistema operatiu cal \
modificar l'arxiu /etc/postgresql/11/main/pg_hba.conf, en la linea 90 aproximadament. Cambiarem \
el mode d'encriptació de peer a md5 en la Linia amb descripció:

'# \"local\" is for Unix domain socket connections only'

Amb md5 cambiem a una encriptació més simple que funciona per contrasenya. \
El que fem és que l'encriptació funcioni amb l'usuari on ens trobem (oc-admin) però no \
entrant amb un altre usuari dels que s'hagin creat prèviament. Haurem doncs de tancar sessió, \
entrar amb usuari concret i connectar amb aquest usuari concret. 

Un cop modificat pg_hba.conf prem qualsevol tecla.\e[0m"
read

cd ~/Escritorio/scripting
# Reiniciem servei psql
sudo service postgresql restart

echo -e "\e[95m\nReiniciem servei postgres.\e[0m"

# Variables bash per a usuari i base de dades
echo -e "\e[95m\nIntrodueix nom de base de dades.\e[0m"
read DB
echo -e "\e[95m\nIntrodueix nom per a usuari.\e[0m"
read DB_USER
echo -e "\e[95m\nIntrodueix contrasenya d'usuari.\e[0m"
read DB_USER_PASSWORD

# Creem arxiu _delete_db_and_users_$DB.
cat << endOfFile > $HOME/$RUTA_PROYECTOS/$CARPETA_PROYECTO/_delete_db_and_users_$DB.sql
-- Eliminem db
DROP DATABASE IF EXISTS $DB;
-- Eliminem usuaris associats a la db
DROP ROLE IF EXISTS $DB_USER;
endOfFile

echo -e "\e[95m\nArxiu _delete_db_and_users_$DB creat.\e[0m"

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

echo -e "\e[95m\nArxiu _create_db_and_users_$DB creat.\e[0m"

# Reiniciem servei psql
echo -e "\e[95m\nReiniciem servei postgres.\e[0m"
sudo service postgresql restart

# Canviem a usuari postgres per crear base de dades.
echo -e "\e[95m\nSi existeix base de dades amb el mateix nom ($DB) serà eliminada. Continuem? 
Si és així prem qualsevol tecla.\e[0m"
read
sudo -u postgres psql -f $HOME/$RUTA_PROYECTOS/$CARPETA_PROYECTO/_delete_db_and_users_$DB.sql
sudo -u postgres psql -f $HOME/$RUTA_PROYECTOS/$CARPETA_PROYECTO/_create_db_and_users_$DB.sql

# Reiniciem servei psql
echo -e "\e[95m\nReiniciem servei postgres.\e[0m"
sudo service postgresql restart

# Creem arxiu py de test de connexió a base de dades i l'executem.
cat << endOfFile > $HOME/$RUTA_PROYECTOS/$CARPETA_PROYECTO/_test_connection.py
import psycopg2
conn = psycopg2.connect(dbname="$DB", user="$DB_USER", password="$DB_USER_PASSWORD")
print("\nfrancescxrs: Connexió a base de dades $DB amb usuari $DB_USER correcta.")
endOfFile
python3 $HOME/$RUTA_PROYECTOS/$CARPETA_PROYECTO/_test_connection.py

# Creem arxiu _init_django_project_$NOMBRE_PROYECTO.
cat << endOfFile > $HOME/$RUTA_PROYECTOS/$CARPETA_PROYECTO/_init_django_project_$NOMBRE_PROYECTO.sh
cd $HOME/$RUTA_PROYECTOS/$CARPETA_PROYECTO
source $CARPETA_PROYECTO$env/bin/activate
x-terminal-emulator -e "python3 manage.py runserver"
x-terminal-emulator -e "psql -U $DB_USER $DB"
code $HOME/$RUTA_PROYECTOS/$CARPETA_PROYECTO >/dev/null 2>&1 &
endOfFile

# Obrim terminal en paral·les postgres per a usuari creat
x-terminal-emulator -e "psql -U $DB_USER $DB"

echo -e "\e[95m\nFi de procés django_total_recall.\e[0m"


