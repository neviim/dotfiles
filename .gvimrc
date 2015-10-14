" colorscheme codeschool
" colorscheme Tomorrow-Night

" set guifont=Monaco\ Plus\ Nerd\ File\ Types:h15
" set guifont=Monaco\ for\ Powerline\ Plus\ Nerd\ File\ Types:h15
" set guifont=Monaco\ for\ Powerline:h15
" set guifont=Sauce\ Code\ Powerline:h16
" set guifont=Menlo\ Regular:h15
set linespace=3

set guioptions-=T " Removes top toolbar
set guioptions-=r " Removes right hand scroll bar
set go-=L " Removes left hand scroll bar

" let background=dark
" colorscheme material-theme

" Enables hardtime
let g:hardtime_ignore_buffer_patterns = [ "NERD.*" ]
let g:hardtime_default_on = 1
let g:hardtime_allow_different_key = 1

" set guicursor=n-v-c:block-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
set guicursor=n-v-c:block-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:block-Cursor/lCursor,r-cr:hor20-Cursor/lCursor,sm:block-Cursor,a:blinkon0

" Guardar con Ctrl+S
nmap <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>

" Move entire line up and down (Bubble effect)
" Alt+j = ê   Alt+k = ë
nnoremap <C-j> :m+<CR>==
nnoremap <C-k> :m-2<CR>==
inoremap <C-j> <Esc>:m+<CR>==gi
inoremap <C-k> <Esc>:m-2<CR>==gi
vnoremap <C-j> :m'>+<CR>gv=gv
vnoremap <C-k> :m-2<CR>gv=gv

