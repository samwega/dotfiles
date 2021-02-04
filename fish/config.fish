#!/bin/fish

starship init fish | source

set -x CDPATH /home/samvega/Repos/samwega/ .

set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

set fish_greeting "<><"

# source ~/.config/fish/jp.fish

alias vi="kak"
alias vim="kak"
alias gr="go run"
alias yay="paru --sudo doas"

bind \ed __fish_prepend_doas
