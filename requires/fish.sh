#!/usr/bin/env fish

chsh -s /usr/bin/fish quentin
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

# Install font before theme
mkdir -p ./tmp/
cd ./tmp/
wget -O scp.zip "https://fonts.google.com/download?family=Source%20Code%20Pro"
unzip scp.zip
sudo mv *.ttf /usr/share/fonts/
sudo fc-cache -rv

# Install pure theme
fisher add rafaelrinaldi/pure
