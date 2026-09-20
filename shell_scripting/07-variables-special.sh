#!/bin/bash

echo "This script demonstrates the use of special variables in shell scripting."
echo "\$0 (script NAME): $0"
echo "\$@ (all ARGUMENTS as a LIST): $@"
echo "\$# (NUMBER of arguments): $#"
echo "\$\$ (process ID): $$"
echo "\$PWD (current working DIRECTORY): $PWD"
echo "\$USER (current user): $USER"
echo "if \$USER is prints empty value, then use \$(whoami)  to get the current user. : $(whoami)"

sleep 100 &
echo "\$! (process ID of last BACKGROUND command): $!"

echo "\$HOME (home DIRECTORY of $USER): $HOME"
echo "\$* (all ARGUMENTS as a SINGLE STRING): $*"