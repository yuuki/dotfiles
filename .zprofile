
### External script {{{
# Rbenv
if type rbenv > /dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

# RVM
if type rvm > /dev/null 2>&1; then
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
fi

# Perlbrew
if type perlbrew > /dev/null 2>&1; then
  [[ -s $HOME/.perlbrew/etc/bashrc ]] && source $HOME/.perlbrew/etc/bashrc
  [[ -s $HOME/perl5/perlbrew/etc/bashrc ]] && source $HOME/perl5/perlbrew/etc/bashrc
fi

# plenv
if type plenv > /dev/null 2>&1; then
  eval "$(plenv init -)"
fi

# pyenv
if type pyenv > /dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Tmuxinator
if type tmuxinator > /dev/null 2>&1; then
  [[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
fi

# autojump
if type autojump > /dev/null 2>&1; then
  [[ -f `brew --prefix`/etc/autojump ]] && source `brew --prefix`/etc/autojump
fi

# hub
# if type hub > /dev/null 2>&1; then
#   eval "$(hub alias -s)"
# fi
### }}}
