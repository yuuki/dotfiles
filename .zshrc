# vim:set ft=zsh foldmethod=marker:
umask 022
limit coredumpsize 0

### Load modules {{{
autoload -Uz compinit; compinit -C
autoload -Uz history-search-end
autoload -Uz vcs_info
autoload -Uz term_info
autoload -Uz zmv
autoload -Uz zcalc
autoload -Uz smart-insert-last-word
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs
autoload -Uz cdr
# autoload -Uz promptinit && promptinit
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
# setopt single_line_zle       # デフォルトの複数行コマンドライン編集ではなく，１行編集モードになる
setopt auto_list             # lsのリスト表示
setopt auto_menu             # lsのメニュー化
unsetopt promptcr            # 改行コードで終らない出力もちゃんと出力する
unsetopt no_clobber          # リダイレクトで上書きを許可

### }}}

### plugins {{{
if [[ -f "${ZSH_HOME}/plugins/zsh-git-prompt/zshrc.sh" ]]; then
  source "${ZSH_HOME}/plugins/zsh-git-prompt/zshrc.sh"
  export GIT_PROMPT_EXECUTABLE="haskell"
  export ZSH_THEME_GIT_PROMPT_CACHE=1
fi
# if [[ -f "${ZSH_HOME}/plugins/zsh-directory-history/directory-history.plugin.zsh" ]]; then
#   export PATH="$PATH":"${ZSH_HOME}/plugins/zsh-directory-history/"
#   source "${ZSH_HOME}/plugins/zsh-directory-history/directory-history.plugin.zsh"
# fi
# if [[ -f "${ZSH_HOME}/plugins/zsh-autosuggestions/autosuggestions.plugin.zsh" ]]; then
#   source "${ZSH_HOME}/plugins/zsh-autosuggestions/autosuggestions.plugin.zsh"
#   zle-line-init() {
#       zle autosuggest-start
#   }
#   zle -N zle-line-init
#   bindkey '^T' autosuggest-toggle
# fi
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

# Peco
bindkey '^x^b' peco-git-recent-branches
bindkey '^xb' peco-git-recent-all-branches
bindkey '^s' peco-ghq
bindkey '^xp' peco-git-add
bindkey '^mr' peco-mkr-roles
bindkey '^mo' peco-mkr-roles-open
bindkey '^mh' peco-mkr-hosts
bindkey '^[o' complete-mackerel-host-ip

# # Bind up/down arrow keys to navigate through your history
# bindkey '^\e[B' directory-history-search-backward
# bindkey '^\e[A' directory-history-search-forward
# # Bind CTRL+k and CTRL+j to substring search
# bindkey '^j' history-substring-search-down
# bindkey '^k' history-substring-search-up

## Ctrl + ] で前回のコマンドの最後の単語を挿入
zle -N insert-last-word smart-insert-last-word
zstyle :insert-last-word match \
    '*([^[:space:]][[:alpha:]/\\]|[[:alpha:]/\\][^[:space:]])*'
bindkey '^]' insert-last-word

### }}}

### Completion {{{
# 補完に使うソース
zstyle ':completion:*' completer _complete _expand _list _match _prefix _approximate

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

### Prompt {{{
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[yellow]%}%{✚%G%}" # default blue but hard to see

PROMPT="%{$fg_bold[NCOLOR]%}%{$fg_bold[green]%}%p %{$fg[cyan]%}%c "
GIT_PROMPT='%b$(git_super_status) %'
PROMPT="${PROMPT}${GIT_PROMPT} %{$reset_color%}"
### }}}

### Aliases {{{
alias q='exit'
alias h='proxychains4 -q -f ~/.proxychains/htn.conf'
alias t='tsocks'
alias s='ssh'
alias ts='tssh'
alias hs='h ssh'
alias hssh='h ssh'
alias hts='h tssh'
alias htssh='h tssh'
alias hbe='h bundle exec'
alias fe='furo2 exec'

## Docker
alias d='docker'
alias dps='docker ps'
alias drm='docker rm'
alias dr='docker run'
alias drr='docker run --rm'
alias drs='docker run --security-opt seccomp:unconfined --cap-add SYS_PTRACE'
alias db='docker build -t'
alias dl='docker ps -l -q'
#alias dssh='boot2docker ssh'
alias dexec='docker exec -it `docker ps | tail -n +2 | peco | cut -d " " -f1` /bin/bash'
#alias b2d='boot2docker'
#alias b2d-datesync='boot2docker ssh sudo /usr/local/bin/ntpclient -s -h pool.ntp.org date'
alias dm='docker-machine'
alias dc='docker-compose'

## Git
alias g='git'
alias gst='git status'
alias gl='git log -p'
alias gg='git grep -H --break'
alias gbr='git-browse-remote'

## Make
alias mb='make build'
alias mt='make test'

## Vim
#alias mvim='~/Applications/MacVim.app/Contents/bin/mvim'
alias mvim='open -n -a ~/Applications/MacVim.app'

