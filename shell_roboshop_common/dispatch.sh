#!/bin/bash

# This script will setup dispatch component for roboshop application. It will install golang package, download and extract the application files to listen for rabbitmq messages. 

source ./common.sh
app_name=dispatch

mkdir -p $LOG_FOLDER

check_root

remove_app_content
download_application
extract_application
install_package golang

# Install dependencies and build application
cd /app
go mod init dispatch  &>> $LOG_FILE
go get  &>> $LOG_FILE
go build  &>> $LOG_FILE
validate_command_execution $? "Building application"
create_app_user

# copy dispatch service file to etc

cp $SCRIPT_DIR/dispatch.service /etc/systemd/system/dispatch.service  &>> $LOG_FILE
validate_command_execution $? "Copying dispatch.service file"


reload_service
enable_start_service $app_name
validate_command_execution $? "Starting dispatch service"

get_total_time

# output service status
check_service_status

