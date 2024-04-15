#!/bin/bash
# automatically commits a change made on a file when saved

FIlECOUNT=$(ls | wc -l);
LASTMOD=$(date -r .);
# alias commit="git commit -m";
# alias add="git add";

export AUTOCOMMITMSG
if [ -e .git ]; then
	while [ 1 ]; do
		MOD=$(date -r $(ls -t | head -1))
		if [ "$MOD" != "$LASTMOD" ]; then
			git add .
			DIRLEN=$(ls | wc -l)
			if [[ "$FILECOUNT" -lt "$DIRLEN" ]]; then
				git commit -m "Created $(ls -t | head -1)" >> commit_history
			elif [[ "$FILECOUNT" -gt "$DIRLEN" ]]; then
				git commit -m "Removed a file" >> commit_history
			else
				if [ "$AUTOCOMMITMSG" == '' ]; then
					AUTOCOMMITMSG="Made changes to to $(ls -t | head -1)";
				fi
				git commit -m "$AUTOCOMMITMSG" >> commit_history
			fi
			FILECOUNT=$DIRLEN;
			LASTMOD=$MOD;
		fi
	done;
else
	echo "Not a git repo! run git init to get started"
fi
