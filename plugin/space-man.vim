" space-man.vim - Whitespace manager
" Author:       Rich Russon (flatcap) <rich@flatcap.org>
" Website:      https://flatcap.org
" Copyright:    2015 Richard Russon
" License:      GPLv3 <http://fsf.org/>
" Version:      1.0

if (exists ('g:loaded_space_man') || &cp || (v:version < 700))
	finish
endif
let g:loaded_space_man = 1

function! s:translate (func)
	execute 'setlocal operatorfunc=' . a:func
	if (v:count == 0)
		return 'g@'
	else
		return 'g@g@'
	endif
endfunction

function! s:delete_top_blank_lines_map()
	if (get (g:, 'space_man_enable_delete_top_blank_lines', 1))
		nnoremap <Plug>DeleteTopBlankLinesA :<C-U>call spaceman#DeleteTopBlankLines ('a')<CR>
		nnoremap <Plug>DeleteTopBlankLinesB :<C-U>call spaceman#DeleteTopBlankLines ('b')<CR>
		nnoremap <Plug>DeleteTopBlankLinesF :<C-U>call spaceman#DeleteTopBlankLines ('f')<CR>
		nnoremap <Plug>DeleteTopBlankLinesW :<C-U>call spaceman#DeleteTopBlankLines ('w')<CR>

		if (get (g:, 'space_man_create_mappings_delete_top_blank_lines', 1))
			nmap <Leader>a<enter>gg <Plug>DeleteTopBlankLinesA
			nmap <Leader>b<enter>gg <Plug>DeleteTopBlankLinesB
			nmap <Leader>f<enter>gg <Plug>DeleteTopBlankLinesF
			nmap <Leader>w<enter>gg <Plug>DeleteTopBlankLinesW
		endif
	endif
endfunction

function! s:delete_bottom_blank_lines_map()
	if (get (g:, 'space_man_enable_delete_bottom_blank_lines', 1))
		nnoremap <Plug>DeleteBottomBlankLinesA :<C-U>call spaceman#DeleteBottomBlankLines ('a')<CR>
		nnoremap <Plug>DeleteBottomBlankLinesB :<C-U>call spaceman#DeleteBottomBlankLines ('b')<CR>
		nnoremap <Plug>DeleteBottomBlankLinesF :<C-U>call spaceman#DeleteBottomBlankLines ('f')<CR>
		nnoremap <Plug>DeleteBottomBlankLinesW :<C-U>call spaceman#DeleteBottomBlankLines ('w')<CR>

		if (get (g:, 'space_man_create_mappings_delete_bottom_blank_lines', 1))
			nmap <Leader>a<enter>G <Plug>DeleteBottomBlankLinesA
			nmap <Leader>b<enter>G <Plug>DeleteBottomBlankLinesB
			nmap <Leader>f<enter>G <Plug>DeleteBottomBlankLinesF
			nmap <Leader>w<enter>G <Plug>DeleteBottomBlankLinesW
		endif
	endif
endfunction

function! s:delete_empty_lines_map()
	if (get (g:, 'space_man_enable_delete_empty_lines', 1))
		nnoremap <expr> <Plug>DeleteEmptyLinesM <SID>translate ('spaceman#DeleteEmptyLines')
		nnoremap        <Plug>DeleteEmptyLinesL :<C-U>call spaceman#DeleteEmptyLines (line ('.'),  line ('.'))<CR>
		xnoremap        <Plug>DeleteEmptyLinesV :<C-U>call spaceman#DeleteEmptyLines (line ("'<"), line ("'>"))<CR>
		nnoremap        <Plug>DeleteEmptyLinesA :<C-U>call spaceman#DeleteEmptyLines ('a')<CR>
		nnoremap        <Plug>DeleteEmptyLinesB :<C-U>call spaceman#DeleteEmptyLines ('b')<CR>
		nnoremap        <Plug>DeleteEmptyLinesF :<C-U>call spaceman#DeleteEmptyLines ('f')<CR>
		nnoremap        <Plug>DeleteEmptyLinesW :<C-U>call spaceman#DeleteEmptyLines ('w')<CR>

		if (get (g:, 'space_man_create_mappings_delete_empty_lines', 1))
			nmap <Leader><enter>dd <Plug>DeleteEmptyLinesL
			nmap <Leader><enter>d  <Plug>DeleteEmptyLinesM
			xmap <Leader><enter>d  <Plug>DeleteEmptyLinesV
			nmap <Leader>a<enter>d <Plug>DeleteEmptyLinesA
			nmap <Leader>b<enter>d <Plug>DeleteEmptyLinesB
			nmap <Leader>f<enter>d <Plug>DeleteEmptyLinesF
			nmap <Leader>w<enter>d <Plug>DeleteEmptyLinesW
		endif
	endif
