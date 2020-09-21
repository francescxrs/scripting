#!/bin/bash

####################
# INICIALITZACIONS #
####################

# Si és 1r cop: 
# 1. Modificar arxiu /etc/postgresql/11/main/pg_hba.conf, linea 90 aprox.
#    > Cambiarem el mode d'encriptació de peer a md5.
# 	   L'encriptació peer amb l'usuari on ens trobem (oc-admin) no funcionarà 
#      entrant amb un altre usuari dels que s'hagin creat prèviament.
#      Hauríem doncs de tancar sessió, entrar amb usuari concret i conectar amb 
#      aquest usuari concret.
#      Amb md5 cambiem a una encriptació més simple que funciona per contrasenya. 
# 2. Reiniciar servidor postgres un cop sigui efectiu el canvi:
#    > Llançar 'sudo service postgresql restart'
# 3. Testejem amb arxiu py o directament amb codi la connexió


# Reiniciem servei psql
sudo service postgresql restart

# Variables bash usuari i base de dades
user="proyecto_03_user"
db="proyecto_03_db"
password="proyecto_03_user"

# Creem arxiu py i l'executem. Test de connexió a db.
cat << endOfFile > test_connection.py
import psycopg2
conn = psycopg2.connect(dbname="$db", user="$user", password="$password")
print("Connexió a base de dades correcta")
endOfFile
python3 test_connection.py

# Accedim amb usuari i base de dades desitjats
psql -U $user $db

