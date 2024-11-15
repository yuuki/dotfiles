### Abbr

abbr -a re . ~/.config/fish/config.fish
abbr -a cf {$EDITOR} ~/.config/fish/config.fish

abbr -a q exit
abbr -a v nvim
abbr -a c code
abbr -a s ssh

abbr -a l ls -CF
abbr -a ll ls -lh
abbr -a la ls -a
abbr -a cp cp -p

abbr -a mb make build
abbr -a mt make test

abbr -a g git
abbr -a gst git status
abbr -a gl git log -p
abbr -a gbr gh pr view --web
abbr -a gv gh repo view --web
abbr -a gmr 'gh pr merge --auto --rebase; git switch - && git pull --rebase'
abbr -a u cd-gitroot

abbr -a pr poetry run
abbr -a pcat python3 -m pickle

abbr -a prev open -a Preview

abbr -a k kubectl
abbr -a d docker
abbr -a dm docker-machine
abbr -a dc docker-compose

abbr -a gcs gcloud compute ssh

abbr -a jq gojq

abbr -a clip "nc -q0 -U ~/.clipper.sock" # clipper

abbr -a now '(date +%Y%m%d_%H%M%S)'
abbr -a cdir '(basename $PWD)'
abbr -a dirnow '(basename $PWD)_(date +%Y%m%d_%H%M%S)'

abbr -a slog script -f '/tmp/(basename $PWD)_(date +%Y%m%d_%H%M%S).log'

### Key bindings

bind \cxb 'fzf_git_recent_branch'

bind \cs '__ghq_repository_search'
if bind -M insert >/dev/null 2>/dev/null
    bind -M insert \cs '__ghq_repository_search'
end

### Enviroment variables

# LANG
set -x LANG en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8

set -x EDITOR nvim
set -x PAGER less

# Init path
set -x PATH /usr/local/bin /usr/local/sbin /usr/sbin /usr/bin /sbin /bin

# User specifc path
set -x PATH "$HOME/.local/bin" "$HOME/local/bin" "$HOME/bin" $PATH

# Homebrew
if type -q /opt/homebrew/bin/brew
  eval (/opt/homebrew/bin/brew shellenv)
end

# Homebrew path
set -x PATH "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" $PATH

# OSX Python
set -x PATH "$HOME/Library/Python/3.8/bin" $PATH

# coreutils
# set -x PATH "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin" $PATH
set -x PATH "$HOMEBREW_PREFIX/opt/gettext/bin" "$HOMEBREW_PREFIX/opt/grep/libexec/gnubin" $PATH

# mise
if type -q mise
  mise activate fish | source
end

# Languages path
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH "$HOME/.rbenv/bin" "$HOME/.plenv/bin" "$PYENV_ROOT/bin" $PATH

# Go
set -x PATH $HOME/.goenv/bin $PATH
if type -q goenv
  goenv init - | source
end
set -x PATH "$HOME/go/bin" $PATH

# Python
if type -q pyenv
  pyenv init --path | source
end

# Python
set -x PATH "$HOME/.poetry/bin" $PATH

# Ruby
set -x PATH "$HOMEBREW_PREFIX/opt/ruby/bin" (gem environment gemdir)/bin $PATH

# Node.js
set -x PATH "$HOME/.ndenv/bin" $PATH

# Kubernetes
set -x PATH "$HOME/.krew/bin" $PATH
set -x PATH "$HOME/.kube/plugins/jordanwilson230" $PATH

# sudo
set -x SUDO_PATH /usr/local/sbin /usr/sbin /sbin

# Man
set -x MAN_PATH "HOMEBREW_PREFIX/share/man" "$HOME/local/share/man" /usr/local/share/man /usr/share/man

# Java
set -x CLASSPATH $CLASSPATH "$JAVA_HOME/lib" .

# Rust
if type -q rustc
  set -x RUST_SRC_PATH "(rustc --print sysroot)/lib/rustlib/src/rust/src/"
end

# Krew
set -x PATH $HOME/.krew/bin $PATH

# Library path
set -x LD_LIBRARY_PATH "$HOMEBREW_PREFIX/lib" $LD_LIBRARY_PATH
set -x DYLD_FALLBACK_LIBRARY_PATH "$HOMEBREW_PREFIX/lib" "$DYLD_FALLBACK_LIBRARY_PATH"
set -x C_INCLUDE_PATH "$HOMEBREW_PREFIX/include" $C_INCLUDE_PATH
set -x CPLUS_INCLUDE_PATH "$HOMEBREW_PREFIX/include"
set -x CFLAGS "-I$HOMEBREW_PREFIX/include"
set -x CXXLAGS "-I$HOMEBREW_PREFIX/include"
set -x LDFLAGS "-L$HOMEBREW_PREFIX/lib"

# GCP
set -x USE_GKE_GCLOUD_AUTH_PLUGIN True

# Lima
if test (uname) = "Darwin"
  set -x DOCKER_HOST "unix://$HOME/.lima/docker/sock/docker.sock"
end

### External tools settings

# rbenv
if type -q rbenv
  rbenv init - --no-rehash | source
end

# plenv
if type -q plenv
  plenv init - | source
end

# pyenv
if type -q pyenv
  status is-login; and pyenv init --path | source
  status is-interactive; and pyenv init - | source
end

# direnv
if type -q direnv
  eval (direnv hook fish)
end

# dockertoolbox
if type -q docker-machine
  docker-machine env default 2>/dev/null
end

# go
if type -q goenv
  goenv init - | source
end

# rustup
if test -e "$HOME/.cargo/env"
  set -U fish_user_paths $fish_user_paths $HOME/.cargo/bin
end

# ndenv
if test -e ndenv
  eval (ndenv init - | source)
end

### Functions

# auto tmux
## Disable when migrating Alacritty terminal to WezTerm
# function attach_tmux_session_if_needed
#   set ID (tmux list-sessions)
#   if test -z "$ID"
#     tmux new-session
#     return
#   end

#   set new_session "Create New Session"
#   set ID (echo $ID\n$new_session | fzf | cut -d: -f1)
#   if test "$ID" = "$new_session"
#     tmux new-session
#   else if test -n "$ID"
#     tmux attach-session -t "$ID"
#   end
# end

# if test -z $TMUX && status --is-login
#     attach_tmux_session_if_needed
# end

# Share history
function history-merge --on-event fish_preexec
  history --save
  history --merge
end

# Git checkout branch
# ref. https://qiita.com/geekduck/items/a521b6d095266a060cfd
function fzf-checkout-branch
    set -l branchname (
        env FZF_DEFAULT_COMMAND='git --no-pager branch -a | grep -v HEAD | sed -e "s/^.* //g"' \
            fzf --height 70% --prompt "BRANCH NAME>" \
                --preview "git --no-pager log -20 --color=always {}"
    )
    if test -n "$branchname"
        git checkout (echo "$branchname"| sed "s#remotes/[^/]*/##")
    end
end

# Generated for envman. Do not edit.
test -s "$HOME/.config/envman/load.fish"; and source "$HOME/.config/envman/load.fish"
