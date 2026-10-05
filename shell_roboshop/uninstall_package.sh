#!/bin/bash

# This script will uninstall a package passed as an argument to the script. 

# define color codes and log folderfor output messages
R="\e[31m" # Red
G="\e[32m" # Green
Y="\e[33m" # Yellow
N="\e[0m" # Reset to default color

LOG_FOLDER="/var/log/shell_roboshop/"
LOG_FILE="$LOG_FOLDER$0.log"
SCRIPT_DIR=$PWD

# check if the script is run as root user
USER=$(id -u)
if [ $USER -ne 0 ]; then
    echo -e "$R This script must be run as root. Please run with sudo or as root user. $N" | tee -a $LOG_FILE
    exit 1
fi

mkdir -p $LOG_FOLDER

validate_command_execution() {
    if [ $1 -eq 0 ]; then
        echo -e " $2 ....$G SUCCESS $N" | tee -a $LOG_FILE
    else
        echo -e " $2 ....$R FAILED $N" | tee -a $LOG_FILE
        exit 1
    fi
}


# This script will uninstall a package passed as an argument to the script. 
for package in $@; do
    if dnf list installed $package &>> $LOG_FILE; then
        echo -e "$G $package is installed. Proceeding with uninstallation... $N" | tee -a $LOG_FILE
    else
        echo -e "$Y $package is not installed. Skipping uninstallation. $N" | tee -a $LOG_FILE
        continue
    fi
    echo "Uninstalling $package..."
    systemctl stop $package &>> $LOG_FILE
    systemctl disable $package &>> $LOG_FILE
    dnf remove -y $package &>> $LOG_FILE
    validate_command_execution $? "$package uninstalled successfully."
done
