#!/bin/bash
# This script will use for loop to print numbers from 1 to 10
for i in {1..10}
do
    echo "Number: $i"
done        

LOG_FOLDER="/var/log/shell_scripting/"
LOG_FILE="$LOG_FOLDER$0.log"

USER=$(id -u)
if [ $USER -ne 0 ]; then
    echo "This script must be run as root. Please run with sudo or as root user." | tee -a $LOG_FILE
    exit 1
fi

mkdir -p $LOG_FOLDER

check_installation() {
    if [ $1 -eq 0 ]; then
        echo "$2 ....SUCCESS" | tee -a $LOG_FILE
    else
        echo "$2 ....FAILED" | tee -a $LOG_FILE
        exit 1
    fi
}

for package in $@
do
    dnf install $package -y &>> $LOG_FILE
    check_installation $? "$package installation"
done    

echo "All installations completed successfully." | tee -a $LOG_FILE