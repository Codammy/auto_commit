#!/bin/bash
# automatically commits a change made on a file when saved

if [![ -eds .git ]]; then
	echo "Not a git repo! run git init to get started"
	exit 1;
fi

FIlECOUNT=$(ls | wc -l);
LASTMOD=$(date -r .);
O='.commit_history'

# alias commit="git commit -m";
# alias add="git add";

while [ -e .git ]; do
	MOD=$(date -r $(ls -t | head -1))
	if [ "$MOD" != "$LASTMOD" ]; then
		git add .
		DIRLEN=$(ls | wc -l)
		if [[ "$FILECOUNT" -lt "$DIRLEN" ]]; then
			git commit -m "Created $(ls -t | head -1)" >> $O;
		elif [[ "$FILECOUNT" -gt "$DIRLEN" ]]; then
			git commit -m "Removed a file" >> $O;
		else
			if [ "$AUTOCOMMITMSG" == '' ]; then
				AUTOCOMMITMSG="Made changes to $(ls -t | head -1)";
			fi
			git commit -m "$AUTOCOMMITMSG" >> $O;
		fi
		FILECOUNT=$DIRLEN;
		LASTMOD=$MOD;
	fi
done;
