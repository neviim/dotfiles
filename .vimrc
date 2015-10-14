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
Plugin 'sheerun/vim-polyglot'  " Soporte para mejorar la syntaxis de varios lenguajes incluye blade
Plugin 'takac/vim-hardtime'  " Enables practice mode
Plugin 'vim-scripts/BufOnly.vim'  " Allow to close all buffers but current
Plugin 'tkztmk/vim-vala'  " vala vim support
Plugin 'szw/vim-tags'  " exhuberant ctags mannager
Plugin 'Valloric/YouCompleteMe'  " A well know completion engine
Plugin 'Shougo/vimproc.vim' " dependency for vimshell
Plugin 'Shougo/vimshell.vim' " shell inside vim
Plugin 'ryanoasis/vim-webdevicons' " Pretty icons for nerdtree
Plugin 'ZzAntares/vim-laravel'
Plugin 'jdkanani/vim-material-theme'  " Material design theme
Plugin 'NLKNguyen/papercolor-theme'  " Paper color theme based on material
Plugin 'reedes/vim-thematic'  " Theme management via presets
Plugin 'tpope/vim-dispatch'  " run asynchronously
Plugin 'mileszs/ack.vim'  " Wrapper para ack
Plugin 'shawncplus/phpcomplete.vim'  " overloading happening even without this

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
  autocmd FileType java setlocal colorcolumn=101

  highlight link OverLength ColorColumn
  highlight ColorColumn ctermbg=233
  exec 'match OverLength /\%'.&cc.'v.\+/'
endif

set encoding=utf8

set nobackup    " No backup files
set noswapfile  " No swap file

" Natural splitting
set splitbelow
" set splitright

set hidden  " Cambia de buffer sin haber guardado los otros
set hlsearch  " Highlight searching
set incsearch  " Jump to match while typing
set ignorecase  " search case insensitive
set smartcase  " case sensitive when using caps
set visualbell  " don't beep
set noerrorbells  " don't beep

" set t_Co=256  " Habilitarlo cuando se quieran otros colorschemes
" colorscheme Tomorrow-Night

set background=dark
colorscheme PaperColor

set list
noremap <leader>l :set list!<CR> 

" Permite ver los manpages en una nueva ventana
" source $VIMRUNTIME/ftplugin/man.vim
runtime ftplugin/man.vim
" autocmd Filetype sh nnoremap K :Man <cword><CR>
autocmd Filetype php setlocal keywordprg=pman
" autocmd Filetype php nnoremap <buffer> K :Man --manpath=/usr/local/pear/docs/pman/man3 <cword><CR>

" Auto formaters
autocmd Filetype gitcommit setlocal spell textwidth=72 formatoptions+=t colorcolumn=73
autocmd Filetype markdown setlocal spell textwidth=80 formatoptions+=t colorcolumn=81
autocmd Filetype html setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype js setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype css setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype eruby setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype blade setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype php setlocal textwidth=80 formatoptions+=t colorcolumn=81
autocmd Filetype python setlocal textwidth=79 formatoptions+=t colorcolumn=80

" Spelling languages map
nmap <silent> <leader>ss :set spelllang=es<CR>
nmap <silent> <leader>se :set spelllang=en<CR>

" Move cursor naturally
nmap j gj
nmap k gk

" Attemp to fix misspelling
nmap <silent> <leader>fs 1z=

" Fugitive maps
nmap <leader>gs :Gstatus<CR>

" Gdiff defaults to vertical split
set diffopt+=vertical

" Cambia los caracteres por default para los tabs y fin de lineas
set listchars=tab:▸\ ,eol:¬

" Habilita el statusline haciendo posible ver vim-airline
set laststatus=2

" Cambia el escape a jk para más rapidez
imap kj <Esc>

" Cierra VIM cuando NERDTree es la unica ventana activa
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Cambia el CWD a donde este el root de NERDTree
let g:NERDTreeChDirMode=2

