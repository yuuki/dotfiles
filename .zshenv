# vim:set ft=zsh foldmethod=marker:

# ZSH_HOME
export ZSH_HOME=${HOME}/.zsh

# fpath
typeset -U fpath
fpath=(
  ${ZSH_HOME}/site-functions
  ${fpath}
)

# system path
typeset -U path
path=(
  /usr/local/bin(N-/)
  /usr/bin(N-/)
  /bin(N-/)
  $path
)

# coreutils
if type brew >> /dev/null 2>&1; then
  path=(
    $(brew --prefix coreutils)/libexec/gnubin(N-/)
    $path
  )
fi

# heroku
if type heroku >> /dev/null 2>&1; then
  path=(
    /usr/local/heroku/bin(N-/)
    $path
  )
fi

# Application path
path=(
  /Applications/UpTeX.app/teTeX/bin(N-/)                # Tex
  /Applications/VMware Fusion.app/Contents/Library      # VMware
  /Applications/android-sdk-macosx/tools(N-/)           # Android
  /Applications/android-sdk-macosx/platform-tools(N-/)  # Android
  $path
)

# LL Path
path=(
  ${HOME}/perl5/perlbrew/bin(N-/)  # Perlbrew
  ${HOME}/.rbenv/shims(N-/)        # Rbenv
  ${HOME}/.plenv/bin(N-/)          # Plenv
  ${HOME}/.rvm/bin(N-/)            # RVM
  ${HOME}/.pyenv/bin(N-/)          # Pyenv
  /usr/local/share/npm/bin(N-/)    # NPM
  /usr/local/mysql/bin(N-/)        # MySQL
  $path
)

# User-specific paths
path=(
  ${HOME}/bin(N-/)
  ${HOME}/local/bin(N-/)
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

export LANG=ja_JP.UTF-8

export EDITOR="vim"

# PAGER
if type lv > /dev/null 2>&1; then
  export PAGER="lv"
else
  export PAGER="less"
fi

# Homebrew
export HOMEBREW_TEMP="/Volumes/Macintosh\ HD/tmp"
export HOMEBREW_PREFIX="/usr/local"

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
export DYLD_FALLBACK_LIBRARY_PATH=$HOMEBREW_PREFIX/lib:$DYLD_FALLBACK_LIBRARY_PATH

# JAVA
export CLASSPATH=$CLASSPATH:$JAVA_HOME/lib:.
export ANDROID_HOME=/Applications/android-sdk-macosx

export XDG_DATA_HOME=/usr/local/share

export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

function setup_GOROOT() {
  local GOPATH=`which go`
  local GODIR=`dirname $GOPATH`
  local GOPATH_BREW_RELATIVE=`readlink $GOPATH`
  local GOPATH_BREW=`dirname $GOPATH_BREW_RELATIVE`
  export GOROOT=`cd $GODIR; cd $GOPATH_BREW/..; pwd`
}
setup_GOROOT

export GOPATH=$HOME/.go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# AWS
export AWS_CONFIG_FILE=$HOME/.aws.conf

# MySQL 5.5
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/usr/local/mysql/lib

# unset LD_LIBRARY_PATH
# unset DYLD_LIBRARY_PATH
# unset DYLD_FALLBACK_LIBRARY_PATH

source $HOME/.zshenv.local
