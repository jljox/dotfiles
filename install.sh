#!/usr/bin/env bash

CONF_HOME_LIST=".ghci .tmux.conf .vimrc.local .zshrc"

for conf in $CONF_HOME_LIST; do
  if [ -L "$HOME/$conf" ]; then
    rm "$HOME/$conf"
  fi
  ln -s "$HOME/dotfiles/$conf" "$HOME/$conf"
done

case `uname` in 
  Darwin)  code_dirname="$HOME/Library/Application Support" ;; 
  Linux) code_dirname="$HOME/.config" ;; 
  *) code_dirname=unknown         ;; 
esac
code_settings_file="Code/User/settings.json"
if [ -L "$code_dirname/$code_settings_file" ]; then
  rm "$code_dirname/$code_settings_file"
fi
ln -s "$HOME/dotfiles/$code_settings_file" "$code_dirname/$code_settings_file"

ln -s "$HOME/dotfiles/bin" "$HOME/bin"
