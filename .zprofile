
export LANG=ja_JP.UTF-8

# vim
export EDITOR="vim"
# vimがなくてもvimでviを起動する。
if ! type vim > /dev/null 2>&1; then
    alias vim=vi
fi

# MANPATH
export MANPATH=/usr/local/share/man:/usr/share/man:$MANPATH

export PATH=$HOME/bin:$PATH

# MySQL PATH
export PATH=:/usr/local/mysql/bin:$PATH

# NPM PATH
export PATH=/usr/local/share/npm/bin:$PATH
export NODE_PATH=/usr/local/share/npm/lib/node_modules

export LESS='-R'
if [ -x /usr/local/bin/src-hilite-lesspipe.sh ]; then
  export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'
fi

# C++ PATH
export CPLUS_INCLUDE_PATH=/usr/local/include:$CPLUS_INCLUDE_PATH
export DYLD_FALLBACK_LIBRARY_PATH=/usr/local/lib
export BOOST_ROOT=/usr/local/include/boost:$BOOST_ROOT

# Android SDK PATH
export PATH=$PATH:/Applications/android-sdk-macosx/tools:/Applications/android-sdk-macosx/platform-tools

# JAVA PATH
export CLASSPATH=$CLASSPATH:$JAVA_HOME/lib:.
export ANDROID_HOME=/Applications/android-sdk-macosx

# Boost PATH
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/usr/local/include/boost
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/boost

# Homebrew PATH
export PATH=/usr/local/bin:$PATH
export HOMEBREW_TEMP="/Volumes/Macintosh\ HD/tmp"
export HOMEBREW_PREFIX="/usr/local"

[[ -f `brew --prefix`/etc/autojump ]] && source `brew --prefix`/etc/autojump

# Tmuxinator PATH
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# TexCommand PATH
export PATH=$PATH:/Applications/UpTeX.app/teTeX/bin

# vmrun of VMWare fusion
export PATH="$PATH:/Applications/VMware Fusion.app/Contents/Library"

# Pythonz PATH
[[ -s $HOME/.pythonz/etc/bashrc ]] && source $HOME/.pythonz/etc/bashrc
export PATH="$HOME/.pythonz/pythons/CPython-2.7.3/bin:$PATH"

# Perlbrew PATH
export PATH=$HOME/.perlbrew/bin:$PATH
[[ -s $HOME/.perlbrew/etc/bashrc ]] && source $HOME/.perlbrew/etc/bashrc
export XDG_DATA_HOME=/usr/local/share

# RVM PATH
export PATH=$HOME/.rvm/bin:$PATH
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

# Rbenv PATH
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

