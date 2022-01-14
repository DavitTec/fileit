#!/bin/bash

###################################################
## REFERENCES
#
#
###################################################
# Bash Shell script to execute psql connect command
###################################################
set -e
set -u

version=0.04

#Set the value of variable
dbname="testdirlist"
host="localhost"
port="5432"

d=$(date +%Y-%m-%d)
t="$(date +"%T")"
timestamp="$d $t"


#Process Directorylist
echo "Creating input file"

./fix_directorylist.sh

echo " ..input file created"
#exit 0

#Execute few psql commands:


#env -i bash --norc   # clean up environment
set +o history

read -sp 'Enter Database password: ' PASS; echo

# DO NOT EXPORT PASS to environment
#printf '%s\n' "$PASS"

# Set these environmental variables to override them,
# but they have safe defaults.
export PGHOST=${PGHOST-localhost}
# ToDo PORT may not be the default port assigned 5432
#export PGDATABASE=${PGDATABASE-"$dbname"}
export PGPORT=${PGPORT-$port}
export PGUSER=${PGUSER-$USER}
export PGPASSWORD=${PGPASSWORD-"$PASS"}


#Note: you can also add -h hostname -U username in the below commands.

echo "psql -c createdb $dbname"
echo "CONNECTING to $PGUSER at $PGHOST:$PGPORT"

# below id passing Password
psql -U $PGUSER password=$PASS -f "../schema/private/src/db/$dbname.sql"

echo "database $dbname created"
# below is using Environament variables
#psql -X -f "./sql/Create_Db_filemedb.sql"

export PGDATABASE=${PGDATABASE-$dbname}
# Create table
psql -d $dbname -f "../schema/private/src/db/tbl/tbl_filelist.sql";
# Insert data
psql -d $dbname -f "../schema/private/src/db/tbl/insert_tbl_filelist.sql";


# Read
echo "List Big files (over 100kb)"
psql -d $dbname -c "SELECT t.file, t.ext, t.size, t.path
                    FROM public.tbl_filelist_temp t
                    WHERE size > 100000
                    ORDER BY size DESC";

TableCount=$(psql -d $dbname -t -c "SELECT COUNT(1) FROM tbl_filelist_temp");

#Print the value of variable
echo "Total table records count....:"$TableCount;

########################  Clear Environment  ########################
#
unset PASS  #drop password
unset PGPASSWORD
unset PGDATABASE
