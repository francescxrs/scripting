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

# INSTAL·LEM LLIBRERIES NECESSÀRIES EN ENTORN
# Psycopg: PostgreSQL database adapter for the Python programming language.
pip3 install psycopg2
# Django: web framework que respecta el patró de disseny MVC.
pip3 install django

# CREEM PROJECTE DJANGO
echo "Introdueix nom de projecte Django"
read NOMBRE_PROYECTO
django-admin.py startproject $NOMBRE_PROYECTO .

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
echo "IMPORTANT!!! 
Afegeix desde pycharm dins l'arxiu settings.py, dins el llistat INSTALLED_APPS, \
afegir l'aplicació: $APLICACION_DE_PROYECTO. Prem qualsevol tecla per continuar"
read
echo "Per a sortir de l'environment quan escaigui utilitza 'deactivate'. Prem qualsevol tecla per continuar"
read

echo "Arranquem servidor en terminal apart..."
# x-terminal-emulator -e "COMMAND" ens executa en una nova terminal COMMAND.
x-terminal-emulator -e "python3 manage.py runserver"
  
# FINS AQUI GUAI !!!

echo "Configuració d'arxiu pg_hba.conf feta?"
echo "Si és el 1r cop que creem projecte django... \
Modifica l'arxiu /etc/postgresql/11/main/pg_hba.conf, linea 90 aprox. \
Cambiarem el mode d'encriptació de peer a md5. \
L'encriptació peer amb l'usuari on ens trobem (oc-admin) no funcionarà \
entrant amb un altre usuari dels que s'hagin creat prèviament. \
Hauríem doncs de tancar sessió, entrar amb usuari concret i conectar amb \
aquest usuari concret. \
Amb md5 cambiem a una encriptació més simple que funciona per contrasenya. \
Un cop modificat pg_hba.conf prem qualsevol tecla."
read

cd ~/Escritorio/scripting
# Reiniciem servei psql
sudo service postgresql restart

# Variables bash per a usuari i base de dades
echo "Introdueix nom de base de dades"
read DB
echo "Introdueix nom per a usuari"
read DB_USER
echo "Introdueix contrasenya d'usuari"
read DB_USER_PASSWORD

# Creem arxiu delete_db_and_users_$DB.
cat << endOfFile > _delete_db_and_users_$DB.sql
-- Eliminem db
DROP DATABASE IF EXISTS $DB;
-- Eliminem usuaris associats a la db
DROP ROLE IF EXISTS $DB_USER;
endOfFile

# Creem arxiu create_db_and_users_$DB.
cat << endOfFile > _create_db_and_users_$DB.sql
-- Creem base de dades $DB
CREATE DATABASE $DB;
-- Connect a base de dades $DB
\c $DB;
-- Creació d'usuari i contrasenya 
CREATE USER $DB_USER WITH PASSWORD '$DB_USER';
-- Configuració per a encodificació de la db
ALTER ROLE $DB_USER SET client_encoding TO 'utf8';
-- Configuració per a fer lectures de forma mes robusta i àgil, entre d'altres.
ALTER ROLE $DB_USER SET default_transaction_isolation TO 'read committed';
-- Configuració horaria
ALTER ROLE $DB_USER SET timezone TO 'UTC';
-- Assignació de permisos a usuari tipus 'Déu'
GRANT ALL PRIVILEGES ON DATABASE $DB TO $DB_USER;
-- Creem seqüència i registres
CREATE SEQUENCE enum_enters_seq START WITH 1 INCREMENT BY 1;
-- Creem taula entitat
CREATE TABLE models(
    id NUMERIC(6) DEFAULT nextval('enum_enters_seq') PRIMARY KEY,
    nom VARCHAR(60) NOT NULL
);
-- Donem permisos a usuari
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO $DB_USER;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO $DB_USER;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO $DB_USER;
-- L'insert de torn seria tal que:
-- INSERT INTO models(id,nom) VALUES(DEFAULT,'model de torn...');
endOfFile

echo "punt 1"
# Reiniciem servei psql
sudo service postgresql restart
echo "punt 2"
# sortim i canviem a usuari postgres
exit
echo "punt 3"
sudo su postgres
echo "Si existeix bd amb el mateix nom sera eliminada. Continuem?"
read
psql -f _delete_db_and_users_$DB.sql
echo "punt 4"
# Creem base de dades
psql -f _create_db_and_users_$DB.sql
echo "punt 5"
# Sortim  de terminal postgres amb usuari postgres
exit

# Reiniciem servei psql
sudo service postgresql restart

# Creem arxiu py i l'executem. Test de connexió a db.
cat << endOfFile > _test_connection.py
import psycopg2
conn = psycopg2.connect(dbname="$DB", user="$DB_USER", password="$DB_USER_PASSWORD")
print("Connexió a base de dades $DB amb usuari $DB_USER correcta")
endOfFile
python3 _test_connection.py

# Obrim terminal postgres per a usuari creat
x-terminal-emulator -e "psql -U $DB_USER $DB"

echo "Procés correcte.


