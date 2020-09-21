# CANVIEM A RUTA DE PROJECTES DJANGO I A CARPETA DE PROJECTE DESITJAT
# cd $HOME/$RUTA_PROYECTOS/$CARPETA_PROYECTO

# ACTIVEM CARPETA PER A L'ENTORN DEL PROJECTE EN QÜESTIÓ
# source $CARPETA_PROYECTO_env/bin/activate

# INICIEM PyCharm EN SEGÓN PLA
# pycharm-community >/dev/null 2>&1 &
# & perquè pycharm corri en segón pla
# Considerant que /dev/null és el black hole de linux
# i que by default: stdin=>0, stdout=>1, stderr=>2
# en l'script >/dev/null vol dir: 1 (stdout) va a /dev/null, 
# segonament 2>&1 vol dir: 2 (stderr) va a 1 (stdout), i 1 ja va /dev/null

# ARRANQUEM SERVIDOR
# x-terminal-emulator -e "COMMAND" ens executa en una nova terminal COMMAND.
# x-terminal-emulator -e "python3 manage.py runserver"

# COMPROVEM NAVEGADOR A: 
# http://127.0.0.1:8000/
# http://127.0.0.1:8000/home
# http://127.0.0.1:8000/admin/
# ...