" Abrir NERDTree con doble <Tab>
map <Tab><Tab> :NERDTreeToggle<CR>

" Buffer control
map <C-h> :bprevious<CR>
map <C-l> :bnext<CR>
map <C-a>a <C-^>
map <C-a>d :q<CR>
map <C-a>k :BD<CR>
map <C-a>c :BufOnly<CR>

" Close man pages with Ctrl+d q
autocmd Filetype help,man,pman map <buffer> <C-a>d q

" Tab control screen-mode
map <C-a>n :tabn<CR>
map <C-a>p :tabp<CR>

" Agrega salto de linea en donde esta el cursor, a veces no es posible r<CR>
nmap <CR> i<CR><Esc>k

" Permite seleccionar texto despues de pegar
nnoremap <expr> gV "`[".getregtype(v:register)[0]."`]"

" Busqueda Ctrl + p
" let g:ctrlp_map = '<C-Space>'

" Cambia entre numero de linas realtivas o absolutas
nnoremap <silent><leader>r :set relativenumber!<cr>

let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:WebDevIconsUnicodeDecorateFolderNodeDefaultSymbol = ' '

" 
" " vim-webdevicons colors
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#9bddff', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'blue', 'none', '#8ecded', '#151515')

" No quiero ver la lista de buffers en la linea de comandos
let g:bufferline_echo = 0

" Airline
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
let g:airline_theme='molokai'

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

" UltiSnips completion function that tries to expand a snippet. If there's no
" snippet for expanding, it checks for completion window and if it's
" shown, selects first element. If there's no completion window it tries to
" jump to next placeholder. If there's no placeholder it just returns TAB key 
function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<Tab>"
            endif
        endif
    endif
    return ""
endfunction

" Intercepts YMC mappings so Ultisnips and YMC can work with the above function.
au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"

" UltiSnips
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
let g:UltiSnipsEditSplit="horizontal"

" VimShell mappings
nmap <leader>sh <Plug>(vimshell_split_switch)
autocmd Filetype vimshell nnoremap <buffer> <C-a>d :bdelete<Cr>
autocmd Filetype vimshell inoremap <buffer> <C-a>d <Esc>:bdelete<Cr>

let g:vimshell_editor_command = 'gvim'
let g:vimshell_prompt = '=> '
let g:vimshell_environment_term = 'xterm-256color'
let g:vimshell_split_command = 'split'

" YCM
let g:ycm_autoclose_preview_window_after_insertion = 1

" Dispatch
nnoremap <leader>ds :Dispatch 

" Ack
let g:ack_use_dispatch = 1

" Syntastyc
let g:syntastic_python_checkers = ['flake8']

" Thematic
nnoremap <Leader>N :ThematicNext<CR>
nnoremap <leader>P :ThematicPrevious<CR>

" Menlo Regular for Powerline Plus Nerd File Types
let g:thematic#themes = {
\ 'demoda': { 'colorscheme': 'PaperColor',
\             'background': 'dark',
\             'airline-theme': 'molokai',
\             'typeface': 'Monaco for Powerline Plus Nerd File Types',
\             'font-size': '15',
\             'linespace': '3',
\             'transparency': '10',
\           },
\ 'scode': { 'colorscheme': 'PaperColor',
\            'background': 'dark',
\            'airline-theme': 'bubblegum',
\            'typeface': 'Menlo Regular for Powerline Plus Nerd File Types',
\            'font-size': '15',
\            'linespace': '5',
\            'transparency': '10',
\          },
\ 'matrix': { 'colorscheme': 'base16-greenscreen',
\             'background': 'dark',
\             'airline-theme': 'wombat',
\             'typeface': 'Ubuntu Mono derivative Powerline Plus Nerd File Types Mono',
\             'font-size': '18',
\             'linespace': '5',
\           },
\ }

let g:thematic#theme_name = 'demoda'
