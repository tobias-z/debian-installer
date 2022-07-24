#!/bin/bash

sudo nala install zsh -y
chsh -s $(which zsh)

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

zsh_custom="$HOME/.oh-my-zsh/custom"

# Theme
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$zsh_custom/themes/spaceship-prompt" --depth=1
ln -s "$zsh_custom/themes/spaceship-prompt/spaceship.zsh-theme" "$zsh_custom/themes/spaceship.zsh-theme"

# Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${zsh_custom:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${zsh_custom:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
