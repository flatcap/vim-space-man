" Pipe into command
nmap <Leader>b1 :bufdo %!<Space>
vmap <Leader>b1 :bufdo !<Space>

" Strip the first two characters off each line -- useful for find(1) output
nmap <Leader>b2 :bufdo %s/^..//<CR>
vmap <Leader>b2 :bufdo s/^..//<CR>

" End of line
nmap <Leader>b4 :bufdo %s/$//<Left>
vmap <Leader>b4 :bufdo s/$//<Left>

" All of selection/file
nmap <Leader>b5 :bufdo %s/
vmap <Leader>b5 :bufdo s/

" Start of line
nmap <Leader>b6 :bufdo %s/^
vmap <Leader>b6 :bufdo s/^

" Everything
nmap <Leader>b8 :bufdo %s/.*//<Left>
vmap <Leader>b8 :bufdo s/.*//<Left>

" Strip leading path component
nmap <Leader>b/ :bufdo %s!^[^/]*/*!!<CR>
vmap <Leader>b/ :bufdo s!^[^/]*/*!!<CR>

" Pipe into:bufdo  sort, sort -R (random), uniq, grep, column -t
nmap <Leader>bpb :bufdo %!LANG=C rev<CR>
nmap <Leader>bpc :bufdo %!LANG=C column -t<CR>
nmap <Leader>bpg :bufdo %!LANG=C grep<Space>""<Left>
nmap <Leader>bpn :bufdo %!LANG=C nl -nrz -w4<CR>
nmap <Leader>bpr :bufdo %!LANG=C sort -R<CR>
nmap <Leader>bps :bufdo %!LANG=C sort -f<CR>
nmap <Leader>bpt :bufdo %!LANG=C tac<CR>
nmap <Leader>bpu :bufdo %!LANG=C uniq<CR>

vmap <Leader>bpb :bufdo !LANG=C rev<CR>
vmap <Leader>bpc :bufdo !LANG=C column -t<CR>
vmap <Leader>bpg :bufdo !LANG=C grep<Space>""<Left>
vmap <Leader>bpn :bufdo !LANG=C nl -nrz -w4<CR>
vmap <Leader>bpr :bufdo !LANG=C sort -R<CR>
vmap <Leader>bps :bufdo !LANG=C sort -f<CR>
vmap <Leader>bpt :bufdo !LANG=C tac<CR>
vmap <Leader>bpu :bufdo !LANG=C uniq<CR>

" Delete whitespace:bufdo  Leading 6^, Trailing 4$, Before Tab <Tab>, Blank lines <Enter>
nmap <Leader>b<Space>4       :bufdo %s/\s\+$//e<CR>
nmap <Leader>b<Space>6       :bufdo %s/^\s\+//e<CR>
nmap <Leader>b<Space><Enter> :bufdo %g/^\s*$/de<CR>
nmap <Leader>b<Space><Tab>   :bufdo %s/<Space>\+<Tab>/<Tab>/e<CR>

vmap <Leader>b<Space>4       :bufdo s/\s\+$//e<CR>
vmap <Leader>b<Space>6       :bufdo s/^\s\+//e<CR>
vmap <Leader>b<Space><Enter> :bufdo g/^\s*$/de<CR>
vmap <Leader>b<Space><Tab>   :bufdo s/<Space>\+<Tab>/<Tab>/e<CR>

