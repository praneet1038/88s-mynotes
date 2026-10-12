#!\bin\bash

# This script will setup frontend component for roboshop application. It will install required packages, download and extract the application code , and configure the systemd service for the frontend component.

source ./common.sh
app_name=frontend
app_dir=/usr/share/nginx/html/

mkdir -p $LOG_FOLDER

check_root

remove_app_dir_content
download_application
extract_app_to_dir
disable_package nginx
install_package_module nginx:1.24

# copy the roboshop_nginx.conf file to /etc/nginx/nginx.conf
cp $SCRIPT_DIR/roboshop_nginx.conf /etc/nginx/nginx.conf &>>$LOG_FILE
validate_command_execution $? "Copying roboshop_nginx.conf file"  
restart_service nginx



