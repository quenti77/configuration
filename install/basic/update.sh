#!/bin/bash

BASEDIR="./"
. ${BASEDIR}/inc/message.sh

info "Mise à jour de la liste des packages ..."
sudo apt-get update -y

info "Mise à jour des packages ..."
sudo apt-get upgrade -y
