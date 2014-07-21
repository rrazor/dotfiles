#!/bin/bash

usage () {

	echo "$(basename "$0") [-h]"
	echo "Compares the current working directory against \$HOME and shows a"
	echo "unified diff (colorized, if possible)."
	echo
	echo "Use this to preview what running bootstrap.sh will do."
}

while getopts ':h' option; do
	case "$option" in
		h)  usage
			exit
			;;
		\?) printf "illegal option: -%s\n" "$OPTARG" >&2
			usage >&2
			exit 1
			;;
	esac
done

compare_files () {

	FILEPATH=$(echo "$1" | sed 's;^[.]/;;')

	if [ ! -e "$HOME/$FILEPATH" ]; then
		return 0
	fi

	if hash colordiff 2>/dev/null; then
		diff -u "$HOME/$FILEPATH" "$FILEPATH" | colordiff
	else
		diff -u "$HOME/$FILEPATH" "$FILEPATH"
	fi
}

export -f compare_files

find . -mindepth 1 -type f \
	-not -path '*/.git/*' \
	-not -name '.DS_Store' \
	-not -name 'bootstrap.sh' \
	-not -name 'compare.sh' \
	-not -name 'README.md' \
	-exec bash -c 'compare_files "$0"' {} \;
