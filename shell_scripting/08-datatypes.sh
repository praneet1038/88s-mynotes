#!bin/bash

NUM1=10
NUM2=20
echo "NUM1 is $NUM1 and NUM2 is $NUM2"
SUM=$((NUM1 + NUM2))
echo "SUM is $SUM"

#Array
FRUITS=("Apple" "Banana" "Cherry")
echo "First fruit is ${FRUITS[0]}"
echo "All fruits are ${FRUITS[@]}"  
echo "Second fruit is ${FRUITS[1]}"
echo "Third fruit is ${FRUITS[2]}"