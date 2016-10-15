#!/bin/bash

BASEDIR="./"
. ${BASEDIR}/inc/message.sh

installInfo "git"
sudo apt-get install -y vim

vimrcPath="${HOME}/.vimrc"
info "Création du fichier ${BLUE}.vimrc ${INFO}..."

cat << EOM >${vimrcPath}
syntax on
set number
EOM
