scriptencoding utf-8
" augroup がセットされていない autocmd 全般用の augroup
" これをやっておかないと ReloadVimrc したときに困る．by Linda_pp
augroup MyAutocmd
    autocmd!
augroup END

""" Options {{{
" Vi互換モードを使わない
set nocompatible
" シンタックスハイライト
syntax enable
" バックスペースでいろいろ消せる
set backspace=indent,eol,start
" バックアップファイルなし
set nobackup
" 勝手に作られる系のファイルを一箇所にまとめる
set directory=~/.vim/swp
set undodir=~/.vim/undo
" .viminfoファイル制限
set viminfo=!,'50,<1000,s100,\"50
" 履歴を500件まで保存する
set history=1000
" カーソル位置を表示する
set ruler
" スクロール時の余白確保
set scrolloff=5
" ファイルエンコーディングをutf-8優先
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,sjis,euc-jp
set fileformats=unix,mac,dos
" 行番号表示
set number
"" タブ幅 {{{
set showtabline=2
set expandtab       " タブをスペースに展開する
set tabstop=4       " 画面上のタブ幅
set shiftwidth=4    " インデント時に自動的に挿入されるタブ幅
set softtabstop=4   " キーボードで<Tab>キーを押したときに挿入される空白の量
set shiftround
set smarttab        " 行頭の余白内で<Tab>キーを押すとshiftwidthの数だけインデント．行頭以外ではtabstopの数だけ空白が挿入される．
"" }}}
" 改行時にコメントしない
set formatoptions-=ro
" 改行コードの自動認識
set fileformats=unix,mac,dos
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
set smartcase
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" ビープ音をOFFにする
set vb t_vb =
" ステータスラインを常に表示
set laststatus=2
" 括弧入力時の対応する括弧を表示
set showmatch
" IMを使う
set noimdisable
" コマンドラインでのIM無効化
set noimcmdline
" 入力中のコマンドをステータスに表示する
set showcmd
" 対応する括弧の行き来する時間の設定
set matchtime=3
" vimを開いた位置ではなくファイルのディレクトリ位置を起点にする
set browsedir=buffer
" コピペにクリップボードを使用する
" ビジュアルモードで選択したテキストが、クリップボードに入るようにす
set clipboard=unnamedplus,autoselect
" 文字にアンチエイリアスをかける
if has('mac') && has('gui_running')
  set antialias
endif
" 外部のエディタで編集中のファイルが変更されたら自動で読み直す
set autoread
" 辞書ファイルからの単語補間
set complete+=k
" 高速ターミナル接続を行う
set ttyfast
" {{{}}}で折りたたみ
set foldmethod=marker
" カーソル下の単語を help で調べる
set keywordprg=:help
" コマンド表示いらない
set noshowcmd
" コマンド実行中は再描画しない
set lazyredraw
" 読み込んでいるファイルが変更された時自動で読み直す
set autoread
" マルチバイト文字があってもカーソルがずれないようにする
set ambiwidth=double
" 256色
set t_Co=256
" タブ文字を CTRL-I で表示し, 行末に $ で表示する.
" set list
" Listモードに使われる文字を設定する "
"set listchars=tab:\ \ ,trail:-,eol:\
" stop hiding json quote
"set conceallevel=0
""" }}}