## Utils
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -a'
alias lla='ls -alh'
alias cp='cp -p'
alias grep='grep --color=auto'
alias gr=grep
alias pg=pgrep
alias lookup='find . -name "$@"'
alias zmv='noglob zmv'
alias be="bundle exec"
alias cap="/opt/homebrew/bin/cap"
#alias dntpsync="boot2docker ssh sudo ntpclient -s -h pool.ntp.org"
alias r="roles"
alias matrix="docker run -it --rm nathanleclaire/matrix_japan cmatrix -"
## memo
alias memo='code -n ~/Dropbox/memo/tmp.txt ~/Dropbox/memo/goal.md'
alias memolist='vim +MemoList'
alias memonew='vim +MemoNew'
## rust
alias cb='cargo build'
alias cr='cargo run'
## Homebrew
alias br=brew
alias bri='brew install'
alias bru='brew update'
alias brug='brew upgrade'
## Perl
alias ce='carton exec'
alias ci='carton install'
alias cpanm-local='cpanm --installdeps -L local/ .'
alias perl-local='perl -Mlib::core::only -Mlib=local/lib/perl5/'

if [[ -x /usr/local/bin/colordiff ]]; then
  alias diff='colordiff'
fi

export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case -R'
if [[ -x /usr/local/bin/src-hilite-lesspipe.sh ]]; then
  export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'
fi

## VScode
alias c='code'

## Vim
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

export LESS="--tabs=4 --no-init --LONG-PROMPT --ignore-case -R"
if [[ -x /usr/local/bin/src-hilite-lesspipe.sh ]]; then
  export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'
fi

## util
alias findbig='find . -type f -exec ls -s {} \; | sort -n -r | head -5'
alias cpurank='ps -eo user,pcpu,pid,cmd | sort -r -k2 | head -6'
alias diskrank='du -ah | sort -r -k1 | head -5'
alias pbcopy='xclip -selection c'

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

# Linux only
if [[ "$(uname 2> /dev/null)" == "Linux" ]]; then
  alias pbcopy='xclip -selection c'
fi
### }}}

# Vim側でC-s C-q
stty -ixon -ixoff

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

