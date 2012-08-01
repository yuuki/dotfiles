if has('gui_macvim')
  set showtabline=2
  set imdisable      " IMを無効化
  set transparency=20 " 透明度を指定
  set antialias
  set guioptions-=T  " ツールバー非表示
  set guifont=Osaka-Mono:h18

  " カラー設定:
  colorscheme slate
  " ウインドウの幅
  set columns=200
  " ウインドウの高さ
  set lines=50

  map gw :macaction selectNextWindow:
  map gW :macaction selectPreviousWindow:

  "全角スペースを視覚化
  highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
  au BufNewFile,BufRead * match ZenkakuSpace /　/
endif

