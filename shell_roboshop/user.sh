#!/bin/bash

# This script will setup user component for roboshop application. It will install nodejs 20 package, download and extract the application files and configure redis/mongodb for the user service.

# define color codes and log folderfor output messages
R="\e[31m" # Red
G="\e[32m" # Green
Y="\e[33m" # Yellow
N="\e[0m" # Reset to default color

LOG_FOLDER="/var/log/shell_scripting/"
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
        echo -e "$G $2 ....SUCCESS $N" | tee -a $LOG_FILE
    else
        echo -e "$R $2 ....FAILED $N" | tee -a $LOG_FILE
        exit 1
    fi
}

# check if nodejs is installed or not, if not then install nodejs 20 package
dnf list installed nodejs &>> $LOG_FILE
if [ $? -ne 0 ]; then
    echo -e "$Y nodejs is not installed. Installing nodejs 20 package...$N" | tee -a $LOG_FILE
    dnf module install nodejs:20 -y &>> $LOG_FILE
    validate_command_execution $? "Installing nodejs 20 package"
else
    echo -e "$Y nodejs is already installed. Skipping installation. $N"
fi

# check if user roboshop exists or not, if not then create the user
id roboshop &>> $LOG_FILE
if [ $? -ne 0 ]; then
    echo -e "&Y user roboshop does not exist. Creating user roboshop... $N" | tee -a $LOG_FILE
    useradd roboshop &>> $LOG_FILE
    validate_command_execution $? "Creating user roboshop"
else
    echo -e "$Y user roboshop already exists. Skipping user creation. $N"
fi

# check if the application directory exists or not, if not then create it
mkdir -p /app &>> $LOG_FILE

# download and extract the user application code to /app directory
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user-v3.zip 
cd /app
unzip -o /tmp/user.zip -d /app &>> $LOG_FILE
validate_command_execution $? "Downloading and extracting user application code to /app directory"
npm install &>> $LOG_FILE

# copy the user systemd service file to /etc/systemd/system/user.service
cp $SCRIPT_DIR/user.service /etc/systemd/system/user.service

# enable and start the user service
systemctl daemon-reload &>> $LOG_FILE
systemctl enable user &>> $LOG_FILE
systemctl start user &>> $LOG_FILE



