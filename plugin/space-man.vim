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

" wrap up all the space manipulating
"
" Notes
"	try to preserve last search, cursor position, marks, etc

function! s:space_mappings (map, command)
	" delete whitespace:
	"	6	leading
	"	^	leading
	"	4	trailing
	"	$	trailing
	"	<tab>	before tab

	" delete empty lines:
	"	<enter>	anywhere
	"	g	at top of file
	"	G	at bottom of file

	let l:cmd = a:command
	if (!empty (l:cmd))
		let l:cmd .= ' '
	endif

	" delete whitespace
	execute 'nnoremap <leader>' . a:map . '<space>4       :' . l:cmd . '%s/\(\s\\|\%x0d\)\+$//e<cr>'
	execute 'nnoremap <leader>' . a:map . '<space>$       :' . l:cmd . '%s/\(\s\\|\%x0d\)\+$//e<cr>'
	execute 'nnoremap <leader>' . a:map . '<space>6       :' . l:cmd . '%s/^\s\+//e<cr>'
	execute 'nnoremap <leader>' . a:map . '<space>^       :' . l:cmd . '%s/^\s\+//e<cr>'
	execute 'nnoremap <leader>' . a:map . '<space><tab>   :' . l:cmd . '%s/<space>\+<tab>/<tab>/e<cr>'

	" delete lines
	execute 'nnoremap <leader>' . a:map . '<space><enter> :' . l:cmd . '%g/^\s*$/de<cr>'
	execute 'nnoremap <leader>' . a:map . '<space>g       :' . l:cmd . '%s/\%^\_s\+\n'
	execute 'nnoremap <leader>' . a:map . '<space>G       :' . l:cmd . '%s/\n\_s\+\%$'

	" visual delete whitespace
	execute 'vnoremap <leader>' . a:map . '<space>4       :' . l:cmd . 's/\s\+$//e<cr>'
	execute 'vnoremap <leader>' . a:map . '<space>$       :' . l:cmd . 's/\s\+$//e<cr>'
	execute 'vnoremap <leader>' . a:map . '<space>6       :' . l:cmd . 's/^\s\+//e<cr>'
	execute 'vnoremap <leader>' . a:map . '<space>^       :' . l:cmd . 's/^\s\+//e<cr>'
	execute 'vnoremap <leader>' . a:map . '<space><enter> :' . l:cmd . 'g/^\s*$/de<cr>'
	execute 'vnoremap <leader>' . a:map . '<space><tab>   :' . l:cmd . 's/<space>\+<tab>/<tab>/e<cr>'
endfunction


call s:space_mappings ('',  '')	" bare mappings first
call s:space_mappings ('a', 'argdo')
call s:space_mappings ('b', 'bufdo')
call s:space_mappings ('w', 'windo')

" tidy whitespace
"	actions:
"		delete leading space
"		delete trailing space
"		delete space errors (space-tab)
"
"	work on:
"		line
"		visual
"		motion
"		file
"		window
"		buffer
"		args

" delete empty lines
"	actions:
"		delete empty lines (space-enter)
"		delete empty lines at top of file (space-g)
"		delete empty lines at bottom of file (space-G)
"
"	work on:
"		visual
"		motion
"		file
"		window
"		buffer
"		args

" tabby
"	actions:
"		expand tab
"		unexpand tab
"
"	work on:
"		line
"		visual
"		file
"		window
"		buffer
"		args

" resize tabs
"	actions:
"
"	use coded count?
"	48<motion> => tabsize 4 -> tabsize 8
"	84<motion> => tabsize 8 -> tabsize 4

" vim:set noet ts=8 sw=8:
