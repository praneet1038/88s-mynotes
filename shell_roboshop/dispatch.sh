#!/bin/bash

# This script will setup dispatch component for roboshop application. It will install golang package, download and extract the application files to listen for rabbitmq messages. 

#!/bin/bash

# This script will setup catalgoue component for roboshop application. It will install required packages, download and extract the application code, and configure the systemd service for the catalogue component.

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
        echo -e "$2 ....$G SUCCESS $N" | tee -a $LOG_FILE
    else
        echo -e "$2 ....$R FAILED $N" | tee -a $LOG_FILE
        exit 1
    fi
},=

# install golang package
dnf install golang -y &>> LOG_FILE
validate_command_execution $? "Installing golang package"

# 



