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