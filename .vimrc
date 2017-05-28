set nocompatible              " be iMproved, required
filetype off                  " required

" Load vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/syntastic'
" Plugin 'vim-scripts/ScrollColors'
Plugin 'SirVer/ultisnips'
Plugin 'tpope/vim-sleuth'  " Detecta la identación automaticamente
Plugin 'airblade/vim-gitgutter'  " git diff en el buffer
Plugin 'tpope/vim-surround'  " Cambia, agrega o elimina lo que encierra una palabra.
Plugin 'vim-scripts/CSApprox'  " Adapta los colorschemes de gvim a vim terminal
Plugin 'vim-scripts/bufkill.vim'  " Permite cerrar buffers sin que vim salga
Plugin 'powerman/vim-plugin-viewdoc'  " Documentacion para varios lenguajes
Plugin 'tpope/vim-fugitive'  " Git para vim
Plugin 'junegunn/gv.vim'  " Navegador de commits git
Plugin 'shumphrey/fugitive-gitlab.vim'  " Makes :Gbrowse work on gitlab
Plugin 'bling/vim-bufferline'  " Muestra los buffers abiertos en la barra de estado
Plugin 'bling/vim-airline'  " Una barra de status mejor
Plugin 'vim-airline/vim-airline-themes'  " Temas para airline
Plugin 'sheerun/vim-polyglot'  " Soporte para mejorar la syntaxis de varios lenguajes incluye blade
Plugin 'vim-scripts/BufOnly.vim'  " Allow to close all buffers but current
" Plugin 'tkztmk/vim-vala'  " vala vim support
Plugin 'Valloric/YouCompleteMe'  " A well know completion engine
Plugin 'Shougo/vimproc.vim' " dependency for vimshell
Plugin 'Shougo/vimshell.vim' " shell inside vim
Plugin 'ryanoasis/vim-webdevicons' " Pretty icons for nerdtree
" Plugin 'ZzAntares/vim-laravel'
Plugin 'reedes/vim-thematic'  " Theme management via presets
Plugin 'tpope/vim-dispatch'  " run asynchronously
" Plugin 'mileszs/ack.vim'  " Wrapper para ack
Plugin 'shawncplus/phpcomplete.vim'  " Better php completion
Plugin 'tpope/vim-repeat'  " Support of repeat commands
Plugin 'mattn/emmet-vim'  " Easy HTML writing
Plugin 'godlygeek/tabular'  " Alignment plugin
Plugin 'Raimondi/delimitMate'  " Auto close parentesis
Plugin 'takac/vim-hardtime'  " Excercise vim navigation commands
Plugin 'tpope/vim-endwise'  " Append end to the end
Plugin 'haya14busa/incsearch.vim'  " Search enhanced
Plugin 'justinmk/vim-sneak'  " oh my motion command
" Plugin 'trusktr/seti.vim'  " Colorscheme
Plugin 'ajh17/Spacegray.vim'  " Colorscheme
" Plugin 'jdkanani/vim-material-theme'  " Material design theme
" Plugin 'NLKNguyen/papercolor-theme'  " Paper color theme based on material
" Plugin 'tomasr/molokai'
Plugin 'cseelus/vim-colors-clearance'  "Colorscheme
Plugin 'whatyouhide/vim-gotham'  " Colorscheme
Plugin 'chriskempson/base16-vim'  " base16 themes
Plugin 'janko-m/vim-test'  " Test runner
Plugin 'vobornik/vim-mql4'  " Syntax for MQL4
Plugin 'altercation/vim-colors-solarized'  " Solarized colorscheme
Plugin 'nanotech/jellybeans.vim'
Plugin 'kristijanhusak/vim-hybrid-material'
Plugin 'vim-scripts/gitignore'  " Ignore contents on gitignore files on tab completion
Plugin 'jalvesaq/Nvim-R'  " Support for R language

call vundle#end()
filetype plugin indent on
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
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
set previewheight=15
set clipboard=unnamed

set nobackup    " No backup files
set noswapfile  " No swap file

" Natural splitting
set splitbelow
set relativenumber

" set splitright

set hidden  " Cambia de buffer sin haber guardado los otros
set hlsearch  " Highlight searching
set incsearch  " Jump to match while typing
set ignorecase  " search case insensitive
set smartcase  " case sensitive when using caps
set visualbell  " don't beep
set noerrorbells  " don't beep

