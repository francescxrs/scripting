#!/bin/bash

echo "Instal·lacion inicials"
. ./linux_first_installs.sh &&

echo "Prem qualsevol tecla per començar a crear environment django"
read
. ./django_environment_and_project_maker.sh &&





