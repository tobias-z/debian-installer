#!/bin/bash

path=$(dirname $(realpath $0))
cp -r $path/../../home/.[^.]* $HOME
