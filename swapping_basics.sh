# 1. Comprovem memoria swap.

# Concatenar arxiu de processos swap.
cat /proc/swaps
# Display amount of free and used memory in the system (megas).
free -m
# Activar swap (summary). ~ el més intuitiu/millor!
swapon –s

# 2. Lliberar memoria swap. * No és necessari.

# Cambiem a usuari root Desactivem swap i el reactivem. Sortim de l usuari.
sudo su root
swapoff -a && swapon -a
exit

# 3. Eliminar partició swap
# Descativem swap (all, verbose)
sudo swapoff -a -v
# Eliminar arxiu swapfile
sudo rm /swapfile
# Copiar arxiu com a backup file
sudo cp /etc/fstab /etc/fstab.bak
# Edició en stream del arxiu fstab in place (-i).
# fstab (file system tables) és un arxiu de configuració per particions/dispositius del sistema. 
# La regex '/elquesigui/d' utilitzada fa delete de 'elquesigui'
# Per tant fem delete de '/swapfile' >> '\/' fa de '/' dins la pròpia regex de sed. 
sudo sed -i '/\/swapfile/d' /etc/fstab

# 4. Crear una nova partició swap
# dd: Convert and copy a file
# if=FILE Arxiu de lectura. /dev/zero és un arxiu especial que proveeix caràcters nulls/zero.
# of=FILE Arxiu d escriptura swap (swapfile).
# bs=BYTES Tamany de lectura dels paquets en bytes (per defecte: 512).
# count=N Número de paquets. Exemples de càlcul (1024B=1KiB, 1024KiB=1MiB, 1024MiB=1GiB) 
#		Si definim bs com 1024 (bytes) >> bs=1024B=1kiB. Hem definits els paquets de tamany 1KiB.
# 		Una swap de 512MiB, quants paquets? 512x1024KiB = 524288KiB o 524288 Paquets.
# 		una swap de 1GiB, quants paquets? 1x1024MiB=1x1024x1024KiB = 1048576KiB o 1048576 Paquets.
sudo dd if=/dev/zero of=/swapfile bs=1024 count=1048576
# Estrucutra change owner: chown [new-owner]:[new-group] [file-name]
chown root:root /swapfile
# rwx >> read, write, execute
# ugoa >> u:propietari, g:grup del propietari, o:altres usuaris, a:u+g+o
chmod u=,g=rw,o= /swapfile # o bé: chmod 060 /swapfile; omitim 'a' perquè definim ugo.
# Set up a linux swap area. 
mkswap /swapfile
# Enable swap area
swapon /swapfile
# Afegim a /etc/fstab en última linea: "/swapfile none swap sw 0 0"
sed -i '$a /swapfile none swap sw 0 0' /etc/fstab
# comprovem arxiu /etc/fstab
# 		drwxrwxrwx >> Significat: 
#			1: - = file, d = directory, l = link 
#			2-4: u (propietari) >> read, write, execute 
#			5-7: g (grup del propietari) >> read, write. execute 
#			8-10: o (altres usuaris) >> read, write. execute
ls -la /etc/fstab



