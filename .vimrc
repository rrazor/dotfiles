" https://github.com/rrazor/dotfiles

set nocompatible      " enhanced vim powers

" Begin Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'ervandew/supertab'
call vundle#end()
filetype plugin indent on
" End Vundle

set modelines=0       " block exploits (http://goo.gl/1jsAt)
set tabstop=4         " CW standard, 4 spaces to a tab
set shiftwidth=4      " see above
set noexpandtab       " use hard tabs
set encoding=utf-8
set scrolloff=3       " scroll before ends of window
set autoindent
set smartindent
" Use cindent to indent PHP
set cinkeys=0{,0},0),:,!^F,o,O,e
set cino==s
set cindent
set cpo+=d            " use tags file relative to CWD, not file
set cpo-=n            " don't use line number column for wrapped lines
set showmode          " Indicate insert, visual, replace mode on screen
set wildmenu          " bash-like tab-complete in ex mode
set wildmode=list:longest
set visualbell
set nocursorline      " highlight the current line
set nonumber          " no line numbers, use <leader>n to turn them on
set ttyfast           " smoother redrawing, more characters sent
set ruler             " CTRL-G shows less with statusline on
set laststatus=2      " always show a status line for the last window
set statusline=%-40.(%f%m%r%h%w%)\ \ \ %<%10.20([%{&ff}/%Y]%)%=\ \ \%03.3b/0x\%02.2B\ \ \ (%4l,%4v)\ \ \%3p%%\ %4LL
set backspace=indent,eol,start
set hlsearch
set incsearch
set showmatch
set smartcase         " searches case-sensitive only when uppercase present
set wrap              " wrap file lines onscreen
set textwidth=0       " allow file lines of any length
set formatoptions=    " default was 'croql'
set formatoptions+=c  " Auto-wrap comments
set formatoptions+=r  " Insert comment leader in insert mode with <enter>
set formatoptions+=q  " allow formatting of comments with gq
set formatoptions+=n  " recognize numbered lists with autoindent
set formatoptions+=1  " don't break after one-letter word
set list
set listchars=tab:⋅\ ,eol:¬,trail:█
set mouse=a           " allows mouse in xterms
" Show a popup menu for insert mode completion, always
set completeopt=menu,menuone,longest
set tags=./tags/all   " use exuberant ctags for completion, lookup
set keywordprg=~/pear/pman   " PHP manual lookup
set spellcapcheck=
set nofoldenable

let mapleader = ','   " custom commands start with ,

if v:version >= 703
	set colorcolumn=
	nnoremap <leader>r :set rnu!<CR>:set rnu?<CR>
endif

" Quickly edit/reload the .vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Clear search highlights
nnoremap <leader>/ :noh<cr>:echo "search cleared"<cr>
nnoremap <leader>n :set nu!<CR>:set nu?<CR>
nnoremap <leader>ai :set autoindent!<CR>:set autoindent?<CR>
nnoremap <leader>p :set paste!<CR>:set paste?<CR>
nnoremap <leader>b :ls<CR>
nnoremap <leader>d :bd<CR>
nnoremap <leader>l :set list!<CR>:set list?<CR>

" Spell checking
nnoremap <leader>sp :setlocal spell spelllang=en_us<cr>

" Tab jumps to matching brackets
nnoremap <tab> %
vnoremap <tab> %

" No arrow keys!
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" I don't need <F1> help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" jj is rare and works great for ESC
inoremap jj <ESC>

syntax enable
set t_Co=256
set background=dark
let base16colorspace=256
colo base16-rrazor

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

set wildignore+=.svn

" Restore cursor to last position when opening a file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Airline
let g:airline_powerline_fonts = 1
" /Airline

" CtrlP
let g:ctrlp_map = '<leader>f'
let g:ctrlp_cmd = 'CtrlPMixed'
" /CtrlP

" Syntastic
let g:syntastic_php_checkers = ['php']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" /Syntastic

" Supertab
let g:SuperTabLongestHighlight = 1
let g:SuperTabCrMapping = 1
" /Supertab
