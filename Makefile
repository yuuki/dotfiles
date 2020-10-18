.PHONY: install
install: install/alacritty install/fish install/tmux install/git install/nvim

.PHONY: install/alacritty
install/alacritty: setup
	ln -fs $(PWD)/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

.PHONY: install/fish
install/fish: setup
	ln -nfs $(PWD)/fish ~/.config/fish

.PHONY: install/zsh
install/zsh:
	ln -fs $(PWD)/zsh/zshrc ~/.zshrc
	ln -fs $(PWD)/zsh/zshenv ~/.zshenv

.PHONY: install/tmux
install/tmux:
	ln -fs $(PWD)/tmux/tmux.conf ~/.tmux.conf

.PHONY: install/git
install/git:
	ln -fs $(PWD)/git/gitconfig ~/.gitconfig
	ln -fs $(PWD)/git/gitignore ~/.gitignore

.PHONY: install/nvim
install/nvim: setup
	ln -nfs $(PWD)/nvim ~/.config/nvim

.PHONY: setup
setup:
	mkdir -p ~/.config/{fish,alacritty,nvim}