endfunction

function! s:squeeze_empty_lines_map()
	if (get (g:, 'space_man_enable_squeeze_empty_lines', 1))
		nnoremap <expr> <Plug>SqueezeEmptyLinesM <SID>translate ('spaceman#SqueezeEmptyLines')
		nnoremap        <Plug>SqueezeEmptyLinesL :<C-U>call spaceman#SqueezeEmptyLines (line ('.'),  line ('.'))<CR>
		xnoremap        <Plug>SqueezeEmptyLinesV :<C-U>call spaceman#SqueezeEmptyLines (line ("'<"), line ("'>"))<CR>
		nnoremap        <Plug>SqueezeEmptyLinesA :<C-U>call spaceman#SqueezeEmptyLines ('a')<CR>
		nnoremap        <Plug>SqueezeEmptyLinesB :<C-U>call spaceman#SqueezeEmptyLines ('b')<CR>
		nnoremap        <Plug>SqueezeEmptyLinesF :<C-U>call spaceman#SqueezeEmptyLines ('f')<CR>
		nnoremap        <Plug>SqueezeEmptyLinesW :<C-U>call spaceman#SqueezeEmptyLines ('w')<CR>

		if (get (g:, 'space_man_create_mappings_squeeze_empty_lines', 1))
			nmap <Leader><enter>zz <Plug>SqueezeEmptyLinesL
			nmap <Leader><enter>z  <Plug>SqueezeEmptyLinesM
			xmap <Leader><enter>z  <Plug>SqueezeEmptyLinesV
			nmap <Leader>a<enter>z <Plug>SqueezeEmptyLinesA
			nmap <Leader>b<enter>z <Plug>SqueezeEmptyLinesB
			nmap <Leader>f<enter>z <Plug>SqueezeEmptyLinesF
			nmap <Leader>w<enter>z <Plug>SqueezeEmptyLinesW
		endif
	endif
endfunction

function! s:delete_space_error_map()
	if (get (g:, 'space_man_enable_delete_space_error', 1))
		nnoremap <expr> <Plug>DeleteSpaceErrorM <SID>translate ('spaceman#DeleteSpaceError')
		nnoremap        <Plug>DeleteSpaceErrorL :<C-U>call spaceman#DeleteSpaceError (line ('.'),  line ('.'))<CR>
		xnoremap        <Plug>DeleteSpaceErrorV :<C-U>call spaceman#DeleteSpaceError (line ("'<"), line ("'>"))<CR>
		nnoremap        <Plug>DeleteSpaceErrorA :<C-U>call spaceman#DeleteSpaceError ('a')<CR>
		nnoremap        <Plug>DeleteSpaceErrorB :<C-U>call spaceman#DeleteSpaceError ('b')<CR>
		nnoremap        <Plug>DeleteSpaceErrorF :<C-U>call spaceman#DeleteSpaceError ('f')<CR>
		nnoremap        <Plug>DeleteSpaceErrorW :<C-U>call spaceman#DeleteSpaceError ('w')<CR>

		if (get (g:, 'space_man_create_mappings_delete_space_error', 1))
			nmap <Leader><space>ee <Plug>DeleteSpaceErrorL
			nmap <Leader><space>e  <Plug>DeleteSpaceErrorM
			xmap <Leader><space>e  <Plug>DeleteSpaceErrorV
			nmap <Leader>a<space>e <Plug>DeleteSpaceErrorA
			nmap <Leader>b<space>e <Plug>DeleteSpaceErrorB
			nmap <Leader>f<space>e <Plug>DeleteSpaceErrorF
			nmap <Leader>w<space>e <Plug>DeleteSpaceErrorW
		endif
	endif
endfunction

