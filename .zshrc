# vim:set ft=zsh foldmethod=marker:

umask 022
limit coredumpsize 0

### Load oh-my-zsh plugins and thema {{{
[[ -s $HOME/.zshrc.antigen ]] && source $HOME/.zshrc.antigen
### }}}

### Load modules {{{
autoload -Uz compinit; compinit -u
autoload -Uz colors; colors
autoload -Uz history-search-end
autoload -Uz vcs_info
autoload -Uz term_info
autoload -Uz zmv
autoload -Uz zcalc
autoload -Uz smart-insert-last-word
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs
autoload -Uz cdr
### }}}

### Set options {{{
# Completion
setopt list_packed           # 補完候補を詰めて表示
setopt auto_menu             # タブキー連打で補完候補を順に表示
setopt correct               # スペルチェック
setopt noautoremoveslash     # パスの最後に付くスラッシュを自動的に削除しない
setopt magic_equal_subst     # = 以降でも補完できるようにする( --prefix=/usr 等の場合)
setopt print_eight_bit       # 補完候補リストの日本語を正しく表示
setopt list_types            # 補完候補一覧でファイルの種別を識別マーク表示(ls -F の記号)
setopt auto_cd               # ディレクトリ名だけでcdする。
setopt auto_param_keys       # 対応する括弧などを自動で補完
setopt cdable_vars           # cdの引数がディレクトリでなく，且つスラッシュで始まるものでもなければ，先頭に'~'を付けて展開
setopt complete_in_word      # カーソル位置で補完
setopt glob_complete         # glob を展開しない
setopt hist_expand           # ヒストリを展開
setopt numeric_glob_sort     # 数字としてソート

# History
setopt extended_history      # 実行時間と時刻保存
setopt hist_ignore_all_dups  # 重複するコマンド行は古い方を削除
setopt hist_ignore_dups      # 直前と同じコマンドラインはヒストリに追加しない
setopt share_history         # プロセス間でヒストリを共有する
setopt append_history        # 履歴を追加 (毎回 .zsh_history を作るのではなく)
setopt inc_append_history    # 履歴をインクリメンタルに追加
setopt hist_no_store         # historyコマンドは履歴に登録しない
setopt hist_reduce_blanks    # 余分な空白は詰めて記録
setopt hist_ignore_space     # 先頭がスペースの場合、ヒストリに追加しない#
setopt no_flow_control       # C-s を殺すな

# Direcotory
setopt auto_pushd            # 移動元のディレクトリを自動的にディレクトリスタックに記憶
setopt pushd_ignore_dups     # ディレクトリスタックに重複する物は古い方を削除

# Others
setopt no_beep               # ビープ音を消す
setopt interactive_comments  # コマンドラインで # 以降をコメントとする
setopt numeric_glob_sort     # 辞書順ではなく数値順でソート
setopt no_multios            # zshのリダイレクト機能を制限する
setopt ignore_eof            # Ctrl-dでログアウトしない
setopt no_hup                # ログアウト時にバックグラウンドジョブをkillしない
setopt no_checkjobs          # ログアウト時にバックグラウンドジョブを確認しない
setopt notify                # バックグラウンドジョブが終了したら(プロンプトの表示を待たずに)すぐに知らせる
setopt rm_star_wait          # rm * を実行する前に確認
setopt chase_links           # シンボリックリンクはリンク先のパスに変換してから実行
setopt print_exit_value      # 戻り値が 0 以外の場合終了コードを表示
setopt single_line_zle       # デフォルトの複数行コマンドライン編集ではなく，１行編集モードになる
setopt auto_list             # lsのリスト表示
setopt auto_menu             # lsのメニュー化
unsetopt promptcr            # 改行コードで終らない出力もちゃんと出力する
unsetopt no_clobber          # リダイレクトで上書きを許可

### }}}

### Keybind {{{
bindkey -e  # Emacs like keybind

