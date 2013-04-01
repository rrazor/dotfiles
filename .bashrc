#!/bin/bash

if [ -f /etc/bash_completion ]; then
	source /etc/bash_completion
fi

export PATH=/usr/local/bin:/usr/local/sbin:$PATH:~/pear:~/bin

export EDITOR=vim
export VISUAL=vim

vim_prompt () {
	if [ ! -z "$VIM" ]; then
		echo " \[\e[1;30m\]vim"
	fi
}

export PS1="\[\e[1;30m\]\u@\[\e[1;31m\]\h"$(vim_prompt)"\[\e[0;0m\]> "

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

svnaddall () {
	local FILES=`svn st | grep '^?' | awk '{print $2}'`
	for f in $FILES
	do
		[[ ! -L "$f" ]] && echo "$f@"
	done | xargs --no-run-if-empty svn add
}

if [ -f ~/.bash.d/*.sh ]; then
	source ~/.bash.d/*.sh
fi

if [ -f ~/.bash.extra.d/*/extra.sh ]; then
	source ~/.bash.extra.d/*/extra.sh
fi
