#!/bin/bash

if [ -f /etc/bash_completion ]; then
	source /etc/bash_completion
fi

export PATH=/usr/local/bin:/usr/local/sbin:$PATH:~/pear:~/bin

export EDITOR=vim
export VISUAL=vim
export HISTTIMEFORMAT="%F %T "

build_prompt () {
	local end_color="\[\e[0;90m\]"
	local reset_color="\[\e[0;0m\]"

	local at_color="\[\e[1;90m\]"
	local at_prompt="${at_color}@${reset_color}"

	local git_color="\[\e[0;35m\]"
	local git_prompt="${git_color}\$(git_prompt_text)${reset_color}"

	local host_color="\[\e[0;36m\]"
	local host_prompt="${host_color}"$(host_prompt_text)"${reset_color}"

	local user_color="\[\e[0;90m\]"
	local user_prompt="${user_color}\$(user_prompt_text)${reset_color}"

	local vim_prompt="\$(vim_prompt_text)"

	echo "${user_prompt}${at_prompt}${host_prompt}${git_prompt}${vim_prompt}${end_color}>${reset_color} "
}

host_prompt_text () {
	echo "\h"
}

user_prompt_text () {
	if [ "$USER" == "root" ]; then
		printf "\e[1;31mroot"
	else
		echo "$USER"
	fi
}

vim_prompt_text () {
	if [ ! -z "$VIM" ]; then
		printf " \e[4;33mvim\e[0;0m"
	fi
}

git_prompt_text () {
	if ! git rev-parse --git-dir > /dev/null 2>&1; then
		return 0
	fi

	local git_branch=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')

	echo " (${git_branch})"
}

export PS1=$(build_prompt)

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
