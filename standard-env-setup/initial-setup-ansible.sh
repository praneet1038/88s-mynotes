#!/bin/bash

mkdir source
cd source
sudo git clone https://github.com/praneet1038/88s-mynotes
cd source/88s-mynotes/ansible-roboshop
sudo git switch ansible-roboshop

sudo dnf install ansible -y
# prereq python libraries to run ansible 
pip install botocore boto3

# if aws hasn't been configured 
aws configure 

# run ansible playbook to create mongodb, catalogue instances
ansible-playbook -i localhost, roboshop.yaml

# describe all aws ec2 instances to confirm
aws-ec2-desall 

# deploy mongodb
ansible-playbook -i inventory.ini mongodb.yaml

