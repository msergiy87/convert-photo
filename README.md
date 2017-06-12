# convert-photo

Task
------------
Create script to convert photo (.tif files) to .jpg files.
ATTENTION, script will REPLACE .tiff files !!!

Requirements
------------
- convert

Distros tested
------------

Currently, this is only tested on ubuntu 16.04. It should theoretically work on older versions of Ubuntu or Debian based systems.

Usage
------------
Just change variable in your copy of script SOURCE_FOLDER="/path/to/somefolder". After that run script.

Source folder with Album folders - "/path/to/somefolder".
We convert and replace .tiff files.

Also we create log files - "/tmp/convert_files.log" and "/tmp/cm_convert.log".

- recode - function that convert all .tiff files in every folder.
