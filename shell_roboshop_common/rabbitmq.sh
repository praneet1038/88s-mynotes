#!/bin/bash

# This script will install rabbitmq database for roboshop applicatin. It will install rabbitmq-server package, configure the rabbitmq service, and create a user for the roboshop application.

source ./common.sh
app_name=mongodb

# check root user
# add user

check_root
# copy the repo file rabbitmq.repo to etc/yum.repos.d/rabbitmq.repo
cp $SCRIPT_DIR/rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo
# call function to check if repo was copied successfully or not
validate_command_execution $? "Copying rabbitmq.repo file"

# check if rabbitmq is installed or not, if not then install rabbitmq package
dnf list installed rabbitmq-server &>> $LOG_FILE
if [ $? -ne 0 ]; then
    echo -e "$Y rabbitmq is not installed. Installing rabbitmq-server package... $N" | tee -a $LOG_FILE
    dnf install rabbitmq-server -y &>> $LOG_FILE
    validate_command_execution $? "Installing rabbitmq-server package"
else
    echo -e "$Y rabbitmq-server is already installed. Skipping installation. $N" | tee -a $LOG_FILE
fi


enable_start_service rabbitmq-server

### Get password for roboshop user from user input
read -s -p "Enter password for roboshop user in rabbitmq: " RABBITMQ_PASSWORD
rabbitmqctl add_user roboshop $RABBITMQ_PASSWORD
validate_command_execution $? "Creating roboshop user in rabbitmq"

rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
validate_command_execution $? "Setting permissions for roboshop user in rabbitmq"

get_total_time

# output service status
check_service_status
