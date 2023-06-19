## POSTGRE & DJANGO
# Reiniciem servei postgresql
# Executar script sql postgre.
# Obrim terminal en paral·lel i executem postgresql per a usuari creat
sudo service postgresql restart
sudo -u postgres psql -f ruta/script.sql -d database
x-terminal-emulator -e "psql -U dbuser db"

## SHELL COMMAND
# Creem arxiu helloworld.txt
cat << endOfFile > helloworld.txt
hello world!
endOfFile
# echo personalitzat
echo -e "\e[95m\n Hello world! \e[0m"
# Process kill
pkill -15 procesquesigui
# Reparar NTFS
sudo ntfsfix /dev/sdaquesigui
# Autokey interface
autokey -c
# Per inicialitzar raspi
sudo raspi-config

## MySQL
# Procés per reinicialitzar mysqlshell
service mysql stop
sudo /opt/lampp/lampp restart

## DRIVES
# CIM Alumnes
# https://drive.google.com/drive/folders/1iEO0HV4jXiFBjwB2CXqACvf2jtyxNNvY?usp=sharing
# CIM Joan
# https://drive.google.com/drive/folders/134RjyLF97mZwVgb7XXStqYWqTsjcKgug?usp=sharing

## VIM
# Add digraphs Ctrl-k + chars. Check :digraphs
