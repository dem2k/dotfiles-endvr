## install packages
```
sudo pacman -S --needed git fzf alacritty lazygit neovim zoxide chezmoi mc bat tmux \
      ttf-jetbrains-mono-nerd ranger rofi autoconf texinfo emacs zsh gcc htop
```

## install dotfiles
```
chezmoi init https://github.com/dem2k/dotfiles-endvr --apply
```

## change shell
```
chsh -s /bin/zsh
```

## configure git
```
git config --global user.name "dk"
git config --global user.email "user@server.com"
git config --global pull.rebase false
git config --global init.defaultBranch main
```

## compile emacs
```
git clone --depth=1 -b master git://git.sv.gnu.org/emacs.git
sudo apt install autoconf texinfo libxaw7-dev libx11-dev libxext-dev libxt-dev libjpeg-dev libpng-dev libgif-dev libtiff-dev libgnutls28-dev libtinfo-dev libncurses-dev libacl1-dev libgccjit-12-dev libgccjit0 
cd emacs
./autogen.sh
./configure
make
sudo make install
```
