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

execute_file () {
    local file_name=$1
    for file in $file_name; do
        echo "Installing $file ..."
        sh $file $email $setup_git $setup_folder_structure

        if [ $? -eq 1 ]; then
            echo "Failed to install $file"
            exit 1
        fi
    done
}

execute_file ./bin/pre-installers/*.sh
execute_file ./bin/post-installers/*.sh