function cliime() {
  if [ $# = 0 ]; then
    echo "usage: cliime RO-MAJI"
    return 1
  fi

  BUNDLE_GEMFILE=~/build/cliime/Gemfile bundle exec -- ruby ~/build/cliime/cliime.rb $@ | peco | pbcopy
}

function tsshrb() {
  BUNDLE_GEMFILE=~/build/tmux-cssh-rb/Gemfile bundle exec -- ruby ~/build/tmux-cssh-rb/bin/tssh -l y_uuki $@
}
function ntssh() {
  BUNDLE_GEMFILE=~/build/tmux-cssh-rb/Gemfile bundle exec -- ruby ~/build/tmux-cssh-rb/bin/tssh -l y_uuki -c ~/.tsshrc_vlo $@
}

function exists { which $1 &> /dev/null }

if exists fzf; then
    function peco_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(fc -l -n 1 | eval $tac | fzf --query "${LBUFFER}")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N peco_select_history
    bindkey '^R' peco_select_history
fi

function peco-mkr-roles() {
  local selected_role=$(mkr services | jq -rM '[.[] | .name as $name | .roles // [] | map("\($name) \(.)")] | flatten | .[]' | fzf --query "${LBUFFER}")
  if [ -n "${selected_role}" ]; then
     local BUFFER="tssh \`roles "${selected_role}"\`"
  fi
  zle clear-screen
}
zle -N peco-mkr-roles

function peco-mkr-roles-open() {
  local org_name='hatena'
  local selected_role=$(mkr services | jq -rM '[.[] | .name as $name | .roles // [] | map("\($name)/\(.)")] | flatten | .[]' | fzf --query "${LBUFFER}")
  if [ -n "${selected_role}" ]; then
     local BUFFER="open https://mackerel.io/orgs/${org_name}/services/${selected_role}/-/graphs"
     zle accept-line
  fi
  zle clear-screen
}
zle -N peco-mkr-roles-open

function peco-mkr-hosts() {
  local selected_host=$(mkr hosts | jq -r -M ".[].name" | fzf --query "${LBUFFER}")
  if [ -n "${selected_host}" ]; then
     local BUFFER="$selected_host"
  fi
  zle clear-screen
}
zle -N peco-mkr-hosts

function peco-git-recent-branches () {
    local selected_branch=$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads | \
        perl -pne 's{^refs/heads/}{}' |  peco)
    if [ -n "$selected_branch" ]; then
        local BUFFER="git checkout ${selected_branch}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-git-recent-branches

function peco-git-recent-all-branches () {
    local selected_branch=$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads refs/remotes | \
        perl -pne 's{^refs/(heads|remotes)/}{}' | peco )
    if [ -n "$selected_branch" ]; then
        local BUFFER="git checkout ${selected_branch}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-git-recent-all-branches

function peco-ghq () {
    local selected_dir=$((cdr -l | awk '{print $2}'; ghq list --full-path) | fzf --query "${LBUFFER}")
    if [ -n "$selected_dir" ]; then
        local BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-ghq

function peco-git-add () {
    local selected_file="$(git status --porcelain | \
                                  sed '/^[A|UU|M]/d' | \
                                  peco | \
                                  awk -F ' ' '{print $NF}')"
    if [ -n "$selected_file" ]; then
        search_root=$(git rev-parse --show-toplevel)
        files=$(echo "$selected_file" | tr '\n' ' ')
        local BUFFER="cd ${search_root} && git add ${files}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-git-add

function gpi () {
    [ "$#" -eq 0 ] && echo "Usage : gpi QUERY" && return 1
    ghs "$@" | peco | awk '{print $1}' | ghq import
}

function gpr () {
    ghq list --full-path | peco | xargs rm -r
}

function u()
{
    cd ./$(git rev-parse --show-cdup)
    if [ $# = 1 ]; then
        cd $1
    fi
}

function gget() {
    ghq get $(echo "$@" | gsed -e "s/\.git//")
}

function uu() {
    gsed -i "s/ssh:\/\/git@github\.com\/\(.*\)/git@github.com:\1.git/" .git/config
}

function gc () {
    cd $(gget $1 | tee -a /dev/stderr | tail -n 1 | awk '{ print $NF }')
}

function da () {
    docker start $1 && docker attach $1
}

function dbox () {
    docker run -it --name $1 --volumes-from=volume_container \
    -e BOX_NAME=$1 yuuk1/dev
}

function dbash() {
    local image=$(docker images | tail -n +2 | peco | cut -d " " -f1)
    if [ -n "$image" ]; then
        docker run --rm --entrypoint=/bin/bash -it $image
    fi
}

function git-ignore() { curl -s https://www.gitignore.io/api/$@ ;}

function git-ignore-list() {
  git-ignore `git-ignore list | ruby -ne 'puts $_.split(",")' | peco`
}
### }}}

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && . /Users/y_uuki/.travis/travis.sh

# http://motemen.hatenablog.com/entry/2015/07/mackerel-mkr-peco-zsh
autoload -U modify-current-argument
autoload -U split-shell-arguments

funcition complete-mackerel-host-ip () {
    local apikey=$1
    local apikey_name=$2

    local mode_append_only=0
    local REPLY
    local reply

    local filter='peco'

    split-shell-arguments
    if [ $(($REPLY % 2)) -eq 0 ]; then
        # query by word under cursor
        query_arg="--query=$reply[$REPLY]"
    elif [ -n "${LBUFFER##* }" ]; then
        # query by word jsut before cursor
        query_arg="--query=${LBUFFER##* }"
    else
        # no word detected
        query_arg='--query='
        mode_append_only=1
    fi

    res=$(MACKEREL_APIKEY=${apikey:-$MACKEREL_APIKEY} MACKEREL_APIKEY_NAME=${apikey_name:-$MACKEREL_APIKEY_NAME} mkr-hosts-tsv | eval $filter "$query_arg")
    if [ -z "$res" ]; then
        zle reset-prompt
        return 1
    fi

    ip=$(echo "$res" | cut -f1)
    host=$(echo "$res" | cut -f2)

    if [ $mode_append_only = 1 ]; then
        LBUFFER+="$host"
    else
        modify-current-argument "$host"
    fi

    BUFFER+=" # $ip"

    zle reset-prompt
}
zle -N complete-mackerel-host-ip

function open-mackerel-role () {
    local apikey=$1
    local apikey_name=$2

    local mode_append_only=0
    local REPLY
    local reply

    local filter='peco'

    split-shell-arguments
    if [ $(($REPLY % 2)) -eq 0 ]; then
        # query by word under cursor
        query_arg="--query=$reply[$REPLY]"
    elif [ -n "${LBUFFER##* }" ]; then
        # query by word jsut before cursor
        query_arg="--query=${LBUFFER##* }"
    else
        # no word detected
        query_arg='--query='
        mode_append_only=1
    fi

    res=$(MACKEREL_APIKEY=${apikey:-$MACKEREL_APIKEY} MACKEREL_APIKEY_NAME=${apikey_name:-$MACKEREL_APIKEY_NAME} mkr-hosts-tsv | eval $filter "$query_arg")
    if [ -z "$res" ]; then
        zle reset-prompt
        return 1
    fi

    ip=$(echo "$res" | cut -f1)
    host=$(echo "$res" | cut -f2)

    if [ $mode_append_only = 1 ]; then
        LBUFFER+="$host"
    else
        modify-current-argument "$host"
    fi

    BUFFER+=" # $ip"

    zle reset-prompt
}
zle -N open-mackerel-role

source ~/.zshrc.local

# End profiling
# if (which zprof > /dev/null) ;then
#     zprof | cat
# fi

# added by travis gem
[ -f /Users/y_uuki/.travis/travis.sh ] && source /Users/y_uuki/.travis/travis.sh
