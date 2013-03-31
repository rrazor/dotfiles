DOTLN = @./dotlink.sh

install:
	$(DOTLN) .bashrc
	$(DOTLN) .gitconfig
	$(DOTLN) .screenrc
	$(DOTLN) .slate
	$(DOTLN) .vimrc
	$(DOTLN) .vim
