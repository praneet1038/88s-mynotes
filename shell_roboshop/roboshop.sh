#!/bin/bash

SG_ID="sg-00e273e797ad748e9"
AMI_ID="ami-0220d79f3f480ecf5" # Redhat-9-DevOps-practice (joinDevOps AMI)
HOSTED_ZONE_ID="Z10383363R1G3CD5ON5XC" # jirawiser.online
DOMAIN_NAME="jirawiser.online"


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
    RECORD_NAME=DOMAIN_NAME
  else
    IP=$(aws ec2 describe-instances --instance-ids $instance_id --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text)
    RECORD_NAME=$instance.$DOMAIN_NAME
    echo "Instance created successfully for $instance with ID: $instance_id IP: $IP"
  fi

  aws route53 change-resource-record-sets \
  --hosted-zone-id $HOSTED_ZONE_ID \
  --change-batch '{
    "Changes": [
      {
        "Action": "UPSERT",
        "ResourceRecordSet": {
          "Name": "'$RECORD_NAME'",
          "Type": "A",
          "TTL": 1,
          "ResourceRecords": [
            {
              "Value": "'$IP'"
            }
          ]
        }
      }
    ]
  }' \
  --no-cli-pager

 echo "DNS record created successfully for $instance with IP: $IP"

done


