#!/bin/bash

# This script will set color of text in the terminal using ANSI escape codes. 
R="\e[31m" # Red
G="\e[32m" # Green
Y="\e[33m" # Yellow
N="\e[0m" # Reset to default color

set -e # Exit immediately if a command exits with a non-zero status
trap 'echo "There is error in $LINENO Command $BASH_COMMAND Exiting..."' ERR

echoo "Testing trap command"


