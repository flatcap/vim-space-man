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
"	option: try to preserve last search, cursor position, marks, etc
"	option: print a summary of changes

function! s:tab_expand (...)
	if (a:0 == 2)
		let [l:start, l:stop] = [a:1, a:2]
	else
		let [l:start, l:stop] = [line ('''['), line (''']')]
	endif

	execute l:start . ',' . l:stop . '!expand --tabs ' . v:count1
endfunction

function! s:tab_unexpand (...)
	if (a:0 == 2)
		let [l:start, l:stop] = [a:1, a:2]
	else
		let [l:start, l:stop] = [line ('''['), line (''']')]
	endif

	execute l:start . ',' . l:stop . '!unexpand --tabs ' . v:count1 . ' --first-only'
endfunction


function s:tabby_mappings()
	nnoremap <silent> <Plug>TabbyExpandA :<C-U>call <SID>tab_expand (1, line ('$'))<CR>
	nnoremap <silent> <Plug>TabbyExpandL :<C-U>call <SID>tab_expand (line ('.'), line ('.'))<CR>
	xnoremap <silent> <Plug>TabbyExpandV :<C-U>call <SID>tab_expand (line ('''<'), line ('''>'))<CR>

	nnoremap <silent> <Plug>TabbyUnexpandA :<C-U>call <SID>tab_unexpand (1, line ('$'))<CR>
	nnoremap <silent> <Plug>TabbyUnexpandL :<C-U>call <SID>tab_unexpand (line ('.'), line ('.'))<CR>
	xnoremap <silent> <Plug>TabbyUnexpandV :<C-U>call <SID>tab_unexpand (line ('''<'), line ('''>'))<CR>

	nmap <Leader><S-Tab>      <Plug>TabbyExpandA
	nmap <Leader><S-Tab><Tab> <Plug>TabbyExpandL
	xmap <Leader><S-Tab>      <Plug>TabbyExpandV

	nmap <Leader><Tab>        <Plug>TabbyUnexpandA
	nmap <Leader><Tab><Tab>   <Plug>TabbyUnexpandL
	xmap <Leader><Tab>        <Plug>TabbyUnexpandV

endfunction

function! s:file_mappings()
	let l:commands = [
	\	[ 'f', ''      ],
	\	[ 'a', 'argdo' ],
	\	[ 'b', 'bufdo' ],
	\	[ 'w', 'windo' ]
	\ ]

	for l:i in l:commands
		let l:key = l:i[0]
		let l:cmd = l:i[1]

		" delete whitespace
		execute 'nnoremap <leader>' . l:key . '<space>4       :' . l:cmd . '%s/\(\s\\|\%x0d\)\+$//e<cr>'
		execute 'nnoremap <leader>' . l:key . '<space>6       :' . l:cmd . '%s/^\s\+//e<cr>'
		execute 'nnoremap <leader>' . l:key . '<space><tab>   :' . l:cmd . '%s/<space>\+<tab>/<tab>/e<cr>'

		" delete lines
		execute 'nnoremap <leader>' . l:key . '<enter>        :' . l:cmd . '%g/^\s*$/de<cr>'
		execute 'nnoremap <leader>' . l:key . '<space><space> :' . l:cmd . 'SQUASH DUPE BLANKS'
		execute 'nnoremap <leader>' . l:key . '<enter>g       :' . l:cmd . '%s/\%^\_s\+\n'
		execute 'nnoremap <leader>' . l:key . '<enter>G       :' . l:cmd . '%s/\n\_s\+\%$'

		" manipulate tabs
		execute 'nnoremap <leader>' . l:key . '<tab>          :' . l:cmd . 'TAB UNEXPAND'
		execute 'nnoremap <leader>' . l:key . '<s-tab>        :' . l:cmd . 'TAB EXPAND'
	endfor
endfunction

function! s:space_mappings (map, command)

" LINE
	" delete whitespace
	execute 'nnoremap <leader><space>44             :%s/\(\s\\|\%x0d\)\+$//e<cr>'
	execute 'nnoremap <leader><space>66             :%s/^\s\+//e<cr>'
	execute 'nnoremap <leader><space><tab><tab>     :%s/<space>\+<tab>/<tab>/e<cr>'

	" delete lines
	execute 'nnoremap <leader><space><space><space> :SQUASH DUPE BLANK LINES'
	execute 'nnoremap <leader><enter><enter>        :%g/^\s*$/de<cr>'

	" manipulate tabs
	execute 'nnoremap <leader><tab><tab>            :TAB UNEXPAND'
	execute 'nnoremap <leader><s-tab><s-tab>        :TAB EXPAND'

" MOTION
	" delete whitespace
	execute 'nnoremap <leader><space>4              :%s/\(\s\\|\%x0d\)\+$//e<cr>'
	execute 'nnoremap <leader><space>6              :%s/^\s\+//e<cr>'
	execute 'nnoremap <leader><space><tab>          :%s/<space>\+<tab>/<tab>/e<cr>'

	" delete lines
	execute 'nnoremap <leader><space><space>        :SQUASH DUPE BLANK LINES'
	execute 'nnoremap <leader><enter>               :%g/^\s*$/de<cr>'

	" manipulate tabs
	execute 'nnoremap <leader><tab>                 :TAB UNEXPAND'
	execute 'nnoremap <leader><s-tab>               :TAB EXPAND'

" VISUAL
	" visual delete whitespace
	execute 'xnoremap <leader><space>4              :s/\s\+$//e<cr>'
	execute 'xnoremap <leader><space>6              :s/^\s\+//e<cr>'
	execute 'xnoremap <leader><space><tab>          :s/<space>\+<tab>/<tab>/e<cr>'

	" visual delete lines
	execute 'xnoremap <leader><space><space>        :SQUASH DUPE BLANK LINES'
	execute 'xnoremap <leader><space><enter>        :g/^\s*$/de<cr>'

	" manipulate tabs
	execute 'xnoremap <leader><tab>                 :TAB UNEXPAND'
	execute 'xnoremap <leader><s-tab>               :TAB EXPAND'
endfunction


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
"
"		file
"		window
"		buffer
"		args

" delete empty lines
"	actions:
"		delete empty lines (space-enter)
"		squash empty lines (space-space)
"		delete empty lines at top of file (space-g)
"		delete empty lines at bottom of file (space-G)
"
"	work on:
"		line
"		visual
"		motion
"
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
"		motion
"
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
