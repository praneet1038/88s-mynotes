#!/bin/bash

# This script will install Nginx, MySQL, and Node.js on a Linux system using dnf package manager.
# It will also log the installation process and check if the installations were successful or not.

LOG_FOLDER="/var/log/shell_scripting/"
LOG_FILE="$LOG_FOLDER$0.log"

USER=$(id -u)
if [ $USER -ne 0 ]; then
    echo "This script must be run as root. Please run with sudo or as root user." | tee -a $LOG_FILE
    exit 1
fi

mkdir -p $LOG_FOLDER

check_installation() {
    if [ $1 -eq 0 ]; then
        echo "$2 ....SUCCESS" | tee -a $LOG_FILE
    else
        echo "$2 ....FAILED" | tee -a $LOG_FILE
        exit 1
    fi
}

dnf install nginx -y &>> $LOG_FILE
check_installation $? "Nginx installation"

dnf install mysql -y &>> $LOG_FILE
check_installation $? "MySQL installation"

dnf install nodejs -y &>> $LOG_FILE
check_installation $? "Nodejs installation"