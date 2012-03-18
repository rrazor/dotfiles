#!/bin/bash -eu

SRC=$(readlink -f $1)
DEST="$HOME/$1"

echo "=> $1"

if [ -e $DEST ]; then
	if [ -L $DEST ]; then
		rm $DEST
	else
		# Back up the file
		BACKUP="$DEST.bak"
		mv $DEST $BACKUP
		echo "   Backed up $DEST => $BACKUP"
	fi
fi

ln -s $SRC $DEST
echo "   Linked $DEST => $SRC"
