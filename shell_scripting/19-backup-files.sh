#!/bin/bash

# This script is to create a command that backs up files older than 14 days. Takes 2 mandatory args - source, target directories, 1 optional arg - timespan 

# define color codes and log folderfor output messages
R="\e[31m" # Red
G="\e[32m" # Green
Y="\e[33m" # Yellow
N="\e[0m" # Reset to default color

# get source, target, days
source=$1
target=$2
DAYS=${3:-14} # set default value 14
# find files older than days to delete
# if files zip is successful then delete files from source
 
echo "$source;$target;$DAYS"
timestamp=$(date +%F-%H-%M-%S)


get_files_to_delete(){  
    # find files older than file_timestamp days
    FILES_TO_DELETE=$(find $source -type f -name '*.log' -mtime +14)
    if [ -z "$FILES_TO_DELETE" ]; then
        # if no files found echo no files to delete and exit 1
        echo "No files to delete."
        exit 1
    else 
        # otherwise zip the files found 
        echo "Found - $FILES_TO_DELETE"

    fi

}

# echo $(find $source -type f -name '*.log' -mtime +14)
get_files_to_delete
if [ $? -eq1 ]; then
    echo "Exiting..."
    exit 1
fi
echo "$timestamp"
filename="$source-$timestamp.tar"
echo "$filename"
tar -cf $filename $(find $source -type f -name '*.log' -mtime +14)

