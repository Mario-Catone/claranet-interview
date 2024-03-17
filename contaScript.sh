#!/bin/bash

echo "Programma: conta file in directory"

declare -A arr

dir=$1

if [[ $dir == "" ]]; then
    echo "Inserisci directory come primo argomento dello script es: ./contaScript.sh /home/user/"
    exit 1
fi
 
#Iterate on all files in the current dir
for f in "$dir"/*; do
    #Take action only on files (not folders etc)
    if [ -f "$f" ]; then
        #Get file first line
        firstLine=$(head -n 1 $f)
        #If first line contains #! proceed. Otherwise, it's not a script!
        if [[ $firstLine == "#!"* ]]; then
            ((arr["$firstLine"] += 1))
        fi

    fi
done

for item in "${!arr[@]}"; do
    echo " ${arr[$item]}: $item"
done
