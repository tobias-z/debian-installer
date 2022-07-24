#!/bin/zsh

sudo nala install lua -y
sudo nala install luarocks -y

luarocks install luacheck
luarocks install lanes

cargo install stylua
