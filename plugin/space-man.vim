" space-man.vim - Whitespace manager
" Author:       Rich Russon (flatcap) <rich@flatcap.org>
" Website:      https://flatcap.org
" Copyright:    2015 Richard Russon
" License:      GPLv3 <http://fsf.org/>
" Version:      1.0
finish

" if (exists ('g:loaded_space_man') || &cp || (v:version < 700))
" 	finish
" endif
" let g:loaded_space_man = 1

let s:scope_list = { 'a': 'argdo', 'b': 'bufdo', 'f': '', 'w': 'windo' }

function! s:translate (func)
	execute 'setlocal operatorfunc=' . a:func
	if (v:count == 0)
		return 'g@'
	else
		return 'g@g@'
	endif
endfunction


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


call <SID>blank_lines_bottom_map()
call <SID>blank_lines_bottom_user_map()
call <SID>blank_lines_top_map()
call <SID>blank_lines_top_user_map()
call <SID>empty_lines_delete_map()
call <SID>empty_lines_delete_user_map()
call <SID>empty_lines_squeeze_map()
call <SID>empty_lines_squeeze_user_map()
call <SID>spaces_tabs_map()
call <SID>spaces_tabs_user_map()
call <SID>space_error_map()
call <SID>space_error_user_map()
call <SID>space_leading_map()
call <SID>space_leading_user_map()
call <SID>space_trailing_map()
call <SID>space_trailing_user_map()
call <SID>tabs_spaces_map()
call <SID>tabs_spaces_user_map()

