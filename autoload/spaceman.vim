let s:scope_list = { 'a': 'argdo', 'b': 'bufdo', 'f': '', 'w': 'windo' }

function! spaceman#BlankLinesTop (scope)
	let cmd = s:scope_list[a:scope] . ' %'
	let cmd .= 's/\v\%^\_s*\n//e'
	execute cmd
endfunction

function! spaceman#BlankLinesBottom (scope)
	let cmd = s:scope_list[a:scope] . ' %'
	let cmd .= 's/\v\n\_s*\%$//e'
	execute cmd
endfunction

function! spaceman#EmptyLinesDelete (...)
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

	let cmd .= 's/\v^\s*$\n//e'
	execute cmd
endfunction

function! spaceman#EmptyLinesSqueeze (...)
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

	let cmd .= 's/\v((^\s*\n){2,}|(\_s*%$))/\r/e'
	execute cmd
endfunction

function! spaceman#SpaceError (...)
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

function! spaceman#SpaceLeading (...)
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

function! spaceman#SpaceTrailing (...)
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

function! spaceman#SpacesTabs (...)
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

	let cmd .= '!unexpand --first-only --tabs ' . v:count1
	execute cmd
endfunction

function! spaceman#TabsSpaces (...)
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

function! spaceman#SpaceSurroundLine (begin, end, count)
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

function! spaceman#SpaceSurroundVisual (...)
	let vm = visualmode()
	if (vm ==# 'V')
		call spaceman#SpaceSurroundLine(line ("'<"), line ("'>"), v:count1)
	elseif (vm ==# 'v')
		call s:space_surround_words(getpos ("'<"), getpos ("'>"), v:count1)
	else
		call s:space_surround_block()
	endif
endfunction

function! spaceman#SpaceSurroundMotion (...)
	if (a:1 == 'line')
		call spaceman#SpaceSurroundLine (line ("'["), line ("']"), 1)
	elseif (a:1 == 'char')
		call s:space_surround_words (getpos ("'["), getpos ("']"), 1)
	else
		" Ignore block mode
	endif
endfunction


