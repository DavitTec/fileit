#! /usr/bin/env bash
version=0.05.2
# HEADER fileit test Directory list file modification script
# AUTHOR David Mullins (DAVit) @2022 Jan
# to prepare file for data import
#
# Processing filenames using an array
# Sometimes you need read a file into an array as
# one array element per line. Following script will
# read file names into an array and you can process each file
# using for loop. This is useful for complex tasks:

# TODO  
#  [ ]  Check standalone or CALLED by prog
#  [ ]  check that calling prog version is not behind this version
#  [ ]  File array loop DISABLED
#  [ ]  FIX  Replace any hard coding of input filenames and paths
#  [ ]  NEED to establish a more efficient populate database
#  [ ]  NEED to include Time estimate and a Progress bar
#            this process may that >hours depending on input file size
#  [ ]  NEED Catch errors and Quit options
#  [ ]  NEED large input file takes too long to process - how about Multi-process?
#  [ ]  NEED to offer simpler methods of splitting large input files
#  [ ]  NEED to present OPTIONS and USAGE
#  [ ]  NEED to SPLIT LARGE CSV
#       ref https://betterprogramming.pub/how-to-split-a-large-excel-file-into-multiple-smaller-files-664f18f97900

#####################################################################
# Default scale used by float functions.
# src https://www.linuxjournal.com/content/floating-point-math-bash
float_scale=2
#####################################################################
# Evaluate a floating point number expression.

