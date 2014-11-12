#!/bin/bash

DOTFILES_DIR=$HOME/dotfiles

# submodule
echo "git submodule sync"
git submodule sync

echo "git submodule update --init"
git submodule update --init

DOT_FILES=( .zshrc .zshenv .zprofile .zsh .ctags .emacs.el .gdbinit .gemrc .gitconfig .gitignore .inputrc .irbrc .pryrc .perldb .proverc .screenrc .vim .vimrc .vimrc.local .gvimrc .tmux.conf .dir_colors .rdebugrc .bash_completion .re.pl .ctags .gdbinit .tigrc )

for file in ${DOT_FILES[@]}
do
    /bin/ln -fs $DOTFILES_DIR/$file $HOME/$file
done

/bin/rm -f $HOME/dotfiles/.vim/perl-support
/bin/ln -fs $HOME/dotfiles/.vim/bundle/perl-support.vim/perl-support $HOME/dotfiles/.vim/perl-support

# vim
vim -c "NeoBundleInstall!"

# neobundleのオプションでビルドできるようになった
# if [[ -d .vim/bundle/vimproc ]]; then
#   cd .vim/bundle/vimproc
#   case $OSTYPE in
#   darwin*)
#     if [[ ! -e autoload/vimproc_mac.so ]]; then
#       echo "Installing vimproc"
#       make -f make_mac.mak
#     fi
#     ;;
#   linux*)
#     if [[ ! -e autoload/vimproc_unix.so ]] ; then
#       echo "Installing vimproc"
#       make -f make_unix.mak
#     fi
#     ;;
#   esac
#   cd $DOTFILES_DIR
# fi

echo "set"
