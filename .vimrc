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
Plugin 'rking/ag.vim'
Plugin 'StanAngeloff/php.vim'
call vundle#end()

filetype plugin indent on
" End Vundle

filetype plugin indent off  " Well-meaning features but ruin formatoptions=

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
" Superseded by Airline, but left here for reference
"set statusline=%-40.(%f%m%r%h%w%)\ \ \ %<%10.20([%{&ff}/%Y]%)%=\ \ \%03.3b/0x\%02.2B\ \ \ (%4l,%4v)\ \ \%3p%%\ %4LL
set backspace=indent,eol,start
set hlsearch
set incsearch
set showmatch
set smartcase         " searches case-sensitive only when uppercase present
set wrap              " wrap file lines onscreen
set textwidth=0       " allow file lines of any length
set formatoptions=    " default was 'croql'
set formatoptions+=q  " allow formatting of comments with gq
set formatoptions+=n  " recognize numbered lists with autoindent
set list
set listchars=tab:⋅\ ,eol:¬,trail:█
set mouse=a           " allows mouse in xterms
" Show a popup menu for insert mode completion, always
set completeopt=menu,menuone,longest
set tags=./tags/all   " use exuberant ctags for completion, lookup
set keywordprg=~/pear/pman   " PHP manual lookup
set spellcapcheck=
set spelllang=en_us
set nofoldenable
set splitright
set splitbelow

let mapleader = ','   " custom commands start with ,

if v:version >= 703
	set colorcolumn=
	nnoremap <leader>r :set rnu!<CR>:set rnu?<CR>
endif

" Quickly edit/reload the .vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>:AirlineRefresh<CR>

" Clear search highlights
nnoremap <leader>/ :noh<cr>:echo "search cleared"<cr>
nnoremap <leader>n :set nu!<CR>:set nu?<CR>
nnoremap <leader>ai :set autoindent!<CR>:set autoindent?<CR>
nnoremap <leader>p :set paste!<CR>:set paste?<CR>
nnoremap <leader>b :ls<CR>
nnoremap <leader>d :bd<CR>
nnoremap <leader>l :set list!<CR>:set list?<CR>

" Spell checking
nnoremap <leader>sp :setlocal spell!<cr>:setlocal spell?<cr>

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

" Navigate between buffers quickly
nmap <c-l> :bnext<CR>
nmap <c-h> :bprev<CR>
nmap <leader>bd :bdelete<CR>
nmap <leader>bn :new<CR>
nmap <leader>bN :vnew<CR>

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
let g:airline#extensions#whitespace#enabled = 0
let g:airline#themes#base16#constant = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
function! AirlineInit()
	let g:airline_section_a = airline#section#create([''])
	let g:airline_section_x = airline#section#create(['%{&ff}/%Y'])
	let g:airline_section_y = airline#section#create(['%03.3b/0x%02.2B'])
	let g:airline_section_z = airline#section#create(['(%4l,%4v)', ' ', '%3p%%', ' ', '%LL'])
endfunction
autocmd VimEnter * call AirlineInit()
" /Airline

" CtrlP
let g:ctrlp_map = '<leader>f'
let g:ctrlp_cmd = 'CtrlPMixed'
" /CtrlP

" Syntastic
let g:syntastic_php_checkers = ['php']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" /Syntastic

" Supertab
let g:SuperTabLongestHighlight = 1
let g:SuperTabCrMapping = 1
" /Supertab
