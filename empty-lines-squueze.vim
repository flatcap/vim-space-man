let s:scope_list = { 'a': 'argdo', 'b': 'bufdo', 'f': '', 'w': 'windo' }

function! s:translate (func)
	execute 'setlocal operatorfunc=' . a:func
	if (v:count == 0)
		return 'g@'
	else
		return 'g@g@'
	endif
endfunction


function! EmptyLinesSqueeze (...)
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

	let cmd .= 's/\v\n(\s*\n){2,}//e'
	execute cmd
endfunction

function! s:empty_lines_squeeze_map()
	nnoremap <expr> <Plug>EmptyLinesSqueezeM <SID>translate ('EmptyLinesSqueeze')
	nnoremap        <Plug>EmptyLinesSqueezeL :<C-U>call EmptyLinesSqueeze (line ('.'),  line ('.'))<CR>
	xnoremap        <Plug>EmptyLinesSqueezeV :<C-U>call EmptyLinesSqueeze (line ("'<"), line ("'>"))<CR>
	nnoremap        <Plug>EmptyLinesSqueezeA :<C-U>call EmptyLinesSqueeze ('a')<CR>
	nnoremap        <Plug>EmptyLinesSqueezeB :<C-U>call EmptyLinesSqueeze ('b')<CR>
	nnoremap        <Plug>EmptyLinesSqueezeF :<C-U>call EmptyLinesSqueeze ('f')<CR>
	nnoremap        <Plug>EmptyLinesSqueezeW :<C-U>call EmptyLinesSqueeze ('w')<CR>
endfunction

function! s:empty_lines_squeeze_user_map()
	nmap <Leader><enter>zz  <Plug>EmptyLinesSqueezeL
	nmap <Leader><enter>z   <Plug>EmptyLinesSqueezeM
	xmap <Leader><enter>z   <Plug>EmptyLinesSqueezeV
	nmap <Leader>a<enter>z  <Plug>EmptyLinesSqueezeA
	nmap <Leader>b<enter>z  <Plug>EmptyLinesSqueezeB
	nmap <Leader>f<enter>z  <Plug>EmptyLinesSqueezeF
	nmap <Leader>w<enter>z  <Plug>EmptyLinesSqueezeW
endfunction


call <SID>empty_lines_squeeze_map()
call <SID>empty_lines_squeeze_user_map()