set list
let mapleader = "\<Space>"
nnoremap <leader>l :set list!<CR> 
nnoremap <leader>o :noh<CR>

" Permite ver los manpages en una nueva ventana
" source $VIMRUNTIME/ftplugin/man.vim
" runtime ftplugin/man.vim
" autocmd Filetype sh nnoremap K :Man <cword><CR>
autocmd Filetype php setlocal keywordprg=pman
autocmd Filetype python setlocal keywordprg=pydoc
autocmd Filetype ruby setlocal keywordprg=ri
" autocmd Filetype php nnoremap <buffer> K :Man --manpath=/usr/local/pear/docs/pman/man3 <cword><CR>

" Auto formaters
autocmd Filetype html setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype css setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype eruby,ruby setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype blade setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype json setlocal ts=4 sts=4 sw=4 expandtab
autocmd Filetype c setlocal ts=8 sts=8 sw=8 expandtab
autocmd Filetype php,c setlocal textwidth=80 formatoptions+=t colorcolumn=81
autocmd Filetype python setlocal textwidth=79 formatoptions+=t colorcolumn=80
autocmd Filetype ruby setlocal textwidth=79 formatoptions+=t colorcolumn=80
autocmd Filetype gitcommit setlocal spell textwidth=72 formatoptions+=t colorcolumn=73
autocmd Filetype markdown setlocal spell textwidth=80 formatoptions+=t colorcolumn=81

" Shurtcut for enabling djangohtml
nmap <leader>dft :set filetype=htmldjango<CR>

" Spelling languages map
nmap <silent> <leader>ss :set spelllang=es<CR>
nmap <silent> <leader>se :set spelllang=en<CR>

" Move cursor naturally
nmap j gj
nmap k gk

" Attemp to fix misspelling
nmap <silent> <leader>fs 1z=

" Fugitive maps
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gl :GV<CR>
nnoremap <leader>gv :GV!<CR>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gpl :Dispatch! git pull<Space>
nnoremap <leader>gps :Dispatch! git push<Space>
nnoremap <leader>gb :Gbrowse<CR>

" Gbrowse on Gitlab
let g:fugitive_gitlab_domains = ['http://git.microbit.com']

" Gdiff defaults to vertical split
set diffopt+=vertical

" Cambia los caracteres por default para los tabs y fin de lineas
set listchars=tab:▸\ ,eol:¬

" Habilita el statusline haciendo posible ver vim-airline
set laststatus=2

" Cambia el escape a kj para más rapidez
imap kj <Esc>

" NERDTree
let g:NERDTreeMapOpenSplit = "s"
let g:NERDTreeMapOpenVSplit = "v"
let g:NERDTreeMinimalUI = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeChDirMode = 2

" Cierra VIM cuando NERDTree es la unica ventana activa
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Open NERDTree 2x<Tab>
map <Tab><Tab> :NERDTreeToggle<CR>

" Buffer control
nmap <C-h> :bprevious<CR>
nmap <C-l> :bnext<CR>
nmap <leader>ls :ls<CR>

nmap gb <C-^>
map <C-a>d :q<CR>
map <C-a>k :BD<CR>
map <C-a>c :BufOnly<CR>

" Close man pages with Ctrl+d q Only works when using ViewDocHelp
autocmd Filetype help,man,pman map <buffer> <C-a>d q

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

" Agrega salto de linea en donde esta el cursor, a veces no es posible r<CR>
nmap <CR> i<CR><Esc>k

" Allow to visual select pasted text
nnoremap <expr> gV "`[".getregtype(v:register)[0]."`]"

" Cambia entre numero de linas realtivas o absolutas
nnoremap <silent><leader>r :set relativenumber!<cr>

" Vim WebDev Icons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:WebDevIconsUnicodeDecorateFolderNodeDefaultSymbol = ' '

" Vim WebDev Icons Colors
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

" Airline
" No buffer list in comand line
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
" let g:airline_theme='molokai'

" Set tabstop, softtabstop and shiftwidth to the same value with :Stab
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

" VimShell
let g:vimshell_editor_command = 'gvim'
let g:vimshell_prompt = '==> '
let g:vimshell_environment_term = 'xterm-256color'
let g:vimshell_split_command = 'split'

