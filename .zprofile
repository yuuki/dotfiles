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

# direnv
if type direnv > /dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# qfc https://github.com/pindexis/qfc
[[ -s "$HOME/.qfc/bin/qfc.sh" ]] && source "$HOME/.qfc/bin/qfc.sh"

# dockertoolbox
if type docker-machine > /dev/null 2>&1; then
  eval "$(docker-machine env default 2>/dev/null)"
fi

if type kubectl > /dev/null 2>&1; then
  autoload -Uz compinit; compinit
  . <(kubectl completion zsh)
fi
kubeps1="${HOMEBREW_PREFIX}/opt/kube-ps1/share/kube-ps1.sh"
if [[ -f $kubeps1 ]]; then
  source "/Users/y-tsubouchi/homebrew/opt/kube-ps1/share/kube-ps1.sh"
  PS1='$(kube_ps1)'$PS1
fi

# go
if type goenv > /dev/null 2>&1; then
  eval "$(goenv init -)"
fi

# rustup
if [[ -f "$HOME/.cargo/env" ]]; then
  . "$HOME/.cargo/env"
fi
# mysqlenv
if [[ -f "$HOME/.mysqlenv/etc/bashrc" ]]; then
  . "$HOME/.mysqlenv/etc/bashrc"
fi

if type ndenv > /dev/null 2>&1; then
  eval "$(ndenv init -)"
fi

# helm
if type helm > /dev/null 2>&1; then
  . <(helm completion zsh)
fi

if type ssh-agent > /dev/null 2>&1; then
  if ! pgrep -q ssh-agent; then
    eval "$(ssh-agent)" >> /dev/null
  fi
fi

# http://www.gcd.org/blog/2006/09/100/
agent="$HOME/tmp/ssh-agent-$USER"
if [ -S "$SSH_AUTH_SOCK" ]; then
	case $SSH_AUTH_SOCK in
	/tmp/*/agent.[0-9]*)
		ln -snf "$SSH_AUTH_SOCK" ${agent} && export SSH_AUTH_SOCK=${agent}
	esac
elif [ -S ${agent} ]; then
	export SSH_AUTH_SOCK=${agent}
else
	echo "no ssh-agent"
fi

export PATH="$HOME/.cargo/bin:$PATH"
