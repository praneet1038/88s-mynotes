#!/bin/bash

# This script will install Nginx on a Linux system 

USER=$(id -u)

if [ $USER -ne 0]; then
    echo "This script must be run as root. Please run with sudo or as root user."
    exit 1
fi

echo "Installing Nginx..."
dnf install nginx -y

if [ $? -eq 0]; then
    echo "Nginx installed sucessfully."
    exit 0
else
    echo "Installation failed."
fi