" colorscheme codeschool
colorscheme Tomorrow-Night
" set guifont=Monaco\ for\ Powerline:h15
set guifont=Sauce\ Code\ Powerline:h16
" set guifont=Menlo\ Regular:h15
set linespace=1

set guioptions-=T " Removes top toolbar
set guioptions-=r " Removes right hand scroll bar
set go-=L " Removes left hand scroll bar

" Enables hardtime
let g:hardtime_ignore_buffer_patterns = [ "NERD.*" ]
let g:hardtime_default_on = 1
let g:hardtime_allow_different_key = 1

" Permite brincar a secciones de la documentacion PHP 3K
" autocmd filetype php nnoremap <buffer> K :<C-U>exe "Man" v:count "<C-R><C-W>"<CR>

" Abrir NERDTree al iniciar GVim
" autocmd vimenter * NERDTree

" function! StartUp()
"     if 0 == argc()
"         if getcwd() == expand('~')
"             NERDTree ~/Documents
"         else
"             NERDTree
"         endif
"     else
"         if argv(0) == '.'
"             execute 'NERDTree' getcwd()
"         else
"             execute 'NERDTree' getcwd() . '/' . argv(0)
"         endif
"     endif
" endfunction
" 
" autocmd VimEnter * call StartUp()
" autocmd VimEnter * wincmd p

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

