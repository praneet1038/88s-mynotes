#!/bin/bash

echo "This script demonstrates the use of special variables in shell scripting."
echo "\$0: $0 (script NAME)"
echo "\$@: $@ (all ARGUMENTS as a LIST)"
echo "\$#: $# (NUMBER of arguments)"
echo "\$\$: $$ (process ID)"
echo "\$PWD: $PWD (current working DIRECTORY)"
echo "\$USER: $USER (current user)"
echo "if \$USER is unset (prints empty value), then use this instead \$(whoami)  to get the current user. : $(whoami)"

sleep 100 &
echo "\$!: $! (process ID of last BACKGROUND command)"

echo "\$HOME: $HOME (home DIRECTORY of $USER)"
echo "\$*: $* (all ARGUMENTS as a SINGLE STRING)"