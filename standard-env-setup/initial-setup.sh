#!/bin/bash
# https://raw.githubusercontent.com/praneet1038/88s-mynotes/refs/heads/ansible-roboshop/standard-env-setup/initial-setup.sh
# download the file 
# curl -L -o setup.sh https://raw.githubusercontent.com/praneet1038/88s-mynotes/refs/heads/ansible-roboshop/standard-env-setup/initial-setup.sh
# run the script without downloading file 
# -f — fail on HTTP errors (such as 404) instead of passing the error page along.
# -s — run silently, suppressing the progress meter and error messages.
# -S — show an error message if -s is also used.
# -L — follow redirects. 
# curl -fsSL 'https://raw.githubusercontent.com/praneet1038/88s-mynotes/refs/heads/ansible-roboshop/standard-env-setup/initial-setup.sh' | bash

# clone repo, install ansible, botocore, boto3

# print all commands before exec

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
# aws configure






