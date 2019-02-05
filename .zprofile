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

# http://d.hatena.ne.jp/homaju/20180508/1525734970
if [ "$TERM_PROGRAM" = "alacritty" ]; then
  SESSION_NAME=ope
  if [[ -z "$TMUX" && -z "$STY" ]] && type tmux >/dev/null 2>&1; then
    option=
    if tmux has-session -t ${SESSION_NAME} 2> /dev/null; then
      option=attach -t ${SESSION_NAME}
    else
      option=new-session -s ${SESSION_NAME}
    fi
    tmux ${option} && exit
  fi
fi

if type ssh-agent > /dev/null 2>&1; then
  eval "$(ssh-agent)" >> /dev/null
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
