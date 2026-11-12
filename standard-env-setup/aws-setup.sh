#!/bin/bash

# if aws hasn't been configured 

# install aws cli
# To install the AWS CLI, run the following command.

validate_awscli_installation() {
    aws --version
    if [ $? -eq 0 ]; then
        echo -e "$(date +%c) $2 .... installed" 
    else
        echo -e "$(date +%c) $2 .... not installed" 
        curl -fsSL https://awscli.amazonaws.com/v2/install.sh | bash
    fi
}

install_awscli()
{
    validate_awscli_installation "awscli"
}

set_aws_commands(){
  # make aws scripts shell commands
    cd ../aws_scripts
    for f in *; do 
        echo "$f"
        cp $f "/usr/bin/${f%.*}"
        chmod +x "/usr/bin/${f%.*}"
    done  
}

install_awscli
set_aws_commands

aws configure

# describe all aws ec2 instances to confirm
# aws-ec2-desall 