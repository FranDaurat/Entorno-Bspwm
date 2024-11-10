#!/bin/bash

# Copia de archivos
sudo cp /home/elgordoponcio/.zshrc zshrc

# Git Push

git add . 
git commit -m "$1"
git push origin main



