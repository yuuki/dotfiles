
export LANG=ja_JP.UTF-8

# Gentoo bashrc load
if [ -s $EPREFIX/etc/profile ]; then
    source $EPREFIX/etc/profile
fi

# vim
export EDITOR=$EPREFIX/usr/bin/vim
# vimがなくてもvimでviを起動する。
if ! type vim > /dev/null 2>&1; then
    alias vim=vi
fi

export PATH=/usr/local/bin:$PATH

# MacPorts PATH setting
export PATH=/opt/local/bin:/opt/local/sbin/:$PATH

# MANPATH setting
export MANPATH=/usr/bin/man:$HOME/Gentoo/usr/bin/man:/opt/local/bin/man:$MANPATH

# HOMEディレクトリ以下のbinのにパスを通す
export PATH=$HOME/bin:$PATH

# MySQL PATH setting
export PATH=:/usr/local/mysql/bin:$PATH

# Pythonbrew PATH setting
if [ -s $HOME/.pythonbrew/etc/bashrc ]; then
    source $HOME/.pythonbrew/etc/bashrc
fi

# Gentoo Prefix PATH setting
export EPREFIX="$HOME/Gentoo"
export PATH=$EPREFIX/usr/bin:$EPREFIX/bin:$EPREFIX/tmp/usr/bin:$EPREFIX/tmp/bin:$PATH

# LLVM PATH setting
export PATH=/opt/llvm/bin:$PATH

# NPM PATH setting
export PATH=/usr/local/share/npm/bin:$PATH
export NODE_PATH=/usr/local/lib/node

# RVM PATH Setting
if [ -s $HOME/.rvm/scripts/rvm ]; then
	source $HOME/.rvm/scripts/rvm
fi

# Perlbrew PATH setting
if [ -f $HOME/.perl5/perlbrew/etc/bashrc ]; then
	source $HOME/.perl5/perlbrew/etc/bashrc
fi

# CUDA PATH setting
export PATH=/usr/local/cuda/bin:$PATH
export DYLD_LIBRARY_PATH=/usr/local/cuda/lib
export LD_LIBRARY_PATH=/usr/local/cuda/lib:$LD_LIBRARY_PATH
export CPLUS_INCLUDE_PATH=”/Developer/GPU\ Computing/C/common/inc”:$CPLUS_INCLUDE_PATH
export C_INCLUDE_PATH=”/Developer/GPU\ Computing/C/common/inc”:$C_INCLUDE_PATH
export LIBRARY_PATH=”/Developer/GPU\ Computing/C/common/lib”:”/Developer/GPU\ Computing/C/lib”:/usr/local/cuda/lib:$LIBRARY_PATH

# Android SDK PATH
export PATH=$PATH:/Applications/android-sdk-macosx/tools

# TexCommand PATH
export PATH=$PATH:/Applications/UpTeX.app/teTeX/bin

# JAVA PATH
export CLASSPATH=$CLASSPATH:$JAVA_HOME/lib:.
export CLASSPATH=$CLASSPATH:$HOME/build/twitter4j-2.2.5/lib/twitter4j-core-2.2.5.jar
export CLASSPATH=$CLASSPATH:$HOME/build/twitter4j-2.2.5/lib/twitter4j-examples-2.2.5.jar
export CLASSPATH=$CLASSPATH:$HOME/build/twitter4j-2.2.5/lib/twitter4j-async-2.2.5.jar
export CLASSPATH=$CLASSPATH:$HOME/build/twitter4j-2.2.5/lib/twitter4j-stream-2.2.5.jar
export CLASSPATH=$CLASSPATH:$HOME/build/twitter4j-2.2.5/lib/twitter4j-media-support-2.2.5.jar
