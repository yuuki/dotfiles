#!/bin/bash

DOTFILES_DIR=$HOME/dotfiles

echo "start setup my dotfiles!"

DOT_FILES=( .zsh .zshrc .zprofile .zshrc.alias .zshrc.linux .zshrc.osx .ctags .emacs.el .gdbinit .gemrc .gitconfig .gitignore .inputrc .irbrc .pryrc .perldb .proverc .sbtconfig .screenrc .vim .vimrc .gvimrc .tmux.conf .dir_colors .rdebugrc .bash_completion )

for file in ${DOT_FILES[@]}
do
    ln -fs $DOTFILES_DIR/$file $HOME/$file
done

<<<<<<< HEAD:setup.sh
<<<<<<< Updated upstream
=======
rm -f $HOME/dotfiles/.vim/perl-support
ln -s $HOME/dotfiles/.vim/bundle/perl-support.vim/perl-support $HOME/dotfiles/.vim/perl-support

>>>>>>> fix iroiro:setup.bash
echo "Install vim plugins by neobundle.vim ..."
vim -c "NeoBundleInstall"
if [ `uname` = "Darwin" ]; then
    make -f $DOTFILES_DIR/.vim/bundle/vimproc/make_mac.mak
elif [`uname` = "Linux" ]; then
    make -f $DOTFILES_DIR/.vim/bundle/vimproc/make_unix.mak
fi

echo "done setup"
=======
echo "done!"
>>>>>>> Stashed changes
