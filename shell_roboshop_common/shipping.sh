#!/bin/bash

# This script will setup user component for roboshop application. It will install nodejs 20 package, download and extract the application files and configure redis/mongodb for the user service.


source ./common.sh
app_name=shipping

mkdir -p $LOG_FOLDER

check_root
remove_app_content
download_application
extract_application
install_package maven
isntall_maven_dependencies_build
create_app_user

# copy the shipping systemd service file to /etc/systemd/system/shipping.service
cp $SCRIPT_DIR/shipping.service /etc/systemd/system/shipping.service

# restart service
reload_service
enable_start_service

# Load the shipping schema to mysql-server
# install mysql-client package if not installed
install_package mysql

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
mysql -h $MYSQL_HOST -uroot -p$MYSQL_ROOT_PASSWORD < /app/db/master-data.sql
validate_command_execution $? "Loading shipping data to mysql-server"

## Restart the shipping service to apply changes
systemctl restart shipping &>> $LOG_FILE
validate_command_execution $? "Restarting shipping service"

