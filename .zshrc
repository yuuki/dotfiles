
###############################################
# キーバインド設定                            #
###############################################
# bindkey -v  # viキーバインド

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^P' history-beginning-search-backward-end
bindkey '^N' history-beginning-search-forward-end
bindkey '^R' history-incremental-search-backward

bindkey -a 'O' push-line
bindkey -a 'H' run-help

###############################################
# 補完設定                                    #
###############################################

# 標準の補完
autoload -U compinit promptinit
compinit

# Portageの補完
#promptinit; prompt gentoo

# キャッシュを有効にする
zstyle ':completion::complete:*' use_cache 1

# 補完候補を詰めて表示
setopt list_packed

# タブキー連打で補完候補を順に表示
setopt auto_menu

# スペルチェック
setopt correct

# パスの最後に付くスラッシュを自動的に削除しない
setopt noautoremoveslash

# = 以降でも補完できるようにする( --prefix=/usr 等の場合)
setopt magic_equal_subst

# 補完候補リストの日本語を正しく表示
setopt print_eight_bit

# 補完の時に大文字小文字を区別しない(但し、大文字を打った場合は小文字に変換しない)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# lsコマンドの補完候補にも色付き表示
zstyle ':completion:*:default' list-colors ${LS_COLORS}
# kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

# cdの引数がディレクトリでなく，且つスラッシュで始まるものでもなければ，先頭に'~'を付けて展開
# setopt cdable_vars

# 補完候補一覧でファイルの種別を識別マーク表示(ls -F の記号)
setopt list_types

# ディレクトリ名だけでcdする。
setopt auto_cd

# 対応する括弧などを自動で補完
setopt auto_param_keys

# hub補完
[[ -f $HOME/.bash_completion/hub.bash_completion.sh ]] && . $HOME/.bash_completion/hub.bash_completion.sh
# tig補完
[[ -f $HOME/.bash_completion/tig-completion.bash ]] && . $HOME/.bash_completion/tig-completion.bash

###############################################
# 履歴設定                                    #
###############################################

# ヒストリー機能
HISTFILE=~/.zsh_history      # ヒストリファイルを指定
HISTSIZE=1000000              # ヒストリに保存するコマンド数
SAVEHIST=1000000              # ヒストリファイルに保存するコマンド数
setopt hist_ignore_all_dups  # 重複するコマンド行は古い方を削除
setopt hist_ignore_dups      # 直前と同じコマンドラインはヒストリに追加しない
setopt share_history         # コマンド履歴ファイルを共有する
setopt append_history        # 履歴を追加 (毎回 .zsh_history を作るのではなく)
setopt inc_append_history    # 履歴をインクリメンタルに追加
setopt hist_no_store         # historyコマンドは履歴に登録しない
setopt hist_reduce_blanks    # 余分な空白は詰めて記録
setopt hist_ignore_space     # 先頭がスペースの場合、ヒストリに追加しない#

# cd - と入力してTabキーで今までに移動したディレクトリを一覧表示
setopt auto_pushd
# カレントディレクトリ中に指定されたディレクトリが見つからなかった場合に
# 移動先を検索するリスト。
cdpath=(~)

# ディレクトリスタックに重複する物は古い方を削除
setopt pushd_ignore_dups

# ディレクトリ移動時に自動でls
function chpwd() { ls -a }

###############################################
# プロンプト関係                              #
###############################################
# プロンプトに escape sequence (環境変数) を通す
# setopt prompt_subst

# ターミナルのタイトル
# case "${TERM}"
# in kterm*|xterm)
#     precmd() {
#         echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
#     }
#     ;;
# esac
#
# PROMPT="${USER}@${HOST%%.*}:%/$%  "
# PROMPT2="%_%% "
# SPROMPT="%r is correct? [n,y,a,e]: "

###############################################
# エイリアス設定                              #
###############################################

# MacOS Applications
alias safari='open -a Safari'
alias chrome='open -a GoogleChrome'
alias prev='open -a Preview "$@"'
alias texshop='open -a TexShop'

