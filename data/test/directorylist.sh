#! /usr/bin/env bash
# HEADER fileit test Directory list file modification script
# AUTHOR David Mullins (DAVit) @2022 Jan
# to prepare file for data import
#
# Processing filenames using an array
# Sometimes you need read a file into an array as
# one array element per line. Following script will
# read file names into an array and you can process each file
# using for loop. This is useful for complex tasks:

# TODO  file array loop DISABLED
#       FIX  Replace any hard coding of input filenames and paths 
#       NEED to establish a more efficient populate database
#       NEED to include Time estimate and a Progress bar
#            this process may that >hours depending on input file size
#       NEED Catch errors and Quit options
#       NEED to present OPTIONS and USAGE 

DIR="$1"

# failsafe - fall back to current directory
[ "$DIR" == "" ] && DIR="."

version=0.04

# save and change IFS
OLDIFS=$IFS
IFS=$'\n'

# # read all file name into an array
# fileArray=($(find $DIR -type f))

# restore it
IFS=$OLDIFS
# get length of an array
# tLen=${#fileArray[@]}

# use for loop read all filenames
# for (( i=0; i<${tLen}; i++ ));
# do
#   #echo "${fileArray[$i]}"
#   filename="$(basename "${fileArray[$i]}")"
#   path="${fileArray[$i]%/*}"
#   extension="${fileArray[$i]##*.}"
#   #echo "${fileArray[$i]} : ${fileArray[$i]##*.} "
#
#   #Check for spaces and add "*" at begining
#   if [[ $filename = *[\ ]* ]]; then  filename="*$filename";  fi
#
#   echo -e "[$filename]\t[$extension]\t[$path]"
#
# done
# exit


#  GETTING SOURCE  DIRECTORY AND PATH
SOURCE="${BASH_SOURCE[0]}"
echo "SOURCE is '$SOURCE  -'  Version $version"
RDIR="$( dirname "$SOURCE" )"
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
if [ "$DIR" != "$RDIR" ]; then
  echo "DIR '$RDIR' resolves to '$DIR'"
fi
echo "DIR is '$DIR'"

start=$(date +%s.%N)

#TODO  FIX and ADD a Progress BAR for LAGE file processing.

# File directory list

# TODO FIX required here
## SAMPLE data
infile="testdir"

outfile="$DIR/out/$infile"
infile="$DIR/in/$infile"

echo "TARGET is '$infile'"

#Getting age of input file
BIRTHDATE=$(stat -c %w $infile)
LASTMODDATE=$(stat -c %y $infile)
LASTMODDATE=${LASTMODDATE%% *}
VALUES=(${LASTMODDATE//-/ })
LASTMODYEAR=${VALUES[0]}


#echo "$LASTMODYEAR $LASTMODDATE ($BIRTHDATE)"

# Get no of lines in files
lnes=$(gawk 'END { print NR }' $infile)

# read all file name into an array
#fileArray=($(find $DIR -type f))

# FIND (\ \.\/.*\b)
# REPLACE "\1"
#echo "create new file TOP" > $outfile
sed -e 's# \.\(\/.*\)#\t"root\1#g' $infile > $outfile.tmp

#exclude lines beginginwith "l" which are filelinks
grep -v '^l' $outfile.tmp > $outfile
rm $outfile.tmp

#PRINT HEADER
echo "..header created.."
echo -e "PERMISSION\tTYPE\tUSER\tGROUP\tSIZE\tDATE\tFILE\tEXT\tPATH" > $outfile.csv


# READ THE OUTFILE
n=1
while read line; do
  # reading each line
  filepath=$(echo "$line" | sed -e "s|^\(.*\)\( /.*\)$|\2|g")
  attributes=$(echo "$line" | sed -e "s|^\(.*\)\( /.*\)$|\1|g")

#echo "$n  | $filepath"
#echo "$n  | $attributes"

  filename="$(basename "$filepath")"

  # If the DATE contains a TIME element then assume its the input file (Year) and replace
  extension=""
  STR="${filepath##*.}"
  SUB="/"
  if [[ "$STR" =~ .*"$SUB".* ]]; then
       extension=" "  # no
      else
       extension="${filepath##*.}" #contains /
  fi
  path="${filepath%/*}"

  #extension="${filepath##*.}"

  #echo "Line No. $n : $line
  #echo "filepath. $n : $filepath"

  #  echo -e "[$filename]\t[$extension]\t[$path]\t[$attributes]"

  attrb="$attributes"
  COLS=()
      for val in $attrb ; do
            COLS+=("$val")
      done

  #TODO Must fix DATE ins current year as it present TIME
  # Get file date
  # use $LASTMODYEAR

  # If the DATE contains a TIME element then assume its the input file (Year) and replace
  STR="${COLS[7]}"
  SUB=":"
  if [[ "$STR" =~ .*"$SUB".* ]]; then
    COLS[7]=$LASTMODYEAR
  fi

  month=$(echo "${COLS[5]}" | awk 'BEGIN{months="  JanFebMarAprMayJunJulAugSepOctNovDec"}{print index(months,$0)/3}')
  #
  # echo "PERMISSION\tTYPE\tUSER\tGROUP\tSIZE\tDATE\tFILE\tEXT\tPATH" > out.txt
  #echo "[PERMISSION:${COLS[0]}][TYPE:${COLS[1]}][USER:${COLS[2]}][GROUP:${COLS[3]}][SIZE:${COLS[4]}][DATE:${COLS[7]}/$month/${COLS[6]}][FILE:$filename][EXT:$extension][PATH:$path]"
  echo -e "\"${COLS[0]}\"\t\"${COLS[1]}\"\t\"${COLS[2]}\"\t\"${COLS[3]}\"\t\"${COLS[4]}\"\t\"${COLS[7]}/$month/${COLS[6]}\"\t\"$filename\"\t\"$extension\"\t\"$path\"" >> $outfile.csv

  #    echo "$line" ;echo
  n=$((n+1))
done < $outfile
rm $outfile

# reset IFS
IFS=$OLDIFS

# Script Time counter
end=$(date +%s.%N)
dt=$(echo "$end - $start" | bc)
dd=$(echo "$dt/86400" | bc)
dt2=$(echo "$dt-86400*$dd" | bc)
dh=$(echo "$dt2/3600" | bc)
dt3=$(echo "$dt2-3600*$dh" | bc)
dm=$(echo "$dt3/60" | bc)
ds=$(echo "$dt3-60*$dm" | bc)
runtime=$( echo "$end - $start" | bc -l )
echo
runtime_long=$(printf "%d:%02d:%02d:%02.4f\n" $dd $dh $dm $ds)
echo "STATISTICS: $lnes lines processed.  Time taken was $runtime ($runtime_long)"

echo "OUTPUT is $outfile.csv"
