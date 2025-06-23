#!/bin/bash

mkdir -p $XDG_CONFIG_HOME/fish/functions
mkdir -p $XDG_CONFIG_HOME/ruff
mkdir -p /home/$USER/.vscode
/usr/bin/fish /env/scripts/init.fish
/usr/bin/fish /env/scripts/nvim_init.fish

exec "$@"
