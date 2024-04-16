# auto_commit

<p>Command line utility program that watches any changes made to a directory (any content in it) and commits it to git in the backgroud without ultering the normal user operation of the host pc, thereby increasing the number of commits in that branch and overall github contribution if used in all branch repository.</p>

## Requirements
Any pc that supports bash scripting (any linux distribution should work).

## How to use
After cloning this repo copy or move the `auto_commit.sh` file to your workspace/codebase or make it a symbolic link of it on one of your system's path in order for you to use it  globally on your host e.g

```bash
ln -s auto_commit.sh /usr/bin/commit
```

Make sure the current dirrctory has an **upstream git branch** (i.e is a git repository) then run:

```bash
./auto_commit.sh &
```

This action keeps the program in **watch mode** i.e in the background.

You can run git push anytime you feel it's okay to push.

*__You can always run git log to view all commit history.__*

## How it works
The utility checks if the working directory ia a git repository, checks for the latest changes in the directory(folder), commits it accordingly and redirect the commit response to a file in order to prevent the default behaviour of `git commit` which is to print the information of the commits to standard output. this file can be used for __*debugging purpose*__ alongside `git log`

### Commit messages
Commit messages would be generated automatically by the program, depending on the type of changes made
<center>
    creation of file => created "file name"
    delete update => deleted a file
    modify => made changes to "filename"
</center>

A custom commit message can also be used by setting a global variable __AUTOCOMMITMSG__ like this `export AUTOCOMMITMSG='custom commit message'`. Note that this commit message would be the one the program would use for any other modifications made on a file, to revert back unset the AUTOCOMMITMSG with this command `unset AUTOCOMMITMSG` or set it to an empty string like this `AUTOCOMMITMSG=''`
---

__If you're reading this kindly give this repository a star 🌟.__
