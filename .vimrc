set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" My Plugins here:
" use :PluginInstall in vim for installing
" original repos on github
Plugin 'docunext/closetag.vim'
Plugin 'StanAngeloff/php.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'vim-scripts/ScrollColors'
Plugin 'SirVer/ultisnips'
Plugin 'ZzAntares/vim-snippets'  " Mis snippets fork de honza/vim-snippets
Plugin 'jiangmiao/auto-pairs'  " Auto cierra parentesis y otros symbolos en pares
Plugin 'tpope/vim-sleuth'  " Detecta la identación automaticamente
Plugin 'airblade/vim-gitgutter'  " git diff en el buffer
Plugin 'tpope/vim-surround'  " Cambia, agrega o elimina lo que encierra una palabra.
Plugin 'vim-scripts/CSApprox'  " Adapta los colorschemes de gvim a vim terminal
Plugin 'vim-scripts/bufkill.vim'  " Permite cerrar buffers sin que vim salga
Plugin 'altercation/vim-colors-solarized'  " Instala solarized colorscheme
Plugin 'powerman/vim-plugin-viewdoc'  " Documentacion para varios lenguajes
Plugin 'tpope/vim-fugitive'  " Git para vim
Plugin 'bling/vim-bufferline'  " Muestra los buffers abiertos en la barra de estado
Plugin 'bling/vim-airline'  " Una barra de status mejor
Plugin 'Valloric/YouCompleteMe'  " Auto code complete
Plugin 'sheerun/vim-polyglot'  " Soporte para mejorar la syntaxis de varios lenguajes incluye blade
Plugin 'wikitopian/hardmode'  " Deshabilita el homerow
" Plugin 'xsbeats/vim-blade'  " Soporte para blade php
" Plugin 'jistr/vim-nerdtree-tabs'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" permite que % tambien salte entre etiqutas en html
runtime macros/matchit.vim


set number
syntax on
set autoread " Automatically reload changes if detected
set ruler

" Highlight on overlenght
if exists('+colorcolumn')
  set colorcolumn=81  " Agrega un ruler para 80 chars

  " El ruler en java debe ser mas permisivo
  autocmd FileType java setlocal colorcolumn=100

  highlight link OverLength ColorColumn
  highlight ColorColumn ctermbg=233
  exec 'match OverLength /\%'.&cc.'v.\+/'
endif

set encoding=utf8

set nobackup    " No backup files
set noswapfile  " No swap file

" El plugin tpope/vim-sleuth soluciona el tema de la identacion.
" set smartindent
" set tabstop=4  " El TAB mide 4 espacios
" set softtabstop=4
" set shiftwidth=4 " Cuando borres identacion o insertes seran 4 espacios
" set expandtab " El TAB son espacios en realidad

set hidden  " Cambia de buffer sin haber guardado los otros
set hlsearch  "Highlight searching

" set t_Co=256  " Habilitarlo cuando se quieran otros colorschemes
colorscheme Tomorrow-Night

set list
noremap <leader>l :set list!<CR> 

" Permite ver los manpages en una nueva ventana
" runtime ftplugin/man.vim
" autocmd Filetype sh nnoremap K :Man <cword><CR>
" autocmd Filetype php nnoremap <buffer> K :Man --manpath=/usr/share/php/docs/pman/ <cword><CR>

" Auto formaters
autocmd Filetype gitcommit setlocal spell textwidth=72 formatoptions+=t colorcolumn=73
autocmd Filetype markdown setlocal spell textwidth=80 formatoptions+=t colorcolumn=81

" Enable HardMode for practicing
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

" Cambia los caracteres por default para los tabs y fin de lineas
set listchars=tab:▸\ ,eol:¬

" Cambia el escape a jk para más rapidez
imap kj <Esc>

" Cierra VIM cuando NERDTree es la unica ventana activa
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Cambia el CWD a donde este el root de NERDTree
let g:NERDTreeChDirMode=2

" El primero es visible en todas las tabs, el segundo solo en la que se usa
" map <F2> :NERDTreeTabsToggle<CR>
map <F2> :NERDTreeToggle<CR>
map <C-h> :tabp<CR>
map <C-l> :tabn<CR>

" Agrega salto de linea en donde esta el cursor, a veces no es posible r<CR>
nmap <CR> i<CR><Esc>k

" Permite seleccionar texto despues de pegar
nnoremap <expr> gV "`[".getregtype(v:register)[0]."`]"

" Busqueda Ctrl + p
nmap <Space> <C-p>

" Disables arrow keys
" inoremap <Up> <NOP>
" inoremap <Down> <NOP>
" inoremap <Left> <NOP>
" inoremap <Right> <NOP>
" noremap <Up> <NOP>
" noremap <Down> <NOP>
" noremap <Left> <NOP>
" noremap <Right> <NOP>
" 
" " Disables l and h for training mode
" noremap l <NOP>
" noremap h <NOP>

" Cambia entre numero de linas realtivas o absolutas
nnoremap <silent><leader>ñ :set relativenumber!<cr>

" Buffer control screen-mode
map <C-a>n :bnext<CR>
map <C-a>p :bprevious<CR>
map <C-a>a <C-^>
map <C-a>d :q<CR>
map <C-a>k :BD<CR>

" tell eclim to register its completion to vim's omni complete, YCM lo usa
let g:EclimCompletionMethod = 'omnifunc'

" Cierra la ventana de preview cuando se completa una palabra o cuando se deja
" el modo de inserccion
let g:ycm_autoclose_preview_window_after_insertion = 1
" let g:ycm_autoclose_preview_window_after_completion = 1

" No quiero ver la lista de buffers en la linea de comandos
let g:bufferline_echo = 0

" Muestra simbolos bonitos en la barra de estado vim-airline
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_inactive_collapse = 1
let g:airline_exclude_filetypes = ['nerdtree']
let g:airline_exclude_preview = 0

" Recarga el .vimrc cuando se edita
" autocmd bufwritepost .vimrc source $MYVIMRC

" Set tabstop, softtabstop and shiftwidth to the same value con :Stab
command! -nargs=* Stab call Stab(<f-args>)
function! Stab(...)
  if a:0 > 0
    let l:tabstop = a:1
  else
    let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  endif
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

" =================================== Handle conflicts between YCM and UltiSnips
let g:UltiSnipsExpandTrigger="<Tab>"

function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"

let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
let g:UltiSnipsListSnippets="<C-e>"
let g:UltiSnipsEditSplit="horizontal"

" this mapping Enter key to <C-y> to chose the current highlight item 
" and close the selection list, same as other IDEs.
" CONFLICT with some plugins like tpope/Endwise
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" ==============================================================================

