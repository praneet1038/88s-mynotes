#!/bin/bash

LOG_FOLDER="/var/log/shell_scripting/"
LOG_FILE="$LOG_FOLDER$0.log"

# This script will use a for loop to install packages passed as arguments to the script. It will also log the installation process and check if the installations were successful or not.

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

for package in $@
do
    dnf installed $package -y &>> $LOG_FILE
    if [ $? -ne 0 ]; then
        echo "Installing $package..." | tee -a $LOG_FILE
        dnf install $package -y &>> $LOG_FILE
        check_installation $? "$package installation"
    else
        echo "$package is already installed. Skipping installation." | tee -a $LOG_FILE
    fi
done


echo "All installations completed successfully." | tee -a $LOG_FILE