#!/bin/bash

DOTFILES_DIR=$HOME/dotfiles

echo "start setup my dotfiles!"

DOT_FILES=( .zsh .zshrc .zprofile .zshrc.alias .zshrc.linux .zshrc.osx .ctags .emacs.el .gdbinit .gemrc .gitconfig .gitignore .inputrc .irbrc .pryrc .perldb .proverc .sbtconfig .screenrc .vim .vimrc .gvimrc .tmux.conf .dir_colors .rdebugrc .bash_completion )

for file in ${DOT_FILES[@]}
do
    ln -fs $DOTFILES_DIR/$file $HOME/$file
done

rm -f $HOME/dotfiles/.vim/perl-support
ln -s $HOME/dotfiles/.vim/bundle/perl-support.vim/perl-support $HOME/dotfiles/.vim/perl-support

echo "done setup"
