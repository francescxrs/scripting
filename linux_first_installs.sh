#!/bin/bash

sudo apt update
sudo apt install snap
sudo snap install pycharm-community --classic
sudo apt install libpq-dev
sudo apt install postgresql
sudo apt install postgresql-contrib
sudo apt install python3-pip
sudo apt-get install python3-venv

# Llibreries python
pip3 install psycopg2
pip3 install django
