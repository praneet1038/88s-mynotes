#!/bin/bash

# This script will setup payment module for roboshop application. It will install python.

# This script will set color of text in the terminal using ANSI escape codes. 
R="\e[31m" # Red
G="\e[32m" # Green
Y="\e[33m" # Yellow
N="\e[0m" # Reset to default color

LOG_FOLDER="/var/log/shell_roboshop/"
LOG_FILE="$LOG_FOLDER$0.log"
RABBITMQ_HOST=rabbitmq.jirawiser.online
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
        echo -e "$2 ....$G SUCCESS $N" | tee -a $LOG_FILE
    else
        echo -e "$2 ....$R FAILED $N" | tee -a $LOG_FILE
        exit 1
    fi
}

# install python3, gcc, and python3-devel packages
dnf install python3 gcc python3-devel -y &>> $LOG_FILE
validate_command_execution $? "Installing python3, gcc, and python3-devel packages"

# check if user roboshop exists or not, if not then create the user
id roboshop &>> $LOG_FILE
if [ $? -ne 0 ]; then
    echo -e "$Y user roboshop does not exist. Creating user roboshop... $N" | tee -a $LOG_FILE
    useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop &>> $LOG_FILE
    validate_command_execution $? "Creating user roboshop"
else
    echo -e "$Y user roboshop already exists. Skipping user creation. $N"
fi

# check if the application directory exists or not, if not then create it
mkdir -p /app &>> $LOG_FILE

# check if /app directory is empty or not, if not then delete the contents of the directory
cd /app
rm -rf /app/* &>> $LOG_FILE
validate_command_execution $? "Deleting content of /app directory"

# download and extract the shipping application code to /app directory
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment-v3.zip 
cd /app
unzip /tmp/payment.zip &>> $LOG_FILE
validate_command_execution $? "Downloading and extracting payment application code to /app directory"

# install the required python packages from requirements.txt file
cd /app
pip3 install -r requirements.txt &>> $LOG_FILE
validate_command_execution $? "Installing required python packages from requirements.txt file"

# copy the payment.service file to /etc/systemd/system/payment.service
cp $SCRIPT_DIR/payment.service /etc/systemd/system/payment.service
validate_command_execution $? "Copying payment systemd service file to /etc/systemd/system/payment service"

# setup the payment systemd service file
systemctl daemon-reload &>> $LOG_FILE
systemctl enable payment &>> $LOG_FILE
systemctl start payment &>> $LOG_FILE
validate_command_execution $? "Starting payment service"

