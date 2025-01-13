## install packages
```
sudo pacman -S --needed git fzf alacritty lazygit neovim zoxide chezmoi mc bat tmux \
      ttf-jetbrains-mono-nerd ranger rofi autoconf texinfo emacs zsh gcc htop ripgrep
```

## in case of errors
If you’re getting an error similar to “Can’t update: signature from *** is marginal trust” or “invalid or corrupted package” you probably just need to update your package signing keys:
```
sudo rm /var/cache/pacman/pkg/*.part # to remove any partial downloads.
sudo pacman -Sy archlinux-keyring endeavouros-keyring
sudo pacman -Syu
```
still got errors?  clear out the pacman keyring and start fresh:
```
sudo rm /etc/pacman.d/gnupg
sudo pacman-key --init
sudo pacman-key --populate archlinux endeavouros
sudo pacman -Syy archlinux-keyring endeavouros-keyring
sudo pacman -Syyu
```
still doesn't work?
```
sudo pacman -U /var/cache/pacman/pkg/{archlinux,endeavouros}-keyring*.pkg.tar.zst
```
and try again. final option: install ubuntu!

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
