#!/bin/bash

if [ "$3" = "1" ]; then
    path=$(dirname $(realpath $0))
    cp -r $path/../../home/* $HOME/*
fi
