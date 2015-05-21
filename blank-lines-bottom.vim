
function! BlankLinesBottom (scope)
	let cmd = s:scope_list[a:scope] . ' %'
	let cmd .= 's/\n\_s\+\%$'
	execute cmd
endfunction

function! s:blank_lines_bottom_map()
	nnoremap <Plug>BlankLinesBottomA :<C-U>call BlankLinesBottom ('a')<CR>
	nnoremap <Plug>BlankLinesBottomB :<C-U>call BlankLinesBottom ('b')<CR>
	nnoremap <Plug>BlankLinesBottomF :<C-U>call BlankLinesBottom ('f')<CR>
	nnoremap <Plug>BlankLinesBottomW :<C-U>call BlankLinesBottom ('w')<CR>
endfunction

function! s:blank_lines_bottom_user_map()
	nmap <Leader>a<enter>G <Plug>BlankLinesBottomA
	nmap <Leader>b<enter>G <Plug>BlankLinesBottomB
	nmap <Leader>f<enter>G <Plug>BlankLinesBottomF
	nmap <Leader>w<enter>G <Plug>BlankLinesBottomW
endfunction


call <SID>blank_lines_bottom_map()
call <SID>blank_lines_bottom_user_map()

