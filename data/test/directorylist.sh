#! /usr/bin/env bash
version=0.05.8

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

### ProgressBar
SLEEP_DURATION=${SLEEP_DURATION:=0.0001}  # default to 1 second, use to speed up tests
space_reserved=6   # reserved width for the percentage value
duration=100
elapsed=1
columns=$(tput cols) # total characters of terminal width
space_available=$(( columns-space_reserved ))

if [[ duration -gt space_available ]] ; then
    	fit_to_screen=1;
else
  fit_to_screen=(( duration / space_available ));
  fit_to_screen=((fit_to_screen+1));
fi


DIR="$1"
#  MODE option for futuer implementation

MODE=0 # "Normal=0, Test=1"
TESTLINES=100
### WARNING ###

#  Need to fix DRIVE and MOUNT
DRIVE=12


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

infile="testdir"
infile="$DIR/mnt/D$DRIVE/$infile"
[ "$infile" == "" ] && { echo "Usage: $0 directory"; exit 1; }

directory="$DIR/CSV"   #Path for CVS outfile

### Check for dir, if not found create it using the mkdir ##
[ ! -d "$directory" ] && mkdir -p "$directory"

outfile="$directory/testdir.D$DRIVE"

#TODO  FIX and ADD a Progress BAR for LAGE file processing.
# Depends on mode LIVE, TEST or DEBUG
if [[ $MODE -eq 0 ]] ; then
    echo "Running in LIVE MODE"
else
    mv $infile $infile.all
    head -n $TESTLINES $infile.all > $infile.$TESTLINES
    cp $infile.$TESTLINES $infile
    echo "Running in TEST MODE on first $TESTLINES lines"
fi

#Getting age of input file
BIRTHDATE=$(stat -c %w $infile)
LASTMODDATE=$(stat -c %y $infile)
LASTMODDATE=${LASTMODDATE%% *}
VALUES=(${LASTMODDATE//-/ })
LASTMODYEAR=${VALUES[0]}

# Get numbers of lines in file
lines=$(gawk 'END { print NR }' $infile)


# CONFIRM input files
echo "Input file for processing is $infile ($LASTMODDATE) and "
echo "it has $lines lines to process."
echo "NOTE:$infile.log was created for unprocessed lines."

#Create clean files and save bad lines or links to filename.log1
mv $infile  $infile.tmp


echo -e	"Running $SOURCE  -  Version $version
==========================================================
MODE $(if [[ $MODE -eq 0 ]] ; then
    echo "Running in LIVE MODE"
else
    echo "Running in TEST MODE with $TESTLINES lines"; fi; )

Input file for processing is $infile ($LASTMODDATE) and
it has $lines lines to process.
NOTE:$infile.log will list any unprocessed lines below
----------------------------------------------------------
" > $infile.log

#exclude lines begingin with "l" which are filelinks
grep -v '^-' $infile.tmp >> $infile.log  # remove links and over runlines
grep  '^-' $infile.tmp > $infile #send other lines to read file

# add '""' to the filepath and adds "/mnt/$DRIVEID" instead of "./"
#Special case
printf  "....Fixing Drive root ID to /mnt/D$DRIVE  " ;
sed "s|\(.*[0-9][0-9]\) \.\(/.*\)$| \1\t/mnt/D$DRIVE\2|g" $infile > $infile.1
# check for root
printf  "  <<DONE>>\n";
echo

#PRINT HEADER for Output csv
echo "Creating $outfile.csv"
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
    clean_line
    clean_line
 ## //PROGRESS bar         ##################################################

  ## Seperate Path/File from Attributes  file ###############################
#> TODO reading each line  NOTE the DRIVE is HARD CODED

  filepath=$(echo "$line"   | sed -e "s|^\(.*\)\(\/mnt/D$DRIVE.*\)$|\2|g")
  attributes=$(echo "$line" | sed -e "s|^\(.*\)\(\/mnt/D$DRIVE.*\)$|\1|g")
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
rm $infile.tmp
rm $infile
rm $infile.$TESTLINES    #remove the test
mv $infile.all $infile   #replace back the orginal

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

echo "
----------------------------------------------------------
 $lines lines processed. Time taken was $runtime_sec sec ($runtime_long)
OUTPUT is $outfile.csv"  >> $infile.log

exit 0
