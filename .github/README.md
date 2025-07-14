# dotfiles

This repo tracks dotfiles and configuration files. It should allow for configs and settings to be portable between machines. This repo is based off of some different strategies (see Resources).  

## Usage

To interact and update config files use `config` (alias) instead of `git`.

## To Do

* fill out README further
    * Structure
    * Installing on new system
    * Requirements section
* ~~add sesh configs~~
* create install script (see dotfiles guides below)
* zsh configs (oh-my-zsh)
* add Neovim config(s)

## Structure

```
dotfiles ($HOME)
├── .github
│   └── README.md
├── .gitignore
├── .config
│   └── sesh
│       └── sesh.toml
├── .tmux.conf
├── LICENSE
```

# Requirements

* tmux >= 2.5 (or 3.5)
* tmux plugin manager (tmp)
* fzf
* zoxide
* sesh

Optional (recommended):
* a font from [Nerd Fonts](https://www.nerdfonts.com/)

# Initial setup

The repo is setup as a `bare` repo @ $HOME/dotfiles.git. Then the alias `config` should be added to the shell profile file, in this case `.zshrc`. This alias directs git to the git directory and sets the work-tree directory to `$HOME`. This allows easier differentiation between other git projects and doesn't pollute the `$HOME` directory with git files.

```zsh
git init --bare $HOME/dotfiles.git
alias config='/usr/bin/git --git-dir=$HOME/dotfiles.git/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
```

# Installing on a new system

Make sure a newer version of tmux is installed (currently using `3.5`). The repo needs to be cloned bare and the `config` alias needs to be added to the user's shell profile (`.bashrc` or `.zshrc`, etc., depending on the shell being used). Additionally, when bringing this in the files will show as staged for deletion. They need to be unstaged and restored. Restoring will overwrite any files with matching names so be careful.

```zsh
# Add this to shell profile
alias config='/usr/bin/git --git-dir=$HOME/dotfiles.git/ --work-tree=$HOME'

# Run this
git clone --bare git@github.com:mosqueteiro/dotfiles dotfiles.git
config config --local status.showUntrackedFiles no
config reset
config restore :/  # This restores all working tree files
```

The tmux config also has some requirements such as Tmux Plugin Manager (TPM), fzf, zoxide, and sesh. These need to be installed one way or another. See [tmux.conf](.tmux.conf) for suggestions on how to accomplish this. Once `tmp` is installed, make sure to start a new tmux server (use `tmux kill-server` to be able to start a new one) and then input `prefix + I` to install the plugins. This can take a moment with seemingly nothing happening, give it 10 sec or so.


# Resources

* [Dotfiles: Best way to store in a bare git repository](https://www.atlassian.com/git/tutorials/dotfiles)
* [How I manage my dotfiles](https://mohundro.com/blog/2024-08-03-how-i-manage-my-dotfiles/)
* [Ryan Bates Dot files](https://github.com/ryanb/dotfiles/tree/master)
* [Dotfiles: The Secret Weapon for Effortless Configuration Management](https://medium.com/@alexcloudstar/dotfiles-the-secret-weapon-for-effortless-configuration-management-c8354f02fbe1)
