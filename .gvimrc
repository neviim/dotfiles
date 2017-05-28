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
nnoremap <C-LeftMouse> :YcmCompleter GoTo<Cr>
inoremap <C-LeftMouse> <Esc>:YcmCompleter GoTo<Cr>

" Blink block and line on insert
" set guicursor=n-v-c:block-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
" Block in all modes
" set guicursor=n-v-c:block-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:block-Cursor/lCursor,r-cr:hor20-Cursor/lCursor,sm:block-Cursor,a:blinkon0

"colorscheme spacegray
autocmd VimEnter * Thematic codeschool
