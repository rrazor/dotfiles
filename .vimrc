" https://github.com/rrazor/dotfiles

set nocompatible      " enhanced vim powers

" Begin Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'FelikZ/ctrlp-py-matcher'
Plugin 'ivalkeen/vim-ctrlp-tjump'
Plugin 'scrooloose/syntastic'
Plugin 'ervandew/supertab'
Plugin 'rking/ag.vim'
Plugin 'StanAngeloff/php.vim'
Plugin 'bufkill.vim'
Plugin 'godlygeek/tabular'
Plugin 'nelstrom/vim-markdown-folding'
call vundle#end()

filetype plugin indent on
" End Vundle

"filetype indent off  " Well-meaning features but ruin formatoptions=

"set modelines=0       " block exploits (http://goo.gl/1jsAt)
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
nnoremap <leader>n :setlocal nu!<CR>:setlocal nu?<CR>
nnoremap <leader>ai :setlocal autoindent!<CR>:setlocal autoindent?<CR>
nnoremap <leader>p :setlocal paste!<CR>:setlocal paste?<CR>
nnoremap <leader>d :BD<CR>
nnoremap <leader>c :close<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>l :setlocal list!<CR>:setlocal list?<CR>
nnoremap <leader>f :CtrlP 
nnoremap <leader>t :CtrlPTag<CR>
nnoremap <leader>v R✓<esc>
nnoremap <c-]> :CtrlPtjump<CR>
vnoremap <c-]> :CtrlPtjumpVisual<CR>
nnoremap <c-\> *:noh<CR>:AgFromSearch 

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

" Navigate between buffers quickly
nmap <M-J> :bnext<CR>
nmap ∆ :bnext<CR>
nmap <M-K> :bprev<CR>
nmap ˚ :bprev<CR>
nmap <leader>bd :bdelete<CR>
nmap <leader>bn :new<CR>
nmap <leader>bN :vnew<CR>

" Navigate between windows quickly
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k

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
augroup bufreadpost_lastline
	autocmd!
	autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

augroup highlight_long_lines
	autocmd!
	" Highlight the portion of a line over 80 characters
	autocmd FileType php match OverLength /\%>80v.\+/
augroup END

augroup filetype_text
	autocmd!
	autocmd FileType text setlocal expandtab
	autocmd FileType text setlocal nowrap
augroup END

"augroup filetype_markdown
"	autocmd!
"	autocmd FileType markdown setlocal expandtab
"	autocmd FileType markdown setlocal nowrap
"	autocmd FileType markdown setlocal syntax=text
"augroup END

augroup filetype_sql
	autocmd!
	autocmd FileType sql setlocal expandtab
	autocmd BufNewFile,BufRead /tmp/sql* setlocal ft=sql
augroup END

augroup filetype_svncommit
	autocmd!
	autocmd FileType svncommit setlocal expandtab
	autocmd FileType svncommit setlocal tw=76
augroup END

" Airline
let g:airline_extensions = ['syntastic', 'tabline']
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tagbar#enabled = 0
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
let g:ctrlp_map = ''
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = ''
let g:ctrlp_extensions = ['tag']
" Set delay to prevent extra search
let g:ctrlp_lazy_update = 350
" Set no file limit, we are building a big project
let g:ctrlp_max_files = 0

if !has('python')
	" echo 'In order to use pymatcher plugin, you need +python compiled vim'
else
	" let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif

" If ag is available use it as filename list generator instead of 'find'
if executable("ag")
	set grepprg=ag\ --nogroup\ --nocolor
	let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --ignore ''.git'' --ignore ''.DS_Store'' --ignore ''node_modules'' --hidden -g ""'
endif
" /CtrlP

" Syntastic
let g:syntastic_php_checkers = ['php']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_skip_checks = 0
" /Syntastic

" Supertab
let g:SuperTabLongestHighlight = 1
let g:SuperTabCrMapping = 1
" /Supertab

" Tabular
nmap <leader>=<space> :Tabularize / = <CR>
vmap <leader>=<space> :Tabularize / = <CR>
nmap <leader>=> :Tabularize / => <CR>
vmap <leader>=> :Tabularize / => <CR>
nmap <leader>: :Tabularize /:\zs<CR>
vmap <leader>: :Tabularize /:\zs<CR>
" /Tabular

" Markdown
let g:markdown_fenced_languages = [ 'html', 'python', 'bash=sh', 'js=javascript' ]
" /Markdown
