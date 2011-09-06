#!/bin/bash

# Opens gedit pointing at the current working directory. Any files that
# are passed as args are opened (and created if they don't exist)

# Check if the user passed in any args
if [ $# = "0" ]; then
	# Opens gedit looking at the current directory (by 'opening') an
	# Untitled document
	gedit "Untitled Document 1" &
else
	# If the user passed in some filenames, the open them instead
	NUMOPENED=0
	for var in "$@"; do
		if [ ! -f "$var" ]; then
			# The filename doesn't exist - create it
			# NB: If the passed in name is a directory this will do nothing
			touch "$var"
		fi
		
		# Open the file if it isn't a directory and isn't a binary file
		if [ -f "$var" ]; then
    		FILETYPE=$(file -ib $var)
    		FILETYPE=${FILETYPE:0:4}
			if [ $FILETYPE == "text" ]; then
    			gedit "$var" &
    			NUMOPENED=$NUMOPENED+1
    		fi
    	fi
	done
	
	# If we didn't manage to open any of the passed-in files, then open us
	# looking at an Untitled Document anyway
	if [ $NUMOPENED == "0" ]; then
        gedit "Untitled Document 1" &
    fi
fi
