#!/bin/bash

# This script will install rabbitmq database for roboshop applicatin. It will install rabbitmq-server package, configure the rabbitmq service, and create a user for the roboshop application.

# This script will set color of text in the terminal using ANSI escape codes. 
R="\e[31m" # Red
G="\e[32m" # Green
Y="\e[33m" # Yellow
N="\e[0m" # Reset to default color

LOG_FOLDER="/var/log/shell_roboshop/"
LOG_FILE="$LOG_FOLDER$0.log"
SCRIPT_DIR=$PWD

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

# copy the repo file rabbitmq.repo to etc/yum.repos.d/rabbitmq.repo
cp $SCRIPT_DIR/rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo
# call function to check if repo was copied successfully or not
validate_command_execution $? "Copying rabbitmq.repo file"

# check if rabbitmq is installed or not, if not then install rabbitmq package
dnf list installed rabbitmq &>> $LOG_FILE
if [ $? -ne 0 ]; then
    echo -e "$Y rabbitmq is not installed. Installing rabbitmq package... $N" | tee -a $LOG_FILE
    dnf install rabbitmq -y &>> $LOG_FILE
    validate_command_execution $? "Installing rabbitmq package"
else
    echo -e "$Y rabbitmq is already installed. Skipping installation. $N" | tee -a $LOG_FILE
fi

# enable and start the rabbitmq service
systemctl enable rabbitmq &>> $LOG_FILE
systemctl start rabbitmq &>> $LOG_FILE
validate_command_execution $? "Starting rabbitmq service"

## create a user for roboshop application in rabbitmq

### Get password for roboshop user from user input
read -s -p "Enter password for roboshop user in rabbitmq: " RABBITMQ_PASSWORD
rabbitmqctl add_user roboshop $RABBITMQ_PASSWORD
validate_command_execution $? "Creating roboshop user in rabbitmq"

rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
validate_command_execution $? "Setting permissions for roboshop user in rabbitmq"
