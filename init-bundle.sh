#!/bin/bash

# Initialize the submodules (pull from respective remotes)
git submodule update --init --recursive

SOURCE_BUNDLE="$(dirname $(readlink -f $0))"
LOCAL_BUNDLE="$HOME/.vim"

if [ ! -z "$1" ]; then
	echo "Using custom local bundle location: $1"
	LOCAL_BUNDLE="$1"
fi

if [ -L "$LOCAL_BUNDLE" ]; then
	echo "$LOCAL_BUNDLE exist but I want to create a link with this name"
	read -e -p "Create a backup and proceed? (y/n) "

	if [[ $REPLY =~ ^[Yy]$ ]]; then
		echo "Creating backup at $LOCAL_BUNDLE.bak"
		mv "$LOCAL_BUNDLE" "$LOCAL_BUNDLE.bak"
	else
		echo 'OK, Aborting'
		exit
	fi
fi

echo "Creating link to $LOCAL_BUNDLE"
ln -s "$SOURCE_BUNDLE" "$LOCAL_BUNDLE"
