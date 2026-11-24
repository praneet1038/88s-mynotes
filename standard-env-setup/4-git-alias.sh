#!/bin/bash

alias g=git

alias ga='git add'

alias gp='git push'

alias gpd='git push -n'

alias gaun='git add -u -n'

alias gucom='git commit -u -m '

# dry run

git add -u -n 
git status -short
git push -n 
git reset -soft HEAD # uncommit last change
git push --set-upstream origin  new-branch # set upstream branch and push changes
