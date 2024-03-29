#!/bin/bash
# Utilitzarem variable per determinar si el node és raspberrypi
# nodename=$(uname -n)
# Segons versió del OS (raspbian/ubuntu/...) seguirem un procés o altre. 
#if [ "${nodename}" != "raspberrypi" ]
#then
#echo -e "\e[95m\nEntrem en instal·lació per a sistema operatiu $nodename\e[0m"

cd
sudo apt-get update
sudo apt install -y snap snapd npm
sudo snap install core
sudo npm install treesitter-cli
sudo apt install -y wget curl git neovim
sudo apt install -y default-jre default-jdk
sudo apt install -y python3 python3-pip
sudo apt install -y ripgrep fzf
sudo apt install -y w3m w3m-img surf qutebrowser chromium
sudo apt install -y ranger calcurse
sudo apt install -y unzip
sudo apt install -y vlc mpv
sudo apt install -y texlive-full 
sudo apt install -y texlive-lang-spanish texlive-lang-english texlive-lang-european 
sudo apt install -y pandoc
# Si no es pot espanso instal.lar tots els packages autokey
sudo apt install espanso
# Després recorda executar "espanso service register" i "espanso start"
# Suckless 
sudo apt install -y gcc build-essential
sudo apt install -y libx11-dev libxft-dev libxinerama-dev
sudo apt install -y xinit
mkdir suckless
cd suckless
git clone https://git.suckless.org/dwm
cd dwm
make
sudo make clean install
cd ..
git clone https://git.suckless.org/st
cd st
make
sudo make clean install
cd ..
git clone https://git.suckless.org/dmenu
cd dmenu
make
sudo make clean install
cd
# Configura arxiu /etc/X11/xinit/xinitrc en mode sudo, comenta tot i deixa només "exec dwm"
# startx per iniciar desde terminal (raspi case)

# Wine stuff
# Afegim repositori universe de l'instal·lador apt i actualitzem apt.
#sudo add-apt-repository universe
# Habilitar l'arquitectura de 32 bits	
#sudo dpkg --add-architecture i386
# Importem keys de configuracio per a wine, aprox.
#wget -nc https://dl.winehq.org/wine-builds/winehq.key
#sudo apt-key add winehq.key
# Afegim repositoris wine
#sudo apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/
#sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
# Refresh the list of available packages and upgrade all installed packages.
#sudo apt update
# Instal·lem alien. Alien converts different Linux package distribution file formats to Debian and viceversa.
# Packages: Linux Standard Base, RPM, deb, Stampede (.slp) and Slackware (tgz).
#sudo apt install -y alien
# Instal.lem wine en la seva versio mes estable
#sudo apt install --install-recommends winehq-stable
# Comprovem info de wine
# wine --version
# Comprovem: LSB (Linux Standard Base) and distribution-specific information.
# lsb_release -a
# Configuracio de wine
#winecfg

# Altres
# Instal·lar editor Visual Studio Code o PyCharm
# sudo snap install -y --classic code
# sudo snap install -y --classic pycharm-community

# Python & Django
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

#else
#echo  -e "\e[95m\nEntrem en instal·lació per a sistema operatiu raspberry pi.\e[0m"

# En OS Raspbian probem instal.lar code de la seguent manera.
#cd ~
# wget: non-interactive download of files from the Web >> En aquest cas un arxiu .deb
#wget https://github.com/stevedesmond-ca/vscode-arm/releases/download/1.28.2/vscode-1.28.2.deb
# Install d'un arxiu .deb desde la mateixa ruta de l'arxiu
#sudo apt install ./vscode-1.28.2.deb

#fi
