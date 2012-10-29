#!/bin/bash

DOTFILES_DIR=$HOME/dotfiles

echo "get"

# submodule
git submodule sync
git submodule update --init

DOT_FILES=( .zshrc .zshenv .zsh .zshrc.antigen .ctags .emacs.el .gdbinit .gemrc .gitconfig .gitignore .inputrc .irbrc .pryrc .perldb .proverc .screenrc .vim .vimrc .gvimrc .tmux.conf .dir_colors .rdebugrc .bash_completion )

for file in ${DOT_FILES[@]}
do
    /bin/ln -fs $DOTFILES_DIR/$file $HOME/$file
done

/bin/rm -f $HOME/dotfiles/.vim/perl-support
/bin/ln -s $HOME/dotfiles/.vim/bundle/perl-support.vim/perl-support $HOME/dotfiles/.vim/perl-support

zsh
/bin/ln -s ${DOTFILES_DIR}/.zsh/yuuki.zsh-theme $HOME/.antigen/repos/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh.git/themes/

# vim
vim -c "NeoBundleInstall!"

if [[ -d .vim/bundle/vimproc ]]; then
  cd .vim/bundle/vimproc
  case $OSTYPE in
  darwin*)
    if [[ ! -e autoload/vimproc_mac.so ]]; then
      echo "Installing vimproc"
      make -f make_mac.mak
    fi
    ;;
  linux*)
    if [[ ! -e autoload/vimproc_unix.so ]] ; then
      echo "Installing vimproc"
      make -f make_unix.mak
    fi
    ;;
  esac
  cd $DOTFILES_DIR
fi

echo "set"
