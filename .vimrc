""""" vimrc copied by y_uuki """""

syntax on

" augroup がセットされていない autocmd 全般用の augroup
" これをやっておかないと ReloadVimrc したときに困る．by Linda_pp
augroup MyAutocmd
    autocmd!
augroup END

" Vi互換モードを使わない
set nocompatible

" バックスペースでいろいろ消せる
set backspace=indent,eol,start

" バックアップファイルなし
set nobackup

" .viminfoファイル制限
set viminfo=!,'50,<1000,s100,\"50

" 履歴を500件まで保存する
set history=500

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

""""" タブ幅 """""
set showtabline=2
set expandtab       " タブをスペースに展開する
set tabstop=4       " 画面上のタブ幅
set shiftwidth=4    " インデント時に自動的に挿入されるタブ幅
set softtabstop=4   " キーボードで<Tab>キーを押したときに挿入される空白の量
set shiftround
set smarttab        " 行頭の余白内で<Tab>キーを押すとshiftwidthの数だけインデント．行頭以外ではtabstopの数だけ空白が挿入される．

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

" タブ文字を CTRL-I で表示し, 行末に $ で表示する.
" set list

" Listモードに使われる文字を設定する "
"set listchars=tab:\ \ ,trail:-,eol:\

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

" ファイル形式毎にテンプレートを設定
augroup templates
  autocmd!
  " autocmd BufNewFile *.pl 0r $HOME/.vim/templates/template.pl
  " autocmd BufNewFile *.pm 0r $HOME/.vim/templates/template.pl
  autocmd BufNewFile *.rb 0r $HOME/.vim/templates/template.rb
  autocmd BufNewFile *.py 0r $HOME/.vim/templates/template.py
augroup END

" 保存時に行末のスペースを削除
augroup rtrim
  function! RTrim()
    let s:cursor = getpos(".")
    %s/\s\+$//e
    call setpos(".", s:cursor)
  endfunction
  autocmd BufWritePre * call RTrim()
augroup END


" ################################
" Syntax関連
" ################################

" Rubyのsyntaxチェック
augroup rbsyntaxcheck
  autocmd!
  autocmd BufWrite *.rb w !ruby -c
augroup END

" Perlのsyntaxチェック
augroup plsyntaxcheck
  autocmd!
  autocmd BufWrite *.pl w !perl -c
augroup END

" ################################
" ハイライト設定
" ################################

" 補完色を変更
highlight Pmenu ctermbg=8
highlight PmenuSel ctermbg=1
highlight PmenuSbar ctermbg=0

" 行末のスペースをハイライト
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
autocmd MyAutocmd WinEnter * match WhitespaceEOL /\s\+$/

" 全角スペースをハイライトする設定
" scriptencoding utf-8
"augroup highlightIdegraphicSpace
"  autocmd!
"  autocmd ColorScheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
"  autocmd VimEnter,WinEnter * match IdeographicSpace /　/
"augroup END

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

" ################################
" Plugins {{{
" ################################
filetype off

if has('vim_starting')
  set rtp+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc()
endif

" --------------------------------
" github にあるプラグイン
" --------------------------------
NeoBundle 'Shougo/echodoc.git'
NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'Shougo/neobundle.vim.git'
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'Shougo/vim-vcs.git'
NeoBundle 'Shougo/vimfiler.git'
NeoBundle 'Shougo/vimshell.git'
NeoBundle 'Shougo/vinarise.git'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimproc'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-guicolorscheme'
NeoBundle 'osyo-manga/neocomplcache-clang_complete'
NeoBundle 'ujihisa/vimshell-ssh.git'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'danchoi/ri.vim.git'
NeoBundle 'motemen/git-vim'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-bundler.git'
NeoBundle 'tpope/vim-rake.git'
NeoBundle 'tpope/vim-abolish.git'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'tpope/vim-haml.git'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'vim-scripts/Source-Explorer-srcexpl.vim'
NeoBundle 'vim-scripts/sudo.vim'
NeoBundle 'vim-jp/cpp-vim'
NeoBundle 'benizi/perl-support.vim'
NeoBundle 'petdance/vim-perl'
NeoBundle 'hrsh7th/vim-unite-vcs'
NeoBundle 'c9s/cpan.vim'

" --------------------------------
" www.vim.orgにあるプラグイン
" --------------------------------
NeoBundle 'L9'
NeoBundle 'ZenCoding.vim'
NeoBundle 'guicolorscheme.vim'
NeoBundle 'vimshell-ssh'
NeoBundle 'yanktmp.vim'
NeoBundle 'trinity.vim'
NeoBundle 'taglist.vim'
NeoBundle 'dbext.vim'
" NeoBundle 'smartchr'
" NeoBundle 'open-browser.vim'
" NeoBundle 'Gist.vim'
" NeoBundle 'The-NERD-tree'

