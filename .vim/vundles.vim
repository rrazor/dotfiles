filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle (required)
Bundle "gmarik/vundle"

" Bundles
Bundle "godlygeek/tabular"
Bundle 'git://git.wincent.com/command-t.git'

" These contain extras that are not meant for the public repos
if filereadable(expand("~/.vim/vundles.extra.vim"))
	source ~/.vim/vundles.extra.vim
endif

filetype plugin indent on