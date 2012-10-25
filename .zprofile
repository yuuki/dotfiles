
export LANG=ja_JP.UTF-8

# vim
export EDITOR="vim"
# vimがなくてもvimでviを起動する。
if ! type vim > /dev/null 2>&1; then
    alias vim=vi
fi

# MANPATH
export MANPATH=/usr/share/man:/usr/local/share/man:/opt/local/man:$MANPATH

# /usr/binをshellのデフォルトパスから削ったのでここに追加
export PATH=/usr/bin:$PATH

# HOMEディレクトリ以下のbinのにパスを通す
export PATH=$HOME/bin:$PATH

# MySQL PATH
export PATH=:/usr/local/mysql/bin:$PATH

# LLVM PATH
# export PATH=/opt/llvm/bin:$PATH

# NPM PATH
export PATH=/usr/local/share/npm/bin:$PATH
export NODE_PATH=/usr/local/share/npm/lib/node_modules


# Gentoo Prefix PATH
export EPREFIX="$HOME/Gentoo"
export PATH=$EPREFIX/usr/bin:$EPREFIX/bin:$EPREFIX/tmp/usr/bin:$EPREFIX/tmp/bin:$PATH

export LESS='-R'
if [ -x /usr/local/bin/src-hilite-lesspipe.sh ]; then
  export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'
fi

# CUDA PATH
export PATH=/usr/local/cuda/bin:$PATH
export DYLD_LIBRARY_PATH=/usr/local/cuda/lib
export LD_LIBRARY_PATH=/usr/local/cuda/lib:$LD_LIBRARY_PATH
export CPLUS_INCLUDE_PATH=”/Developer/GPU\ Computing/C/common/inc”:$CPLUS_INCLUDE_PATH
export C_INCLUDE_PATH=”/Developer/GPU\ Computing/C/common/inc”:$C_INCLUDE_PATH
export LIBRARY_PATH=”/Developer/GPU\ Computing/C/common/lib”:”/Developer/GPU\ Computing/C/lib”:/usr/local/cuda/lib:$LIBRARY_PATH

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

# for OpenCV Python Module
export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"

# Homebrew PATH
export PATH=/usr/local/bin:$PATH

# Tmuxinator PATH
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# TexCommand PATH
export PATH=$PATH:/Applications/UpTeX.app/teTeX/bin

# vmrun of VMWare fusion
export PATH="$PATH:/Applications/VMware Fusion.app/Contents/Library"

# Pythonbrew PATH
if [ -s $HOME/.pythonbrew/etc/bashrc ]; then
    source $HOME/.pythonbrew/etc/bashrc
fi

# Perlbrew PATH
if [ -s $HOME/perl5/perlbrew/etc/bashrc ]; then
	source $HOME/perl5/perlbrew/etc/bashrc
fi
export PERL5LIB="$PERLBREW_ROOT/perls/$PERLBREW_PERL/lib/site_perl/5.16.1"

# RVM PATH
# export PATH=$HOME/.rvm/bin:$PATH
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

# Rbenv PATH
eval "$(rbenv init -)"

export PATH=/opt/gcc/bin:$PATH
