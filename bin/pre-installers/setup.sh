#!/bin/bash

sudo apt update -y
sudo apt upgrade -y
sudo apt-get update -y

# Use nala for package management
echo "deb http://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg
sudo apt update && sudo apt install nala -y

sudo nala fetch

sudo nala install software-properties-common htop neofetch ncdu wget curl ripgrep tmux zip unzip feh fzf xkeycaps autokey-gtk nmap snapd gcc gnome-tweaks -y
