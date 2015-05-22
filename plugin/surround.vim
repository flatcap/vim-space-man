function! s:translate (func)
	echom visualmode()
	execute 'setlocal operatorfunc=' . a:func
	if (v:count == 0)
		return 'g@'
	else
		return 'g@g@'
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

function! SpaceSurroundWords (begin, end, count)
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

function! SpaceSurroundBlock()
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
	" echo vm getpos ('.')
	if (vm ==# 'V')
		call SpaceSurroundLine(line ("'<"), line ("'>"), v:count1)
	elseif (vm ==# 'v')
		call SpaceSurroundWords(getpos ("'<"), getpos ("'>"), v:count1)
	else
		call SpaceSurroundBlock()
	endif
endfunction

function! SpaceSurroundMotion (...)
	if (a:1 == 'line')
		call SpaceSurroundLine (line ("'["), line ("']"), 1)
	elseif (a:1 == 'char')
		call SpaceSurroundWords (getpos ("'["), getpos ("']"), 1)
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
			nmap <Leader>ss <Plug>SpaceSurroundL
			nmap <Leader>s  <Plug>SpaceSurroundM
			xmap <Leader>s  <Plug>SpaceSurroundV
		endif
	endif
endfunction


call s:space_surround_map()

