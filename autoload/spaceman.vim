let s:scope_list = { 'a': 'argdo', 'b': 'bufdo', 'f': '', 'w': 'windo' }

function! spaceman#DeleteTopBlankLines (scope)
	let cmd = s:scope_list[a:scope] . ' %'
	let cmd .= 's/\v\%^\_s*\n//e'
	execute cmd
endfunction

function! spaceman#DeleteBottomBlankLines (scope)
	let cmd = s:scope_list[a:scope] . ' %'
	let cmd .= 's/\v\n\_s*\%$//e'
	execute cmd
endfunction

function! spaceman#DeleteEmptyLines (...)
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

function! spaceman#SqueezeEmptyLines (...)
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

function! spaceman#DeleteSpaceError (...)
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

function! spaceman#DeleteLeadingSpace (...)
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

function! spaceman#DeleteTrailingSpace (...)
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

function! spaceman#ConvertSpacesToTabs (...)
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

function! spaceman#ConvertTabsToSpaces (...)
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

function! s:surround_with_space_words (begin, end, count)
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

function! s:surround_with_space_block()
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

function! spaceman#SurroundWithSpaceLine (begin, end, count)
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

function! spaceman#SurroundWithSpaceVisual (...)
	let vm = visualmode()
	if (vm ==# 'V')
		call spaceman#SurroundWithSpaceLine(line ("'<"), line ("'>"), v:count1)
	elseif (vm ==# 'v')
		call s:surround_with_space_words(getpos ("'<"), getpos ("'>"), v:count1)
	else
		call s:surround_with_space_block()
	endif
endfunction

function! spaceman#SurroundWithSpaceMotion (...)
	if (a:1 == 'line')
		call spaceman#SurroundWithSpaceLine (line ("'["), line ("']"), 1)
	elseif (a:1 == 'char')
		call s:surround_with_space_words (getpos ("'["), getpos ("']"), 1)
	else
		" Ignore block mode
	endif
endfunction


