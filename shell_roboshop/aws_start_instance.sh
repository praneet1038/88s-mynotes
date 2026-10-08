#!/bin/bash

# This script will stop an instance based on name tag passed as an argument

# safely check which instance will be deleted

read -r -p "Enter instance name to start: " INSTANCE_TO_START

aws ec2 start-instances \
  --filters "Name=tag:Name,Values=$INSTANCE_TO_START" \
  --query 'Reservations[].Instances[].{ID:InstanceId,State:State.Name,Name:Tags[?Key==`Name`]|[0].Value}' \
  --output table

# Test the command - dry run

aws ec2 start-instances \
  --instance-ids $(aws ec2 describe-instances \
    --filters \
      "Name=tag:Name,Values=$INSTANCE_TO_START" \
      "Name=instance-state-name,Values=pending,running,stopping,stopped" \
    --query 'Reservations[].Instances[].InstanceId' \
    --output text) \
  --dry-run

# Get confirmation to start instance 

confirm() {
    read -r -p "$1 (yes/no): " answer
    [[ "$answer" == "y" ]]
}

if confirm "start the instance"; then
    aws ec2 start-instances \
        --instance-ids $(aws ec2 describe-instances \
        --filters \
        "Name=tag:Name,Values=$INSTANCE_TO_START" \
        "Name=instance-state-name,Values=pending,running,stopping,stopped" \
        --query 'Reservations[].Instances[].InstanceId' \
        --output text)
else
    echo "Start operation cancelled."
fi





