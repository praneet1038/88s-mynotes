#!/bin/bash
# echo all commands before exec
set -x 
set -e

source ./aws-setup.sh

mkdir source
cd source
sudo git clone https://github.com/praneet1038/88s-mynotes
cd 88s-mynotes/ansible-roboshop
sudo git switch ansible-roboshop

sudo dnf install ansible -y
# prereq python libraries to run ansible 
pip install botocore boto3

install_awscli
set_aws_commands




