#!/bin/bash

read -p "Enter the directory name: " dirname

if [[ -d "$dirname" ]]; then
    echo "Your directory $dirname exists"

    if [[ -f "submission1.txt" ]]; then
        mv submission1.txt "$dirname"
        touch "$dirname/submission2.txt"

    elif [[ -f "submission2.txt" ]]; then
        mv submission2.txt "$dirname"
        touch "$dirname/submission1.txt"

    else
        touch "$dirname/submission1.txt" "$dirname/submission2.txt"
    fi

elif [[ -f "$dirname" ]]; then
    echo "Sorry this is a file, not a directory"

else
    mkdir "$dirname"
    touch "$dirname/submission1.txt" "$dirname/submission2.txt"
fi
