#!/usr/bin/env bash

sudo pacman -S i3-gaps i3status i3lock

mkdir -p ~/.config/i3/
cp ./../configs/i3/config ~/.config/i3/config

mkdir -p ~/.config/rofi/
cp ./../configs/i3/config.rasi ~/.config/rofi/config.rasi

cp ./../configs/.Xresources ~/.Xresources
xrdb ~/.Xresources

pacman -S termite
sudo cp ./../configs/termite/config /etc/xdg/termite/config