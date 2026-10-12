#!/bin/bash

# This script will setup payment module for roboshop application. It will install python.


source ./common.sh
app_name=payment

mkdir -p $LOG_FOLDER
check_root

remove_app_content
download_application
extract_application
create_app_user


# install python3, gcc, and python3-devel packages
dnf install python3 gcc python3-devel -y &>> $LOG_FILE
validate_command_execution $? "Installing python3, gcc, and python3-devel packages"

# check if the application directory exists or not, if not then create it
mkdir -p /app &>> $LOG_FILE

# install the required python packages from requirements.txt file
cd /app
pip3 install -r requirements.txt &>> $LOG_FILE
validate_command_execution $? "Installing required python packages from requirements.txt file"

# copy the payment.service file to /etc/systemd/system/payment.service
cp $SCRIPT_DIR/payment.service /etc/systemd/system/payment.service
validate_command_execution $? "Copying payment systemd service file to /etc/systemd/system/payment service"

reload_service
enable_start_service payment
get_total_time

# output service status
check_service_status
