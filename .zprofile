
### External script {{{

# rbenv
if type rbenv > /dev/null 2>&1; then
  eval "$(rbenv init - --no-rehash)"
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
  [[ -f /usr/local/etc/autojump ]] && source /usr/local/etc/autojump
fi

# direnv
if type direnv > /dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# qfc https://github.com/pindexis/qfc
[[ -s "$HOME/.qfc/bin/qfc.sh" ]] && source "$HOME/.qfc/bin/qfc.sh"

# dockertoolbox
if type docker-machine > /dev/null 2>&1; then
  eval "$(docker-machine env default)"
fi
### }}}
