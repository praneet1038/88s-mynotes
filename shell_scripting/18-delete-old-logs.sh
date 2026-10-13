#!/bin/bash

# This script is to delete log files generated for past 14 days

# pseudo code
# if logdirectory exists
# delete all files older than 14 days
LOG_DIR=/logdir

if [ ! -d $LOG_DIR ]; then
    echo "$LOG_DIR doesnot exist"
else
    files_to_delete = find $LOG_DIR -type f -name '*.log' -mtime +14
    echo $files_to_delete
    echo "While counter : "
    while [ $counter -le 5 ]
    do
        echo $counter
        counter=$((counter + 1)) 
    done
fi


