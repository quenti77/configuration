#!/usr/bin/env bash

sudo pacman -S i3-gaps i3status i3lock

mkdir -p ~/.config/i3/
cp ./../configs/i3/config ~/.config/i3/config

mkdir -p ~/.config/rofi/
cp ./../configs/i3/config.rasi ~/.config/rofi/config.rasi

pacman -S termite
sudo cp ./../configs/termite/config /etc/xdg/termite/config

sudo pacman -S feh

sudo pacman -S --needed base-devel
sudo pacman -S yaourt

yaourt -Syy
yaourt -S polybar

wget https://github.com/FortAwesome/Font-Awesome/blob/fa-4/fonts/fontawesome-webfont.ttf?raw=true
sudo mv 'fontawesome-webfont.ttf?raw=true' /usr/share/fonts/fa4.ttf
sudo fc-cache -rv

mkdir -p ~/.config/polybar/
cp ./../configs/polybar/config ~/.config/polybar/config
