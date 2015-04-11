
function! s:MakeMappings(map, command)
	let s:cmd = a:command
	if (!empty (s:cmd))
		let s:cmd .= ' '
	endif

	" Pipe into command
	execute 'nmap <Leader>'.a:map.'1 :'.s:cmd.'%!<Space>'
	execute 'vmap <Leader>'.a:map.'1 :'.s:cmd.'!<Space>'

	" Strip the first two characters off each line -- useful for find(1) output
	execute 'nmap <Leader>'.a:map.'2 :'.s:cmd.'%s/^..//<CR>'
	execute 'vmap <Leader>'.a:map.'2 :'.s:cmd.'s/^..//<CR>'

	" End of line
	execute 'nmap <Leader>'.a:map.'4 :'.s:cmd.'%s/$//<Left>'
	execute 'vmap <Leader>'.a:map.'4 :'.s:cmd.'s/$//<Left>'

	" All of selection/file
	execute 'nmap <Leader>'.a:map.'5 :'.s:cmd.'%s/\v'
	execute 'vmap <Leader>'.a:map.'5 :'.s:cmd.'s/\v'

	" Start of line
	execute 'nmap <Leader>'.a:map.'6 :'.s:cmd.'%s/^/'
	execute 'vmap <Leader>'.a:map.'6 :'.s:cmd.'s/^/'

	" Everything
	execute 'nmap <Leader>'.a:map.'8 :'.s:cmd.'%s/.*//<Left>'
	execute 'vmap <Leader>'.a:map.'8 :'.s:cmd.'s/.*//<Left>'

	" Pipe into grep
	execute 'nmap <Leader>'.a:map.'pg :'.s:cmd.'%!LANG=C grep<Space>""<Left>'
	execute 'vmap <Leader>'.a:map.'pg :'.s:cmd.'!LANG=C grep<Space>""<Left>'

	" Delete whitespace: Leading 6^, Trailing 4$, Before Tab <Tab>, Blank lines <Enter>
	execute 'nmap <Leader>'.a:map.'<Space>4       :'.s:cmd.'%s/\(\s\\|\%x0d\)\+$//e<CR>'
	execute 'nmap <Leader>'.a:map.'<Space>6       :'.s:cmd.'%s/^\s\+//e<CR>'
	execute 'nmap <Leader>'.a:map.'<Space><Enter> :'.s:cmd.'%g/^\s*$/de<CR>'
	execute 'nmap <Leader>'.a:map.'<Space><Tab>   :'.s:cmd.'%s/<Space>\+<Tab>/<Tab>/e<CR>'

	execute 'vmap <Leader>'.a:map.'<Space>4       :'.s:cmd.'s/\s\+$//e<CR>'
	execute 'vmap <Leader>'.a:map.'<Space>6       :'.s:cmd.'s/^\s\+//e<CR>'
	execute 'vmap <Leader>'.a:map.'<Space><Enter> :'.s:cmd.'g/^\s*$/de<CR>'
	execute 'vmap <Leader>'.a:map.'<Space><Tab>   :'.s:cmd.'s/<Space>\+<Tab>/<Tab>/e<CR>'
endfunction

call s:MakeMappings('',   '')	" bare mappings first
call s:MakeMappings('a', 'argdo')
call s:MakeMappings('b', 'bufdo')
call s:MakeMappings('w', 'windo')