" --------------------------------
" それ以外にある gitリポジトリにあるプラグイン
" --------------------------------
NeoBundle 'git://git.wincent.com/command-t.git'
NeoBundle 'git://github.com/msanders/cocoa.vim.git'
" NeoBundle 'git://github.com/scrooloose/nerdcommenter'
" NeoBundle 'git://github.com/scrooloose/nerdtree.git'


filetype plugin on
filetype indent on

" --------------------------------
" vim-quickrun
" --------------------------------
nnoremap <Leader>q  <Nop>
nmap     <silent><Leader>qr :w<CR><Plug>(quickrun):copen<CR>
nnoremap <Leader>qR :QuickRun<Space>
" QuickFixバッファを閉じると同時にエラー表示も消す
autocmd MyAutocmd FileType qf nnoremap <buffer><silent> q :q<CR>:HierClear<CR>

" --------------------------------
" git.vim
" --------------------------------
" git add
let g:proj_run1='!git add %f'
let g:proj_run_fold1='*!git add %f'

" git checkout --
let g:proj_run2='!git checkout -- %f'
let g:proj_run_fold2="*!git checkout --%f"

" git status
let g:proj_run3='!git status'

" フォールディングを展開した状態で, プロジェクトを開く
autocmd MyAutocmd BufAdd .vimprojects silent! %foldopen!

" カレントディレクトリにプロジェクト管理ファイルがあったら読み込む
if getcwd() != $HOME
    if filereadable(getcwd(). '/.vimprojects')
        Project .vimprojects
    endif
endif

" --------------------------------
" vim-ruby
" --------------------------------
" <C-Space>でomni補完
imap <C-Space> <C-x><C-o>

" --------------------------------
" rails.vim
" --------------------------------
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

" --------------------------------
" neocomplcache
" --------------------------------
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_auto_completion_start_length = 3

""""" yanktmp.vim """""
" map <silent> sy :call YanktmpYank()<CR>
" map <silent> sp :call YanktmpPaste_p()<CR>
" map <silent> sP :call YanktmpPaste_P()<CR>
" if has("win32")
"     let g:yanktmp_file = $TEMP. '/vimyanktmp'
" endif

