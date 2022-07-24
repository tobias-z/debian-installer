#!/bin/zsh

path=$(dirname $(realpath $0))
sudo cp -r $path/../../home/.[^.]* $HOME
sudo cp -r $path/../../home/* $HOME
