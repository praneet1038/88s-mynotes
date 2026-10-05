#!/bin/bash

# This script will setup shipping component for roboshop application. It will install java.

# This script will set color of text in the terminal using ANSI escape codes. 
R="\e[31m" # Red
G="\e[32m" # Green
Y="\e[33m" # Yellow
N="\e[0m" # Reset to default color

LOG_FOLDER="/var/log/shell_roboshop/"
LOG_FILE="$LOG_FOLDER$0.log"
MYSQL_HOST=mysql.jirawiser.online
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

# check if maven is installed or not, if not then install maven package
dnf list installed maven &>> $LOG_FILE
if [ $? -ne 0 ]; then
    echo -e "$Y maven is not installed. Installing maven package... $N" | tee -a $LOG_FILE
    dnf install maven -y &>> $LOG_FILE
    validate_command_execution $? "Installing maven package"
else
    echo -e "$Y maven is already installed. Skipping installation. $N" | tee -a $LOG_FILE
fi

# check if user roboshop exists or not, if not then create the user
id roboshop &>> $LOG_FILE
if [ $? -ne 0 ]; then
    echo -e "$Y user roboshop does not exist. Creating user roboshop... $N" | tee -a $LOG_FILE
    useradd roboshop &>> $LOG_FILE
    validate_command_execution $? "Creating user roboshop"
else
    echo -e "$Y user roboshop already exists. Skipping user creation. $N"
fi

# check if the application directory exists or not, if not then create it
mkdir -p /app &>> $LOG_FILE

# download and extract the shipping application code to /app directory
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping-v3.zip 
cd /app
unzip /tmp/shipping.zip &>> $LOG_FILE
validate_command_execution $? "Downloading and extracting shipping application code to /app directory"

# build the shipping application using maven
cd /app 
mvn clean package 
mv target/shipping-1.0.jar shipping.jar 

# copy the shipping systemd service file to /etc/systemd/system/shipping.service
cp $SCRIPT_DIR/shipping.service /etc/systemd/system/shipping.service

# reload the systemd daemon to recognize the new service file
systemctl daemon-reload

# enable and start the shipping service
systemctl enable shipping &>> $LOG_FILE
systemctl start shipping &>> $LOG_FILE
validate_command_execution $? "Starting shipping service"

# Load the shipping schema to mysql-server
# install mysql-client package if not installed
dnf list installed mysql &>> $LOG_FILE
if [ $? -ne 0 ]; then
    echo -e "$Y mysql-client is not installed. Installing mysql-client package... $N" | tee -a $LOG_FILE
    dnf install mysql -y &>> $LOG_FILE
    validate_command_execution $? "Installing mysql-client package"
else
    echo -e "$Y mysql-client is already installed. Skipping installation. $N" | tee -a $LOG_FILE
fi

# Load the shipping schema to mysql-server 
## get mysql root password from user
read -s -p "Enter mysql root password: " MYSQL_ROOT_PASSWORD

## Load the shipping schema to mysql-server
mysql -h $MYSQL_HOST -uroot -p$MYSQL_ROOT_PASSWORD < /app/db/schema.sql
validate_command_execution $? "Loading shipping schema to mysql-server"

## Create app user for shipping app to connect to mysql-server
mysql -h $MYSQL_HOST -uroot -p$MYSQL_ROOT_PASSWORD < /app/db/app-user.sql
validate_command_execution $? "Creating app user for shipping app to connec to mysql-server" 

## Load the shipping data to mysql-server
mysql -h $MYSQL_HOST -uroot -p$MYSQL_ROOT_PASSWORD < /app/db/data.sql
validate_command_execution $? "Loading shipping data to mysql-server"

## Restart the shipping service to apply changes
systemctl restart shipping &>> $LOG_FILE
validate_command_execution $? "Restarting shipping service"