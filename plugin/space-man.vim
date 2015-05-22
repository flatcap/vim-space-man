" space-man.vim - Whitespace manager
" Author:       Rich Russon (flatcap) <rich@flatcap.org>
" Website:      https://flatcap.org
" Copyright:    2015 Richard Russon
" License:      GPLv3 <http://fsf.org/>
" Version:      1.0

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
	let cmd .= 's/\v\n\_s*\%$//e'
	execute cmd
endfunction

function! s:blank_lines_bottom_map()
	if (get (g:, 'space_man_enable_blank_lines_bottom', 1))
		nnoremap <Plug>BlankLinesBottomA :<C-U>call BlankLinesBottom ('a')<CR>
		nnoremap <Plug>BlankLinesBottomB :<C-U>call BlankLinesBottom ('b')<CR>
		nnoremap <Plug>BlankLinesBottomF :<C-U>call BlankLinesBottom ('f')<CR>
		nnoremap <Plug>BlankLinesBottomW :<C-U>call BlankLinesBottom ('w')<CR>

		if (get (g:, 'space_man_create_mappings_blank_lines_bottom', 1))
			nmap <Leader>a<enter>G <Plug>BlankLinesBottomA
			nmap <Leader>b<enter>G <Plug>BlankLinesBottomB
			nmap <Leader>f<enter>G <Plug>BlankLinesBottomF
			nmap <Leader>w<enter>G <Plug>BlankLinesBottomW
		endif
	endif
endfunction


function! BlankLinesTop (scope)
	let cmd = s:scope_list[a:scope] . ' %'
	let cmd .= 's/\v\%^\_s*\n//e'
	execute cmd
endfunction

function! s:blank_lines_top_map()
	if (get (g:, 'space_man_enable_blank_lines_top', 1))
		nnoremap <Plug>BlankLinesTopA :<C-U>call BlankLinesTop ('a')<CR>
		nnoremap <Plug>BlankLinesTopB :<C-U>call BlankLinesTop ('b')<CR>
		nnoremap <Plug>BlankLinesTopF :<C-U>call BlankLinesTop ('f')<CR>
		nnoremap <Plug>BlankLinesTopW :<C-U>call BlankLinesTop ('w')<CR>

		if (get (g:, 'space_man_create_mappings_blank_lines_top', 1))
			nmap <Leader>a<enter>gg <Plug>BlankLinesTopA
			nmap <Leader>b<enter>gg <Plug>BlankLinesTopB
			nmap <Leader>f<enter>gg <Plug>BlankLinesTopF
			nmap <Leader>w<enter>gg <Plug>BlankLinesTopW
		endif
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

	let cmd .= 'g/\v^\s*$/de'
	execute cmd
endfunction

function! s:empty_lines_delete_map()
	if (get (g:, 'space_man_enable_empty_lines_delete', 1))
		nnoremap <expr> <Plug>EmptyLinesDeleteM <SID>translate ('EmptyLinesDelete')
		nnoremap        <Plug>EmptyLinesDeleteL :<C-U>call EmptyLinesDelete (line ('.'),  line ('.'))<CR>
		xnoremap        <Plug>EmptyLinesDeleteV :<C-U>call EmptyLinesDelete (line ("'<"), line ("'>"))<CR>
		nnoremap        <Plug>EmptyLinesDeleteA :<C-U>call EmptyLinesDelete ('a')<CR>
		nnoremap        <Plug>EmptyLinesDeleteB :<C-U>call EmptyLinesDelete ('b')<CR>
		nnoremap        <Plug>EmptyLinesDeleteF :<C-U>call EmptyLinesDelete ('f')<CR>
		nnoremap        <Plug>EmptyLinesDeleteW :<C-U>call EmptyLinesDelete ('w')<CR>

		if (get (g:, 'space_man_create_mappings_empty_lines_delete', 1))
			nmap <Leader><enter>dd <Plug>EmptyLinesDeleteL
			nmap <Leader><enter>d  <Plug>EmptyLinesDeleteM
			xmap <Leader><enter>d  <Plug>EmptyLinesDeleteV
			nmap <Leader>a<enter>d <Plug>EmptyLinesDeleteA
			nmap <Leader>b<enter>d <Plug>EmptyLinesDeleteB
			nmap <Leader>f<enter>d <Plug>EmptyLinesDeleteF
			nmap <Leader>w<enter>d <Plug>EmptyLinesDeleteW
		endif
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

	let cmd .= 's/\v((^\s*\n){2,}|(\_s*%$))//e'
	execute cmd
