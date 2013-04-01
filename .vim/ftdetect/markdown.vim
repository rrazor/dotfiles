if exists("did\_load\_filetypes")
	"finish
endif

augroup markdown
	au! BufRead,BufNewFile *.mkd   setfiletype mkd
	autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt; expandtab
augroup END
