#!/bin/bash

NC="\033[0m"
INFO="\033[1;36m"
SUCCESS="\033[1;32m"
WARNING="\033[1;33m"
DANGER="\033[1;31m"
BLUE="\033[1;34m"

message() {
    echo -ne "${1}${2}${NC}"

    if [ -z $3 ] || [ $3 = true ]; then
        echo -ne "\n"
    fi
}

info() {
    message $INFO $1 $2
}

success() {
    message $SUCCESS $1 $2
}

warning() {
    message $WARNING $1 $2
}

danger() {
    message $DANGER $1 $2
}
