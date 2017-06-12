#!/bin/bash
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:$PATH

# convert and replace files

#set -x

MAIN_FOLDER="/path/to/somefolder"	# folder with photo albums
LOG_FILE="/tmp/convert_files.log"

rm "$LOG_FILE" > /dev/null 2>&1
rm /tmp/cm_convert.log > /dev/null 2>&1

##############################################
### FIRST PART - RECODE FILES IN EVERY DIR ###
##############################################

recode () {
	INPUT_DIR="$1"

	echo "-------------------------" >> "$LOG_FILE"
	echo "START PROCESS DIRECTORY" >> "$LOG_FILE"
	echo "$INPUT_DIR" >> "$LOG_FILE"

	# Create list of files that should process
	find "$INPUT_DIR"/*.tif -maxdepth 0 -type f > /tmp/cm_processing_list_files

	if [ -s /tmp/cm_processing_list_files ]		# True if FILE exists and has a size greater than zero
	then
		echo "FILES IN DIR:" >> "$LOG_FILE"
		cat /tmp/cm_processing_list_files >> "$LOG_FILE"

#		ORDER_NUM="1"

		while read -r PHOTO_FILE
		do
			echo "Start CONVERT files" >> "$LOG_FILE"
			echo "$PHOTO_FILE" >> "$LOG_FILE"
#			echo "$INPUT_DIR"/"$ORDER_NUM".mp3 >> "$LOG_FILE"

			convert "$PHOTO_FILE" -set filename: "%t" "$INPUT_DIR"/%[filename:].jpg > /tmp/cm_convert.log 2>&1
			rm "$PHOTO_FILE"
#			ORDER_NUM=$(( ORDER_NUM + 1 ))

		done < /tmp/cm_processing_list_files

	elif [ ! -s /tmp/cm_processing_list_files ]
	then
		echo "There are no any files .tif in folder $INPUT_DIR" >> "$LOG_FILE"
	else
		echo "ERROR. File not exist /tmp/cm_processing_list_files or another problem" >> "$LOG_FILE"
		exit 113
	fi
}

# Find all nesting dirs and process it
find "$MAIN_FOLDER" -mindepth 1 -type d > /tmp/cm_list_all_albums

while read -r ALB_DIR
do
	recode "$ALB_DIR"

done < /tmp/cm_list_all_albums
