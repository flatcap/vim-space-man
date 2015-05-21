let s:scope_list = { 'a': 'argdo', 'b': 'bufdo', 'f': '', 'w': 'windo' }

function! s:translate (func)
	execute 'setlocal operatorfunc=' . a:func
	if (v:count == 0)
		return 'g@'
	else
		return 'g@g@'
	endif
endfunction


function! TabsSpaces (...)
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

	let cmd .= '!expand --tabs ' . v:count1
	execute cmd
endfunction

function! s:tabs_spaces_map()
	nnoremap <expr> <Plug>TabsSpacesM <SID>translate ('TabsSpaces')
	nnoremap        <Plug>TabsSpacesL :<C-U>call TabsSpaces (line ('.'),  line ('.'))<CR>
	xnoremap        <Plug>TabsSpacesV :<C-U>call TabsSpaces (line ("'<"), line ("'>"))<CR>
	nnoremap        <Plug>TabsSpacesA :<C-U>call TabsSpaces ('a')<CR>
	nnoremap        <Plug>TabsSpacesB :<C-U>call TabsSpaces ('b')<CR>
	nnoremap        <Plug>TabsSpacesF :<C-U>call TabsSpaces ('f')<CR>
	nnoremap        <Plug>TabsSpacesW :<C-U>call TabsSpaces ('w')<CR>
endfunction

function! s:tabs_spaces_user_map()
	nmap <Leader><tab><space><space> <Plug>TabstabsL
	nmap <Leader><tab><space>        <Plug>TabstabsM
	xmap <Leader><tab><space>        <Plug>TabstabsV
	nmap <Leader>a<tab><space>       <Plug>TabstabsA
	nmap <Leader>b<tab><space>       <Plug>TabstabsB
	nmap <Leader>f<tab><space>       <Plug>TabstabsF
	nmap <Leader>w<tab><space>       <Plug>TabstabsW
endfunction


call <SID>tabs_spaces_map()
call <SID>tabs_spaces_user_map()

