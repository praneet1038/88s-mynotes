#!/bin/bash

# This script will install mongodb database for roboshop applicatin. It will install mongodb package, configure the mongodb service.

source ./common.sh
app_name = mongodb

# check root user
# add user

# app setup (download, extract, install dependencies )
# create systemcd service
# enable, start service
# delete app content


check_root
create_app_user
app_setup

# copy the repo file mongo.repo to etc/yum.repos.d/mongo.repo
cp $SCRIPT_DIR/mongo.repo /etc/yum.repos.d/mongo.repo
# call function to check if previous process was successful or not
validate_command_execution $? "Copying mongo.repo file"

# install mongdb package
dnf install mongodb-org -y &>>$LOG_FILE
validate_command_execution $? "Installing mongodb package"

enable_start_service mongod

# start the mongodb service
systemctl start mongod 
validate_command_execution $? "Starting mongodb service"

# enable the mongodb service to start on boot
systemctl enable mongod
validate_command_execution $? "Enabling mongodb service"

# update listen address from 127.0.0.1 to 0.0.0.0 permanently in mongodb config file
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
validate_command_execution $? "Updating mongodb configuration file"


# restart the mongodb service
systemctl restart mongod
validate_command_execution $? "Restarting mongodb service"

