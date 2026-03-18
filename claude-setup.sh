#!/bin/bash

# $1 is the source file passed in the terminal
# $2 is the destination path passed in the terminal

# It's good practice to check if the user provided the arguments
if [ -z "$1" ] ; then
    echo "Usage: $0 [self/ea]"
    exit 1
fi

# Execute the copy command
# Quoting "$1" and "$2" handles filenames with spaces correctly
cp ~/.claude/settings.json.$1 ~/.claude/settings.json
cp ~/.claude.zsh.$1 ~/.claude.zsh
source ~/.claude.zsh