"""""" smartchr """""
" inoremap <expr> = smartchr#loop(' = ', '=', ' == ')
" inoremap <expr> , smartchr#one_of(', ', ',')
"cnoremap <expr> / smartchr#loop('/', '~/', '//', {'ctype': ':'})

" --------------------------------
" unite.vim
" --------------------------------
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

nnoremap [unite]u  :<C-u>Unite -no-split<Space>
" 最近使用したファイル一覧
nnoremap <silent> [unite]m  :<C-u>Unite -no-split file_mru<CR>
" ファイル一覧
nnoremap <silent> [unite]f  :<C-u>Unite -no-split -buffer-name=files file<CR>
" バッファ一覧
nnoremap <silent> [unite]b  :<C-u>Unite -no-split buffer<CR>
" 常用セット
nnoremap <silent> [unite]u  :<C-u>Unite -no-split buffer file_mru<CR>
" 現在のバッファのカレントディレクトリからファイル一覧
nnoremap <silent> [unite]d  :<C-u>UniteWithBufferDir -no-split file<CR>
" grep検索
nnoremap <silent>[unite]G :<C-u>Unite -no-start-insert grep<CR>
" Uniteバッファの復元
nnoremap <silent>[unite]r :<C-u>UniteResume<CR>
" バッファ全体
nnoremap <silent>[unite]L :<C-u>Unite line<CR>

augroup UniteMapping
  autocmd!
  "insertモード時はC-gでいつでもバッファを閉じられる（絞り込み欄が空の時はC-hでもOK）
  autocmd FileType unite imap <buffer><C-g> <Plug>(unite_exit)
  " <Space> だと待ち時間が発生してしまうので <Space><Space> を割り当て
  autocmd FileType unite nmap <buffer><Space><Space> <Plug>(unite_toggle_mark_current_candidate)
  " q だと待ち時間が発生してしまうので
  autocmd FileType unite nmap <buffer><C-g> <Plug>(unite_exit)
  "直前のパス削除
  autocmd FileType unite imap <buffer><C-w> <Plug>(unite_delete_backward_path)
  autocmd FileType unite nmap <buffer>h <Plug>(unite_delete_backward_path)
  "ファイル上にカーソルがある時，pでプレビューを見る
  autocmd FileType unite inoremap <buffer><expr>p unite#smart_map("p", unite#do_action('preview'))
  "C-xでクイックマッチ
  autocmd FileType unite imap <buffer><C-x> <Plug>(unite_quick_match_default_action)
  "lでデフォルトアクションを実行
  autocmd FileType unite nmap <buffer>l <Plug>(unite_do_default_action)
  autocmd FileType unite imap <buffer><expr>l unite#smart_map("l", unite#do_action(unite#get_current_unite().context.default_action))

  " autocmd FileType unite imap <buffer><C-w> <Plug>(neocomplcache_start_unite_complete)
augroup END

autocmd MyAutocmd FileType unite call s:unite_my_settings()

function! s:unite_my_settings()"
  " Overwrite settings.

  " ESCキーを2回押すと終了する
  nmap <buffer> <ESC>      <Plug>(unite_exit)
  nmap <buffer> <ESC><ESC> <Plug>(unite_exit)
  imap <buffer> jj  <Plug>(unite_insert_leave)
  nnoremap <silent><buffer> <C-k> :<C-u>call unite#mappings#do_action('preview')<CR>
  imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)

  " ウィンドウを分割して開く
  nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('split')
  inoremap <silent> <buffer> <expr> <C-l> unite#do_action('split')

  " ウィンドウを縦に分割して開く
  nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
  inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
endfunction"


" --------------------------------
" vimfiler
" --------------------------------
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_split_command = 'vertical rightbelow vsplit'
let g:vimfiler_execute_file_list = { 'c' : 'vim', 'h' : 'vim', 'cpp' : 'vim', 'hpp' : 'vim', 'cc' : 'vim', 'rb' : 'vim', 'pl' : 'vim', 'pm' : 'vim', 'txt' : 'vim', 'pdf' : 'open', 'vim' : 'vim' }


autocmd! FileType vimfiler call g:my_vimfiler_settings()
function! g:my_vimfiler_settings()
  nmap     <buffer><expr><Cr> vimfiler#smart_cursor_map("
  nnoremap <buffer>s          :call vimfiler#mappings#do_action('my_split')<Cr>
  nnoremap <buffer>v          :call vimfiler#mappings#do_action('my_vsplit')<Cr>
endfunction

augroup VimFilerMapping
  autocmd!
  autocmd FileType vimfiler nmap <buffer><silent><expr> e vimfiler#smart_cursor_map(
        \   "\<Plug>(vimfiler_cd_file)",
        \   "\<Plug>(vimfiler_edit_file)",
        \   "\<Plug>(vimfiler_expand_tree)",
        \   "\<Plug>(vimfiler_edit_file)")
  autocmd FileType vimfiler nmap <buffer><silent>x <Plug>(vimfiler_hide)
augroup END
nnoremap <Leader>f        <Nop>
nnoremap <Leader>ff       :<C-u>VimFiler<CR>
nnoremap <Leader>fnq      :<C-u>VimFiler -no-quit<CR>
nnoremap <Leader>fh       :<C-u>VimFiler ~<CR>
" Explorer仕様
nnoremap <Leader>fe       :<C-u>VimFiler -buffer-name=explorer -split -ainsize=45 -toggle -no-quit<CR>
nnoremap <Leader>fc       :<C-u>VimFilerCurrentDir<CR>
nnoremap <Leader>fb       :<C-u>VimFilerBufferDir<CR>
" nnoremap <silent><expr><Leader>fg ":\<C-u>VimFiler " . <SID>git_root_dir( . '\<CR>'
" nnoremap <silent><expr><Leader>fe ":\<C-u>VimFilerExplorer " . <SID>git_root_dir( . '\<CR>')


" --------------------------------
" vimshell
" --------------------------------
let g:vimshell_user_prompt = 'getcwd()'
let g:vimshell_disable_escape_highlight = 1

" --------------------------------
" srcexpl
" --------------------------------
" Previewを自動表示する
let g:SrcExpl_RefreshTime = 1

" tagsを自動生成
let g:SrcExpl_UpdateTags = 1

" --------------------------------
" vim-unite-vcs
" --------------------------------
nnoremap  [vcs] <Nop>
nmap      fv    [vcs]

nnoremap [vcs]l  :<C-u>Unite vcs/log<CR>
nnoremap [vcs]s  :<C-u>Unite vcs/status<CR>
nnoremap [vcs]r  :<C-u>Unite vcs/file_rec<CR>

"-------------------------------------------------------------------------------
" インデント Indent
"-------------------------------------------------------------------------------
set autoindent   " 自動でインデント
" set paste        " ペースト時にautoindentを無効に(onにするとautocomplpop.vimが動かない)
set cindent      " Cプログラムファイルの自動インデントを始める．これがあれば smartindent 要らない．

" softtabstopはTabキー押し下げ時の挿入される空白の量，0の場合はtabstopと同じ，BSにも影響する
set tabstop=2 shiftwidth=2 softtabstop=0

"ファイルタイプの検索を有効にする
filetype plugin on
"そのファイルタイプにあわせたインデントを利用する
filetype indent on
" これらのftではインデントを無効に
"autocmd FileType php filetype indent off


augroup IndentGroup
  autocmd!
  autocmd BufNewFile,BufRead *.psgi,*.perldb,cpanfile setf perl
  autocmd BufNewFile,BufRead *.hpp,*.cl setf cpp
  autocmd BufNewFile,BufRead *.aj setf java
  autocmd BufNewFile,BufRead *.jspx setf xhtml
  autocmd BufNewFile,BufRead *.tex,*.latex,*.sty,*.dtx,*.ltx,*.bbl setf tex
  autocmd BufNewFile,BufRead *.tt,*.tt2 call s:FTtt2()
  autocmd BufNewFile,BufRead *.html call s:FTtt2html()

  " インデント幅4
  autocmd FileType apache,aspvbs,c,cpp,hpp,cs,diff,java,javascript,perl,php,sh,sql,vb,wsh,xhtml,xml,groovy
        \ setlocal sw=4 sts=4 ts=4 et
  autocmd FileType apache,aspvbs,c,cpp,hpp,cs,diff,java,javascript,perl,php,sh,sql,vb,wsh,xhtml,xml,groovy
        \ setlocal sw=4 sts=4 ts=4 et

  " インデント幅2
  autocmd FileType css,eruby,html,python,ruby,haml,vim,yaml,zsh,scala,tex,tt2,tt2html
        \ setlocal sw=2 sts=2 ts=2 et

  autocmd FileType c,cpp,objc,perl,ruby,java,javascript,css inoremap : ;
  autocmd FileType c,cpp,objc,perl,ruby,java,javascript,css inoremap ; :
  let $BOOST_ROOT = "/usr/local/include/boost"
  autocmd FileType c,cpp,objc set path+=$BOOST_ROOT

  autocmd FileType perl,cgi   compiler perl
  autocmd FileType perl,cgi   map <buffer>,pt <ESC>:%! perltidy<CR> " ソースコード全体を整形
  autocmd FileType perl,cgi   map <buffer>,ptv <ESC>:%'<, '>! perltidy<CR> " 選択された部分のソースコードを整形
  autocmd FileType perl,cgi   setlocal iskeyword+=:
  autocmd FileType perl,cgi   setlocal isfname-=-I
  autocmd FileType perl,cgi   setlocal dictionary+=~/.vim/dict/perl_functions.dict

  autocmd FileType python     setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
  autocmd FileType python     setlocal g:pydiction_location = '~/.vim/pydiction/complete-dict'

  autocmd FileType ruby       compiler ruby
  autocmd FileType ruby       setlocal nocompatible

  autocmd FileType javascript setl omnifunc=javascriptcomplete#CompleteJS
augroup END

" Functions for Template Toolkit 2 syntax
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

" ################################
" 移動・挿入・削除関連の設定
" ################################

" insertモードから抜ける
inoremap <silent> jj <ESC>
inoremap <silent> <C-j> j
inoremap <silent> kk <ESC>
inoremap <silent> <C-k> k

" insertモードでもquit
inoremap <C-q><C-q> <Esc>:wq<CR>
" insertモードでもsave
inoremap <C-w><C-w> <Esc>:w<Insert><CR>

" 行頭・行末移動方向をキーの相対位置にあわせる
nnoremap 0 $
vnoremap 0 $
nnoremap 1 0
vnoremap 1 0

" 押しやすく
nnoremap ^ -
nnoremap $ L

" 表示行単位で行移動する
nmap j gj
nmap k gk
vmap j gj
vmap k gk

" insertモードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" カーソル前の文字削除
inoremap <silent> <C-h> <C-g>u<C-h>
" カーソル後の文字削除
inoremap <silent> <C-d> <Del>
" カーソルから行頭まで削除
inoremap <silent> <C-d>e <Esc>lc^<CR>
" カーソルから行末まで削除
inoremap <silent> <C-d>0 <Esc>lc$<CR>
" カーソルから行頭までヤンク
inoremap <silent> <C-y>e <Esc>ly0<Insert>
" カーソルから行末までヤンク
inoremap <silent> <C-y>0 <Esc>ly$<Insert>

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

" Visualモード時にvで行末まで選択する
vnoremap v $h

" 空行挿入
nnoremap ; :<C-u>call append(expand('.'), '')<CR>

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

" 検索後画面の中心に移動
nnoremap n nzvzz
nnoremap N Nzvzz
nnoremap * *zvzz
nnoremap # *zvzz

" タブの設定
nnoremap ge :<C-u>tabedit<Space>
nnoremap gn :<C-u>tabnew<CR>

" ウィンドウ分割時にウィンドウサイズを調節
nnoremap <silent> <S-Left>  :5wincmd <<CR>
nnoremap <silent> <S-Right> :5wincmd ><CR>
nnoremap <silent> <S-Up>    :5wincmd -<CR>
nnoremap <silent> <S-Down>  :5wincmd +<CR>


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

""" FIN """
