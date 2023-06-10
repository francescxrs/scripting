---
output: pdf_document
geometry: "left=2cm,right=1.75cm,top=2.5cm,bottom=2.25cm"
title: "Software Tips"
author: Francesc X. Reverter
date: 05/2023
toc: true
toc-title: "Índice"
header-includes:
	\usepackage{fancyhdr}
	\pagestyle{fancy}
	\fancyhead[L]{Tips}
	\fancyhead[C]{}
	\fancyhead[R]{Francesc X. Reverter}
	\fancyfoot[C]{\thepage}
---

\thispagestyle{empty}
\pagebreak


# Terminal

**setxkbmap es|us**: Selecciona idioma del teclat  
**xdg-open**: Obre el que li indiquis amb el predeterminat  
**pkill --oldest chrome|...**: Tancar procés encallat  
**wine .wine/drive_c/Program\ Files/Mp3tag.exe**: Obrir programa wine  

## FZF (Fuzzy Finder)

- **Ctrl+r**: Command history
- **Ctrl+t**: Directory (Tab selects)
- **cd \*\***: Exemple de trigger amb cd

# Vim

## FZF (Fuzzy Finder)

**,aa**: Regex search  
**,aq**: Files search  

- **Ctrl+t**: Tab split
- **Ctrl+x**: Horizontal split
- **Ctrl+v**: Vertical split

## Telescope

**,ff**: Find Files  
**,fg**: Find grep  

## Nerd-Commenter

**,cc**: Comment  
**,cn**: Nest  
**,ci**: Inverter  
**,c$**: Comment to the end of line  
**,cA**: Append  

## EZ-Window

**Ctrl+hjkl**: Moure a la finestra segons cursor Vim
**Ctrl+r**: Resize mode, + hjkl. 

# DWM (Dynamic Window Manager)

**Alt+Shift+Enter**: Obre una nova Terminal
**Alt+j|k**: Anem de finestra en finestra
**Alt+Shift+c**: Tanca finestra
**Alt+Enter**: Fem switch master/esclau
**Alt+Número**: Anem a tab numerada
**Alt+,|.**: Anem a l'altra screen
**Alt+<|>**: Movem finestra a l'altra screen
**Alt+mtb**: Pantalla completa, tiles, border

# Espanso

**exp,,**: xdg-open .  
**lan,,**: setxkbmap us  
**mp3tag,,**: wine ~/.wine/drive_c/Program\\ Files/Mp3tag/Mp3tag.exe  
**fr@**: francescreverter@hotmail.com  
**fxr@**: francescxreverter@gmail.com  
**php,,**: \<?php $|$ ?\>  
**mysqlshell,,**: mysql -h 127.0.0.1 -P 3306 -u root -p mysql  
**mysqldumpcopy,,**: mysqldump --column-statistics=0 -h 127.0.0.1 -P 3306 -u root BASEDEDADES > RUTA/DOCUMENT.sql  
**mysqldumppaste,,**: mysql -h 127.0.0.1 -P 3306 -u root BASEDEDADES < /RUTA/DOCUMENT.sql  
