#!/bin/sh

# Alacritty
sudo apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 -y

rustup override set stable
rustup update stable

git clone https://github.com/alacritty/alacritty.git
cd alacritty

cargo build --release

sudo tic -xe alacritty,alacritty-direct extra/alacritty.info

sudo cp target/release/alacritty /usr/local/bin
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

sudo mkdir -p /usr/local/share/man/man1
gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
gzip -c extra/alacritty-msg.man | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null

mkdir -p ${ZDOTDIR:-~}/.zsh_functions
echo 'fpath+=${ZDOTDIR:-~}/.zsh_functions' >> ${ZDOTDIR:-~}/.zshrc

cp extra/completions/_alacritty ${ZDOTDIR:-~}/.zsh_functions/_alacritty

gsettings set org.gnome.desktop.default-applications.terminal exec 'alacritty'

cd ..
rm -rf alacritty

# Gyazo
curl -s https://packagecloud.io/install/repositories/gyazo/gyazo-for-linux/script.deb.sh | sudo bash
sudo nala install gyazo -y

sudo nala install software-properties-common apt-transport-https wget ca-certificates gnupg2 -y

# Peek for gif generation
sudo add-apt-repository ppa:peek-developers/stable
sudo apt-get update
sudo apt-get install peek

# Slack, Discord, vscode, Teams
sudo snap install core
sudo snap install slack --classic
sudo snap install discord
sudo snap install --classic code

wget https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/teams_1.5.00.10453_amd64.deb
sudo dpkg -i teams_1.5.00.10453_amd64.deb

# Jetbrains toolbox
wget --show-progress -qO ./toolbox.tar.gz "https://data.services.jetbrains.com/products/download?platform=linux&code=TBA"

TOOLBOX_TEMP_DIR=$(mktemp -d)

tar -C "$TOOLBOX_TEMP_DIR" -xf toolbox.tar.gz
rm ./toolbox.tar.gz

"$TOOLBOX_TEMP_DIR"/*/jetbrains-toolbox

rm -r "$TOOLBOX_TEMP_DIR"

# brave browser
sudo nala install apt-transport-https curl -y
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo nala update
sudo nala install brave-browser -y

# Chrome
cd ~/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

# Docker
sudo apt-get remove docker docker-engine docker.io containerd runc -y

sudo apt-get update
sudo apt-get install ca-certificates curl gnupg lsb-release -y

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

# https://docs.docker.com/engine/install/linux-postinstall/
# Allow none sudo docker
sudo groupadd docker
sudo usermod -aG docker $USER

# Docker Compose
mkdir -p ~/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.7.0/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
sudo chmod +x ~/.docker/cli-plugins/docker-compose

# Font manager
sudo add-apt-repository ppa:font-manager/staging -y
sudo nala update
sudo nala install font-manager -y

# i3, Rofi
wget -O- https://baltocdn.com/i3-window-manager/signing.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/i3wm-signing.gpg
sudo nala install apt-transport-https -y
echo "deb https://baltocdn.com/i3-window-manager/i3/i3-autobuild/ all main" | sudo tee /etc/apt/sources.list.d/i3-autobuild.list
sudo nala update
sudo nala install i3 rofi -y

# Setup for Java
sdk install java 17.0.4-amzn
sdk install java 8.0.342-amzn
sdk install java 11.0.16-amzn

sdk default java 17.0.4-amzn

sdk install tomcat 10.0.22
sdk install tomcat 9.0.56

sdk default tomcat 10.0.22

sdk install maven
sdk install gradle
sdk install springboot

# Lua
sudo nala install lua -y
sudo nala install luarocks -y

luarocks install luacheck
luarocks install lanes

cargo install stylua
cargo install tree-sitter-cli
