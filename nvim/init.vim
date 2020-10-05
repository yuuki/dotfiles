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
" 外部のエディタで編集中のファイルが変更されたら自動で読み直す
set autoread
" {{{}}}で折りたたみ
set foldmethod=marker
set autoindent   " 自動でインデント

" ------------------------------------------------------------
"  key bind
" ------------------------------------------------------------

" :w1 と打ってしまうくせ防止
cabbrev q1 q!
cabbrev w1 w!
cabbrev wq1 wq!
" insertモードから抜ける
inoremap <silent> jj <ESC>
inoremap <silent> <C-j> j
" Insert mode movekey bind
inoremap <C-d> <BS>
inoremap <C-h> <Left>                                                                                                                 
inoremap <C-l> <Right>
inoremap <C-k> <Up>                          
inoremap <C-j> <Down>
" 表示行単位で行移動する
nmap j gj
nmap k gk
vmap j gj
vmap k gk
" 行末までヤンク
nnoremap Y y$
" 空行挿入
nnoremap O :<C-u>call append(expand('.'), '')<CR>j

" 検索後画面の中心に移動
nnoremap n nzvzz
nnoremap N Nzvzz
nnoremap * *zvzz
nnoremap # *zvzz


" ------------------------------------------------------------
" command
" ------------------------------------------------------------

" git-browse-remote
" http://motemen.hatenablog.com/entry/2014/06/05/released-git-browse-remote-0-1-0
command! -nargs=* -range GB !git browse-remote --rev -L<line1>,<line2> <f-args> -- %
