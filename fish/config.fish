#!/bin/fish

starship init fish | source

set -x CDPATH /home/samvega/Repos/samwega/ .

set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

set fish_greeting "<><"

# source ~/.config/fish/jp.fish

alias v="kak"
alias vi="kak"
alias vim="kak"
alias gr="go run"
alias yay="paru --sudo doas"

bind \ed __fish_prepend_doas

# export GOPATH=$HOME/go
# export PATH=/home/samvega/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/usr/bin/go/:/home/samvega/go/bin
# export GOBIN=$HOME/go/bin
