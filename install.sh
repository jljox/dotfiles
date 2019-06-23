#!/usr/bin/env bash

CONF_HOME_LIST=".ghci .tmux.conf .vimrc.local .zshrc"

for conf in $CONF_HOME_LIST; do
  if [ -L $HOME/$conf ]; then
    rm $HOME/$conf
  fi
  ln -s $HOME/dotfiles/$conf $HOME/$conf
done
