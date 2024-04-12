#!/bin/bash
# automatically commits a change made on a file when saved

if [ -e .git ]; then
	echo "This is a git repo"
else
	echo "Not a git repo! run git init to get started"
fi
