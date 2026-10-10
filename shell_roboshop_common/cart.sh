#!/bin/bash

# This script will setup cart component for roboshop application. It will install nodejs 20 package, download and extract the application files and configure redis/mongodb for the cart service.


source ./common.sh
app_name=cart

mkdir -p $LOG_FOLDER

check_root
remove_app_content
download_application
extract_application
install_nodejs_package
install_dependencies_js
create_app_user

### setup systemctl cart service

cp $SCRIPT_DIR/cart.service /etc/systemd/system/cart.service
validate_command_execution $? "Copying cart systemd service file"  

### start and enable the cart service
reload_service 
enable_start_service cart
get_total_time
