
function! BlankLinesTop (scope)
	let cmd = s:scope_list[a:scope] . ' %'
	let cmd .= 's/\%^\_s\+\n'
	execute cmd
endfunction

function! s:blank_lines_top_map()
	nnoremap <Plug>BlankLinesTopA :<C-U>call BlankLinesTop ('a')<CR>
	nnoremap <Plug>BlankLinesTopB :<C-U>call BlankLinesTop ('b')<CR>
	nnoremap <Plug>BlankLinesTopF :<C-U>call BlankLinesTop ('f')<CR>
	nnoremap <Plug>BlankLinesTopW :<C-U>call BlankLinesTop ('w')<CR>
endfunction

function! s:blank_lines_top_user_map()
	nmap <Leader>a<enter>gg <Plug>BlankLinesTopA
	nmap <Leader>b<enter>gg <Plug>BlankLinesTopB
	nmap <Leader>f<enter>gg <Plug>BlankLinesTopF
	nmap <Leader>w<enter>gg <Plug>BlankLinesTopW
endfunction


call <SID>blank_lines_top_map()
call <SID>blank_lines_top_user_map()

