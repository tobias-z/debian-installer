#!/bin/bash

for arg in "$@"; do
    if [ "$arg" = "--setup-folder-structure" ]; then
        echo "copying folders"
        exit 0
    fi
done
