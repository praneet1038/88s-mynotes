#!/bin/bash

# This script will setup user component for roboshop application. It will install nodejs 20 package, download and extract the application files and configure redis/mongodb for the user service.


source ./common.sh
app_name=user
app_dir=/app/

mkdir -p $LOG_FOLDER

check_root
remove_app_dir_content
download_application
extract_app_to_dir
install_nodejs_package
install_dependencies_js
create_app_user

### setup systemctl user service

cp $SCRIPT_DIR/user.service /etc/systemd/system/user.service
validate_command_execution $? "Copying user systemd service file"  

### start and enable the user service
reload_service 
enable_start_service user
get_total_time

# output service status
check_service_status user