""" Util {{{
" augroup AutoDeleteTailSpace
"   autocmd!
"   autocmd BufWritePre * :%s/\s\+$//ge
" augroup END

" 一定時間カーソルを移動しないとカーソルラインを表示（ただし，ウィンドウ移動時
" はなぜか切り替わらない
" http://d.hatena.ne.jp/thinca/20090530/1243615055
augroup AutoCursorLine
  autocmd!
  autocmd CursorMoved,CursorMovedI,WinLeave * setlocal nocursorline
  autocmd CursorHold,CursorHoldI,WinEnter * setlocal cursorline
augroup END

" imsertモードから抜けるときにIMをOFFにする（GUI(MacVim)は自動的にやってくれる
" iminsert = 2にすると，insertモードに戻ったときに自動的にIMの状態が復元される
if !has("gui-running")
  inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif

" ファイルを開いたときに, カレントディレクトリを編集中のファイルディレクトリに変更
augroup grlcd
  autocmd!
  autocmd BufEnter * lcd %:p:h
augroup END

" :vimgrepでの検索後, QuickFixウィンドウを開く
augroup greopen
  autocmd!
  autocmd QuickfixCmdPost vimgrep cw
augroup END

" vimrcのリロード
command! ReloadVimrc source $MYVIMRC

" カーソル位置の復元
autocmd MyAutocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif
" Hack #202: 自動的にディレクトリを作成する
" http://vim-users.jp/2011/02/hack202/
autocmd MyAutocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
function! s:auto_mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force ||
           \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
     " call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
     call mkdir(a:dir, 'p')
  endif
endfunction

" ファイルタイプを書き込み時に自動判別
autocmd MyAutocmd BufWritePost
\ * if &l:filetype ==# '' || exists('b:ftdetect')
\ |   unlet! b:ftdetect
\ |   filetype detect
\ | endif
" git commit message のときは折りたたまない(diff で中途半端な折りたたみになりがち)
autocmd MyAutocmd FileType gitcommit setlocal nofoldenable

" git のルートディレクトリを開く
function! s:git_root_dir()
  if (system('git rev-parse --is-inside-work-tree') == "true\n")
    let s:path = system('git rev-parse --show-cdup')
    return strpart(s:path, 0, strlen(s:path)-1) " 末尾改行削除
  else
    echoerr 'current directory is outside git working tree'
  endif
endfunction

" 行末のスペースをハイライト
"http://d.hatena.ne.jp/mickey24/20120808/vim_highlight_trailing_spaces
augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

" 挿入モードとノーマルモードでステータスラインの色変更
autocmd MyAutocmd InsertEnter * hi StatusLine guifg=DarkBlue guibg=DarkYellow gui=none ctermfg=Blue ctermfg=Yellow cterm=none
autocmd MyAutocmd InsertLeave * hi StatusLine guifg=DarkBlue guibg=DarkGray   gui=none ctermfg=Blue ctermbg=DarkGray cterm=none
""" }}}

" tmp memo
command! Memo edit ~/Dropbox/memo/tmp.txt
command! Work edit ~/Dropbox/memo/works.txt

" git-browse-remote
" http://motemen.hatenablog.com/entry/2014/06/05/released-git-browse-remote-0-1-0
command! -nargs=* -range GB !git browse-remote --rev -L<line1>,<line2> <f-args> -- %

""" Keymap {{{
" :w1 と打ってしまうくせ防止
cabbrev q1 q!
cabbrev w1 w!
cabbrev wq1 wq!
" insertモードから抜ける
inoremap <silent> jj <ESC>
inoremap <silent> <C-j> j

" ; と : をスワップ
" inoremap : ;
" inoremap ; :
" nnoremap : ;
" nnoremap ; :
" vnoremap : ;
" vnoremap ; :

" insertモードでもquit
inoremap <C-q><C-q> <Esc>:wq<CR>
" insertモードでもsave
inoremap <C-w><C-w> <Esc>:w<Insert><CR>

" insertモードでC-s -> Save, C-q -> Quit
inoremap <C-s> <Esc>:w<CR>
inoremap <C-q> <Esc>:q<CR>

"Esc->Escで検索結果とエラーハイライトをクリア
nnoremap <silent><Esc><Esc> :<C-u>nohlsearch<CR>

" 賢く行頭・非空白行頭・行末の移動
nnoremap <silent>0 :<C-u>call <SID>smart_move('g^')<CR>
vnoremap <silent>0 :<C-u>call <SID>smart_move('g^')<CR>
nnoremap <silent>^ :<C-u>call <SID>smart_move('g0')<CR>
vnoremap <silent>^ :<C-u>call <SID>smart_move('g0')<CR>
nnoremap <silent>- :<C-u>call <SID>smart_move('g$')<CR>
vnoremap <silent>- :<C-u>call <SID>smart_move('g$')<CR>
" Visualモード時にvで行末まで選択する
vnoremap v $h

" 表示行単位で行移動する
nmap j gj
nmap k gk
vmap j gj
vmap k gk

" insertモードでのカーソル移動 ポップアップウィンドウがでないように
" inoremap <C-e> <END>
" vnoremap <C-e> <END>
" cnoremap <C-e> <END>
" inoremap <C-a> <HOME>
" vnoremap <C-a> <HOME>
" cnoremap <C-a> <HOME>
" inoremap <silent><expr><C-j> pumvisible() ? "\<C-y>\<Down>" : "\<Down>"
" inoremap <silent><expr><C-k> pumvisible() ? "\<C-y>\<Up>" : "\<Up>"
" inoremap <silent><expr><C-h> pumvisible() ? "\<C-y>\<Left>" : "\<Left>"
" inoremap <silent><expr><C-l> pumvisible() ? "\<C-y>\<Right>" : "\<Right>"
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
" カーソル前の文字削除
inoremap <silent> <C-h> <C-g>u<C-h>
cnoremap <silent> <C-h> <C-g>u<C-h>
" カーソル後の文字削除
inoremap <silent> <C-d> <Del>
cnoremap <silent> <C-d> <Del>
" 引用符, 括弧の設定
inoremap {} {}<Left>
inoremap [] []<Left>
inoremap () ()<Left>
inoremap "" ""<Left>
inoremap '' ''<Left>
inoremap <> <><Left>
inoremap []5 [%  %]<Left><Left><Left>
inoremap {}5 {%  %}<Left><Left><Left>
inoremap <>5 <%  %><Left><Left><Left>

" 行末までヤンク
nnoremap Y y$

" 空行挿入
nnoremap O :<C-u>call append(expand('.'), '')<CR>j

"ヘルプ表示
nnoremap <Leader>h :<C-u>vert to help<Space>

" CTRL-hjklでウィンドウ移動
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" ウィンドウ分割時にウィンドウサイズを調節
nnoremap <silent> <S-Left>  :5wincmd <<CR>
nnoremap <silent> <S-Right> :5wincmd ><CR>
nnoremap <silent> <S-Up>    :5wincmd -<CR>
nnoremap <silent> <S-Down>  :5wincmd +<CR>

" 検索後画面の中心に移動
nnoremap n nzvzz
nnoremap N Nzvzz
nnoremap * *zvzz
nnoremap # *zvzz

"バッファ切り替え
nnoremap <silent><C-n>   :<C-u>bnext<CR>
nnoremap <silent><C-p>   :<C-u>bprevious<CR>

" タブの設定
nnoremap ge :<C-u>tabedit<Space>
nnoremap gn :<C-u>tabnew<CR>

" 初回のみ a:cmd の動きをして，それ以降は行内をローテートする
let s:smart_line_pos = -1
function! s:smart_move(cmd)
  let line = line('.')
  if s:smart_line_pos == line . a:cmd
    call <SID>rotate_in_line()
  else
    execute "normal! " . a:cmd
    " 最後に移動した行とマッピングを保持
    let s:smart_line_pos = line . a:cmd
  endif
endfunction

" 行頭 → 非空白行頭 → 行 をローテートする by Linda_pp
" http://qiita.com/items/ee4bf64b1fe2c0a32cbd#comment-e2aafa1f4e60ae49a730
function! s:rotate_in_line()
  let c = col('.')

  if c == 1
    let cmd = '^'
  else
    let cmd = '$'
  endif

  execute "normal! ".cmd

  if c == col('.')
    if cmd == '^'
      normal! $
    else
      normal! 0
    endif
  endif
endfunction
" , に割り当てる
nnoremap <silent>, :<C-u>call <SID>rotate_in_line()<CR>

""" }}}

