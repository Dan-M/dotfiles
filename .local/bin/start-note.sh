#!/bin/zsh
cd ~/neuron/
export PATH=$PATH:~/.nix-profile/bin
nohup alacritty -t "neuron_zettel" -e $SHELL -lc "lvim" > /dev/null &

