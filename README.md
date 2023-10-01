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
# cf template
ln -s ~/.dotfiles/.cf-template/ ~/.cf-template

# nvim
mkdir -p ~/.config
ln -s ~/.dotfiles/nvim/ ~/.config/nvim

ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# zshrc
ln -s ~/.dotfiles/.zshrc ~/.zshrc
```
