" GUI のみで読み込むプラグイン
NeoBundleSource unite-colorscheme
NeoBundleSource molokai
NeoBundleSource vim-colors-solarized
NeoBundleSource earendel
NeoBundleSource rdark
NeoBundleSource vim-color-github

" ツールバーなし
set guioptions-=T
" スクロールバー無し
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=t
set guioptions-=b
" メニューバー無し
set guioptions-=m
" 無効メニュー項目の灰色表示無し
set guioptions-=g

if has('gui_macvim')
  set showtabline=2
  set imdisable       " IMを無効化
  set transparency=10 " 透明度を指定
  set antialias
  set guifont=Osaka-Mono:h18

  " カラー設定
  colorscheme molokai

  " ウインドウの幅
  set columns=200
  " ウインドウの高さ
  set lines=50

  map gw :macaction selectNextWindow:
  map gW :macaction selectPreviousWindow:

  " 全角スペースを視覚化
  highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
  au BufNewFile,BufRead * match ZenkakuSpace /　/

  " +perl, +python, +ruby  for MacVim
  let $PERL_DLL = "/System/Library/Perl/5.12/darwin-thread-multi-2level/CORE/libperl.dylib"
  let $PYTHON_DLL = "/usr/lib/libpython.dylib"
  let $RUBY_DLL = "/Users/zac/.rvm/rubies/ruby-1.9.3-p194/lib/libruby.dylib"
endif