endfunction

function! s:empty_lines_squeeze_map()
	if (get (g:, 'space_man_enable_empty_lines_squeeze', 1))
		nnoremap <expr> <Plug>EmptyLinesSqueezeM <SID>translate ('EmptyLinesSqueeze')
		nnoremap        <Plug>EmptyLinesSqueezeL :<C-U>call EmptyLinesSqueeze (line ('.'),  line ('.'))<CR>
		xnoremap        <Plug>EmptyLinesSqueezeV :<C-U>call EmptyLinesSqueeze (line ("'<"), line ("'>"))<CR>
		nnoremap        <Plug>EmptyLinesSqueezeA :<C-U>call EmptyLinesSqueeze ('a')<CR>
		nnoremap        <Plug>EmptyLinesSqueezeB :<C-U>call EmptyLinesSqueeze ('b')<CR>
		nnoremap        <Plug>EmptyLinesSqueezeF :<C-U>call EmptyLinesSqueeze ('f')<CR>
		nnoremap        <Plug>EmptyLinesSqueezeW :<C-U>call EmptyLinesSqueeze ('w')<CR>

		if (get (g:, 'space_man_create_mappings_empty_lines_squeeze', 1))
			nmap <Leader><enter>zz <Plug>EmptyLinesSqueezeL
			nmap <Leader><enter>z  <Plug>EmptyLinesSqueezeM
			xmap <Leader><enter>z  <Plug>EmptyLinesSqueezeV
			nmap <Leader>a<enter>z <Plug>EmptyLinesSqueezeA
			nmap <Leader>b<enter>z <Plug>EmptyLinesSqueezeB
			nmap <Leader>f<enter>z <Plug>EmptyLinesSqueezeF
			nmap <Leader>w<enter>z <Plug>EmptyLinesSqueezeW
		endif
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

	let cmd .= 's/\v +\t/\t/e'
	execute cmd
endfunction

function! s:space_error_map()
	if (get (g:, 'space_man_enable_space_error', 1))
		nnoremap <expr> <Plug>SpaceErrorM <SID>translate ('SpaceError')
		nnoremap        <Plug>SpaceErrorL :<C-U>call SpaceError (line ('.'),  line ('.'))<CR>
		xnoremap        <Plug>SpaceErrorV :<C-U>call SpaceError (line ("'<"), line ("'>"))<CR>
		nnoremap        <Plug>SpaceErrorA :<C-U>call SpaceError ('a')<CR>
		nnoremap        <Plug>SpaceErrorB :<C-U>call SpaceError ('b')<CR>
		nnoremap        <Plug>SpaceErrorF :<C-U>call SpaceError ('f')<CR>
		nnoremap        <Plug>SpaceErrorW :<C-U>call SpaceError ('w')<CR>

		if (get (g:, 'space_man_create_mappings_space_error', 1))
			nmap <Leader><space>ee <Plug>SpaceErrorL
			nmap <Leader><space>e  <Plug>SpaceErrorM
			xmap <Leader><space>e  <Plug>SpaceErrorV
			nmap <Leader>a<space>e <Plug>SpaceErrorA
			nmap <Leader>b<space>e <Plug>SpaceErrorB
			nmap <Leader>f<space>e <Plug>SpaceErrorF
			nmap <Leader>w<space>e <Plug>SpaceErrorW
		endif
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

	let cmd .= 's/\v^\s+//e'
	execute cmd
endfunction