function float_eval()
{
    local stat=0
    local result=0.0
    if [[ $# -gt 0 ]]; then
        result=$(echo "scale=$float_scale; $*" | bc -q 2>/dev/null)
        stat=$?
        if [[ $stat -eq 0  &&  -z "$result" ]]; then stat=1; fi
    fi
    echo $result
    return $stat
}
#####################################################################


### ProgressBar
SLEEP_DURATION=${SLEEP_DURATION:=0.01}  # default to 1 second, use to speed up tests
space_reserved=6   # reserved width for the percentage value
duration=100
elapsed=1
columns=$(tput cols) # total characters of terminal width
space_available=$(( columns-space_reserved ))

if (( duration < space_available )); then
    	fit_to_screen=1;
else
  fit_to_screen=$(( duration / space_available ));
  fit_to_screen=$((fit_to_screen+1));
fi

DIR="$1"
#  MODE option for futuer implementation
MODE=0 # "0 - Normal, 1 - Test, 2 - Debug"
# failsafe - fall back to current directory
[ "$DIR" == "" ] && DIR="."

# save and change IFS
OLDIFS=$IFS

#  GETTING SOURCE  DIRECTORY AND PATH
SOURCE="${BASH_SOURCE[0]}"
echo "Running '$SOURCE  -'  Version $version"
RDIR="$( dirname "$SOURCE" )"
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
if [ "$DIR" != "$RDIR" ]; then
  echo "DIR '$RDIR' resolves to '$DIR'"
fi
echo "DIR is '$DIR'"

start=$(date +%s.%N)

#TODO  FIX and ADD a Progress BAR for LAGE file processing.
# Depends on mode LIVE, TEST or DEBUG
if [[ $mode -eq 0 ]] ; then
    infile="testdir"
    echo "Running in LIVE MODE"
else
    infile="testdocwithbreaks.txt"
    echo "Running in TEST MODE"
fi

outfile="$DIR/out/$infile"
infile="$DIR/in/$infile"

#Getting age of input file
BIRTHDATE=$(stat -c %w $infile)
LASTMODDATE=$(stat -c %y $infile)
LASTMODDATE=${LASTMODDATE%% *}
VALUES=(${LASTMODDATE//-/ })
LASTMODYEAR=${VALUES[0]}

# Get numbers of lines in file
lines=$(gawk 'END { print NR }' $infile)

## read all file name into an array
# fileArray=($(find $DIR -type f))
# FIND (\ \.\/.*\b)
# REPLACE "\1"
# echo "create new file TOP" > $outfile

# This was supposed to alter file with adding "root" but now necessary
# condition of file but be in a format presneted by the
# NOTE...THIS WILL PRINT NON printable characters, Line return etc,
##    You must clean the OUTPUT file to make one line per file.
##    DO THIS FIRST to remove
##    to rename all files containing line feed in current folder and
##    sub-folder, by combining find command with rename -
##    Check to see if errors and or remaing bad names files#
##    Here, find command locates all files containing line feed and
##    rename command replaces every line feed in the name with a space.
##    The same can be done for any other such problematic characters such as
#     carriage return (\r).
# NOTE: THIS IS NOT removing bad characters
# NOTE: Running the following command assumes root privileges and from "/mnt"
#       or change the Source to the target folder.
#       Drives are usually mounted in the "/mnt" folder
#
#  - This will rename some bad file names recursively - TEST first
#  find -name $'*\n*' -exec rename  $'s|\n| |g' '{}' \;
#  - This will collect file list (inc links) into a new input file in table
#    format. But this will include files with hidden or bad file name characters
#    and possible extra line feeds.
#
# find . ! -type d -exec ls -lnt {} + > in/directorylist.txt
#
#
#### Example Disk information
##       It would be helpful to collect Drive infor first and add to Database
####  DISK INFORMATION
##     MAKE:                SAMSUNG
##     MODEL:               ST1000DM005
##     SIZE:                1000GB
##     SERIAL:              NO:S246J9EC424741
##     PARTITION FORMAT:    Ext4 (version 1.0)
##     LAST CHECKED:        27/01/2020
##     STATUS:
##     FREESPACE:           280
####  Creating Directory listings

DRIVEID="DO3"   # Change to your drive id

#  OLD method
# sed -e 's# \.\(\/.*\)#\t"root\1#g' $infile > $outfile.tmp

# CONFIRM input files
echo "Input file for processing is $infile ($LASTMODDATE) and "
echo "it has $lines lines to process."
echo "NOTE:$infile.log1 was created for unprocessed lines."

#Create clean files and save bad lines or links to filename.log1
mv $infile  $infile.tmp
#exclude lines begingin with "l" which are filelinks
grep -v '^-' $infile.tmp > $infile.log1  # remove links and over runlines
grep  '^-' $infile.tmp > $infile #send other lines to read file

# add '""' to the filepath and adds "/mnt/$DRIVEID" instead of "./"
#Special case
sed 's|\(.*[0-9][0-9]\) \.\(/.*\)$| \1\t/mnt/$DRIVEID\2|g' $infile > $infile.1
# check for root

#PRINT HEADER for Output csv
echo -e "PERMISSION\tTYPE\tUSER\tGROUP\tSIZE\tDATE\tFILE\tEXT\tPATH" > $outfile.csv

###  Start reading file loop ##################################################

n=1
while read line; do

 ## PROGRESS bar           ##################################################
 printf "ROWS $n ";
 already_done() { for ((done=0; done<(elapsed / fit_to_screen) ; done=done+1 ));
                    do printf "▇"; done }
 remaining() { for (( remain=(elapsed/fit_to_screen) ; remain<(duration/fit_to_screen) ;
                remain=remain+1 )); do printf " "; done }
 percentage() { printf "| %s%%" $(( ((elapsed)*100)/(duration)*100/100 )); }
 clean_line() { printf "\r"; }
  # Arithimatic Floating decimal to nearst whole integer
  progressbar_float="100/$lines*$n"
  float=$(awk "BEGIN {print ($progressbar_float)}" )
  progressbar_int=$(echo "$float" | awk '{print ($0-int($0)<0.499)?int($0):int($0)+1}')
  elapsed=$progressbar_int   #  roundup
    already_done; remaining; percentage
    sleep "$SLEEP_DURATION"
    #clean_line
    clean_line
 ## //PROGRESS bar         ##################################################

  ## Seperqate Path/File from Attributes  file ###############################
#> TODO reading each line  NOTE the DRIVE is HARD CODED

  filepath=$(echo "$line"   | sed -e 's|^\(.*\)\(\/mnt.*\)$|\2|g')
  attributes=$(echo "$line" | sed -e 's|^\(.*\)\(\/mnt.*\)$|\1|g')
  filename="$(basename "$filepath")"

  extension=""
  STR="${filepath##*.}"
  SUB="/" # no extension as it contains /
  if [[ "$STR" =~ .*"$SUB".* ]]; then
       extension=" "
      else
       extension="${filepath##*.}"    
  fi
  path="${filepath%/*}"
  attrb="$attributes"  #need to make sure string is quoted
  COLS=()
      for val in $attrb ; do
            COLS+=($val) #COLS+=("$val")
      done

  # If the DATE contains a TIME element then assume inputfile (Year) and replace
  #>TODO Must fix DATE FORMAT
  STR="${COLS[7]}"
  SUB=":"   #Find ":" which refers to time not YEAR
  if [[ "$STR" =~ .*"$SUB".* ]]; then
    COLS[7]=$LASTMODYEAR
  fi
  #Convert Month into digits
  month=$(echo "${COLS[5]}" | awk 'BEGIN{months="  JanFebMarAprMayJunJulAugSepOctNovDec"}{print index(months,$0)/3}')
  # send to outfile
  echo -e "\"${COLS[0]}\"\t\"${COLS[1]}\"\t\"${COLS[2]}\"\t\"${COLS[3]}\"\t\"${COLS[4]}\"\t\"${COLS[7]}/$month/${COLS[6]}\"\t\"$filename\"\t\"$extension\"\t\"$path\"" >> $outfile.csv
  n=$((n+1))
done < $infile.1
rm $infile.1

### /End reading file loop  ##################################################

# reset IFS
IFS=$OLDIFS
n=$((n-1))  # we started at 1 we exit at n+1
echo "DONE $n "


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
runtime_sec=$( echo "$runtime" | awk '{print ($0-int($0)<0.499)?int($0):int($0)+1}')
runtime_long=$(printf "%d:%02d:%02d:%02.4f\n" $dd $dh $dm $ds)
echo " $lines lines processed. Time taken was $runtime_sec sec ($runtime_long)"
echo " OUTPUT is $outfile.csv"
exit 0
