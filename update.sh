#!/bin/bash

# Copia de archivos
sudo cp -r /home/elgordoponcio/go/bin/* /home/elgordoponcio/repos/entorno-bspwm/gobin/
sudo cp /home/elgordoponcio/.zshrc zshrc

# Git Push

git add . 
git commit -m "$1"
git push origin main



