#!/usr/bin/env bash
# To install the `code` cli see https://code.visualstudio.com/docs/setup/mac 

cat "$HOME/dotfiles/Code/User/code_list_of_extensions.txt" | xargs -L 1 code --install-extension
