#!/bin/zsh

# Gyazo
curl -s https://packagecloud.io/install/repositories/gyazo/gyazo-for-linux/script.deb.sh | sudo bash
sudo nala install gyazo -y

sudo nala install software-properties-common apt-transport-https wget ca-certificates gnupg2 -y

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