function! s:delete_leading_space_map()
	if (get (g:, 'space_man_enable_delete_leading_space', 1))
		nnoremap <expr> <Plug>DeleteLeadingSpaceM <SID>translate ('spaceman#DeleteLeadingSpace')
		nnoremap        <Plug>DeleteLeadingSpaceL :<C-U>call spaceman#DeleteLeadingSpace (line ('.'),  line ('.'))<CR>
		xnoremap        <Plug>DeleteLeadingSpaceV :<C-U>call spaceman#DeleteLeadingSpace (line ("'<"), line ("'>"))<CR>
		nnoremap        <Plug>DeleteLeadingSpaceA :<C-U>call spaceman#DeleteLeadingSpace ('a')<CR>
		nnoremap        <Plug>DeleteLeadingSpaceB :<C-U>call spaceman#DeleteLeadingSpace ('b')<CR>
		nnoremap        <Plug>DeleteLeadingSpaceF :<C-U>call spaceman#DeleteLeadingSpace ('f')<CR>
		nnoremap        <Plug>DeleteLeadingSpaceW :<C-U>call spaceman#DeleteLeadingSpace ('w')<CR>

		if (get (g:, 'space_man_create_mappings_delete_leading_space', 1))
			nmap <Leader><space>ll <Plug>DeleteLeadingSpaceL
			nmap <Leader><space>l  <Plug>DeleteLeadingSpaceM
			xmap <Leader><space>l  <Plug>DeleteLeadingSpaceV
			nmap <Leader>a<space>l <Plug>DeleteLeadingSpaceA
			nmap <Leader>b<space>l <Plug>DeleteLeadingSpaceB
			nmap <Leader>f<space>l <Plug>DeleteLeadingSpaceF
			nmap <Leader>w<space>l <Plug>DeleteLeadingSpaceW
		endif
	endif
endfunction

function! s:delete_trailing_space_map()
	if (get (g:, 'space_man_enable_delete_trailing_space', 1))
		nnoremap <expr> <Plug>DeleteTrailingSpaceM <SID>translate ('spaceman#DeleteTrailingSpace')
		nnoremap        <Plug>DeleteTrailingSpaceL :<C-U>call spaceman#DeleteTrailingSpace (line ('.'),  line ('.'))<CR>
		xnoremap        <Plug>DeleteTrailingSpaceV :<C-U>call spaceman#DeleteTrailingSpace (line ("'<"), line ("'>"))<CR>
		nnoremap        <Plug>DeleteTrailingSpaceA :<C-U>call spaceman#DeleteTrailingSpace ('a')<CR>
		nnoremap        <Plug>DeleteTrailingSpaceB :<C-U>call spaceman#DeleteTrailingSpace ('b')<CR>
		nnoremap        <Plug>DeleteTrailingSpaceF :<C-U>call spaceman#DeleteTrailingSpace ('f')<CR>
		nnoremap        <Plug>DeleteTrailingSpaceW :<C-U>call spaceman#DeleteTrailingSpace ('w')<CR>

		if (get (g:, 'space_man_create_mappings_delete_trailing_space', 1))
			nmap <Leader><space>tt <Plug>DeleteTrailingSpaceL
			nmap <Leader><space>t  <Plug>DeleteTrailingSpaceM
			xmap <Leader><space>t  <Plug>DeleteTrailingSpaceV
			nmap <Leader>a<space>t <Plug>DeleteTrailingSpaceA
			nmap <Leader>b<space>t <Plug>DeleteTrailingSpaceB
			nmap <Leader>f<space>t <Plug>DeleteTrailingSpaceF
			nmap <Leader>w<space>t <Plug>DeleteTrailingSpaceW
		endif
	endif
endfunction

