#!/bin/bash

# This script will uninstall all the components of roboshop application including mongodb, catalogue, user, cart, shipping, payment, frontend and redis. 

components=("mongodb" "catalogue" "user" "cart" "shipping" "payment" "frontend" "redis")

for component in "${components[@]}"; do
    echo "Uninstalling $component..."
    systemctl stop $component &>> /var/log/shell_roboshop/uninstall.log
    systemctl disable $component &>> /var/log/shell_roboshop/uninstall.log
    dnf remove -y $component &>> /var/log/shell_roboshop/uninstall.log
    echo "$component uninstalled successfully."
done

echo "All components uninstalled successfully."