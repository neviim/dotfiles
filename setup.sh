#!/usr/bin/env bash

self=`realpath $0`
this=`dirname $self`

# Create symlinks so config appears in right folder
ln -sT $this/.lesskey $HOME/.lesskey
ln -sT $this/.aliases $HOME/.aliases
ln -sT $this/tmux $HOME/.config/tmux
ln -sT $this/dunst $HOME/.config/dunst
ln -sT $this/.ghci $HOME/.ghci
ln -sT $this/neovim $HOME/.config/nvim
ln -sT $this/git $HOME/.config/git
ln -sT $this/bat $HOME/.config/bat
ln -sT $this/alacritty $HOME/.config/alacritty
ln -sT $this/containers $HOME/.config/containers

# This should execute only when xmonad support is desired
# # TODO Should link as well
# mkdir -p $HOME/.local/share/sounds/
# cp $this/share/sounds/* $HOME/.local/share/sounds/
# cp $this/share/icons/* $HOME/.local/share/icons/
