" Pipe into command
nmap <Leader>1 :%!<Space>
vmap <Leader>1 :!<Space>

" Strip the first two characters off each line -- useful for find(1) output
nmap <Leader>2 :%s/^..//<CR>
vmap <Leader>2 :s/^..//<CR>

" End of line
nmap <Leader>4 :%s/$//<Left>
vmap <Leader>4 :s/$//<Left>

" All of selection/file
nmap <Leader>5 :%s/
vmap <Leader>5 :s/

" Start of line
nmap <Leader>6 :%s/^
vmap <Leader>6 :s/^

" Everything
nmap <Leader>8 :%s/.*//<Left>
vmap <Leader>8 :s/.*//<Left>

" Strip leading path component
nmap <Leader>/ :%s!^[^/]\+/*!!<CR>
vmap <Leader>/ :s!^[^/]\+/*!!<CR>

" Pipe into: sort, sort -R (random), uniq, grep, column -t
nmap <Leader>pc :%!LANG=C column -t<CR>
nmap <Leader>pg :%!LANG=C grep<Space>""<Left>
nmap <Leader>pr :%!LANG=C sort -R<CR>
nmap <Leader>ps :%!LANG=C sort -f<CR>
nmap <Leader>pu :%!LANG=C uniq<CR>

vmap <Leader>pc :!LANG=C column -t<CR>
vmap <Leader>pg :!LANG=C grep<Space>""<Left>
vmap <Leader>pr :!LANG=C sort -R<CR>
vmap <Leader>ps :!LANG=C sort -f<CR>
vmap <Leader>pu :!LANG=C uniq<CR>

" Delete whitespace: Leading 6^, Trailing 4$, Before Tab <Tab>, Blank lines <Enter>
nmap <Leader><Space>4       :%s/\s\+$//e<CR>
nmap <Leader><Space>6       :%s/^\s\+//e<CR>
nmap <Leader><Space><Enter> :%g/^\s*$/de<CR>
nmap <Leader><Space><Tab>   :%s/<Space>\+<Tab>/<Tab>/e<CR>

vmap <Leader><Space>4       :s/\s\+$//e<CR>
vmap <Leader><Space>6       :s/^\s\+//e<CR>
vmap <Leader><Space><Enter> :g/^\s*$/de<CR>
vmap <Leader><Space><Tab>   :s/<Space>\+<Tab>/<Tab>/e<CR>

