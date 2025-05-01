pacman -Qq | fzf --preview-window=right:70% --preview 'pacman -Qi {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | bat --paging=always)'

