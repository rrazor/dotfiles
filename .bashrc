if [ -f /etc/bash_completion ]; then
	source /etc/bash_completion
fi

export PATH=/usr/local/bin:/usr/local/sbin:$PATH:~/bin
export EDITOR=vim
export VISUAL=vim

case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

if [ -z "$VIM" ]; then
	PS1="\[\e[1;31m\]\u@\h [\!]>\[\e[0m\] "
else
	PS1="\[\e[1;31m\]\u@\h [\!] [vim]>\[\e[0m\] "
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