bindkey "^[u" undo
bindkey "^[r" redo
bindkey '^J'  self-insert-unmeta

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^P' history-beginning-search-backward-end
bindkey '^N' history-beginning-search-forward-end
bindkey '^R' history-incremental-search-backward
bindkey "^S" history-incremental-pattern-search-forward
bindkey -a 'O' push-line
bindkey -a 'H' run-help

## Ctrl + ] で前回のコマンドの最後の単語を挿入
zle -N insert-last-word smart-insert-last-word
zstyle :insert-last-word match \
    '*([^[:space:]][[:alpha:]/\\]|[[:alpha:]/\\][^[:space:]])*'
bindkey '^]' insert-last-word

### }}}

### Completion {{{
# 補完に使うソース
zstyle ':completion:*' completer _complete _expand _list _match _prefix _approximate _history

# Enable cache
zstyle ':completion::complete:*' use_cache 1

# スマートケースで補完
zstyle ':completion:*' matcher-list ' 'm:{a-z}={A-Z}' 'm:{A-Z}={a-z}''

# ls
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"

# cd
zstyle ':completion:*:cd:*' tag-order local-directories path-directories

# kill
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

# Select like Emacs
zstyle ':completion:*:default' menu select=1

# sudo を含めても保管できるようにする
zstyle ':completion:*:sudo:*' command-path $sudo_path $path

# Verbose
zstyle ':completion:*' verbose yes

# hub補完
[[ -f $HOME/.bash_completion/hub.bash_completion.sh ]] && . $HOME/.bash_completion/hub.bash_completion.sh
# tig補完
[[ -f $HOME/.bash_completion/tig-completion.bash ]] && . $HOME/.bash_completion/tig-completion.bash

### }}}

### {{{ cdr
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 5000
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both
### }}}

### History {{{
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000000
SAVEHIST=$HISTSIZE
### }}}

### Aliases {{{
alias q='exit'

## Utils
alias ll='ls -lh'
alias la='ls -a'
alias lla='ls -alh'
alias cp='cp -p'
alias grep='grep --color=auto'
alias gr=grep
alias pgrep='pgrep -fl'
alias pg=pgrep
alias lookup='find . -name "$@"'
alias df='df -h'
alias du='du -h'
alias less='less -R'
alias zmv='noglob zmv'
alias pdftotext='pdftotext -layout -'

if [[ -x /usr/local/bin/colordiff ]]; then
  alias diff='colordiff'
fi

export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case -R'
if [[ -x /usr/local/bin/src-hilite-lesspipe.sh ]]; then
  export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'
fi

## vim
alias v='vim'
alias vrc='vim ~/.vimrc'
if [ -f '/Applications/MacVim.app/Contents/MacOS/Vim' ]; then
    alias vim='/Applications/MacVim.app/Contents/MacOS/Vim -u $HOME/.vimrc'
    # alias mvim='/Applications/MacVim.app/Contents/MacOS/MacVim -u $HOME/.vimrc'
    alias mvim='open -a MacVIm.app "$@"'
fi
# vimがなくてもvimでviを起動する。
if ! type vim > /dev/null 2>&1; then
    alias vim=vi
fi

# GitFlow & HubFlow
alias gf='git flow'
alias ghf='git hf'

export LESS="--tabs=4 --no-init --LONG-PROMPT --ignore-case -R"
if [[ -x /usr/local/bin/src-hilite-lesspipe.sh ]]; then
  export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'
fi

# Tex
alias -s tex=platex
alias -s dvi=dvipdfmx
alias -s bib=bibtex

# Homebrew
alias br=brew
alias bri='brew install'
alias bru='brew update'
alias brug='brew upgrade'

## Others
alias ce='carton exec'
alias ci='carton install'
alias plackup='plackup -L Shotgun'

## Perl
alias cpanm-local='cpanm --installdeps -L local/ .'
alias perl-local='perl -Mlib::core::only -Mlib=local/lib/perl5/'

