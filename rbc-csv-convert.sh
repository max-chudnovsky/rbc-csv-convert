#!/bin/bash
# written by Max.Chudnovsky

# script to correct CSV file you get from RBC banking
# simply run it with csv file as parameter and it will 
# convert dates format to (MM/DD/YY format) and sort it

[ ! -r "$1" ] && {
    echo "$0: Error. Missing input file."
    echo "  usage: $0 <file>"
    exit
}

awk -F',' '{
    split($3, d, "/");
    printf "%s,%s,%04d-%02d-%02d,%s,%s,%s,%s,%s,%s\n", $1, $2, d[3], d[1], d[2], $4, $5, $6, $7, $8, $9
}' $1 | sort -t',' -k3 | awk -F',' '{
    split($3, d, "-");
    printf "%s,%s,%s/%s/%s,%s,%s,%s,%s,%s,%s\n", $1, $2, d[2], d[3], d[1], $4, $5, $6, $7, $8, $9
}'
