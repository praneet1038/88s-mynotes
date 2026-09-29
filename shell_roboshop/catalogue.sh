#!/bin/bash

# This script will setup catalgoue component for roboshop application. It will install required packages, download and extract the application code, and configure the systemd service for the catalogue component.

# define color codes and log folderfor output messages
R="\e[31m" # Red
G="\e[32m" # Green
Y="\e[33m" # Yellow
N="\e[0m" # Reset to default color

LOG_FOLDER="/var/log/shell_scripting/"
LOG_FILE="$LOG_FOLDER$0.log"


# check if the script is run as root user
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

# install nodejs 20 package

dnf module enable nodejs:20 -y
dnf install nodejs -y 
validate_command_execution $? "Installing nodejs package"

### add application user
useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
validate_command_execution $? "Adding application user"

### download and extract the application code
curl -s -L -o /tmp/catalogue.zip "https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip"
validate_command_execution $? "Downloading catalogue application code"

unzip -o /tmp/catalogue.zip -d /app
validate_command_execution $? "Extracting catalogue application code"

### install dependencies
cd /app
npm install 
validate_command_execution $? "Installing catalogue application dependencies"

### setup systemcctl catalogue service

cp catalogue.service /etc/systemd/system/catalogue.service
validate_command_execution $? "Copying catalogue systemd service file"  

### start and enable the catalogue service
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue
validate_command_execution $? "Starting catalogue service"