""" FileType {{{
set autoindent   " 自動でインデント
set cindent      " Cプログラムファイルの自動インデントを始める．これがあれば smartindent 要らない．
" softtabstopはTabキー押し下げ時の挿入される空白の量，0の場合はtabstopと同じ，BSにも影響する
set tabstop=2 shiftwidth=2 softtabstop=0

"ファイルタイプの検索を有効にする
filetype plugin on
"そのファイルタイプにあわせたインデントを利用する
filetype indent on

augroup FileTypeDetect
  autocmd!
  autocmd BufNewFile,BufRead *.PL,*.t,*.psgi,*.perldb,cpanfile setf perl
  autocmd BufNewFile,BufRead Capfile,Thorfile set filetype=ruby
  autocmd BufNewFile,BufRead *.hpp,*.cl setf cpp
  autocmd BufNewFile,BufRead *.cu,*.hcu setf cuda
  autocmd BufNewFile,BufRead *.aj setf java
  autocmd BufNewFile,BufRead *.tex,*.latex,*.sty,*.dtx,*.ltx,*.bbl setf tex
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} setf markdown
  autocmd BufNewFile,BufRead *.erb set filetype=eruby.html
  autocmd BufNewFile,BufRead */nginx.conf set filetype=nginx
  autocmd BufNewFile,BufRead *.nginx.conf set filetype=nginx
augroup END

augroup IndentGroup
  autocmd!
  " インデント幅4
  " setlocal sw=4 sts=4 ts=4 et
  autocmd FileType apache     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType c          setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cuda       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cpp        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cs         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType css        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType diff       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType eruby      setlocal sw=2 sts=2 ts=2 et
  autocmd FileType go         setlocal sw=8 sts=8 ts=8 et
  autocmd FileType groovy     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType haml       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType hpp        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType java       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType javascript setlocal sw=4 sts=4 ts=4 et
  autocmd FileType markdown   setlocal sw=2 sts=2 ts=2 et
  autocmd FileType perl       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType python     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType ruby       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType rust       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType scala      setlocal sw=2 sts=2 ts=2 et
  autocmd FileType sh         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType sql        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType terraform  setlocal sw=4 sts=4 ts=4 et
  autocmd FileType tex        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType tt2        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType tt2html    setlocal sw=2 sts=2 ts=2 et
  autocmd FileType vim        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType xhtml      setlocal sw=4 sts=4 ts=4 et
  autocmd FileType yaml       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType zsh        setlocal sw=2 sts=2 ts=2 et

  autocmd FileType perl,cgi   compiler perl
  autocmd FileType perl,cgi   nmap <buffer>,pt <ESC>:%! perltidy<CR> " ソースコード全体を整形
  autocmd FileType perl,cgi   nmap <buffer>,ptv <ESC>:%'<, '>! perltidy<CR> " 選択された部分のソースコードを整形
  autocmd FileType python     setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
  autocmd FileType ruby       compiler ruby
  autocmd FileType go         setlocal noexpandtab
  autocmd FileType tex        setlocal spelllang=en,cjk
augroup END

" http://d.hatena.ne.jp/WK6/20120606/1338993826
autocmd FileType text setlocal textwidth=0

"" ファイル形式毎にテンプレートを設定 {{{
augroup templates
  autocmd!
  " autocmd BufNewFile *.pl 0r $HOME/.vim/templates/template.pl
  " autocmd BufNewFile *.pm 0r $HOME/.vim/templates/template.pl
  autocmd BufNewFile *.rb 0r $HOME/.vim/templates/template.rb
  autocmd BufNewFile *.py 0r $HOME/.vim/templates/template.py
augroup END
"" }}}

"" +perl, +python, +ruby  for MacVim {{{
if has('gui_macvim') && has('kaoriya')
  let s:ruby_libdir = system("ruby -rrbconfig -e 'print Config::CONFIG[\"libdir\"]'")
  let s:ruby_libruby = s:ruby_libdir . '/libruby.dylib'
  if filereadable(s:ruby_libruby)
    let $RUBY_DLL = s:ruby_libruby
  endif
endif
let $PERL_DLL = "/System/Library/Perl/5.12/darwin-thread-multi-2level/CORE/libperl.dylib"
let $PYTHON_DLL = "$HOME/.pythonz/CPython-2.7.3/lib/libpython2.7.dylib"
"" }}}

" Go {{{
if $GOROOT != ''
  set rtp+=$GOROOT/misc/vim
endif
" }}}
""" }}}

