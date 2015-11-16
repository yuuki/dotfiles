#!/bin/bash

DOTFILES_DIR=$PWD

# submodule
echo "git submodule sync"
git submodule sync

echo "git submodule update --init"
git submodule update --init

DOT_FILES=( .zshrc .zshenv .zprofile .zsh .ctags .emacs.el .gdbinit .gemrc .gitconfig .gitignore .inputrc .irbrc .pryrc .perldb .proverc .screenrc .vim .vimrc .vimrc.local .gvimrc .tmux.conf .dir_colors .rdebugrc .bash_completion .re.pl .ctags .gdbinit .tigrc .ansible.cfg )

for file in ${DOT_FILES[@]}
do
    /bin/ln -fs $DOTFILES_DIR/$file $HOME/$file
done

/bin/rm -f $HOME/dotfiles/.vim/perl-support
/bin/ln -fs $HOME/dotfiles/.vim/bundle/perl-support.vim/perl-support $HOME/dotfiles/.vim/perl-support

# vim
vim -c "NeoBundleInstall!"

echo "set"
