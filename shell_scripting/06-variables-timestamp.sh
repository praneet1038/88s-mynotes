#!/bin/bash
# This script will print the current date and time in a specific format
# It will also demonstrate the use of variables and command substitution
START_TIME=$(date +%s)
echo "Script started at: $(date)"
sleep 10
end_time = $(date +%s)
elapsed_time = $((end_time - start_time))
echo "Script ended at: $(date)"
echo "Elapsed time: $elapsed_time seconds"