set encoding=utf-8

set number
set linebreak
set showmatch
set visualbell

set hlsearch
set smartcase
set ignorecase
set incsearch

set wildmenu
set ruler
set cursorline

set autoindent
set expandtab
set tabstop=2
set shiftwidth=2

set undolevels=1000
set backspace=indent,eol,start
set autochdir
set clipboard=unnamed

" ------------------------------------------------------------
"  key bind
" ------------------------------------------------------------
" Insert Mode
inoremap <silent> jj <ESC>:<C-u>w<CR>:
" Insert mode movekey bind
inoremap <C-d> <BS>
inoremap <C-h> <Left>                                                                                                                 
inoremap <C-l> <Right>
inoremap <C-k> <Up>                          
inoremap <C-j> <Down>

