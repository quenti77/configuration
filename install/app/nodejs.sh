#!/bin/bash

BASEDIR="./"
. ${BASEDIR}/inc/message.sh

curlInstalled=`dpkg -l | grep -w "curl" | head -n 1 | cut -d " " -f 1`
if [ -z ${curlInstalled} ]; then
    warning "package ${DANGER}curl ${WARNING}manquant ..."

    installInfo "curl"
    sudo apt-get install curl -y
fi

installInfo "nodejs"
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs
