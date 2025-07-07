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
* zsh configs (oh-my-zsh)
* add Neovim config(s)

## Structure

```
dotfiles ($HOME)
├── .github
│   └── README.md
├── .gitignore
├── .tmux.conf
├── LICENSE
```

# Initial setup

The repo is setup as a `bare` repo @ $HOME/dotfiles.git. Then the alias `config` should be added to the shell profile file, in this case `.zshrc`. This alias directs git to the git directory and sets the work-tree directory to `$HOME`. This allows easier differentiation between other git projects and doesn't pollute the `$HOME` directory with git files.

```zsh
git init --bare $HOME/dotfiles.git
alias='/usr/bin/git --git-dir=$HOME/dotfiles.git/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
```

# Installing on a new system

...

# Resources

* [Dotfiles: Best way to store in a bare git repository](https://www.atlassian.com/git/tutorials/dotfiles)
* [How I manage my dotfiles](https://mohundro.com/blog/2024-08-03-how-i-manage-my-dotfiles/)
* [Ryan Bates Dot files](https://github.com/ryanb/dotfiles/tree/master)
* [Dotfiles: The Secret Weapon for Effortless Configuration Management](https://medium.com/@alexcloudstar/dotfiles-the-secret-weapon-for-effortless-configuration-management-c8354f02fbe1)
