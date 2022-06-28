#!/bin/bash

for arg in "$@"; do
    echo "arg is: $arg"
    if [ "$arg" = "--with-folder-structure" ]; then
        echo "copying folders"
    fi
done
