# Aliases for Oh my zsh

# Alias for using git with the dot files
# Use `config` to interact with dotfiles repo
alias config='/usr/bin/git --git-dir=$HOME/dotfiles.git/ --work-tree=$HOME'

# Start sesh from regular terminal with `seshin`
alias seshin='sesh connect $(sesh list | fzf)'
