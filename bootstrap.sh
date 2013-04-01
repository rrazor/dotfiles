#!/bin/bash
#
# From https://github.com/mathiasbynens/dotfiles/blob/master/bootstrap.sh
cd "$(dirname "${BASH_SOURCE}")"
chmod 0755 .
function doIt() {
	rsync --exclude ".gitmodules" --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "README.md" -av . ~
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
fi
unset doIt
source ~/.bash_profile
