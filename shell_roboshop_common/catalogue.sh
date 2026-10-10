#!/bin/bash

# This script will setup catalgoue component for roboshop application. It will install required packages, download and extract the application code, and configure the systemd service for the catalogue component.

# check root user
# app setup (download, extract, install dependencies )
# create systemcd service
# enable, start service
# delete app content

source ./common.sh
app_name=catalogue

MONGO_HOST=mongodb.jirawiser.online

mkdir -p $LOG_FOLDER

check_root
remove_app_content
download_application
extract_application
install_nodejs_package
install_dependencies_js
create_app_user



### setup systemctl catalogue service

cp $SCRIPT_DIR/catalogue.service /etc/systemd/system/catalogue.service
validate_command_execution $? "Copying catalogue systemd service file"  

### start and enable the catalogue service
reload_service
enable_start_service


### install mongo shell client to connect to mongodb server
cp $SCRIPT_DIR/mongo.repo /etc/yum.repos.d/mongo.repo
validate_command_execution $? "Copying mongo.repo file"

install_package mongodb-mongosh



### load the catalogue schema to mongodb server

### check if database(catalogue) is already created or not, if not then load the schema to mongodb server
mongosh --host $MONGO_HOST --eval "show dbs" | grep catalogue &>> $LOG_FILE
if [ $? -ne 0 ]; then
    echo -e "$Y catalogue database does not exist. Loading schema to mongodb server... $N" | tee -a $LOG_FILE
    mongosh --host $MONGO_HOST </app/db/master-data.js &>> $LOG_FILE
    validate_command_execution $? "Loading catalogue schema to mongodb server"
else
    echo -e "$Y catalogue database already exists. Skipping schema loading. $N" | tee -a $LOG_FILE
    exit 0
fi