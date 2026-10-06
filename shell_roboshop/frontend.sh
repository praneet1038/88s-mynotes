#!\bin\bash

# This script will setup frontend component for roboshop application. It will install required packages, download and extract the application code , and configure the systemd service for the frontend component.

# define color codes and log folderfor output messages
R="\e[31m" # Red
G="\e[32m" # Green
Y="\e[33m" # Yellow
N="\e[0m" # Reset to default color

LOG_FOLDER="/var/log/shell_scripting/"
LOG_FILE="$LOG_FOLDER$0.log"
SCRIPT_DIR=$PWD
FRONTEND_HOST=jirawiser.online


# check if the script is run as root user
USER=$(id -u)
if [ $USER -ne 0 ]; then
    echo -e "$R This script must be run as root. Please run with sudo or as root user. $N" | tee -a $LOG_FILE
    exit 1
fi

mkdir -p $LOG_FOLDER

validate_command_execution() {
    if [ $1 -eq 0 ]; then
        echo -e "$2 ....$G SUCCESS $N" | tee -a $LOG_FILE
    else
        echo -e " $2 ....$R FAILED $N" | tee -a $LOG_FILE
        exit 1
    fi
}

# disable the default nginx module to install nginx package
dnf module disable nginx -y &>> $LOG_FILE
validate_command_execution $? "Disabling default nginx module"

# enable and install nginx:1.24 version package
dnf module enable nginx:1.24 -y &>> $LOG_FILE
validate_command_execution $? "Enabling nginx:1.24 module"

# check if nginx is installed or not, if not then install nginx package
dnf install nginx -y &>> $LOG_FILE
validate_command_execution $? "Installing nginx package"

# enable and start the nginx service
systemctl enable nginx &>> $LOG_FILE
systemctl start nginx &>> $LOG_FILE

# remove default nginx content 
rm -rf /usr/share/nginx/html/* &>> $LOG_FILE
# download the frontend application
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip &>> $LOG_FILE
validate_command_execution $? "Downloading frontend application"

# extract the frontend application
unzip -o /tmp/frontend.zip -d /usr/share/nginx/html &>> $LOG_FILE
validate_command_execution $? "Extracting frontend application"

# copy the roboshop_nginx.conf file to /etc/nginx/nginx.conf
cp $SCRIPT_DIR/roboshop_nginx.conf /etc/nginx/nginx.conf &>>$LOG_FILE
validate_command_execution $? "Copying roboshop_nginx.conf file"  

# restart the nginx service to apply the changes
systemctl restart nginx &>> $LOG_FILE
validate_command_execution $? "Restarting nginx service"

# Configure the frontend application with the backend API endpoint





