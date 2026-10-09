#!/bin/bash

# This script will hold all the common functions required to deploy roboshop application components like mongodb, catalogue, redis, user, cart, mysql, shipping, payment, rabbitmq, dispatch

# define color codes and log folderfor output messages
R="\e[31m" # Red
G="\e[32m" # Green
Y="\e[33m" # Yellow
N="\e[0m" # Reset to default color

LOG_FOLDER="/var/log/shell_roboshop_common/"
LOG_FILE="$LOG_FOLDER$0.log"
SCRIPT_DIR=$PWD
START_TIME= $(date +%s)

mkdir -p $LOG_FOLDER

check_root(){
    USER=$(id -u)
    if [ $USER -ne 0 ]; then
        echo -e "$R This script must be run as root. Please run with sudo or as root user. $N" | tee -a $LOG_FILE
        exit 1
    fi
}

validate_command_execution() {
    if [ $1 -eq 0 ]; then
        echo -e "$(date +%c) $2 ....$G SUCCESS $N" | tee -a $LOG_FILE
    else
        echo -e "$(date +%c) $2 ....$R FAILED $N" | tee -a $LOG_FILE
        exit 1
    fi
}

disable_package(){
    dnf module disable $1
    validate_command_execution $? "Enabling $1 package"

}

enable_package_version(){
    dnf module enable $1 &>> $LOG_FILE
    validate_command_execution $? "Enabling $1 package"

}

install_package(){
    dnf install $1 -y &>> $LOG_FILE
    validate_command_execution $? "Installing $1 package"
}

install_nodejs_package(){
    disable_package $1
    enable_package_version $1
    validate_command_execution $? "Installing $1 package"

}

create_app_user(){
    if [ $? -ne 0 ]; then
        useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
        validate_command_execution $? "Adding application user"
    else
        echo -e "$Y roboshop user already exists. Skipping user creation. $N" | tee -a $LOG_FILE
    fi
}

download_application(){
    curl -s -L -o /tmp/$1.zip  https://roboshop-artifacts.s3.amazonaws.com/$1-v3.zip &>> $LOG_FILE
}

extract_application(){
    mkdir -p /app 
    cd /app
    unzip /tmp/$1.zip &>> $LOG_FILE
    validate_command_execution $? $2
}

reload_service(){
    systemctl daemon-reload &>> $LOG_FILE
}

app_setup(){
    create_app_user
    download_application $app_name
    extract_application $app_name
    install_package_version nodejs:20

}

enable_start_service(){
    systemctl enable $1 &>> $LOG_FILE
    systemctl start $1 &>> $LOG_FILE
    validate_command_execution $? "Starting $1 service"
}

