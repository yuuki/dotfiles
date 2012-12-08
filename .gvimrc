" GUI のみで読み込むプラグイン
NeoBundleSource unite-colorscheme
NeoBundleSource molokai
NeoBundleSource vim-colors-solarized
NeoBundleSource vim-color-github
NeoBundleSource earendel
NeoBundleSource rdark

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

  " カラースキーム
  set background=dark
  colorscheme solarized

  " ウインドウの幅
  set columns=200
  " ウインドウの高さ
  set lines=50

  map gw :macaction selectNextWindow:
  map gW :macaction selectPreviousWindow:

  " 全角スペースを視覚化
  highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
  au BufNewFile,BufRead * match ZenkakuSpace /　/

endif
