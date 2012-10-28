#!/bin/bash

DOTFILES_DIR=$HOME/dotfiles

echo "start setup my dotfiles!"

DOT_FILES=( .zshrc .zshenv .zsh .zshrc.antigen .ctags .emacs.el .gdbinit .gemrc .gitconfig .gitignore .inputrc .irbrc .pryrc .perldb .proverc .screenrc .vim .vimrc .gvimrc .tmux.conf .dir_colors .rdebugrc .bash_completion )

for file in ${DOT_FILES[@]}
do
    /bin/ln -fs $DOTFILES_DIR/$file $HOME/$file
done

/bin/rm -f $HOME/dotfiles/.vim/perl-support
/bin/ln -s $HOME/dotfiles/.vim/bundle/perl-support.vim/perl-support $HOME/dotfiles/.vim/perl-support

echo "done setup"