# Unix Commands
export LSCOLORS=gxfxcxdxbxegedabagacad # lsのDir色を明るくする
alias ls='ls -FG' # --color
alias ll='ls -l'
alias la='ls -a'
# export GREP_OPTIONS='--color=auto --line-number' # grep結果のハイライト
alias grep='grep --color=auto --line-number'
alias pgrep='pgrep -fl'
alias lookup='find . -name "$@"'
alias v='vim'
alias vrc='vim ~/.vimrc'
if [ -f '/Applications/MacVim.app/Contents/MacOS/Vim' ]; then
    alias vim='/Applications/MacVim.app/Contents/MacOS/Vim -u $HOME/.vimrc'
    alias mvim='/Applications/MacVim.app/Contents/MacOS/MacVim -u $HOME/.vimrc'
fi

# GNU coreutils
if [ "$PS1" ] && [ -f '/usr/local/Cellar/coreutils/8.19/aliases' ]; then
    . /usr/local/Cellar/coreutils/8.19/aliases
    alias ls='gls -FG --color'
fi

alias br='brew'
alias bri='brew install'
alias brs='brew search'
alias bru='brew update'

alias r='rails'
alias pd='perldoc'
alias ce='carton exec'
alias ci='carton install'
alias plackup='plackup -L Shotgun'

alias pdftotext='pdftotext -layout -'

# global alias
alias -g TELLME='&& say succeeded || say failed'
alias -g G="| grep"
alias -g XG='| xargs grep'
alias -g H='| head'
alias -g L='| less -R'
alias -g W='| wc'
alias -g WL='| wc -l'
alias -g T='| tail'
alias -g ...='..//..'
alias -g ....='..//..//..'
alias -g .....='..//..//..//..'

# Utility Commands
alias findbig='find . -type f -exec ls -s {} \; | sort -n -r | head -5'
alias cpurank='ps -eo user,pcpu,pid,cmd | sort -r -k2 | head -6'
alias diskrank='du -ah | sort -r -k1 | head -5'

# hub関連
if [[ -x "$(/usr/bin/which -s hub)" ]]; then
  function git() { hub "$@" }
  eval "$(hub alias -s)"
fi


###############################################
# その他                                      #
###############################################
# ファイル作成時のパーミッション
umask 022

setopt no_beep               # ビープ音を消す
#setopt nolistbeep           # 補完候補表示時などにビープ音を鳴らさない

#setopt interactive_comments # コマンドラインで # 以降をコメントとする

setopt numeric_glob_sort     # 辞書順ではなく数値順でソート

setopt no_multios            # zshのリダイレクト機能を制限する

unsetopt promptcr            # 改行コードで終らない出力もちゃんと出力する
setopt ignore_eof            # Ctrl-dでログアウトしない

setopt no_hup                # ログアウト時にバックグラウンドジョブをkillしない
setopt no_checkjobs          # ログアウト時にバックグラウンドジョブを確認しない
setopt notify                # バックグラウンドジョブが終了したら(プロンプトの表示を待たずに)すぐに知らせる

setopt rm_star_wait          # rm * を実行する前に確認
#setopt rm_star_silent       # rm * を実行する前に確認しない
#setopt no_clobber           # リダイレクトで上書きを禁止
unsetopt no_clobber          # リダイレクトで上書きを許可

setopt chase_links           # シンボリックリンクはリンク先のパスに変換してから実行
setopt print_exit_value      # 戻り値が 0 以外の場合終了コードを表示
setopt single_line_zle       # デフォルトの複数行コマンドライン編集ではなく、１行編集モードになる

setopt auto_pushd            # 移動元のディレクトリを自動的にディレクトリスタックに記憶
setopt pushd_ignore_dups     # 重複するディレクトリ名を削除
setopt auto_list             # lsのリスト表示
setopt auto_menu             # lsのメニュー化

#
# clip current directory path
#
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

[[ -s $HOME/.zsh/antigen/antigen.zsh ]] && source $HOME/.zshrc.antigen

