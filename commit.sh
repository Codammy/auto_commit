#!/bin/bash
# automatically commits a change made on a file when saved

if [ ! -d .git ]; then
	echo "Not a git repo! run git init to get started"
	exit 1;
fi

FIlECOUNT=$(ls | wc -l);
LASTMOD=$(date -r .);
O="/home/$USER/.commit_history"

start_commit () {
	echo -e "Automating git commit...\n--- Watch mode activated."
	while [ -d .git ]; do
		MOD=$(date -r $(ls -t | head -1) > /dev/null)
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
}

end() {
	echo -e "You can always check "$O" to see your commit history."
	exit
}

if [ "$1" == "start" ]; then
	bg pid; start_commit;
elif [ "$1" == "stop" ]; then
	end;
fi
