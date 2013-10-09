" Default key mappings

" Command mode
cmap <C-A> <Home>
cmap <C-B> <S-Left>
cmap <C-F> <S-Right>

" Tab between windows
nmap <Tab> <C-W><C-W>

" Quit, now
nmap <silent> Q :update<BAR>quit<CR>

" Double-click to open/close folds
map <2-LeftMouse> za

" Find common items
nmap <silent> <leader>c	:silent! call findme#Constructor()<CR>
nmap <silent> <leader>d	:silent! call findme#Destructor()<CR>
nmap <silent> <leader>i	:silent! call findme#Include()<CR>
nmap <silent> <leader>h :silent! call swapfile#SwapFile()<CR>
nmap <silent> <leader>H :silent! vsplit<Bar>call swapfile#SwapFile()<CR>
nmap <silent> <leader>m :call make#RichMake()<CR>
nmap <silent> <leader>t :silent! tabedit docs/todo.txt<CR>G
nmap <silent> <leader>l :ls<CR>

nmap <silent> <leader>fc :silent! call function#CommentBlock()<CR>
nmap <silent> <leader>fp :silent! call function#CopyrightBlock()<CR>
nmap <silent> <leader>fi :silent! call function#IncludeGuard()<CR>

" open tag in new window
nnoremap <C-W>] :vsplit<CR><C-]>zv

" F8 - Switch between .c and .h
nmap <silent> <F3>	:let &laststatus = 2-&laststatus<CR>
nmap          <F4>	:call tagsrotate#TagsRotate()<CR>
nmap          <F6>	zmzv
nmap          <F7>	zr
nmap <silent> <F10>	:cnext<CR>zvzz
nmap <silent> <F11>	:cc<CR>zvzz
nmap <silent> <F12>	:cwindow 5<CR>

" Shift-F1-F4 are a bit wonky
" S-F5: create some temp space
nmap          <Esc>O1;2Q	:set paste!<Bar>:set paste?<CR>
nmap          <Esc>O1;2R	:set ruler!<CR><C-L>
nmap <silent> <S-F5>		:vnew<CR>:set buftype=nofile bufhidden=delete<CR>
nmap          <S-F6>		:tabs<CR>
nmap          <S-F7>		:tabclose<CR>
nmap          <S-F8>		:tabnew<Space>

" C-Up/Down Scroll Window
nmap <Esc>[1;5A <C-Y>
nmap <Esc>[1;5B <C-E>
imap <Esc>[1;5A <C-O><C-Y>
imap <Esc>[1;5B <C-O><C-E>

" Shift-Up/Down Scroll Window
nmap <Esc>[1;2A <C-Y>
nmap <Esc>[1;2B <C-E>
imap <Esc>[1;2A <C-O><C-Y>
imap <Esc>[1;2B <C-O><C-E>

" Previous/Next match for command
cmap <C-P> <Up>
cmap <C-N> <Down>

" Make horizontal scrolling easier
nmap <silent> <C-Left>  8zh
nmap <silent> <C-Right> 8zl

" Alright... let's try this out
imap jj <esc>
cmap jj <esc>

" Only mapping
nmap <silent> <Leader>o :only<CR>

" Update diff markings
nmap <Leader>u :diffupdate<CR>

" Make the current file executable
nmap ,x :w<cr>:!chmod +x %<cr>:e<cr>

" #ifdef 0
vmap <Leader>0 :call ifzero#IfZero()<CR>

source ~/.vim/defmap_file.vim
source ~/.vim/defmap_file_bufdo.vim
source ~/.vim/defmap_file_argdo.vim
source ~/.vim/defmap_file_windo.vim

