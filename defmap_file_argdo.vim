" Pipe into command
nmap <Leader>a1 :argdo %!<Space>
vmap <Leader>a1 :argdo !<Space>

" Strip the first two characters off each line -- useful for find(1) output
nmap <Leader>a2 :argdo %s/^..//<CR>
vmap <Leader>a2 :argdo s/^..//<CR>

" End of line
nmap <Leader>a4 :argdo %s/$//<Left>
vmap <Leader>a4 :argdo s/$//<Left>

" All of selection/file
nmap <Leader>a5 :argdo %s/
vmap <Leader>a5 :argdo s/

" Start of line
nmap <Leader>a6 :argdo %s/^
vmap <Leader>a6 :argdo s/^

" Everything
nmap <Leader>a8 :argdo %s/.*//<Left>
vmap <Leader>a8 :argdo s/.*//<Left>

" Strip leading path component
nmap <Leader>a/ :argdo %s!^[^/]\+/*!!<CR>
vmap <Leader>a/ :argdo s!^[^/]\+/*!!<CR>

" Pipe into:argdo  sort, sort -R (random), uniq, grep, column -t
nmap <Leader>apc :argdo %!LANG=C column -t<CR>
nmap <Leader>apg :argdo %!LANG=C grep<Space>""<Left>
nmap <Leader>apr :argdo %!LANG=C sort -R<CR>
nmap <Leader>aps :argdo %!LANG=C sort -f<CR>
nmap <Leader>apu :argdo %!LANG=C uniq<CR>

vmap <Leader>apc :argdo !LANG=C column -t<CR>
vmap <Leader>apg :argdo !LANG=C grep<Space>""<Left>
vmap <Leader>apr :argdo !LANG=C sort -R<CR>
vmap <Leader>aps :argdo !LANG=C sort -f<CR>
vmap <Leader>apu :argdo !LANG=C uniq<CR>

" Delete whitespace:argdo  Leading 6^, Trailing 4$, Before Tab <Tab>, Blank lines <Enter>
nmap <Leader>a<Space>4       :argdo %s/\s\+$//e<CR>
nmap <Leader>a<Space>6       :argdo %s/^\s\+//e<CR>
nmap <Leader>a<Space><Enter> :argdo %g/^\s*$/de<CR>
nmap <Leader>a<Space><Tab>   :argdo %s/<Space>\+<Tab>/<Tab>/e<CR>

vmap <Leader>a<Space>4       :argdo s/\s\+$//e<CR>
vmap <Leader>a<Space>6       :argdo s/^\s\+//e<CR>
vmap <Leader>a<Space><Enter> :argdo g/^\s*$/de<CR>
vmap <Leader>a<Space><Tab>   :argdo s/<Space>\+<Tab>/<Tab>/e<CR>

