#!/bin/bash

execute_file () {
    local file_name=$1
    for file in $file_name
    do
        echo "Installing $file ..."
        sh $file

        if [ $? -eq 1 ]; then
            echo "Failed to install $file"
            exit 1
        fi
    done
}

execute_file ./pre-installers/*.sh
execute_file ./post-installers/*.sh
