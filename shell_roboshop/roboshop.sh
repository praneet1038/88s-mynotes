#!/bin/bash

SG_ID="sg-00e273e797ad748e9"
AMI_ID="ami-0220d79f3f480ecf5" # Redhat-9-DevOps-practice (joinDevOps AMI)



for instance in $@
do     
  echo "Creating instance $instance"
  instance_id=$(aws ec2 run-instances \
  --image-id $AMI_ID \
  --instance-type t3.micro \
  --security-group-ids $SG_ID \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" \
  --query 'Instances[0].InstanceId' \
  --output text); 
  echo "$instance_id"

  if [ "$instance_id" == "frontend" ]
  then
    IP=$(aws ec2 describe-instances --instance-ids $instance_id --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)
  else
    IP=$(aws ec2 describe-instances --instance-ids $instance_id --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text)

    echo "Instance created successfully for $instance with ID: $instance_id IP: $IP"
  fi


done


