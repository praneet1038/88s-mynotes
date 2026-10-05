#!/bin/bash

# This script will set color of text in the terminal using ANSI escape codes. 
R="\e[31m" # Red
G="\e[32m" # Green
Y="\e[33m" # Yellow
N="\e[0m" # Reset to default color

LOG_FOLDER="/var/log/shell_roboshop/"
LOG_FILE="$LOG_FOLDER$0.log"

# Check if the script is run as root user

USER=$(id -u)
if [ $USER -ne 0 ]; then
    echo -e "$R This script must be run as root. Please run with sudo or as root user. $N" | tee -a $LOG_FILE
    exit 1
fi

mkdir -p $LOG_FOLDER

validate_command_execution() {
    if [ $1 -eq 0 ]; then
        echo -e "$G $2 ....SUCCESS $N" | tee -a $LOG_FILE
    else
        echo -e "$R $2 ....FAILED $N" | tee -a $LOG_FILE
        exit 1
    fi
}

# check if mysql-server is installed or not, if not then install mysql-server package
dnf list installed mysql-server &>> $LOG_FILE
if [ $? -ne 0 ]; then
    echo -e "$Y mysql-server is not installed. Installing mysql-server package... $N" | tee -a $LOG_FILE
    dnf install mysql-server -y &>> $LOG_FILE
    validate_command_execution $? "Installing mysql-server package"
else
    echo -e "$Y mysql-server is already installed. Skipping installation. $N" | tee -a $LOG_FILE
fi

# enable and start the mysql-server service
systemctl enable mysqld &>> $LOG_FILE
systemctl start mysqld &>> $LOG_FILE
validate_command_execution $? "Starting mysql-server service"

# set root password for mysql-server
echo -e "Setting root password for mysql-server..."
read -s -p "Enter new root password: " MYSQL_ROOT_PASSWORD
mysql_secure_installation --set-root-pass $MYSQL_ROOT_PASSWORD
validate_command_execution $? "Setting root password for mysql-server"