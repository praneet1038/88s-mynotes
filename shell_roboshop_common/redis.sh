#!/bin/bash

# This script will setup redis component for roboshop application. 

source ./common.sh

mkdir -p $LOG_FOLDER

check_root
install_package redis:7

# update listen address from 127.0.0.1 to 0.0.0.0 permanently in redis config file
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/redis/redis.conf
validate_command_execution $? "Updating port in redis configuration file"

# change protectedmode from yes to no in redis config file
sed -i 's/protected-mode yes/protected-mode no/g' /etc/redis/redis.conf
validate_command_execution $? "Updating protected mode in redis configuration file"

enable_start_service redis

get_total_time
