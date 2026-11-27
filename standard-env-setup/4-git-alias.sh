#!/bin/bash

# curl -fsSL 'https://raw.githubusercontent.com/praneet1038/88s-mynotes/refs/heads/ansible-roboshop/standard-env-setup/4-git-alias.sh' | bash

# print all commands before exec

set -x 
set -e

alias g=git

alias ga=git add

alias gaa=git add .

alias gp=git push

alias gpd=git push -n

alias gaun=git add -u -n

alias gacom=git commit -a -m 

# git status -short


# dry run

# git add -u -n 
# git status -short
# git push -n 
# git reset -soft HEAD # uncommit last change
# git push --set-upstream origin  new-branch # set upstream branch and push changes
