let s:scope_list = { 'a': 'argdo', 'b': 'bufdo', 'f': '', 'w': 'windo' }

function! s:translate (func)
	execute 'setlocal operatorfunc=' . a:func
	if (v:count == 0)
		return 'g@'
	else
		return 'g@g@'
	endif
endfunction


function! SpaceError (...)
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

	let cmd .= 's/<space>\+<tab>/<tab>/e'
	execute cmd
endfunction

function! s:space_error_map()
	nnoremap <expr> <Plug>SpaceErrorM <SID>translate ('SpaceError')
	nnoremap        <Plug>SpaceErrorL :<C-U>call SpaceError (line ('.'),  line ('.'))<CR>
	xnoremap        <Plug>SpaceErrorV :<C-U>call SpaceError (line ("'<"), line ("'>"))<CR>
	nnoremap        <Plug>SpaceErrorA :<C-U>call SpaceError ('a')<CR>
	nnoremap        <Plug>SpaceErrorB :<C-U>call SpaceError ('b')<CR>
	nnoremap        <Plug>SpaceErrorF :<C-U>call SpaceError ('f')<CR>
	nnoremap        <Plug>SpaceErrorW :<C-U>call SpaceError ('w')<CR>
endfunction

function! s:space_error_user_map()
	nmap <Leader><space>ee  <Plug>SpaceErrorL
	nmap <Leader><space>e   <Plug>SpaceErrorM
	xmap <Leader><space>e   <Plug>SpaceErrorV
	nmap <Leader>a<space>e  <Plug>SpaceErrorA
	nmap <Leader>b<space>e  <Plug>SpaceErrorB
	nmap <Leader>f<space>e  <Plug>SpaceErrorF
	nmap <Leader>w<space>e  <Plug>SpaceErrorW
endfunction


call <SID>space_error_map()
call <SID>space_error_user_map()