## pipe
alias findbig='find . -type f -exec ls -s {} \; | sort -n -r | head -5'
alias cpurank='ps -eo user,pcpu,pid,cmd | sort -r -k2 | head -6'
alias diskrank='du -ah | sort -r -k1 | head -5'

## OSX GUI
alias safari='open -a Safari'
alias chrome='open -a GoogleChrome'
alias prev='open -a Preview'
alias texshop='open -a TexShop'

# global alias
alias -g TELLME='&& say succeeded || say failed'
alias -g G="| grep"
alias -g XG='| xargs grep'
alias -g H='| head'
alias -g T='| tail'
alias -g L='| less -R'
alias -g V='| view -R -'
alias -g W='| wc'
alias -g WL='| wc -l'
alias -g P=' --help | less'
alias -g ...='..//..'
alias -g ....='..//..//..'
alias -g .....='..//..//..//..'
### }}}

# Vim側でC-s C-q
stty -ixon -ixoff

### plugins {{{
# cdd
if [[ -f "${ZSH_HOME}/plugins/cdd/cdd" ]]; then
  source "${ZSH_HOME}/plugins/cdd/cdd"
  add-zsh-hook chpwd _cdd_chpwd
fi
if [[ -f "${ZSH_HOME}/plugins/auto-fu.zsh/auto-fu.zsh" ]]; then
  # source "${ZSH_HOME}/plugins/auto-fu.zsh/auto-fu.zsh"
  # zle-line-init () {auto-fu-init;}; zle -N zle-line-init
  # zstyle ':completion:*' completer _oldlist _complete
  # zle -N zle-keymap-select auto-fu-zle-keymap-select
fi
### }}}

### functions {{{

## ディレクトリ移動時に自動でls
function chpwd() { ls -a }

function history-all { history -E 1 }

function mkcd() {
    if (( ARGC != 1 )); then
        printf 'usage: mkcd <new-directory>\n'
        return 1;
    fi
    if [[ ! -d "$1" ]]; then
        command mkdir -p "$1"
    else
        printf '"%s" already exists: cd-ing.\n' "$1"
    fi
    builtin cd "$1"
}

## clip current directory path
function pwd-clip() {
    local copyToClipboard

    if which pbcopy >/dev/null 2>&1 ; then
        # Mac
        copyToClipboard='pbcopy'
    elif which xsel >/dev/null 2>&1 ; then
        # Linux
        copyToClipboard='xsel --input --clipboard'
    elif which putclip >/dev/null 2>&1 ; then
        # Cygwin
        copyToClipboard='putclip'
    else
        copyToClipboard='cat'
    fi

    # ${=VAR} enables SH_WORD_SPLIT option
    # so ${=VAR] is splited in words, for example "a" "b" "c"
    echo -n $PWD | ${=copyToClipboard}
}

# url: $1, delimiter: $2, prefix: $3, words: $4..
function web_search {
  local url=$1       && shift
  local delimiter=$1 && shift
  local prefix=$1    && shift
  local query

  while [ -n "$1" ]; do
    if [ -n "$query" ]; then
      query="${query}${delimiter}${prefix}$1"
    else
      query="${prefix}$1"
    fi
    shift
  done

  open "${url}${query}"
}

function qiita () {
  web_search "http://qiita.com/search?utf8=✓&q=" "+" "" $*
}

function google () {
  web_search "https://www.google.co.jp/search?&q=" "+" "" $*
}

# search in metacpan
function perld() {
  command perldoc $1 2>/dev/null
  [ $? -ne 0 ] && web_search "https://metacpan.org/search?q=" "+" "" $*
  return 0
}

# search in rurima
function rurima () {
  web_search "http://rurema.clear-code.com" "/" "query:" $*
}

# search in rubygems
function gems () {
  web_search "http://rubygems.org/search?utf8=✓&query=" "+" "" $*
}

# search in github
function ghub () {
  web_search "https://github.com/search?type=Code&q=" "+" "" $*
}
### }}}
