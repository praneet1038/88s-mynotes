#!/bin/bash
# This script will print if the given number is greater than or equal to 20 or not.
NUMBER=$1
if [ -z "$NUMBER" ]; then
    echo "Please provide a number as an argument."
    exit 1
elif [ $NUMBER -gt 20 ]; then
    echo "The number $NUMBER is greater than 20."
elif [ $NUMBER -eq 20 ]; then
    echo "The number $NUMBER is equal to 20."
else
    echo "The number $NUMBER is less than 20."
fi