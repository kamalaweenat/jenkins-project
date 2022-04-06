#!/usr/bin/bash

if [ $# != 2 ]; then
    echo "Enter only two arguments.." >&2 
    exit 1  
fi

# Check if arguments are digits
re='^[0-9]+$'
if ! [[ "$1" =~ $re ]] || ! [[ "$2" =~ $re ]] ; then
   echo "Please enter only integer numbers.." >&2; exit 2
fi

SUM=$(("$1" + "$2"))
echo "$SUM"
