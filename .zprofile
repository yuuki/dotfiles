
export LANG=ja_JP.UTF-8

# vim
export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
# vimがなくてもvimでviを起動する。
if ! type vim > /dev/null 2>&1; then
    alias vim=vi
fi

# MacPorts PATH
export PATH=/opt/local/bin:/opt/local/sbin/:$PATH

# MANPATH
export MANPATH=/usr/share/man:/usr/local/share/man:/opt/local/man:$MANPATH

# HOMEディレクトリ以下のbinのにパスを通す
export PATH=$HOME/bin:$PATH

# MySQL PATH
export PATH=:/usr/local/mysql/bin:$PATH

# LLVM PATH
# export PATH=/opt/llvm/bin:$PATH

# NPM PATH
export PATH=/usr/local/share/npm/bin:$PATH
export NODE_PATH=/usr/local/lib/node

# Gentoo Prefix PATH
export EPREFIX="$HOME/Gentoo"
export PATH=$EPREFIX/usr/bin:$EPREFIX/bin:$EPREFIX/tmp/usr/bin:$EPREFIX/tmp/bin:$PATH

# Pythonbrew PATH
if [ -s $HOME/.pythonbrew/etc/bashrc ]; then
    source $HOME/.pythonbrew/etc/bashrc
fi

# Perlbrew PATH
if [ -s $HOME/.perl5/perlbrew/etc/bashrc ]; then
	source $HOME/.perl5/perlbrew/etc/bashrc
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

# TexCommand PATH
export PATH=$PATH:/Applications/UpTeX.app/teTeX/bin

# JAVA PATH
export CLASSPATH=$CLASSPATH:$JAVA_HOME/lib:.
export CLASSPATH=$CLASSPATH:$HOME/build/twitter4j-2.2.5/lib/twitter4j-core-2.2.5.jar
export CLASSPATH=$CLASSPATH:$HOME/build/twitter4j-2.2.5/lib/twitter4j-examples-2.2.5.jar
export CLASSPATH=$CLASSPATH:$HOME/build/twitter4j-2.2.5/lib/twitter4j-async-2.2.5.jar
export CLASSPATH=$CLASSPATH:$HOME/build/twitter4j-2.2.5/lib/twitter4j-stream-2.2.5.jar
export CLASSPATH=$CLASSPATH:$HOME/build/twitter4j-2.2.5/lib/twitter4j-media-support-2.2.5.jar

# RVM PATH
# export PATH=$HOME/.rvm/bin:$PATH
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function


# Boost PATH
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/usr/local/include/boost
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/boost

# for OpenCV Python Module
export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"

# Homebrew Path
export PATH=/usr/local/bin:$PATH

eval "$(rbenv init -)"

# GCC PATH
export PATH=/Applications/Xcode.app/Contents/Developer/usr/bin:$PATH
