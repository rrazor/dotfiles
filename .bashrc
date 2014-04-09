#!/bin/bash

if [ -f /etc/bash_completion ]; then
	source /etc/bash_completion
fi

export PATH=/usr/local/bin:/usr/local/sbin:$PATH:~/pear:~/bin

export EDITOR=vim
export VISUAL=vim

host_prompt () {
	echo "\[\e[1;36m\]\h"
}

user_prompt () {
	echo "\[\e[1;30m\]\u"
}

vim_prompt () {
	if [ ! -z "$VIM" ]; then
		echo " \[\e[1;30m\]vim"
	fi
}

git_prompt () {
	if [ -d ".git" ]; then
		echo " \[\e[1;30m\]git:"$(git status -b --porcelain | awk '/^## / {print $2}' | tr -d '\n' | sed 's;[.][.][.].*$;;')
	fi
}

export PS1=$(user_prompt)"@"$(host_prompt)$(git_prompt)$(vim_prompt)"\[\e[0;0m\]> "

alias ls="/bin/ls -F"
alias du="du -cks"
alias vi="vim"
alias reconf="cd ..; aclocal; autoheader; autoconf; automake -a; ./configure; make clean; make; cd src"

case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Python development
export WORKON_HOME=$HOME/.virtualenvs
if [ -e `which virtualenvwrapper.sh` ]; then
	source `which virtualenvwrapper.sh`
fi
