let s:scope_list = { 'a': 'argdo', 'b': 'bufdo', 'f': '', 'w': 'windo' }

function! s:translate (func)
	execute 'setlocal operatorfunc=' . a:func
	if (v:count == 0)
		return 'g@'
	else
		return 'g@g@'
	endif
endfunction


function! SpacesTabs (...)
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

	let cmd .= '!unexpand --tabs ' . v:count1 . ' --first-only'
	execute cmd
endfunction

function! s:spaces_tabs_map()
	nnoremap <expr> <Plug>SpacesTabsM <SID>translate ('SpacesTabs')
	nnoremap        <Plug>SpacesTabsL :<C-U>call SpacesTabs (line ('.'),  line ('.'))<CR>
	xnoremap        <Plug>SpacesTabsV :<C-U>call SpacesTabs (line ("'<"), line ("'>"))<CR>
	nnoremap        <Plug>SpacesTabsA :<C-U>call SpacesTabs ('a')<CR>
	nnoremap        <Plug>SpacesTabsB :<C-U>call SpacesTabs ('b')<CR>
	nnoremap        <Plug>SpacesTabsF :<C-U>call SpacesTabs ('f')<CR>
	nnoremap        <Plug>SpacesTabsW :<C-U>call SpacesTabs ('w')<CR>
endfunction

function! s:spaces_tabs_user_map()
	nmap <Leader><space><tab><tab> <Plug>TabstabsL
	nmap <Leader><space><tab>      <Plug>TabstabsM
	xmap <Leader><space><tab>      <Plug>TabstabsV
	nmap <Leader>a<space><tab>     <Plug>TabstabsA
	nmap <Leader>b<space><tab>     <Plug>TabstabsB
	nmap <Leader>f<space><tab>     <Plug>TabstabsF
	nmap <Leader>w<space><tab>     <Plug>TabstabsW
endfunction


call <SID>spaces_tabs_map()
call <SID>spaces_tabs_user_map()

