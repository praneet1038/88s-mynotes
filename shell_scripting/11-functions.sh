#!/bin/bash

# This script will use a function to check if an installation was successful or not. It will also demonstrate the use of functions in shell scripting.

LOG_FOLDER="/var/log/shell_scripting/"
LOG_FILE="$LOG_FOLDER$0.log"

# check root user
USER=$(id -u)
if [ $USER -ne 0 ]; then
    echo "This script must be run as root. Pleae run with sudo or as root user." &>> $LOG_FILE
    exit 1
fi

# create log folder if it does not exist
mkdir -p $LOG_FOLDER

check_installation() {
    if [ $1 -eq 0 ]; then
        echo "$2 installed successfully." 
    else
        echo "$2 installation failed."  
        exit 1
    fi
}

dnf install nginx -y &>> $LOG_FILE
check_installation $? "Nginx"

dnf install mysql -y &>> $LOG_FILE
check_installation $? "MySQL"

dnf install nodejs -y &>> $LOG_FILE
check_installation $? "Nodejs"

echo "All installations completed successfully."
