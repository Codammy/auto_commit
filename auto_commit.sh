#!/bin/bash
# automatically commits a change made on a file when saved

FIlECOUNT=$(ls | wc -l);
LASTMOD=$(date -r .)
if [ -e .git ]; then
	echo "This is a git repo"
	while [ 1 ]; do
		MOD=$(date -r .)
		if [ "$MOD" != "$LASTMOD" ]; then
			echo "file changed"
			DIRLEN=$(ls | wc -l)
			if [[ "$FILECOUNT" -lt "$DIRLEN" ]]; then
				echo "Created $(ls -t | head -1)"
			elif [[ "$FILECOUNT" -gt "$DIRLEN" ]]; then
				echo "Rwmoved a file"
			else
				echo "Made changes to to $(ls -t | head -1)"
			fi
			FILECOUNT=$DIRLEN;
			LASTMOD=$MOD;
		fi
	done;
else
	echo "Not a git repo! run git init to get started"
fi