function! s:space_leading_map()
	if (get (g:, 'space_man_enable_space_leading', 1))
		nnoremap <expr> <Plug>SpaceLeadingM <SID>translate ('SpaceLeading')
		nnoremap        <Plug>SpaceLeadingL :<C-U>call SpaceLeading (line ('.'),  line ('.'))<CR>
		xnoremap        <Plug>SpaceLeadingV :<C-U>call SpaceLeading (line ("'<"), line ("'>"))<CR>
		nnoremap        <Plug>SpaceLeadingA :<C-U>call SpaceLeading ('a')<CR>
		nnoremap        <Plug>SpaceLeadingB :<C-U>call SpaceLeading ('b')<CR>
		nnoremap        <Plug>SpaceLeadingF :<C-U>call SpaceLeading ('f')<CR>
		nnoremap        <Plug>SpaceLeadingW :<C-U>call SpaceLeading ('w')<CR>

		if (get (g:, 'space_man_create_mappings_space_leading', 1))
			nmap <Leader><space>ll <Plug>SpaceLeadingL
			nmap <Leader><space>l  <Plug>SpaceLeadingM
			xmap <Leader><space>l  <Plug>SpaceLeadingV
			nmap <Leader>a<space>l <Plug>SpaceLeadingA
			nmap <Leader>b<space>l <Plug>SpaceLeadingB
			nmap <Leader>f<space>l <Plug>SpaceLeadingF
			nmap <Leader>w<space>l <Plug>SpaceLeadingW
		endif
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

	let cmd .= 's/\v(\s|%x0d)+$//e'
	execute cmd
endfunction

function! s:space_trailing_map()
	if (get (g:, 'space_man_enable_space_trailing', 1))
		nnoremap <expr> <Plug>SpaceTrailingM <SID>translate ('SpaceTrailing')
		nnoremap        <Plug>SpaceTrailingL :<C-U>call SpaceTrailing (line ('.'),  line ('.'))<CR>
		xnoremap        <Plug>SpaceTrailingV :<C-U>call SpaceTrailing (line ("'<"), line ("'>"))<CR>
		nnoremap        <Plug>SpaceTrailingA :<C-U>call SpaceTrailing ('a')<CR>
		nnoremap        <Plug>SpaceTrailingB :<C-U>call SpaceTrailing ('b')<CR>
		nnoremap        <Plug>SpaceTrailingF :<C-U>call SpaceTrailing ('f')<CR>
		nnoremap        <Plug>SpaceTrailingW :<C-U>call SpaceTrailing ('w')<CR>

		if (get (g:, 'space_man_create_mappings_space_trailing', 1))
			nmap <Leader><space>tt <Plug>SpaceTrailingL
			nmap <Leader><space>t  <Plug>SpaceTrailingM
			xmap <Leader><space>t  <Plug>SpaceTrailingV
			nmap <Leader>a<space>t <Plug>SpaceTrailingA
			nmap <Leader>b<space>t <Plug>SpaceTrailingB
			nmap <Leader>f<space>t <Plug>SpaceTrailingF
			nmap <Leader>w<space>t <Plug>SpaceTrailingW
		endif
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
	if (get (g:, 'space_man_enable_spaces_tabs', 1))
		nnoremap <expr> <Plug>SpacesTabsM <SID>translate ('SpacesTabs')
		nnoremap        <Plug>SpacesTabsL :<C-U>call SpacesTabs (line ('.'),  line ('.'))<CR>
		xnoremap        <Plug>SpacesTabsV :<C-U>call SpacesTabs (line ("'<"), line ("'>"))<CR>
		nnoremap        <Plug>SpacesTabsA :<C-U>call SpacesTabs ('a')<CR>
		nnoremap        <Plug>SpacesTabsB :<C-U>call SpacesTabs ('b')<CR>
		nnoremap        <Plug>SpacesTabsF :<C-U>call SpacesTabs ('f')<CR>
		nnoremap        <Plug>SpacesTabsW :<C-U>call SpacesTabs ('w')<CR>

		if (get (g:, 'space_man_create_mappings_spaces_tabs', 1))
			nmap <Leader><space><tab><tab> <Plug>SpacesTabsL
			nmap <Leader><space><tab>      <Plug>SpacesTabsM
			xmap <Leader><space><tab>      <Plug>SpacesTabsV
			nmap <Leader>a<space><tab>     <Plug>SpacesTabsA
			nmap <Leader>b<space><tab>     <Plug>SpacesTabsB
			nmap <Leader>f<space><tab>     <Plug>SpacesTabsF
			nmap <Leader>w<space><tab>     <Plug>SpacesTabsW
		endif
	endif
endfunction


function! SpaceSurroundLine (begin, end, count)
	let curpos = getcurpos()

	let lines = []
	for i in range (a:count)
		let lines += ['']
	endfor

	call append (a:end,       lines)
	call append (a:begin - 1, lines)

	let curpos[1] += a:count
	call setpos ('.', curpos)
