#!/bin/bash

read -r -p "Enter instance name to terminate: " INSTANCE_TO_TERMINATE



# dry run termination

aws ec2 terminate-instances \
  --instance-ids $(aws ec2 describe-instances \
    --filters Name=tag:Name,Values=$INSTANCE_TO_TERMINATE \
    --query 'Reservations[].Instances[].InstanceId' \
    --output text) \
  --dry-run


# Get confirmation to start instance 

confirm() {
    read -r -p "$1 (yes/no): " answer
    [[ "$answer" == "yes" ]]
}

if confirm "Terminates the instance"; then
  aws ec2 terminate-instances \
    --instance-ids $(aws ec2 describe-instances \
    --filters Name=tag:Name,Values=$INSTANCE_TO_TERMINATE \
    --query 'Reservations[].Instances[].InstanceId' \
    --output text)
else
    echo "Terminate operation cancelled."
fi