# CANVIEM A RUTA DE PROJECTES DJANGO I A CARPETA DE PROJECTE DESITJAT
# cd $HOME/$RUTA_PROYECTOS/$CARPETA_PROYECTO

# ACTIVEM CARPETA PER A L'ENTORN DEL PROJECTE EN QÜESTIÓ
# source $CARPETA_PROYECTO_env/bin/activate

# ARRANQUEM SERVIDOR
# python3 manage.py runserver

# INICIEM PyCharm EN SEGÓN PLA
# pycharm-community >/dev/null 2>&1 &
# & perquè pycharm corri en segón pla
# /dev/null: Black hole de linux...
# By default: stdin => 0, stdout => 1, stderr => 2
# In the script >/dev/null: stdin => 0, stdout => /dev/null, stderr => 2
# And then 2>&1: stdin => 0, stdout => /dev/null, stderr => stdout

# COMPROVEM NAVEGADOR A: http://127.0.0.1:8000/
# http://127.0.0.1:8000/home
# http://127.0.0.1:8000/admin/
# ...
