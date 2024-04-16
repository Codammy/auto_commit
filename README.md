# auto_commit

<p>This program watches any changes made to a directory (any content in it) and commits it to git in the backgroud without ultering the normal user operation of the host pc, thereby increasing the number of commits in that branch and overall github commit history if used in all branch repository.</p>

## How to use
After cloning this repo copy or move the `auto_commit.sh` file to your workspace/codebase or make it a symbolic link of it on one of your system's path in order for you to use it  globally on your host e.g

```bash
ln -s auto_commit.sh /usr/bin/commit```

Make sure the current dirrctory has an **upstream git branch** (i.e is a git repository) then run:

```bash
./auto_commit.sh &
```

This action keeps the program in **watch mode** i.e in the background.

You can run git push anytime you feel it's okay to push.

### Requirements
Any pc that supports bash scripting (any linux distribution should work).

You can always run git log to view all commit history.

If you're reading this kindly give this repository a star.
