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

export PS1="\[\e[1;30m\]\u@\[\e[1;36m\]\h"$(vim_prompt)"\[\e[0;0m\]> "

alias ls="/bin/ls -F"
alias du="du -cks"
alias vi="vim"
alias reconf="cd ..; aclocal; autoheader; autoconf; automake -a; ./configure; make clean; make; cd src"
alias tmux="TERM=xterm-256color tmux"

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
