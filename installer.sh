#!/bin/bash

tput civis

# Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

function ctrl_c() {
  echo -e "\n\n${redColour}[!] Saliendo...${endColour}\n"
  tput cnorm
  exit 1
}

# Ctrl+C
trap ctrl_c INT

# Variables de configuración
USER_HOME="/home/elgordoponcio"
ROOT_HOME="/root"

# Función para instalar paquetes
install_packages() {
  echo -e "${blueColour}[*] Actualizando e instalando paquetes...${endColour}"
  sudo apt update -y
  sudo apt install -y git curl kitty bat xclip httpx-toolkit subfinder moreutils lsd bspwm sxhkd zsh 
  sudo apt install -y build-essential vim libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev 
  sudo apt install -y  libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev
}

# Función para instalar oh-my-zsh y plugins
install_oh_my_zsh() {
  echo -e "${blueColour}[*] Instalando oh-my-zsh y plugins...${endColour}"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${USER_HOME}/.oh-my-zsh/custom/themes/powerlevel10k
  git clone https://github.com/zsh-users/zsh-autosuggestions ${USER_HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${USER_HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

  sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ROOT_HOME}/.oh-my-zsh/custom/themes/powerlevel10k
  sudo git clone https://github.com/zsh-users/zsh-autosuggestions ${ROOT_HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ROOT_HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
}

# Función para copiar archivos de configuración
copy_config_files() {
  echo -e "${blueColour}[*] Copiando archivos de configuración...${endColour}"

  # .zshrc

  if [ -f "${USER_HOME}/.zshrc" ]; then
    rm -rf ${USER_HOME}/.zshrc
    cp zshrc ${USER_HOME}/.zshrc
  else
    cp zshrc ${USER_HOME}/.zshrc
  fi
  ## Root
  if [ -f "${ROOT_HOME}/.zshrc" ]; then
    rm -rf ${ROOT_HOME}/.zshrc
    sudo cp zshrc ${ROOT_HOME}/.zshrc
  else
    sudo cp zshrc ${ROOT_HOME}/.zshrc
  fi

  # .p10k.zsh

  if [ -f "${USER_HOME}/.p10k.zsh" ]; then
    rm -rf ${USER_HOME}/.p10k.zsh
    cp p10k.zsh ${USER_HOME}/.p10k.zsh
  else
    cp p10k.zsh ${USER_HOME}/.p10k.zsh
  fi
  ## Root
  if [ -f "${ROOT_HOME}/.p10k.zsh" ]; then
    rm -rf ${ROOT_HOME}/.p10k.zsh
    sudo cp .p10k.zsh_root ${ROOT_HOME}/.p10k.zsh
  else
    sudo cp .p10k.zsh_root ${ROOT_HOME}/.p10k.zsh
  fi

  # powerlevel10k

  if [ -d "${USER_HOME}/powerlevel10k" ]; then
    rm -rf ${USER_HOME}/powerlevel10k/*
    cp -r powerlevel10k/* ${USER_HOME}/powerlevel10k
  else
    mkdir ${USER_HOME}/powerlevel10k
    cp -r powerlevel10k/* ${USER_HOME}/powerlevel10k
  fi
  ## Root
  if [ -d "${ROOT_HOME}/powerlevel10k" ]; then
    rm -rf ${ROOT_HOME}/powerlevel10k/*
    sudo cp -r powerlevel10k_root/* ${ROOT_HOME}/powerlevel10k/
  else
    mkdir ${ROOT_HOME}/powerlevel10k
    sudo cp -r powerlevel10k_root/* ${ROOT_HOME}/powerlevel10k/
  fi

  # .config
  if [ -d "${USER_HOME}/.config" ]; then
    rm -rf ${USER_HOME}/.config/*
    cp -r config_Bspwm/config_user/* ${USER_HOME}/.config/
  else
    mkdir ${USER_HOME}/.config
    cp -r config_Bspwm/config_user/* ${USER_HOME}/.config/
  fi
  ## Root
  if [ -d "${ROOT_HOME}/.config" ]; then
    rm -rf ${ROOT_HOME}/.config/*
    sudo cp -r config_Bspwm/config_root/* ${ROOT_HOME}/.config/
  else
    mkdir ${ROOT_HOME}/.config
    sudo cp -r config_Bspwm/config_root/* ${ROOT_HOME}/.config/
  fi
}

# Función para crear enlaces simbólicos
#create_symlinks() {
#  echo -e "${blueColour}[*] Creando enlaces simbólicos...${endColour}"
#  ln -s ${USER_HOME}/.oh-my-zsh ${USER_HOME}/.oh-my-zsh/oh-my-zsh.sh
#  sudo ln -s ${ROOT_HOME}/.oh-my-zsh ${ROOT_HOME}/.oh-my-zsh/oh-my-zsh.sh#
#
#  ln -s ${USER_HOME}/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme ${USER_HOME}/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh
#  sudo ln -s ${ROOT_HOME}/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme ${ROOT_HOME}/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh
#}

# Llamada a funciones
install_packages
install_oh_my_zsh
copy_config_files
create_symlinks

echo -e "\n\n${greenColour}[*] Instalación terminada, sólo falta instalar BurpsuitePro y reiniciar...${endColour}\n"
tput cnorm