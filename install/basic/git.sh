#!/bin/bash

BASEDIR="./"
. ${BASEDIR}/inc/message.sh

installInfo "git"
sudo apt-get install -y git
