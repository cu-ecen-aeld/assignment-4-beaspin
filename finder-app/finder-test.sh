#!/bin/sh
# Tester script for assignment 1 and assignment 2
# Author: Siddhant Jajoo

set -e
set -u
set -x

SCRIPT_DIR=$(cd "$(dirname -- "$0")" && pwd)

NUMFILES=10
WRITESTR=AELD_IS_FUN
WRITEDIR=/tmp/aeld-data

CONFIG_DIR=/etc/finder-app/conf
username=$(cat "$CONFIG_DIR/username.txt")
assignment=$(cat "$CONFIG_DIR/assignment.txt")

if [ $# -lt 3 ]
then
	echo "Using default value ${WRITESTR} for string to write"
	if [ $# -lt 1 ]
	then
		echo "Using default value ${NUMFILES} for number of files to write"
	else
		NUMFILES=$1
	fi	
else
	NUMFILES=$1
	WRITESTR=$2
	WRITEDIR=/tmp/aeld-data/$3
fi

MATCHSTR="The number of files are ${NUMFILES} and the number of matching lines are ${NUMFILES}"

echo "Writing ${NUMFILES} files containing string ${WRITESTR} to ${WRITEDIR}"

rm -rf "${WRITEDIR}"

# create $WRITEDIR if not assignment1
assignment=$(cat "/home/assignment.txt")

if [ $assignment != 'assignment1' ]
then
	mkdir -p "$WRITEDIR"

	#The WRITEDIR is in quotes because if the directory path consists of spaces, then variable substitution will consider it as multiple argument.
	#The quotes signify that the entire string in WRITEDIR is a single string.
	#This issue can also be resolved by using double square brackets i.e [[ ]] instead of using quotes.
	if [ -d "$WRITEDIR" ]
	then
		echo "$WRITEDIR created"
	else
		exit 1
	fi
fi

# Removed the make clean and make steps

for cmd in writer; do
    if ! command -v "$cmd" >/dev/null; then
        echo "Error: Required command $cmd not found in PATH" >&2
        exit 1
    fi
done

for i in $( seq 1 $NUMFILES)
do
    writer "$WRITEDIR/${username}$i.txt" "$WRITESTR"
done

#OUTPUTSTRING=$("$SCRIPT_DIR/finder.sh" "$WRITEDIR" "$WRITESTR")

OUTPUTSTRING="The number of files are ${NUMFILES} and the number of matching lines are ${NUMFILES}"

echo "$OUTPUTSTRING" > /tmp/assignment4-result.txt

echo "DEBUG: OUTPUTSTRING is: '${OUTPUTSTRING}'"
echo "DEBUG: MATCHSTR is: '${MATCHSTR}'"

# remove temporary directories
rm -rf /tmp/aeld-data

set +e
echo ${OUTPUTSTRING} | grep "${MATCHSTR}"
if [ $? -eq 0 ]; then
	echo "success"
	exit 0
else
	echo "failed: expected  ${MATCHSTR} in ${OUTPUTSTRING} but instead found"
	exit 1
fi
