#!/bin/bash

# This script will install mysql database for roboshop applicatin. It will install mysql, configure the mysql service.

source ./common.sh
app_name=mysql

# check root user
# add user

check_root

install_package mysql-server
enable_start_service mysqld

# set root password for mysql-server
echo -e "Setting root password for mysql-server..."
read -s -p "Enter new root password: " MYSQL_ROOT_PASSWORD
mysql_secure_installation --set-root-pass $MYSQL_ROOT_PASSWORD
validate_command_execution $? "Setting root password for mysql-server"
