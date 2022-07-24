#!/bin/zsh

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
chmod +x bin/*
cd bin

sudo nala install libxml2-utils -y