function! s:convert_spaces_to_tabs_map()
	if (get (g:, 'space_man_enable_convert_spaces_to_tabs', 1))
		nnoremap <expr> <Plug>ConvertSpacesToTabsM <SID>translate ('spaceman#ConvertSpacesToTabs')
		nnoremap        <Plug>ConvertSpacesToTabsL :<C-U>call spaceman#ConvertSpacesToTabs (line ('.'),  line ('.'))<CR>
		xnoremap        <Plug>ConvertSpacesToTabsV :<C-U>call spaceman#ConvertSpacesToTabs (line ("'<"), line ("'>"))<CR>
		nnoremap        <Plug>ConvertSpacesToTabsA :<C-U>call spaceman#ConvertSpacesToTabs ('a')<CR>
		nnoremap        <Plug>ConvertSpacesToTabsB :<C-U>call spaceman#ConvertSpacesToTabs ('b')<CR>
		nnoremap        <Plug>ConvertSpacesToTabsF :<C-U>call spaceman#ConvertSpacesToTabs ('f')<CR>
		nnoremap        <Plug>ConvertSpacesToTabsW :<C-U>call spaceman#ConvertSpacesToTabs ('w')<CR>

		if (get (g:, 'space_man_create_mappings_convert_spaces_to_tabs', 1))
			nmap <Leader><space><tab><tab> <Plug>ConvertSpacesToTabsL
			nmap <Leader><space><tab>      <Plug>ConvertSpacesToTabsM
			xmap <Leader><space><tab>      <Plug>ConvertSpacesToTabsV
			nmap <Leader>a<space><tab>     <Plug>ConvertSpacesToTabsA
			nmap <Leader>b<space><tab>     <Plug>ConvertSpacesToTabsB
			nmap <Leader>f<space><tab>     <Plug>ConvertSpacesToTabsF
			nmap <Leader>w<space><tab>     <Plug>ConvertSpacesToTabsW
		endif
	endif
endfunction

function! s:convert_tabs_to_spaces_map()
	if (get (g:, 'space_man_enable_convert_tabs_to_spaces', 1))
		nnoremap <expr> <Plug>ConvertTabsToSpacesM <SID>translate ('spaceman#ConvertTabsToSpaces')
		nnoremap        <Plug>ConvertTabsToSpacesL :<C-U>call spaceman#ConvertTabsToSpaces (line ('.'),  line ('.'))<CR>
		xnoremap        <Plug>ConvertTabsToSpacesV :<C-U>call spaceman#ConvertTabsToSpaces (line ("'<"), line ("'>"))<CR>
		nnoremap        <Plug>ConvertTabsToSpacesA :<C-U>call spaceman#ConvertTabsToSpaces ('a')<CR>
		nnoremap        <Plug>ConvertTabsToSpacesB :<C-U>call spaceman#ConvertTabsToSpaces ('b')<CR>
		nnoremap        <Plug>ConvertTabsToSpacesF :<C-U>call spaceman#ConvertTabsToSpaces ('f')<CR>
		nnoremap        <Plug>ConvertTabsToSpacesW :<C-U>call spaceman#ConvertTabsToSpaces ('w')<CR>

		if (get (g:, 'space_man_create_mappings_convert_tabs_to_spaces', 1))
			nmap <Leader><tab><space><space> <Plug>ConvertTabsToSpacesL
			nmap <Leader><tab><space>        <Plug>ConvertTabsToSpacesM
			xmap <Leader><tab><space>        <Plug>ConvertTabsToSpacesV
			nmap <Leader>a<tab><space>       <Plug>ConvertTabsToSpacesA
			nmap <Leader>b<tab><space>       <Plug>ConvertTabsToSpacesB
			nmap <Leader>f<tab><space>       <Plug>ConvertTabsToSpacesF
			nmap <Leader>w<tab><space>       <Plug>ConvertTabsToSpacesW
		endif
	endif
endfunction

function! s:surround_with_space_map()
	if (get (g:, 'space_man_enable_surround_with_space', 1))
		nnoremap <expr> <Plug>SurroundWithSpaceM <SID>translate ('spaceman#SurroundWithSpaceMotion')
		nnoremap        <Plug>SurroundWithSpaceL :<C-U>call spaceman#SurroundWithSpaceLine (line ('.'), line ('.'), v:count1)<CR>
		xnoremap        <Plug>SurroundWithSpaceV :<C-U>call spaceman#SurroundWithSpaceVisual()<CR>

		if (get (g:, 'space_man_create_mappings_surround_with_space', 1))
			nmap <Leader><space>ss <Plug>SurroundWithSpaceL
			nmap <Leader><space>s  <Plug>SurroundWithSpaceM
			xmap <Leader><space>s  <Plug>SurroundWithSpaceV
		endif
	endif
endfunction


call s:delete_top_blank_lines_map()
call s:delete_bottom_blank_lines_map()
call s:delete_empty_lines_map()
call s:squeeze_empty_lines_map()
call s:delete_space_error_map()
call s:delete_leading_space_map()
call s:delete_trailing_space_map()
call s:convert_spaces_to_tabs_map()
call s:convert_tabs_to_spaces_map()
call s:surround_with_space_map()

