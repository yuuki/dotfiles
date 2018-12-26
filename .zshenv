# vim:set ft=zsh foldmethod=marker:

# Start profiling
# zmodload zsh/zprof && zprof

# ZSH_HOME
export ZSH_HOME=${HOME}/.zsh
# /etc/profile を読み込まないように
setopt no_global_rcs

# Local
export LANG='en_US.UTF-8'
export LC_CTYPE="en_US.UTF-8"

# fpath
typeset -U fpath
fpath=(
  ${ZSH_HOME}/site-functions
  ${fpath}
)

# system path
typeset -U path
path=(
  /opt/homebrew/bin(N-/)
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  /usr/bin(N-/)
  /bin(N-/)
  $path
)

# coreutils
if type brew >> /dev/null 2>&1; then
  path=(
    /opt/homebrew/opt/coreutils/libexec/gnubin(N-/)
    $path
  )
fi

# heroku
# if type heroku >> /dev/null 2>&1; then
#   path=(
#     /usr/local/heroku/bin(N-/)
#     $path
#   )
# fi

# LL Path
path=(
  ${HOME}/.rbenv/bin(N-/)          # Rbenv
  ${HOME}/.plenv/bin(N-/)          # Plenv
  ${HOME}/.pyenv/bin(N-/)          # Pyenv
  $path
)

# Rust
path=(
  ${HOME}/.cargo/bin(N-/)
  $path
)

# User-specific paths
path=(
  ${HOME}/src/github.com/yuuki/opstools/bin(N-/)
  ${HOME}/local/bin(N-/)
  ${HOME}/bin(N-/)
  $path
)

# SUDO_PATH
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=(
  /usr/local/sbin(N-/)
  /usr/sbin(N-/)
  /sbin(N-/)
)

# MANPATH
typeset -U manpath
manpath=(
  ${HOME}/local/share/man(N-/)
  /usr/local/share/man(N-/)
  /usr/share/man(N-/)
)

#export LANG=ja_JP.UTF-8

export EDITOR="vim"

# PAGER
if type lv > /dev/null 2>&1; then
  export PAGER="lv"
else
  export PAGER="less"
fi

# Homebrew
export HOMEBREW_TEMP="/tmp"
export HOMEBREW_PREFIX="/opt/homebrew"

fpath=(
  $HOMEBREW_PREFIX/share/zsh/site-functions(N-/)
  $HOMEBREW_PREFIX/share/zsh/functions(N-/)
  ${fpath}
)

# C++
typeset -xT CPLUS_INCLUDE_PATH cplus_include_path
typeset -U cplus_include_path
cplus_include_path=(
  $HOMEBREW_PREFIX/include
  $HOMEBREW_PREFIX/opt/boost/include
  $HOMEBREW_PREFIX/include/boost
  $cplus_include_path
)

# JAVA
export CLASSPATH=$CLASSPATH:$JAVA_HOME/lib:.

export XDG_DATA_HOME=/usr/local/share

#export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

# Go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOPATH/bin:$PATH

# MySQL
export PATH=$HOME/.mysqlenv/bin:$HOME/.mysqlenv/mysql-build/bin:$PATH

# getext
export PATH=$PATH:/opt/homebrew/opt/gettext/bin

export LD_LIBRARY_PATH=/opt/homebrew/lib:$LD_LIBRARY_PATH
export DYLD_FALLBACK_LIBRARY_PATH=/opt/homebrew/lib:$DYLD_FALLBACK_LIBRARY_PATH
export C_INCLUDE_PATH=/opt/homebrew/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/opt/homebrew/include
export CFLAGS="-I/opt/homebrew/include"
export CXXLAGS="-I/opt/homebrew/include"
export LDFLAGS="-L/opt/homebrew/lib"
# unset LD_LIBRARY_PATH
# unset DYLD_LIBRARY_PATH
# unset DYLD_FALLBACK_LIBRARY_PATH

# if [ "`docker-machine status default`" = "Running" ]; then
#   eval $(docker-machine env default) >>/dev/null
# fi

# Java
# export JAVA_HOME=`/usr/libexec/java_home`
# export PATH="$HOME/.jenv/bin:$PATH"

# Postgres
# source $HOME/.pgvm/pgvm_env

# Rust
if type rustc > /dev/null 2>&1; then
  export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src/
fi

export PATH="$HOME/.ndenv/bin:$PATH"

# # AWS
# source $(brew --prefix)/bin/aws_zsh_completer.sh

export PATH="${HOME}/bin:${PATH}"

export REPORTTIME=5

source $HOME/.zshenv.local

