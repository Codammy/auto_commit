#!/bin/bash
# automatically commits a change made on a file when saved

FIlECOUNT=$(ls | wc -l);
LASTMOD=$(date -r .);
O="/home/$USER/.commit_history"

help () {
echo "auto_commit commits changes made on a file to git immediately when there's a change in the directory.

    Usage: path_to_script/commit start &
    e.g ./commit start &
    Options:
        start - starts the process
        end - kills all running instance of the program"
}

start_commit () {
	GIT_INIT="$1/.git"
	if [ -z $1 ]; then
		GIT_INIT=".git"
	fi
	echo $GIT_INIT
	if [ ! -d "$GIT_INIT" ]; then
		echo "Not a git repo! run git init to get started"
		exit 1;
	fi

	# echo -e "Automating git commit...\n--- Watch mode activated."
	git config --global --add safe.directory $PWD
	while [ True ]; do
		if [ -d .git ]; then
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
		fi
	done;
}

end() {
	pkill "$0"
	echo "Bye bye.."
	echo -e "You can always check "$O" to see your commit history."
	exit
}

if [ "$1" == "start" ]; then
       	start_commit $2
elif [ "$1" == "end" ]; then
	end
else
	help
fi
