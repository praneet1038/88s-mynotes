#!/bin/bash

# This script is to delete log files generated for past 14 days

# define color codes and log folderfor output messages
R="\e[31m" # Red
G="\e[32m" # Green
Y="\e[33m" # Yellow
N="\e[0m" # Reset to default color

# pseudo code
# if logdirectory exists
# delete all files older than 14 days
LOG_DIR=/logdir

if [ ! -d $LOG_DIR ]; then
    echo "$LOG_DIR does not exist"
    exit 1
else
    FILES_TO_DEL=$(find $LOG_DIR -type f -name '*.log' -mtime +14)
    echo $FILES_TO_DEL
    echo "While counter : "
    counter=0
    while [ $counter -le 5 ]
    do
        echo $counter
        counter=$((counter + 1)) 
    done

    while IFS= read -r filepath; 
    do
        echo "Deleting $filepath"
        if [ $filepath ]; then
            rm $filepath
            echo "Deleted $filepath"
        fi
    done <<< $FILES_TO_DEL
fi


