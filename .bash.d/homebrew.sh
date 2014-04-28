#!/bin/bash
# Homebrew-specific entries in here
if [ `uname -s` == "Darwin" ]; then
	# Brew-installed nvm, so we can use npm outside of homebrew
	source $(brew --prefix nvm)/nvm.sh
fi
