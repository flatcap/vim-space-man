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

function! s:tab_expand (...) range
	echohl error
	echom 'expand: ' . a:0 a:1
	echom 'count: ' . v:count v:count1
	echohl none
	if (a:0 == 2)
		let [l:start, l:stop] = [a:1, a:2]
	else
		let [l:start, l:stop] = [line ('''['), line (''']')]
	endif

	execute l:start . ',' . l:stop . '!expand --tabs ' . v:count1
endfunction

function! s:tab_unexpand (...)
	echohl error
	echom 'count: ' . v:count v:count1
	echohl none
	if (a:0 == 2)
		let [l:start, l:stop] = [a:1, a:2]
	else
		let [l:start, l:stop] = [line ('''['), line (''']')]
	endif

	execute l:start . ',' . l:stop . '!unexpand --tabs ' . v:count1 . ' --first-only'
endfunction


function! s:tabby_mappings()
	nnoremap <silent> <Plug>TabbyExpandA :<C-U>call <SID>tab_expand (1, line ('$'))<CR>
	nnoremap <silent> <Plug>TabbyExpandL :<C-U>call <SID>tab_expand (line ('.'), line ('.'))<CR>
	nnoremap <silent> <Plug>TabbyExpandM :set opfunc=<SID>tab_expand<CR>g@
	xnoremap <silent> <Plug>TabbyExpandV :<C-U>call <SID>tab_expand (line ('''<'), line ('''>'))<CR>

	" nnoremap <silent> <Plug>TabbyUnexpandA :<C-U>call <SID>tab_unexpand (1, line ('$'))<CR>
	" nnoremap <silent> <Plug>TabbyUnexpandL :<C-U>call <SID>tab_unexpand (line ('.'), line ('.'))<CR>
	" nnoremap <silent> <Plug>TabbyUnexpandM :<C-U>set opfunc=<SID>tab_unexpand<CR>g@
	" xnoremap <silent> <Plug>TabbyUnexpandV :<C-U>call <SID>tab_unexpand (line ('''<'), line ('''>'))<CR>

	nmap <Leader>f<S-Tab>       <Plug>TabbyExpandA
	nmap <Leader><S-Tab><S-Tab> <Plug>TabbyExpandL
	nmap <Leader><S-Tab>        <Plug>TabbyExpandM
	xmap <Leader><S-Tab>        <Plug>TabbyExpandV

	nmap <F3> 4,<S-Tab>ip:messages<cr>

	" nmap <Leader>f<Tab>         <Plug>TabbyUnexpandA
	" nmap <Leader><Tab><Tab>     <Plug>TabbyUnexpandL
	" nmap <Leader><Tab>          <Plug>TabbyUnexpandM
	" xmap <Leader><Tab>          <Plug>TabbyUnexpandV
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
	execute 'xnoremap <leader><space><tab>          :s/<space>\+<tab>/<tab>/e<cr>'

	" visual delete lines
	execute 'xnoremap <leader><space><space>        :SQUASH DUPE BLANK LINES'
	execute 'xnoremap <leader><space><enter>        :g/^\s*$/de<cr>'

	" manipulate tabs
	execute 'xnoremap <leader><tab>                 :TAB UNEXPAND'
	execute 'xnoremap <leader><s-tab>               :TAB EXPAND'
endfunction


" call <SID>tabby_mappings()
" set list

let s:scope_list = { 'a': 'argdo', 'b': 'bufdo', 'f': '', 'w': 'windo' }

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
		let cmd = a:start . ',' . a:stop
	endif

	let cmd .= 's/^\s\+//e'
	execute cmd
endfunction

function! s:translate (func)
	execute 'setlocal operatorfunc=' . a:func
	if (v:count == 0)
		return 'g@'
	else
		return 'g@g@'
	endif
endfunction

function! SpaceLeadingMap (...)
	nnoremap <expr> <Plug>SpaceLeadingM <SID>translate ('SpaceLeading')
	nnoremap        <Plug>SpaceLeadingL :<C-U>call SpaceLeading (line ('.'),  line ('.'))<CR>
	xnoremap        <Plug>SpaceLeadingV :<C-U>call SpaceLeading (line ("'<"), line ("'>"))<CR>
	nnoremap        <Plug>SpaceLeadingA :<C-U>call SpaceLeading ('a')<CR>
	nnoremap        <Plug>SpaceLeadingB :<C-U>call SpaceLeading ('b')<CR>
	nnoremap        <Plug>SpaceLeadingF :<C-U>call SpaceLeading ('f')<CR>
	nnoremap        <Plug>SpaceLeadingW :<C-U>call SpaceLeading ('w')<CR>
endfunction

function! SpaceTrailing (...)
endfunction

function! SpaceError (...)
endfunction

function! SpaceSurround (...)
endfunction

function! EmptyLinesSqueeze (...)
endfunction

function! EmptyLinesDelete (...)
endfunction

function! BlankLinesTop (...)
endfunction

function! BlankLinesBottom (...)
endfunction

function! TabsSpaces (...)
endfunction

function! SpacesTabs (...)
endfunction


nmap <Leader><space>ll  <Plug>SpaceLeadingM
nmap <Leader><space>l   <Plug>SpaceLeadingL
xmap <Leader><space>l   <Plug>SpaceLeadingV
nmap <Leader>a<space>l  <Plug>SpaceLeadingA
nmap <Leader>b<space>l  <Plug>SpaceLeadingB
nmap <Leader>f<space>l  <Plug>SpaceLeadingF
nmap <Leader>w<space>l  <Plug>SpaceLeadingW

