" color Tomorrow-Night
color codeschool
" set guifont=Monaco\ 13
" set guifont=Source\ Code\ Pro\ Medium\ 12.7
set guifont=Source\ Code\ Pro\ for\ Powerline\ Medium\ 12.7
" set guifont=Source\ Code\ Pro\ Medium\ 13
set linespace=1

set guioptions-=T " Removes top toolbar
set guioptions-=r " Removes right hand scroll bar
set go-=L " Removes left hand scroll bar

" Permite brincar a secciones de la documentacion PHP 3K
" autocmd filetype php nnoremap <buffer> K :<C-U>exe "Man" v:count "<C-R><C-W>"<CR>

" Abrir NERDTree al iniciar GVim
" autocmd vimenter * NERDTree

function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction

autocmd VimEnter * call StartUp()
autocmd VimEnter * wincmd p

" Guardar con Ctrl+S
nmap <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>

" Move entire line up and down (Bubble effect)
" Alt+j = ê   Alt+k = ë
nnoremap ê :m+<CR>==
nnoremap ë :m-2<CR>==
inoremap ê <Esc>:m+<CR>==gi
inoremap ë <Esc>:m-2<CR>==gi
vnoremap ê :m'>+<CR>gv=gv
vnoremap ë :m-2<CR>gv=gv

