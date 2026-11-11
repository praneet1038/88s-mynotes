#!/bin/bash
# echo all commands before exec
set -x 
set -e
mkdir source
cd source
sudo git clone https://github.com/praneet1038/88s-mynotes
cd 88s-mynotes/ansible-roboshop
sudo git switch ansible-roboshop

sudo dnf install ansible -y
# prereq python libraries to run ansible 
pip install botocore boto3

# if aws hasn't been configured 


# make aws scripts shell commands
cd ../aws_scripts
for f in *; do 
    echo "$f"
    cp $f "/usr/bin/${f%.*}"
    chmod +x "/usr/bin/${f%.*}"
done


