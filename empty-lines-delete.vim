let s:scope_list = { 'a': 'argdo', 'b': 'bufdo', 'f': '', 'w': 'windo' }

function! s:translate (func)
	execute 'setlocal operatorfunc=' . a:func
	if (v:count == 0)
		return 'g@'
	else
		return 'g@g@'
	endif
endfunction


function! EmptyLinesDelete (...)
	if (a:0 == 1)
		if (a:1 == 'line')
			" Motion
			let cmd = "'[,']"
		else
			" 1 arg: scope
			let cmd = s:scope_list[a:1] . ' %'
		endif
	else
		" 2 args: start,stop
		let cmd = a:1 . ',' . a:2
	endif

	let cmd .= 'g/^\s*$/de'
	execute cmd
endfunction

function! s:empty_lines_delete_map()
	nnoremap <expr> <Plug>EmptyLinesDeleteM <SID>translate ('EmptyLinesDelete')
	nnoremap        <Plug>EmptyLinesDeleteL :<C-U>call EmptyLinesDelete (line ('.'),  line ('.'))<CR>
	xnoremap        <Plug>EmptyLinesDeleteV :<C-U>call EmptyLinesDelete (line ("'<"), line ("'>"))<CR>
	nnoremap        <Plug>EmptyLinesDeleteA :<C-U>call EmptyLinesDelete ('a')<CR>
	nnoremap        <Plug>EmptyLinesDeleteB :<C-U>call EmptyLinesDelete ('b')<CR>
	nnoremap        <Plug>EmptyLinesDeleteF :<C-U>call EmptyLinesDelete ('f')<CR>
	nnoremap        <Plug>EmptyLinesDeleteW :<C-U>call EmptyLinesDelete ('w')<CR>
endfunction

function! s:empty_lines_delete_user_map()
	nmap <Leader><enter>dd  <Plug>EmptyLinesDeleteL
	nmap <Leader><enter>d   <Plug>EmptyLinesDeleteM
	xmap <Leader><enter>d   <Plug>EmptyLinesDeleteV
	nmap <Leader>a<enter>d  <Plug>EmptyLinesDeleteA
	nmap <Leader>b<enter>d  <Plug>EmptyLinesDeleteB
	nmap <Leader>f<enter>d  <Plug>EmptyLinesDeleteF
	nmap <Leader>w<enter>d  <Plug>EmptyLinesDeleteW
endfunction


call <SID>empty_lines_delete_map()
call <SID>empty_lines_delete_user_map()

