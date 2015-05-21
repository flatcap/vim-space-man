let s:scope_list = { 'a': 'argdo', 'b': 'bufdo', 'f': '', 'w': 'windo' }

function! s:translate (func)
	execute 'setlocal operatorfunc=' . a:func
	if (v:count == 0)
		return 'g@'
	else
		return 'g@g@'
	endif
endfunction


function! SpaceLeading (...)
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

	let cmd .= 's/^\s\+//e'
	execute cmd
endfunction

function! s:space_leading_map()
	nnoremap <expr> <Plug>SpaceLeadingM <SID>translate ('SpaceLeading')
	nnoremap        <Plug>SpaceLeadingL :<C-U>call SpaceLeading (line ('.'),  line ('.'))<CR>
	xnoremap        <Plug>SpaceLeadingV :<C-U>call SpaceLeading (line ("'<"), line ("'>"))<CR>
	nnoremap        <Plug>SpaceLeadingA :<C-U>call SpaceLeading ('a')<CR>
	nnoremap        <Plug>SpaceLeadingB :<C-U>call SpaceLeading ('b')<CR>
	nnoremap        <Plug>SpaceLeadingF :<C-U>call SpaceLeading ('f')<CR>
	nnoremap        <Plug>SpaceLeadingW :<C-U>call SpaceLeading ('w')<CR>
endfunction

function! s:space_leading_user_map()
	nmap <Leader><space>ll  <Plug>SpaceLeadingL
	nmap <Leader><space>l   <Plug>SpaceLeadingM
	xmap <Leader><space>l   <Plug>SpaceLeadingV
	nmap <Leader>a<space>l  <Plug>SpaceLeadingA
	nmap <Leader>b<space>l  <Plug>SpaceLeadingB
	nmap <Leader>f<space>l  <Plug>SpaceLeadingF
	nmap <Leader>w<space>l  <Plug>SpaceLeadingW
endfunction


call <SID>space_leading_map()
call <SID>space_leading_user_map()