" VimShell mappings

nmap <leader>] :VimShellPop -toggle<CR>
nmap <leader>sh :VimShell -toggle<CR>
autocmd Filetype vimshell nmap <buffer> <C-a>d q
autocmd Filetype vimshell imap <buffer> <C-a>d <Esc>q
autocmd Filetype vimshell nmap <buffer> <C-a>k :bdelete<CR>
autocmd Filetype vimshell imap <buffer> <C-a>k <Esc>:bdelete<CR>
autocmd Filetype vimshell imap <buffer> <C-h> <Esc>:bprevious<CR>
autocmd Filetype vimshell imap <buffer> <C-l> <Esc>:bnext<CR>
autocmd Filetype vimshell imap <buffer> <leader>] <Esc>q
autocmd Filetype vimshell nnoremap <buffer> i G:startinsert!<CR>

" VimTest
let test#strategy = "dispatch"

" VimTest mappings
nmap <silent> <leader>tt :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>

" Vim Sneak
" Replace 'f' with 1-char Sneak
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
" Replace 't' with 1-char Sneak
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

" YCM
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_python_binary_path = 'python3'

" YCM mappings
nnoremap <leader>gt :YcmCompleter GoTo<Cr>

" CtrlP
let g:ctrlp_open_new_file = 'h'
" Faster CtrlP using ag
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

" Dispatch
nnoremap <leader>ds :Dispatch 

" Ack
let g:ack_use_dispatch = 1

" Tabular
nnoremap <leader>ta :Tabular /
vnoremap <leader>ta :Tabular /

" Incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Syntastyc
let g:syntastic_python_checkers = ['flake8']

" DelimitMate
let g:delimitMate_expand_cr = 1
imap <C-g>g <Plug>delimitMateS-Tab
imap <C-g>l <Plug>delimitMateJumpMany

" Emmet
let g:user_emmet_leader_key='<C-e>'

" HardTime
let g:hardtime_maxcount = 3
let g:hardtime_default_on = 0
let g:hardtime_ignore_buffer_patterns = ["NERD.*", "vundle", "vimshell"]
let g:hardtime_ignore_quickfix = 1
let g:hardtime_allow_different_key = 1
nnoremap <leader>ht :HardTimeToggle<CR>

" Thematic
nnoremap <Leader>N :ThematicNext<CR>
nnoremap <leader>P :ThematicPrevious<CR>

" Menlo Regular for Powerline Plus Nerd File Types
let g:thematic#themes = {
\ 'demoda': { 'colorscheme': 'base16-ocean',
\             'background': 'dark',
\             'airline-theme': 'molokai',
\             'typeface': 'Monaco for Powerline Plus Nerd File Types',
\             'font-size': '15',
\             'linespace': '3',
\             'transparency': '0',
\           },
\ 'codify': { 'colorscheme': 'PaperColor',
\            'background': 'dark',
\            'airline-theme': 'molokai',
\            'typeface': 'Menlo Regular for Powerline Plus Nerd File Types',
\            'font-size': '19',
\            'linespace': '15',
\            'transparency': '0',
\          },
\ 'molokai': { 'colorscheme': 'molokai',
\             'background': 'dark',
\             'airline-theme': 'molokai',
\             'typeface': 'Inconsolata for Powerline Plus Nerd File Types',
\             'font-size': '17',
\             'linespace': '6',
\           },
\ 'codeschool': { 'colorscheme': 'codeschool',
\             'background': 'dark',
\             'airline-theme': 'wombat',
\             'typeface': 'Monaco for Powerline Plus Nerd File Types',
\             'font-size': '15',
\             'linespace': '6',
\           },
\ 'gotham': { 'colorscheme': 'gotham',
\             'background': 'dark',
\             'airline-theme': 'gotham',
\             'typeface': 'Inconsolata for Powerline Plus Nerd File Types',
\             'font-size': '18',
\             'linespace': '6',
\           },
\ }

" let g:thematic#theme_name = 'molokai'
if $TERM == "xterm-256color"
  set t_Co=256
endif

" colorscheme clearance
" colorscheme spacegray
" colorscheme jellybeans
set background=dark
colorscheme hybrid_material

let g:airline_theme='powerlineish'
