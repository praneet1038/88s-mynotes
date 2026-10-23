#!/bin/bash

# Run this script on an ec2 instance to get the local private ip
get_local_ipv4()
{curl http://169.254.169.254/latest/meta-data/local-ipv4
}
get_all_metadata(){
    curl http://169.254.169.254/latest/meta-data
}