#!/bin/bash

# This script will set color of text in the terminal using ANSI escape codes. 
R="\e[31m" # Red
G="\e[32m" # Green
Y="\e[33m" # Yellow
N="\e[0m" # Reset to default color

echo -e "$R This is red text $N"
echo -e "$G This is green text $N"
echo -e "$Y This is yellow text $N"

LOG_FOLDER="/var/log/shell_scripting/"
LOG_FILE="$LOG_FOLDER$0.log"

# This script will use a for loop to install packages passed as arguments to the script. It will also log the installation process and check if the installations were successful or not.

USER=$(id -u)
if [ $USER -ne 0 ]; then
    echo -e "$R This script must be run as root. Please run with sudo or as root user. $N" | tee -a $LOG_FILE
    exit 1
fi

mkdir -p $LOG_FOLDER

check_installation() {
    if [ $1 -eq 0 ]; then
        echo -e "$G $2 ....SUCCESS $N" | tee -a $LOG_FILE
    else
        echo -e "$R $2 ....FAILED $N" | tee -a $LOG_FILE
        exit 1
    fi
}

for package in $@
do
    dnf list installed $package &>> $LOG_FILE
    if [ $? -ne 0 ]; then
        echo -e "$G Installing $package...$N" | tee -a $LOG_FILE
        dnf install $package -y &>> $LOG_FILE
        check_installation $? "$package installation"
    else
        echo -e "$Y $package is already installed. Skipping installation.$N" | tee -a $LOG_FILE
    fi
done

echo "All installations completed successfully." | tee -a $LOG_FILE



