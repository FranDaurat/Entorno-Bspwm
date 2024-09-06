#!/bin/bash

# Copia de archivos
sudo cp -r /home/elgordoponcio/go/bin/* /home/elgordoponcio/repos/entorno-bspwm/gobin/
sudo cp /home/elgordoponcio/.zshrc zshrc

# Git Push
rm -rf ./gobin/nuclei 

git add . 
git commit -m "Pusheo Automatizado"
git push origin main



