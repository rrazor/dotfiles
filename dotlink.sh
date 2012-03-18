#!/bin/bash -eu

REL=${1}
SRC=$(readlink -f $REL)
DEST="$HOME/$(basename $REL)"
BAK="$DEST.bak"

if [ -L $DEST ]; then
	rm $DEST
	echo "    UNLINK: $DEST"
elif [ -e $DEST ]; then
	if [ -e $BAK ]; then
		echo "ERROR: Will not overwrite backup: $BAK"
		exit 1
	fi
	mv $DEST $BAK
	echo "    BACKUP: $DEST => $BAK"
fi

ln -s $SRC $DEST
echo "    LINK  : $SRC => $DEST"
