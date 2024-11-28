## install packages

````
sudo pacman -S --needed git fzf alacritty lazygit neovim zoxide chezmoi mc bat kitty tmux wezterm \
        ttf-jetbrains-mono-nerd ttf-hack-nerd ranger rofi autoconf texinfo
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
## compile emacs
````
git clone --depth=1 -b master git://git.sv.gnu.org/emacs.git
sudo apt install autoconf texinfo libxaw7-dev libx11-dev libxext-dev libxt-dev libjpeg-dev libpng-dev libgif-dev libtiff-dev libgnutls28-dev
cd emacs
./autogen.sh
./configure
make
sudo make install
````



