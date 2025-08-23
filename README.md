## install xorg and xfce

```
sudo pacman -S --needed xorg xorg-apps xfce4 xfce4-goodies ly
sudo systemctl set-default multi-user.target
sudo systemctl enable --now ly.service
```

## install packages
```
mkdir -p ~/{Bilder,Desktop,Dokumente,Downloads,Musik,Public,Videos,Vorlagen}
sudo pacman -S --needed git fzf alacritty lazygit neovim zoxide ttf-zed-mono-nerd eza \
   chezmoi bat tmux ttf-jetbrains-mono-nerd autoconf texinfo emacs zsh gcc ripgrep lf
```

### install fonts manually if they are not in your distro's repo
```
FONTURL=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest \
  | grep -i "browser_download_url.*ZedMono.zip" | awk -F'"' '{print $4}') \
  && wget -P ~/.local/share/fonts "https://github.com/ryanoasis/nerd-fonts/releases/download/$FONTURL/ZedMono.zip"
  && cd ~/.local/share/fonts && unzip *.zip && rm *.zip && fc-cache -fv
```

## in case of errors
if you’re getting an error similar to “Can’t update: signature from *** is marginal trust” or “invalid or corrupted package”:
```
sudo rm /var/cache/pacman/pkg/*.part # to remove any partial downloads.
sudo pacman -Syu archlinux-keyring endeavouros-keyring
```
still got errors?  clear out the pacman keyring and start fresh:
```
sudo rm /etc/pacman.d/gnupg
sudo pacman-key --init
sudo pacman-key --populate archlinux endeavouros
sudo pacman -Syyu archlinux-keyring endeavouros-keyring
```
still doesn't work?
```
sudo pacman -U /var/cache/pacman/pkg/{archlinux,endeavouros}-keyring*.pkg.tar.zst
```
and try again. final option: install ubuntu!

## install dotfiles
```
chezmoi init --apply https://github.com/dem2k/dotfiles-endvr
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
git config --global diff.algorithm histogram
```

## compile emacs
```
sudo apt install autoconf texinfo libxaw7-dev libx11-dev libxext-dev libxt-dev libjpeg-dev libpng-dev libgif-dev libtiff-dev libgnutls28-dev libtinfo-dev libncurses-dev libacl1-dev libgccjit-12-dev libgccjit0
git clone --depth=1 -b master git://git.sv.gnu.org/emacs.git
cd emacs
./autogen.sh
./configure
make
sudo make install
```
