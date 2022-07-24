#!/bin/bash

email="tobias.zimmer007@gmail.com"

ARGS=$(getopt -o 'e:' --long 'email:' -- "$@") || exit
eval "set -- $ARGS"

while true; do
    case $1 in
      (-e|--email)
            email=$2
            shift 2;;
      (--)  shift; break;;
      (*)   exit 1;;
    esac
done

path=$(dirname $(realpath $0))

execute_file () {
    local file_name=$path/$1
    echo "Installing $file_name ..."
    source $file_name $email
    if [ -f "$HOME/.zshrc" ]; then
        source $HOME/.zshrc
    fi

    if [ $? -eq 1 ]; then
        echo "Failed to install $file"
        exit 1
    fi
}

execute_file pre-installers/setup.sh
execute_file pre-installers/git.sh
execute_file pre-installers/zsh.sh
