#!/bin/bash

dir="submissions"

if  [-d  "$dir"] ; then
echo "Directory $dir found."

else
#echo "Directory $dir not found ."
mkdir  submissions
fi

