#!/bin/bash

# defaults
email="tobias.zimmer007@gmail.com"
setup_git="0"
setup_folder_structure="0"

ARGS=$(getopt -o 'e:gf' --long 'email:,setup-git,setup-folder-structure' -- "$@") || exit
eval "set -- $ARGS"

while true; do
    case $1 in
      (-e|--email)
            email=$2
            shift 2;;
      (-g|--setup-git)
            setup_git="1"
            shift;;
      (-f|--setup-folder-structure)
            setup_folder_structure="1"
            shift;;
      (--)  shift; break;;
      (*)   exit 1;;
    esac
done

path=$(dirname $(realpath $0))

execute_file () {
    local file_name=$path/$1
    echo "Installing $file_name ..."
    echo "args: $email, $setup_git, $setup_folder_structure"
    sh $file_name $email $setup_git $setup_folder_structure

    if [ $? -eq 1 ]; then
        echo "Failed to install $file"
        exit 1
    fi
}

execute_file pre-installers/setup.sh
execute_file pre-installers/git.sh
execute_file pre-installers/zsh.sh
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
execute_file post-installers/tmux-workspaces.sh
