#!/bin/bash

echo "This script demonstrates the use of special variables in shell scripting."
echo "The script NAME is: $0"
echo "All ARGUMENTS passed to the script as a LIST: $@"
echo "The NUMBER of arguments passed to the script is: $#"
echo "The process ID of the script is: $$"
echo "Current working DIRECTORY is: $PWD"
echo "Who am I? $USER"
sleep 100 &
echo "The process ID of the last BACKGROUND command is: $!"
echo "Home DIRECTORY of the $USER is: $HOME"
echo "All ARGUMENTS passed to the script as a SINGLE STRING: $*"