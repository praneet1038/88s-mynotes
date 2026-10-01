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
MONGO_HOST=$MONGODB.jirawiser.online


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

enable_nodejs_repo() {
    # disable the default nodejs module to install nodejs 20 package
    dnf module disable nodejs -y &>> $LOG_FILE
    validate_command_execution $? "Disabling default nodejs module"

    # enable and install nodejs 20 package

    dnf module enable nodejs:20 -y &>> $LOG_FILE
    validate_command_execution $? "Enabling nodejs 20 module"

    dnf install nodejs -y  &>> $LOG_FILE
    validate_command_execution $? "Installing nodejs package"
}

# check if nodejsis installed or not, if not then install nodejs 20 package
dnf list installed nodejs &>> $LOG_FILE
if [ $? -ne 0 ]; then
    echo -e "$Y nodejs is not installed. Installing nodejs 20 package... $N" | tee -a $LOG_FILE
    enable_nodejs_repo $? "Installing nodejs 20 package"
else
    echo -e "$Y nodejs is already installed. Skipping installation. $N"
fi

### check if user roboshop exists or not, if not then create the user
id roboshop &>> $LOG_FILE

### add application user
if [ $? -ne 0 ]; then
    useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
    validate_command_execution $? "Adding application user"
else
    echo -e "$Y roboshop user already exists. Skipping user creation. $N" | tee -a $LOG_FILE
fi

### download and extract the application code
curl -s -L -o /tmp/catalogue.zip "https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip"
validate_command_execution $? "Downloading catalogue application code"

# delete the existing application code if any
rm -rf /app/* &>> $LOG_FILE
validate_command_execution $? "Deleting existing application code"

unzip -o /tmp/catalogue.zip -d /app
validate_command_execution $? "Extracting catalogue application code"

### install dependencies
cd /app
validate_command_execution $? "Changing directory to /app"
npm install &>> $LOG_FILE
validate_command_execution $? "Installing catalogue application dependencies"

### setup systemctl catalogue service

cp $SCRIPT_DIR/catalogue.service /etc/systemd/system/catalogue.service
validate_command_execution $? "Copying catalogue systemd service file"  

### start and enable the catalogue service
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue
validate_command_execution $? "Starting catalogue service"

### install mongo shell client to connect to mongodb server
cp $SCRIPT_DIR/mongo.repo /etc/yum.repos.d/mongo.repo
validate_command_execution $? "Copying mongo.repo file"

dnf install mongodb-mongosh -y &>> $LOG_FILE
validate_command_execution $? "Installing mongodb shell client"

### load the catalogue schema to mongodb server

### check if database(catalogue) is already created or not, if not then load the schema to mongodb server
mongosh --host $MONGO_HOST --eval "show dbs" | grep catalogue &>> $LOG_FILE
if [ $? -ne 0 ]; then
    echo -e "$Y catalogue database does not exist. Loading schema to mongodb server... $N" | tee -a $LOG_FILE
    mongosh --host $MONGO_HOST </app/schema/catalogue.js &>> $LOG_FILE
    validate_command_execution $? "Loading catalogue schema to mongodb server"
else
    echo -e "$Y catalogue database already exists. Skipping schema loading. $N" | tee -a $LOG_FILE
    exit 0
fi