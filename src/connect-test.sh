#!/bin/bash

###################################################
## REFERENCES
# VERSION 0.0.1
# a connect test and setup FileIT database
#
###################################################
# First Bash Shell script to execute psql command
###################################################
set -e
set -u

version=0.03

#Set the value of variable
dbname="test30e9dm3db"

host="localhost"

d=$(date +%Y-%m-%d)
t="$(date +"%T")"
timestamp="$d $t"

#ToDo..
