#!/bin/bash
# echo all commands before exec
# https://raw.githubusercontent.com/praneet1038/88s-mynotes/refs/heads/ansible-roboshop/standard-env-setup/initial-setup.sh
set -x 
set -e


mkdir -pv source # parents, verbose
cd source
sudo git clone https://github.com/praneet1038/88s-mynotes
cd 88s-mynotes/ansible-roboshop
sudo git switch ansible-roboshop

sudo dnf install ansible -y
# prereq python libraries to run ansible 
pip install botocore boto3






