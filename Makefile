all: install

install:
	install -p -m 0640 bashrc $(HOME)/.bashrc
	install -p -m 0640 vimrc $(HOME)/.vim/vimrc
	install -p -m 0640 muttrc_options $(HOME)/.mutt/muttrc_options
	install -p -m 0640 tmux.conf $(HOME)/.tmux.conf
	install -p -m 0640 zshrc $(HOME)/.zshrc
