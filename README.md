## install packages

````
sudo pacman -S --needed git fzf alacritty lazygit neovim zoxide chezmoi mc bat kitty tmux wezterm \
        ttf-jetbrains-mono-nerd ttf-hack-nerd
````

## install dotfiles

````
chezmoi init https://github.com/dem2k/dotfiles-endvr --apply
````

## configure git

````
git config --global user.name "User Name"
git config --global user.email "user@server.com"
git config --global pull.rebase false
git config --global init.defaultBranch main
````



