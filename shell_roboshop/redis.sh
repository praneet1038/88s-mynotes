#!/bin/bash

# This script will setup redis component for roboshop application. It will install redis 7 package, configure the redis service, and start the redis service.

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

dnf module list redis &>> $LOG_FILE
dnf module enable redis:7 -y &>> $LOG_FILE
validate_command_execution $? "Enabling redis 7 module"
dnf module install redis:7 -y &>> $LOG_FILE
validate_command_execution $? "Installing redis 7 package"

# update listen address from 127.0.0.1 to 0.0.0.0 permanently in redis config file
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/redis/redis.conf
validate_command_execution $? "Updating port in redis configuration file"

# change protectedmode from yes to no in redis config file
sed -i 's/protected-mode yes/protected-mode no/g' /etc/redis/redis.conf
validate_command_execution $? "Updating protected mode in redis configuration file"

# enable and start the redis service
systemctl enable redis &>> $LOG_FILE
systemctl start redis &>> $LOG_FILE







