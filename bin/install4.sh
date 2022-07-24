#!/bin/sh

# setup for nvim jdtls
mkdir -p ~/.local/share/jdtls/workspaces
mkdir -p ~/config/neovim/debuggers

cd ~/config/neovim/debuggers

git clone https://github.com/microsoft/java-debug
cd java-debug
./mvnw clean install
cd ..

git clone https://github.com/microsoft/vscode-java-test
cd vscode-java-test
npm install
npm run build-plugin

# Tools
cd ~/bin/.local
sudo chmod +x bin/*
cd bin

sudo nala install libxml2-utils -y

# Javascript
nvm install 16
nvm install --lts

npm install --global yarn
npm install -g prettier
npm install -g eslint

# Latex
sudo nala install texlive-full -y

# Neovim
sudo nala install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen -y

cd ~/dev/lua

git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

# Tmux workspaces
cd ~/dev/scripts

git clone git@github.com:tobias-z/tmux-workspaces.git
sudo chmod +x ./tmux-workspaces/src/tw
