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

# copy the repo file mongo.repo to etc/yum.repos.d/mongo.repo
cp mongo.repo /etc/yum.repos.d/mongo.repo
# call function to check if previous process was successful or not
validate_command_execution $? "Copying mongo.repo file"

# install mongdb package
dnf install mongodb-org -y 
validate_command_execution $? "Installing mongodb package"

# start the mongodb service
systemctl start mongod
validate_command_execution $? "Starting mongodb service"

# enable the mongodb service to start on boot
systemctl enable mongod
validate_command_execution $? "Enabling mongodb service"

# update listen address from 127.0.0.1 to 0.0.0.0 permanently in mongodb config file
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
validate_command_execution $? "Updating mongodb configuration file"


# restart the mongodb service
systemctl restart mongod
validate_command_execution $? "Restarting mongodb service"

