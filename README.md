# dotfiles-endvr
sudo pacman -S --needed git fzf alacritty lazygit neovim zoxide chezmoi mc bat kitty tmux ttf-jetbrains-mono-nerd

chezmoi init https://github.com/dem2k/dotfiles-manjaro --apply
#chezmoi update

git config --global user.name "Your Name"
git config --global user.email "you@example.com"
git config --global pull.rebase false # Merge

