
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
set clipboard+=unnamed
" ビジュアルモードで選択したテキストが、クリップボードに入るようにす
set clipboard+=autoselect
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
" OSのクリップボードを使う
set clipboard=unnamed
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
""" }}}

""" Util {{{

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

" 保存時に行末のスペースを削除
augroup rtrim
  function! RTrim()
    let s:cursor = getpos(".")
    %s/\s\+$//e
    call setpos(".", s:cursor)
  endfunction
  autocmd BufWritePre * call RTrim()
augroup END

" git のルートディレクトリを開く
function! s:git_root_dir()
  if (system('git rev-parse --is-inside-work-tree') == "true\n")
    return system('git rev-parse --show-cdup')
  else
    echoerr 'current directory is outside git working tree'
  endif
endfunction

" 補完色を変更
highlight Pmenu ctermbg=8
highlight PmenuSel ctermbg=1
highlight PmenuSbar ctermbg=0

" 行末のスペースをハイライト
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
autocmd MyAutocmd WinEnter * match WhitespaceEOL /\s\+$/

" 挿入モードとノーマルモードでステータスラインの色変更
autocmd MyAutocmd InsertEnter * hi StatusLine guifg=DarkBlue guibg=DarkYellow gui=none ctermfg=Blue ctermfg=Yellow cterm=none
autocmd MyAutocmd InsertLeave * hi StatusLine guifg=DarkBlue guibg=DarkGray   gui=none ctermfg=Blue ctermbg=DarkGray cterm=none

" Vim 力を測る Scouter （thinca さん改良版）
" http://d.hatena.ne.jp/thinca/20091031/1257001194
function! Scouter(file, ...)
  let pat = '^\s*$\|^\s*"'
  let lines = readfile(a:file)
  if !a:0 || !a:1
    let lines = split(substitute(join(lines, "\n"), '\n\s*\\', '', 'g'), "\n")
  endif
  return len(filter(lines,'v:val !~ pat'))
endfunction
command! -bar -bang -nargs=? -complete=file Scouter
      \        echo Scouter(empty(<q-args>) ? $MYVIMRC : expand(<q-args>), <bang>0)
""" }}}

""" Keymap {{{
" insertモードから抜ける
inoremap <silent> jj <ESC>
inoremap <silent> <C-j> j
inoremap <silent> kk <ESC>
inoremap <silent> <C-k> k

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
" 選択範囲置換補助
vnoremap <C-r> ::s/\%V

" 表示行単位で行移動する
nmap j gj
nmap k gk
vmap j gj
vmap k gk

" insertモードでのカーソル移動 ポップアップウィンドウがでないように
inoremap <C-e> <END>
vnoremap <C-e> <END>
cnoremap <C-e> <END>
inoremap <C-a> <HOME>
vnoremap <C-a> <HOME>
cnoremap <C-a> <HOME>
inoremap <silent><expr><C-j> pumvisible() ? "\<C-y>\<Down>" : "\<Down>"
inoremap <silent><expr><C-k> pumvisible() ? "\<C-y>\<Up>" : "\<Up>"
inoremap <silent><expr><C-h> pumvisible() ? "\<C-y>\<Left>" : "\<Left>"
inoremap <silent><expr><C-l> pumvisible() ? "\<C-y>\<Right>" : "\<Right>"
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

" 空行挿入
nnoremap ; :<C-u>call append(expand('.'), '')<CR>
"ヘルプ表示
nnoremap <Leader>h :<C-u>vert to help<Space>

"<BS>の挙動 いきおいあまっていろいろ消してしまう
" nnoremap <BS> bdw

" 縦方向移動支援
" nnoremap J 3j
" nnoremap K 3k"

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

" そっこうのvimrc
nnoremap <silent> <Space>ev  :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>eg  :<C-u>edit $MYGVIMRC<CR>

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
  autocmd BufNewFile,BufRead *.hpp,*.cl setf cpp
  autocmd BufNewFile,BufRead *.aj setf java
  autocmd BufNewFile,BufRead *.jspx setf xhtml
  autocmd BufNewFile,BufRead *.tex,*.latex,*.sty,*.dtx,*.ltx,*.bbl setf tex
  autocmd BufNewFile,BufRead *.tt,*.tt2 call s:FTtt2()
  autocmd BufNewFile,BufRead *.html call s:FTtt2html()
  autocmd BufRead,BufNewFile *.mkd setfiletype mkd
  autocmd BufRead,BufNewFile *.md  setfiletype mkd
  autocmd BufRead,BufNewFile *.less setfiletype less
  autocmd BufRead,BufNewFile *.coffee setfiletype coffee
augroup END

augroup IndentGroup
  autocmd!
  " インデント幅4
        \ setlocal sw=4 sts=4 ts=4 et
  autocmd FileType apache     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType c          setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cpp        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cs         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType css        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType diff       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType eruby      setlocal sw=2 sts=2 ts=2 et
  autocmd FileType groovy     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType haml       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType hpp        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType java       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType javascript setlocal sw=4 sts=4 ts=4 et
  autocmd FileType perl       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType python     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType ruby       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType scala      setlocal sw=2 sts=2 ts=2 et
  autocmd FileType sh         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType sql        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType tex        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType tt2        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType tt2html    setlocal sw=2 sts=2 ts=2 et
  autocmd FileType vim        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType xhtml      setlocal sw=4 sts=4 ts=4 et
  autocmd FileType yaml       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType zsh        setlocal sw=2 sts=2 ts=2 et

  autocmd FileType c,cpp,objc,perl,ruby,java,javascript,css inoremap : ;
  autocmd FileType c,cpp,objc,perl,ruby,java,javascript,css inoremap ; :
  let $BOOST_ROOT = "/usr/local/include/boost"
  autocmd FileType c,cpp,objc set path+=$BOOST_ROOT

  autocmd FileType perl,cgi   compiler perl
  autocmd FileType perl,cgi   nmap <buffer>,pt <ESC>:%! perltidy<CR> " ソースコード全体を整形
  autocmd FileType perl,cgi   nmap <buffer>,ptv <ESC>:%'<, '>! perltidy<CR> " 選択された部分のソースコードを整形
  autocmd FileType perl,cgi   setlocal iskeyword+=:
  autocmd FileType perl,cgi   setlocal isfname-=-I
  autocmd FileType perl,cgi   setlocal dictionary+=~/.vim/dict/perl_functions.dict

  autocmd FileType python     setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
  autocmd FileType ruby       compiler ruby
  autocmd FileType ruby       setlocal nocompatible
augroup END

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

"" Syntax chack {{{
" Rubyのsyntaxチェック
" augroup rbsyntaxcheck
"   autocmd!
"   autocmd BufWrite *.rb w !ruby -c
" augroup END

" Perlのsyntaxチェック
" augroup plsyntaxcheck
"   autocmd!
"   function! _CheckPerlCode()
"     let s:perl_path = split(vimproc#system('which perl'), "\n")[-1]
"     exe ":!" . s:perl_path . " -wc -M'Project::Libs lib_dirs => [qw(local/lib/perl5)]' %"
"   endfunction
"   command! CheckCode call _CheckPerlCode()
"   autocmd BufWritePost *.pl,*.pm,*.t :CheckCode
" augroup END
"" }}}

"" Functions for Template Toolkit 2 syntax {{{
" http://d.hatena.ne.jp/dayflower/20090626/1245983732
function! s:FTtt2()
  let save_cursor = getpos('.')
  call cursor(1, 1)
  if search('\<\c\%(html\|head\|body\|div\)', 'cn') > 0
    setf tt2html
  else
    setf tt2
  endif
  call setpos('.', save_cursor)
endfunction

function! s:FTtt2html()
  let save_cursor = getpos('.')
  call cursor(1, 1)
  if search('\[%', 'cn') > 0
    setlocal filetype=tt2html
  endif
  call setpos('.', save_cursor)
endfunction
"" }}}

""" }}}

""" Plugins {{{
filetype off
filetype plugin indent off

if has('vim_starting')
  set rtp+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc()
endif

"" on GitHub {{{
NeoBundle 'Shougo/vimproc', {
            \ 'build' : {
            \       'mac'     : 'make -f make_mac.mak',
            \       'unix'    : 'make -f make_unix.mak',
            \   }
            \ }
NeoBundle 'Shougo/vimfiler.git'
NeoBundle 'Shougo/vimshell.git'
NeoBundle 'Shougo/vinarise.git'
NeoBundle 'Shougo/echodoc.git'
NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'Shougo/neosnippet.git'
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'Shougo/unite-ssh.git'
NeoBundle 'osyo-manga/unite-fold'
NeoBundle 'osyo-manga/unite-quickfix'
NeoBundle 'taka84u9/unite-git'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'Shougo/vim-vcs.git'
NeoBundle 'hrsh7th/vim-unite-vcs'
NeoBundle 'basyura/unite-rails'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-guicolorscheme'
NeoBundle 'thinca/vim-ref'
NeoBundle 'ujihisa/vimshell-ssh.git'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'danchoi/ri.vim.git'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-bundler.git'
NeoBundle 'tpope/vim-rake.git'
NeoBundle 'tpope/vim-abolish.git'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'hotchpotch/perldoc-vim'
NeoBundle 'rhysd/wombat256.vim'
NeoBundle 'rhysd/unite-ruby-require.vim'
NeoBundle 'y-uuki/unite-perl-module.vim'
NeoBundle 'y-uuki/syntastic_local_lib_path.vim'
NeoBundle 'scrooloose/syntastic'
" NeoBundle 'vim-scripts/errormarker.vim'
" NeoBundle 'ywatase/flymake-perl.vim'
" NeoBundle 'c9s/cpan.vim'
"" }}}

"" on www.vim.org {{{
NeoBundle 'dbext.vim'
" NeoBundle 'L9'
" NeoBundle 'taglist.vim'
"" }}}

"" on others Git repositories {{{
" NeoBundle 'git://git.wincent.com/command-t.git'
" NeoBundle 'git://github.com/msanders/cocoa.vim.git'
"" }}}

"" GUI colorscheme {{{
NeoBundleLazy 'ujihisa/unite-colorscheme'
NeoBundleLazy 'tomasr/molokai'
NeoBundleLazy 'altercation/vim-colors-solarized'
NeoBundleLazy 'telamon/vim-color-github'
NeoBundleLazy 'earendel'
NeoBundleLazy 'rdark'
NeoBundleLazy 'guicolorscheme.vim'
"" }}}

"" 特定環境用 {{{
NeoBundleLazy 'sudo.vim'
NeoBundleLazy 'vim-ruby/vim-ruby'
NeoBundleLazy 'benizi/perl-support.vim'
NeoBundleLazy 'petdance/vim-perl'
NeoBundleLazy 'motemen/xslate-vim'
NeoBundleLazy 'vim-jp/cpp-vim'
NeoBundleLazy 'osyo-manga/neocomplcache-clang_complete'
NeoBundleLazy 'kchmck/vim-coffee-script'
NeoBundleLazy 'plasticboy/vim-markdown'
NeoBundleLazy 'groenewege/vim-less'
NeoBundleLazy 'tpope/vim-haml.git'
NeoBundleLazy 'zaiste/tmux.vim'
NeoBundleLazy 'micheljansen/vim-latex'
"" }}}

"" 遅延ロード {{{
augroup NeoBundleLazyLoad
    autocmd!
    autocmd FileType cpp NeoBundleSource
                \ cpp-vim
                \ neocomplcache-clang_complete
    autocmd FileType ruby NeoBundleSource vim-ruby
    autocmd FileType perl NeoBundleSource
                \ perl-support.vim
                \ vim-perl
    autocmd FileType less   NeoBundleSource vim-less
    autocmd FileType coffee NeoBundleSource vim-coffee-script
    autocmd FileType tmux   NeoBundleSource tmux.vim
    autocmd FileType tex    NeoBundleSource vim-latex
    autocmd FileType haml   NeoBundleSource vim-haml
    autocmd FileType xslate NeoBundleSource xslate-vim
augroup END
"" }}}

filetype plugin indent on

"" wombat {{{
if !has('gui_running')
    colorscheme wombat256mod
endif
"" }}}

"" neocomplcache {{{
" AutoComplPopを無効にする
let g:acp_enableAtStartup = 0
" vim起動時に有効化
let g:neocomplcache_enable_at_startup = 1
" smart_caseを有効にする．大文字が入力されるまで大文字小文字の区別をなくす
let g:neocomplcache_enable_smart_case = 1
" _を区切りとした補完を有効にする
let g:neocomplcache_enable_underbar_completion = 1
" シンタックスをキャッシュするときの最小文字長を3に
let g:neocomplcache_min_syntax_length = 3
" 日本語を収集しないようにする
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
" リスト表示
let g:neocomplcache_max_list = 300
let g:neocomplcache_max_keyword_width = 20
" 辞書定義
let g:neocomplcache_dictionary_filetype_lists = {
            \ 'default' : '',
            \ 'vimshell' : expand('~/.vimshell/command-history'),
            \ }
let g:neocomplcache_ctags_arguments_list = {
  \ 'perl' : '-R -h ".pm"'
  \ }
if !has("gui_running")
  " CUIのvimでの補完リストの色を調節する
  highlight Pmenu ctermbg=8
endif

" Enable omni completion.
augroup NeocomplcacheOmniFunc
    autocmd!
    autocmd FileType python     setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType html       setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css        setlocal omnifunc=csscomplete#CompleteCss
    autocmd FileType xml        setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType php        setlocal omnifunc=phpcomplete#CompletePHP
    autocmd FileType c          setlocal omnifunc=ccomplete#Complete
    " autocmd FileType ruby set omnifunc=rubycomplete#Complete
augroup END

" neocomplcacheのキーマップ {{{
" <CR>: close popup and save indent.
imap     <expr><CR>  pumvisible() ? neocomplcache#smart_close_popup()."\<CR>" : "\<CR>"
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-y> neocomplcache#close_popup()
" }}}
"" }}}

"" neosnippet {{{
" スニペット展開候補があれば展開を，そうでなければbash風補完を．
" プレースホルダ優先で展開
imap <expr><C-l> neosnippet#expandable() ?
            \ "\<Plug>(neosnippet_jump_or_expand)" :
            \ neocomplcache#complete_common_string()
smap <expr><C-l> neosnippet#expandable() ?
            \ "\<Plug>(neosnippet_jump_or_expand)" :
            \ neocomplcache#complete_common_string()
" ネスト優先で展開
imap <expr><C-S-l> neosnippet#expandable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" :
            \ neocomplcache#complete_common_string()
smap <expr><C-S-l> neosnippet#expandable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" :
            \ neocomplcache#complete_common_string()
"" }}}
" 自作スニペット {{{
let g:neosnippet#snippets_directory=$HOME.'/.vim/snippets'
"" }}}

"" unite.vim {{{
" insertモードをデフォルトに
let g:unite_enable_start_insert = 1
" 無指定にすることで高速化
let g:unite_source_file_mru_filename_format = ''
" most recently used のリストサイズ
let g:unite_source_file_mru_limit = 100
" Unite起動時のウィンドウ分割
let g:unite_split_rule = 'rightbelow'
" unite-grep で使うコマンド
let g:unite_source_grep_default_opts = "-Hn --color=never"

nnoremap  [unite] <Nop>
nmap      f       [unite]

"バッファを開いた時のパスを起点としたファイル検索
nnoremap <silent> [unite]ff :<C-u>UniteWithBufferDir -buffer-name=files file -vertical<CR>
" 最近使用したファイル一覧
nnoremap <silent> [unite]m :<C-u>Unite -no-split file_mru<CR>
" ファイル一覧
nnoremap <silent> [unite]f :<C-u>Unite -no-split -buffer-name=files file<CR>
" バッファ一覧
nnoremap <silent> [unite]b :<C-u>Unite -no-split buffer<CR>
" 常用セット
nnoremap <silent> [unite]u :<C-u>Unite -no-split buffer file_mru<CR>
" 現在のバッファのカレントディレクトリからファイル一覧
nnoremap <silent> [unite]d :<C-u>UniteWithBufferDir -no-split file<CR>
" grep検索
nnoremap <silent> [unite]G :<C-u>Unite -no-start-insert grep<CR>
" Uniteバッファの復元
nnoremap <silent> [unite]r :<C-u>UniteResume<CR>
" バッファ全体
nnoremap <silent> [unite]L :<C-u>Unite line<CR>
" ブックマーク一覧
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
" ブックマークに追加
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
" スニペット候補表示
nnoremap <silent> [unite]s <Plug>(neocomplcache_start_unite_snippet)

" git常用
nnoremap <silent> [unite]g :<C-u>Unite -no-split git_cached git_untracked<CR>
" git ls-files一覧
nnoremap <silent> [unite]gc :<C-u>Unite -no-split git_cached<CR>
" git modefied一覧
nnoremap <silent> [unite]gm :<C-u>Unite -no-split git_modified<CR>
" git untracked一覧
nnoremap <silent> [unite]gu :<C-u>Unite -no-split git_untracked<CR>

"" unite-perl-module
"
nnoremap <silent> [unite]pl :<C-u>Unite perl/local<CR>
nnoremap <silent> [unite]pg :<C-u>Unite perl/global<CR>

augroup UniteMapping
  autocmd!
  " insertモード時はC-gでいつでもバッファを閉じられる（絞り込み欄が空の時はC-hでもOK）
  autocmd FileType unite imap <buffer><C-g> <Plug>(unite_exit)
  " <Space> だと待ち時間が発生してしまうので <Space><Space> を割り当て
  autocmd FileType unite nmap <buffer><Space><Space> <Plug>(unite_toggle_mark_current_candidate)
  " q だと待ち時間が発生してしまうので
  autocmd FileType unite nmap <buffer><C-g> <Plug>(unite_exit)
  " jjでインサートモードを抜ける
  autocmd FileType unite imap <buffer> jj <Plug>(unite_insert_leave)
  " 直前のパス削除
  autocmd FileType unite imap <buffer><C-w> <Plug>(unite_delete_backward_path)
  autocmd FileType unite nmap <buffer>h <Plug>(unite_delete_backward_path)
  " ファイル上にカーソルがある時，pでプレビューを見る
  autocmd FileType unite inoremap <buffer><expr>p unite#smart_map("p", unite#do_action('preview'))
  " C-xでクイックマッチ
  autocmd FileType unite imap <buffer><C-x> <Plug>(unite_quick_match_default_action)
  " lでデフォルトアクションを実行
  autocmd FileType unite nmap <buffer>l <Plug>(unite_do_default_action)
  autocmd FileType unite imap <buffer><expr>l unite#smart_map("l", unite#do_action(unite#get_current_unite().context.default_action))
  " tでtabedit
  autocmd FileType unite nnoremap <buffer><expr> t unite#smart_map('t', unite#do_action('tabopen'))
  autocmd FileType uniti inoremap <buffer><expr> t unite#smart_map('t', unite#do_action('tabopen'))
  " sでsplit
  autocmd FileType unite nnoremap <buffer><expr> s unite#smart_map('s', unite#do_action('split'))
  autocmd FileType unite inoremap <buffer><expr> s unite#smart_map('s', unite#do_action('split'))
  " vでsplit
  autocmd FileType unite nnoremap <buffer><expr> v unite#smart_map('v', unite#do_action('vsplit'))
  autocmd FileType unite inoremap <buffer><expr> v unite#smart_map('v', unite#do_action('vsplit'))
  " fでvimfiler
  autocmd FileType unite nnoremap <buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
  autocmd FileType unite inoremap <buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
augroup END
"" }}}

"" VimFiler {{{
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_split_command = 'vertical rightbelow vsplit'
let g:vimfiler_execute_file_list = { 'c' : 'vim', 'h' : 'vim', 'cpp' : 'vim', 'hpp' : 'vim', 'cc' : 'vim', 'rb' : 'vim', 'pl' : 'vim', 'pm' : 'vim', 'txt' : 'vim', 'pdf' : 'open', 'vim' : 'vim' }
let g:vimfiler_edit_action = 'tabopen'

augroup VimFilerMapping
  autocmd!
  autocmd FileType vimfiler nmap <buffer><silent><expr> e vimfiler#smart_cursor_map(
        \   "\<Plug>(vimfiler_cd_file)",
        \   "\<Plug>(vimfiler_edit_file)")
  autocmd FileType vimfiler nmap <buffer><silent><expr><CR> vimfiler#smart_cursor_map(
        \   "\<Plug>(vimfiler_expand_tree)",
        \   "\<Plug>(vimfiler_edit_file)")
  autocmd FileType vimfiler nmap <buffer><silent>x <Plug>(vimfiler_hide)
augroup END

nnoremap <Leader>f    <Nop>
nnoremap <Leader>ff   :<C-u>VimFiler<CR>
nnoremap <Leader>fnq  :<C-u>VimFiler -no-quit<CR>
nnoremap <Leader>fh   :<C-u>VimFiler ~<CR>
nnoremap <Leader>fc   :<C-u>VimFilerCurrentDir<CR>
nnoremap <Leader>fb   :<C-u>VimFilerBufferDir<CR>
nnoremap <Leader>fB   :<C-u>VimFilerBufferDir<CR>
nnoremap <silent><expr><Leader>fg ":\<C-u>VimFiler " . <SID>git_root_dir() . '\<CR>'
nnoremap <silent><expr><Leader>fe ":\<C-u>VimFilerExplorer " . <SID>git_root_dir() . '\<CR>'
"" }}}

"" vimshell {{{
let g:vimshell_user_prompt = 'getcwd()'
let g:vimshell_disable_escape_highlight = 1
"" }}}

"" vim-unite-vcs {{{
nnoremap  [vcs] <Nop>
nmap      fv    [vcs]

nnoremap [vcs]l  :<C-u>Unite vcs/log<CR>
nnoremap [vcs]s  :<C-u>Unite vcs/status<CR>
nnoremap [vcs]r  :<C-u>Unite vcs/file_rec<CR>
"" }}}

"" vim-fugutive {{{
nnoremap [fugu] <Nop>
nmap     gi    [fugu]

nnoremap [fugu]st :<C-u>Gstatus<CR>
nnoremap [fugu]bl :<C-u>Gblame<CR>
nnoremap [fugu]gr :<C-u>Ggrep<SPACE>
nnoremap [fugu]lo :<C-u>Glog<CR>
nnoremap [fugu]re :<C-u>Gread<CR>
"" }}}

"" vim-quickrun {{{
nnoremap <Leader>q  <Nop>
nmap     <silent><Leader>qr :w<CR><Plug>(quickrun):copen<CR>
nnoremap <Leader>qR :QuickRun<Space>
" QuickFixバッファを閉じると同時にエラー表示も消す
autocmd MyAutocmd FileType qf nnoremap <buffer><silent> q :q<CR>:HierClear<CR>

let g:quickrun_config = {}
let g:quickrun_config.perl = {'command' : 'perl', 'cmdopt': '-MProject::Libs lib_dirs => [qw(local/lib/perl5)]' }
"" }}}

"" vim-ruby {{{
" <C-Space>でomni補完
inoremap <C-Space> <C-x><C-o>
"" }}}

"" rails.vim {{{
" Rubyのオムニ補完を設定(ft-ruby-omni)
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

autocmd User Rails.controller* Rnavcommand api app/controllers/api -glob=**/* -suffix=_controller.rb
autocmd User Rails.controller* Rnavcommand tmpl app/controllers/tmpl -glob=**/* -suffix=_controller.rb
autocmd User Rails Rnavcommand config config   -glob=*.*  -suffix= -default=routes.rb
autocmd User Rails nnoremap :<C-u>Rcontroller :<C-u>Rc
autocmd User Rails nnoremap :<C-u>Rmodel :<C-u>Rm
autocmd User Rails nnoremap :<C-u>Rview :<C-u>Rv
"" }}}

"" unite-ruby-require {{{
let g:unite_source_ruby_require_ruby_command = '/usr/local/opt/rbenv/shims/ruby'
"" }}}

"" syntastic-local-lib-path {{{
" let g:syntastic_perl_lib_path = 'local/lib/perl5'
augroup SyntasticLocalLibPathGroup
  autocmd!
  autocmd FileType perl SyntasticLocalLibPath
augroup END

"" }}}

"" vim-latex {{{
let g:tex_flavor = 'latex'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_FormatDependency_pdf = 'dvi,pdf'
if has('mac')
  let g:Tex_CompileRule_dvi = '/Applications/UpTeX.app/teTeX/bin/latex -synctex=1 -interaction=nonstopmode $*'
  let g:Tex_CompileRule_pdf = '/Applications/UpTeX.app/teTeX/bin/dvipdfmx $*.dvi'
  let g:Tex_BibtexFlavor    = '/Applications/UpTeX.app/teTeX/bin/pbibtex'
  let g:Tex_ViewRule_pdf    = '/usr/bin/open -a Preview.app'
endif
"" }}}

""" }}}
