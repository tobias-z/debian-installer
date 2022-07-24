#!/bin/sh

email=$1

# Setup
sudo apt update -y
sudo apt upgrade -y
sudo apt-get update -y

echo "deb http://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg
sudo apt update && sudo apt install nala -y

sudo nala fetch

sudo nala install software-properties-common htop neofetch ncdu wget curl ripgrep tmux zip unzip feh fzf xkeycaps autokey-gtk nmap snapd gcc gnome-tweaks -y

sudo nala install make build-essential libssl-dev libghc-zlib-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip -y

# Git
cd /tmp
sudo wget https://github.com/git/git/archive/master.zip -O git.zip
unzip git.zip
cd git-*
make prefix=/usr/local/
sudo make prefix=/usr/local install

echo "git version $(git --version) was succesfully installed"

ssh-keygen -t ed25519 -C $email

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo nala install gh -y

echo "Enter Github access token:"
read access_token

echo "$access_token" >> /tmp/token.txt
gh auth login --with-token < /tmp/token.txt
gh ssh-key add ~/.ssh/id_ed25519.pub

rm /tmp/token.txt

# Zsh
sudo nala install zsh -y
chsh -s $(which zsh)

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

zsh_custom="$HOME/.oh-my-zsh/custom"

# Theme
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$zsh_custom/themes/spaceship-prompt" --depth=1
ln -s "$zsh_custom/themes/spaceship-prompt/spaceship.zsh-theme" "$zsh_custom/themes/spaceship.zsh-theme"

# Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${zsh_custom:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${zsh_custom:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
