let s:scope_list = { 'a': 'argdo', 'b': 'bufdo', 'f': '', 'w': 'windo' }

function! s:translate (func)
	execute 'setlocal operatorfunc=' . a:func
	if (v:count == 0)
		return 'g@'
	else
		return 'g@g@'
	endif
endfunction


function! SpaceTrailing (...)
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

	let cmd .= 's/\(\s\\|\%x0d\)\+$//e'
	execute cmd
endfunction

function! s:space_trailing_map()
	nnoremap <expr> <Plug>SpaceTrailingM <SID>translate ('SpaceTrailing')
	nnoremap        <Plug>SpaceTrailingL :<C-U>call SpaceTrailing (line ('.'),  line ('.'))<CR>
	xnoremap        <Plug>SpaceTrailingV :<C-U>call SpaceTrailing (line ("'<"), line ("'>"))<CR>
	nnoremap        <Plug>SpaceTrailingA :<C-U>call SpaceTrailing ('a')<CR>
	nnoremap        <Plug>SpaceTrailingB :<C-U>call SpaceTrailing ('b')<CR>
	nnoremap        <Plug>SpaceTrailingF :<C-U>call SpaceTrailing ('f')<CR>
	nnoremap        <Plug>SpaceTrailingW :<C-U>call SpaceTrailing ('w')<CR>
endfunction

function! s:space_trailing_user_map()
	nmap <Leader><space>tt  <Plug>SpaceTrailingL
	nmap <Leader><space>t   <Plug>SpaceTrailingM
	xmap <Leader><space>t   <Plug>SpaceTrailingV
	nmap <Leader>a<space>t  <Plug>SpaceTrailingA
	nmap <Leader>b<space>t  <Plug>SpaceTrailingB
	nmap <Leader>f<space>t  <Plug>SpaceTrailingF
	nmap <Leader>w<space>t  <Plug>SpaceTrailingW
endfunction


call <SID>space_trailing_map()
call <SID>space_trailing_user_map()

