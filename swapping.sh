-- 1. Comprovem memoria swap.

-- Concatenar arxiu de processos swap.
-- cat /proc/swaps

-- Display amount of free and used memory in the system (megas).
-- free -m

-- Activar swap (summary). ~ el més intuitiu/millor!
-- swapon –s

-- 2. Lliberar memoria swap.

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
-- 
-- sudo sed -i '/\/swapfile/d' /etc/fstab

-- 4. Crear una nova partició swap


