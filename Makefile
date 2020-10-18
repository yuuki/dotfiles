.PHONY: install
install: install/alacritty install/fish install/tmux install/git

.PHONY: install/alacritty
install/alacritty: setup
	ln -s $(PWD)/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

.PHONY: install/fish
install/fish: setup
	ln -s $(PWD)/fish/config.fish ~/.config/fish/config.fish

.PHONY: install/tmux
install/tmux:
	ln -s $(PWD)/tmux/tmux.conf ~/.tmux.conf

.PHONY: install/git
install/git:
	ln -s $(PWD)/git/gitconfig ~/.gitconfig
	ln -s $(PWD)/git/gitignore ~/.gitignore

.PHONY: setup
setup:
	mkdir -p ~/.config/{fish,alacritty,nvim}
