#!/bin/bash

SOURCE="$(pwd)/_vimrc"
VIMRC="$HOME/.vimrc"

if [ -L "$VIMRC" ]; then

	echo "$VIMRC exists but I want to create a link with this name."
	read -e -p "Create a backup and proceed? (y/n) "

	if [[ $REPLY =~ ^[Yy]$ ]]; then
		echo "Creating backup at $VIMRC.bak"
		mv "$VIMRC" "$VIMRC.bak"
	else
		echo 'OK, Aborting'
		exit
	fi
fi

echo "Creating link to $VIMRC"
ln -s "$SOURCE" "$VIMRC"
