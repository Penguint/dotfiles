# dotfiles

## Install on Linux

1. Clone repo into new hidden directory.

```bash
# Use SSH (if set up)...
git clone git@github.com:Penguint/dotfiles.git ~/.dotfiles

# ...or use HTTPS and switch remotes later.
git clone https://github.com/Penguint/dotfiles.git ~/.dotfiles
```

2. Create symlinks in the Home directory to the real files in the repo.

```bash
# neovim
mkdir -p ~/.config
ln -s ~/.dotfiles/nvim/ ~/.config/nvim

# vim-plug for neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim --cmd 'PlugInstall' \
     -c 'qa!' # Quit vim

# git config
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

# zshrc
ln -s ~/.dotfiles/.zshrc ~/.zshrc

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# cf template
ln -s ~/.dotfiles/.cf-template/ ~/.cf-template
```