""" Plugins {{{
" neobundle.vim が無ければインストールする
if ! isdirectory(expand('~/.vim/bundle'))
    echon "Installing neobundle.vim..."
    silent call mkdir(expand('~/.vim/bundle'), 'p')
    silent !git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
    echo "done."
    if v:shell_error
        echoerr "neobundle.vim installation has failed!"
        finish
    endif
endif

if has('vim_starting')
    set rtp+=~/.vim/bundle/neobundle.vim/
endif

let s:meet_neocomplete_requirements = has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))

call neobundle#begin(expand('~/.vim/bundle'))

NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'kana/vim-operator-user'
NeoBundle 'rhysd/vim-operator-surround'
NeoBundle "kana/vim-textobj-user"
NeoBundle 'osyo-manga/vim-textobj-multiblock'
NeoBundle 'osyo-manga/vim-operator-search'
" NeoBundle 'y-uuki/perl-local-lib-path.vim'

" colorscheme
NeoBundle 'tomasr/molokai'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'telamon/vim-color-github'
NeoBundle 'earendel'
NeoBundle 'rdark'
NeoBundle 'rhysd/wallaby.vim'

" NeoBundleLazy 'kana/vim-operator-replace', {
"             \ 'autoload' : {
"             \     'mappings' : '<Plug>(operator-replace)'
"             \     }
"             \ }
NeoBundleLazy 'corylanou/vim-present', {
            \ 'autoload' : {'filetypes' : 'present'}
            \ }

NeoBundleCheck
NeoBundleSaveCache

call neobundle#end()
filetype plugin indent on     " required!

autocmd MyAutocmd BufWritePost *vimrc,*gvimrc NeoBundleClearCache

" ReadOnly のファイルを編集しようとしたときに sudo.vim を遅延読み込み
autocmd MyAutocmd FileChangedRO * NeoBundleSource sudo.vim
autocmd MyAutocmd FileChangedRO * execute "command! W SudoWrite" expand('%')
""" }}}


" カラースキーム {{{
" シンタックスハイライト
syntax enable
if !has('gui_running')
    if &t_Co < 256
        colorscheme default
    else
        try
            colorscheme wallaby
        catch
            colorscheme desert
        endtry
    endif
endif

" seoul256 バックグラウンドカラーの明るさ
let g:seoul256_background = 233
" }}}

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

" vim: set ft=vim fdm=marker ff=unix fileencoding=utf-8:
