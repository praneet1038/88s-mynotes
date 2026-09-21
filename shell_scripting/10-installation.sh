#!/bin/bash

# This script will install Nginx on a Linux system 

USER=$(id -u)

if [ $USER -ne 0]; then
    echo "This script must be run as root. Please run with sudo or as root user."
    exit 1
fi

echo "Installing Nginx..."
dnf install nginx -y

if [ $? -eq 0 ]; then
    echo "Nginx installed sucessfully."
    exit 0
else
    echo "Nginx installation failed."
fi

echo "Installing mySQL..."
dnf install mysql-server -y

if [ $? -eq 0 ]; then
    echo "MySQL installed sucessfully."
    exit 0
else
    echo "MySQL installation failed."
fi

echo "Installing nodejs..."
dnf install nodejs -y

if [ $? -eq 0 ]; then
    echo "Nodejs installed sucessfully."
    exit 0
else
    echo "Nodejs installation failed."
fi

