#!/usr/bin/env bash

# Mettre à jour
sudo pacman -Syu

# Installation des packages de base
sudo pacman -S git curl htop vim fish

# Installation de php
sudo pacman -S extra/php extra/php-fpm extra/php-gd extra/php-intl community/xdebug

sudo cp ./../configs/php/php.ini /etc/php/php.ini
sudo cp ./../configs/php/xdebug.ini /etc/php/xdebug.ini
sudo systemctl restart php-fpm.service

# Installation de composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/bin/composer

# Installation de nginx
sudo pacman -S community/nginx-mainline

# Installation de nodejs + npm
sudo pacman -S community/nodejs
sudo pacman -S community/npm

# Installation de yarn
sudo npm i -g yarn

# Installation de vscode
sudo pacman -S community/code