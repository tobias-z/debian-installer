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

execute_file pre-installers/folder-structure.sh
execute_file pre-installers/golang.sh
execute_file pre-installers/python.sh
execute_file pre-installers/rust.sh
execute_file pre-installers/sdkman.sh
execute_file post-installers/apps.sh
execute_file post-installers/browsers.sh
execute_file post-installers/docker.sh
execute_file post-installers/font-manager.sh
execute_file post-installers/java.sh
execute_file post-installers/javascript.sh
execute_file post-installers/latex.sh
execute_file post-installers/lsp-servers.sh
execute_file post-installers/lua.sh
execute_file post-installers/neovim.sh
execute_file post-installers/i3.sh
execute_file post-installers/tmux-workspaces.sh
