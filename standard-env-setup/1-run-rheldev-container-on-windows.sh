#!/bin/bash

# start docker desktop
docker desktop start

# docker desktop status
docker desktop status

# start rhel-dev container
docker start rhel-dev

# docker ps

# bash rhel-dev 
docker exec -it rhel-dev bash

# run these commands from rhel-dev bash
# list all running instances
aws-ec2-desall
# create a new instance to install ansible
aws-ec2-run ansible