endfunction

function! s:space_surround_words (begin, end, count)
	let curpos = getcurpos()
	let curpos[2] += a:count

	" echo a:begin
	" echo a:end
	" echom a:count

	let space = ''
	for i in range (a:count)
		let space .= ' '
	endfor

	call setpos ('.', a:end)
	execute 'normal a' . space
	call setpos ('.', a:begin)
	execute 'normal i' . space

	call setpos ('.', curpos)
endfunction

function! s:space_surround_block()
	let curpos = getcurpos()
	let curpos[2] += v:count1

	let num = v:count1

	let space = ''
	for i in range (v:count1)
		let space .= ' '
	endfor

	let top = getpos ("'<")
	let bot = getpos ("'>")

	let cols = bot[2] - top[2] + 1

	let cmd = "'<,'>s/\\%V.\\{" . cols . "}/" . space . '&' . space . '/'
	execute cmd

	call setpos ('.', curpos)
endfunction

function! SpaceSurroundVisual (...)
	let vm = visualmode()
	if (vm ==# 'V')
		call SpaceSurroundLine(line ("'<"), line ("'>"), v:count1)
	elseif (vm ==# 'v')
		call s:space_surround_words(getpos ("'<"), getpos ("'>"), v:count1)
	else
		call s:space_surround_block()
	endif
endfunction

function! SpaceSurroundMotion (...)
	if (a:1 == 'line')
		call SpaceSurroundLine (line ("'["), line ("']"), 1)
	elseif (a:1 == 'char')
		call s:space_surround_words (getpos ("'["), getpos ("']"), 1)
	else
		" Ignore block mode
	endif
endfunction

function! s:space_surround_map()
	if (get (g:, 'space_man_enable_space_surround', 1))
		nnoremap <expr> <Plug>SpaceSurroundM <SID>translate ('SpaceSurroundMotion')
		nnoremap        <Plug>SpaceSurroundL :<C-U>call SpaceSurroundLine (line ('.'), line ('.'))<CR>
		xnoremap        <Plug>SpaceSurroundV :<C-U>call SpaceSurroundVisual()<CR>

		if (get (g:, 'space_man_create_mappings_space_surround', 1))
			nmap <Leader><space>ss <Plug>SpaceSurroundL
			nmap <Leader><space>s  <Plug>SpaceSurroundM
			xmap <Leader><space>s  <Plug>SpaceSurroundV
		endif
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
	if (get (g:, 'space_man_enable_tabs_spaces', 1))
		nnoremap <expr> <Plug>TabsSpacesM <SID>translate ('TabsSpaces')
		nnoremap        <Plug>TabsSpacesL :<C-U>call TabsSpaces (line ('.'),  line ('.'))<CR>
		xnoremap        <Plug>TabsSpacesV :<C-U>call TabsSpaces (line ("'<"), line ("'>"))<CR>
		nnoremap        <Plug>TabsSpacesA :<C-U>call TabsSpaces ('a')<CR>
		nnoremap        <Plug>TabsSpacesB :<C-U>call TabsSpaces ('b')<CR>
		nnoremap        <Plug>TabsSpacesF :<C-U>call TabsSpaces ('f')<CR>
		nnoremap        <Plug>TabsSpacesW :<C-U>call TabsSpaces ('w')<CR>

		if (get (g:, 'space_man_create_mappings_tabs_spaces', 1))
			nmap <Leader><tab><space><space> <Plug>TabsSpacesL
			nmap <Leader><tab><space>        <Plug>TabsSpacesM
			xmap <Leader><tab><space>        <Plug>TabsSpacesV
			nmap <Leader>a<tab><space>       <Plug>TabsSpacesA
			nmap <Leader>b<tab><space>       <Plug>TabsSpacesB
			nmap <Leader>f<tab><space>       <Plug>TabsSpacesF
			nmap <Leader>w<tab><space>       <Plug>TabsSpacesW
		endif
	endif
endfunction


call s:blank_lines_bottom_map()
call s:blank_lines_top_map()
call s:empty_lines_delete_map()
call s:empty_lines_squeeze_map()
call s:spaces_tabs_map()
call s:space_error_map()
call s:space_leading_map()
call s:space_surround_map()
call s:space_trailing_map()
call s:tabs_spaces_map()

