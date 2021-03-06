#!/bin/bash

## zsh
#. $HOME/.zshrc
. $HOME/.bash_profile
. $HOME/.bashrc

if [ "$PHPENV_ROOT" == "" ] ; then
   echo "PHPENV_ROOT is required."
   exit 1
fi

PHP_VERSION=$(php --version | awk 'NR == 1 {print $2}')

is_bsd() {
    man sed | grep BSD > /dev/null
    echo $?
}

create_dir() {
    mkdir -p $(dirname "$1")
}

replace_php_version() {
    if [ $(is_bsd) -eq 0 ]; then
        sed -i "" -e "s|__PHP_VERSION__|$PHP_VERSION|g" $1
    else
        sed -i -e "s|__PHP_VERSION__|$PHP_VERSION|g" $1
    fi
}

replace_phpenv_root() {
    if [ $(is_bsd) -eq 0 ]; then
        sed -i "" -e "s|__PHPENV_ROOT__|$PHPENV_ROOT|g" $1
    else
        sed -i -e "s|__PHPENV_ROOT__|$PHPENV_ROOT|g" $1
    fi
}

_cp() {
    if [ -f "$2" ] ; then
        mv $2 "${2}.$(date +%Y%m%d%H%M)"
    fi

    cp $1 $2
}
