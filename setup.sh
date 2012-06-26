#!/bin/sh

echo "start setup my dotfiles!"

DOT_FILES=( .zsh .zshrc .zshrc.alias .zshrc.linux .zshrc.osx .ctags .emacs.el .gdbinit .gemrc .gitconfig .gitignore .inputrc .irbrc .pryrc .sbtconfig .screenrc .vim .vimrc .gvimrc .tmux.conf .dir_colors .rdebugrc)

for file in ${DOT_FILES[@]}
do
    ln -fs $HOME/dotfiles/$file $HOME/$file
done


echo "done!"
