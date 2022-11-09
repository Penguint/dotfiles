# dotfiles

## Install on Linux

1. Clone repo into new hidden directory.

```sh
# Use SSH (if set up)...
git clone git@github.com:Penguint/dotfiles.git ~/.dotfiles

# ...or use HTTPS and switch remotes later.
git clone https://github.com/Penguint/dotfiles.git ~/.dotfiles
```

2. Create symlinks in the Home directory to the real files in the repo.

```sh
ln -s ~/.dotfiles/.cf-template/ ~/.cf-template
ln -s ~/.dotfiles/nvim/ ~/.config/nvim
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.zshrc ~/.zshrc
```
