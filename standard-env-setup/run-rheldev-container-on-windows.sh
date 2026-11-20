#!/bin/bash

# start docker desktop
docker desktop start

# start rhel-dev container
docker start rhel-dev

# bash rhel-dev 
docker exec -it rhel-dev bash