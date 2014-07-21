" PHP ftplugin

" Check php syntax whenever you save
function! ValPhp()
	let s:results = system( "php -l " . expand("%") )
	if match( s:results, "No syntax errors detected" ) != -1
		return
	else
		echo s:results
	endif
endfunction

" Validate PHP on save
au BufWritePost *.php call ValPhp()

" Use omnicompletion
call SuperTabSetDefaultCompletionType( "<c-x><c-o>" )
