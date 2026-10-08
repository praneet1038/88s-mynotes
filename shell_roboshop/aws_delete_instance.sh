#!/bin/bash

# This script will stop an instance based on name tag passed as an argument

# safely check which instance will be deleted

read "Enter instance name to delete: " INSTANCE_TO_DEL

aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=$INSTANCE_TO_DEL" \
  --query 'Reservations[].Instances[].{ID:InstanceId,State:State.Name,Name:Tags[?Key==`Name`]|[0].Value}' \
  --output table

# Test the command - dry run

aws ec2 terminate-instances \
  --instance-ids $(aws ec2 describe-instances \
    --filters \
      "Name=tag:Name,Values=$INSTANCE_TO_DEL" \
      "Name=instance-state-name,Values=pending,running,stopping,stopped" \
    --query 'Reservations[].Instances[].InstanceId' \
    --output text) \
  -- dry-run

# Get confirmation from user 

confirm() {
    read -r -p "$1 (y/n): " answer
    [[ "$answer" == "yes" ]]
}

if confirm "Terminate the instance"; then
    aws ec2 terminate-instances \
        --instance-ids $(aws ec2 describe-instances \
        --filters \
        "Name=tag:Name,Values=$INSTANCE_TO_DEL" \
        "Name=instance-state-name,Values=pending,running,stopping,stopped" \
        --query 'Reservations[].Instances[].InstanceId' \
        --output text)
else
    echo "Operation cancelled."
fi


# Delete the instance



