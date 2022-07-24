#!/bin/sh

# Copy folders / files
path=$(dirname $(realpath $0))
sudo cp -r $path/../../home/.[^.]* $HOME
sudo cp -r $path/../../home/* $HOME

# Golang
cd ~/Downloads/
curl -OL https://golang.org/dl/go1.18.3.linux-amd64.tar.gz
rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.18.3.linux-amd64.tar.gz

# Python
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo nala install python3 -y
sudo nala install -y python3-pip
sudo nala install -y build-essential libssl-dev libffi-dev python3-dev
sudo nala install -y python3-venv

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Sdkman
curl -s "https://get.sdkman.io" | bash

# Nvm
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
