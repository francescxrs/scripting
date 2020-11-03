-- 1. Comprovem memoria swap.

-- Concatenar arxiu de processos swap.
-- cat /proc/swaps

-- Display amount of free and used memory in the system (megas).
-- free -m

-- Activar swap (summary). ~ el més intuitiu/millor!
-- swapon –s

-- 2. Lliberar memoria swap. * No és necessari.

-- Cambiem a usuari root Desactivem swap i el reactivem. Sortim de l usuari.
-- sudo su root
-- swapoff -a && swapon -a
-- exit

-- 3. Eliminar partició swap
-- Descativem swap (all, verbose)
-- sudo swapoff -a -v
-- Eliminar arxiu swapfile
-- sudo rm /swapfile
-- Copiar arxiu com a backup file
-- sudo cp /etc/fstab /etc/fstab.bak
-- Edició en stream del arxiu fstab in place (-i).
-- fstab (file system tables) és un arxiu de configuració per particions/dispositius del sistema. 
-- La regex '/elquesigui/d' utilitzada fa delete de 'elquesigui'
-- Per tant fem delete de '/swapfile' >> '\/' fa de '/' dins la pròpia regex de sed. 
-- sudo sed -i '/\/swapfile/d' /etc/fstab

-- 4. Crear una nova partició swap
-- dd: Convert and copy a file
-- if=FILE read from FILE instead of stdin
-- of=FILE write to FILE instead of stdout 
-- bs=BYTES read and write up to BYTES bytes at a time (default: 512); overrides ibs and obs
-- count=N copy only N input blocks
-- sudo dd if=/dev/zero of=/mnt/512MiB.swap bs=1024 count=524288


