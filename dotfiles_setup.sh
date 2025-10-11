#!/bin/zsh
# Setup file for dotfiles repo
#
# This file sets up various commandline tools


link_omz_custom() {
	find ~/.config/oh-my-zsh_custom -type f -name '*.zsh' -exec ln -s {} ~/.oh-my-zsh/custom/ \;
}

main() {
	link_omz_custom
}

main
