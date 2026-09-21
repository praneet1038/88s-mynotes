#!/bin/bash

# This script will use a function to check if an installation was successful or not. It will also demonstrate the use of functions in shell scripting.

# check root user
USER=$(id -u)
if [ $USER -ne 0 ]; then
    echo "This script must be run as root. Pleae run with sudo or as root user."
    exit 1
fi

check_installation() {
    if [ $1 -eq 0 ]; then
        echo "$2 installed successfully."
    else
        echo "$2 installation failed."
        exit 1
    fi
}

dnf install nginx -y
check_installation $? "Nginx"

dnf install mysql -y
check_installation "$? MySQL"

dnf install nodejs -y
check_installation "$? Nodejs"

echo "All installations completed successfully."
