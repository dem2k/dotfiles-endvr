## install packages

````
sudo pacman -S --needed git fzf alacritty lazygit neovim zoxide chezmoi mc bat kitty tmux ttf-jetbrains-mono-nerd
````

## install dotfiles

````
chezmoi init https://github.com/dem2k/dotfiles-endvr --apply
````

## configure git

````
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
git config --global pull.rebase false # Merge
````



