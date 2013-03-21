#!/usr/bin/env bash

# from https://github.com/sontek/dotfiles/blob/master/install.sh

function link_file {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    if [ -e "${target}" ] && [ ! -L "${target}" ]; then
	mv $target $target.df.bak
    fi

	ln -sf ${source} ${target}
}

function unlink_file {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    if [ -e "${target}.df.bak" ] && [ -L "${target}" ]; then
	unlink ${target}
        mv $target.df.bak $target
    fi
}

if [ "$1" = "vim" ]; then
for i in _vim*
    do
	link_file $i
    done
elif [ "$1" = "restore" ]; then
for i in _*
    do
	unlink_file $i
    done
exit
else
    echo "What dotfile to install ?  Enter to install all or a dotfile name"
    read W 

    if [ -z "$W" ]; then

	echo "Install all"
    	for i in _*
    	    do
    	       link_file $i
    	    done
    else
	[ -f $W ] && link_file $W && echo "$W installed"
	[ -d $W ] && link_file $W && echo "$W installed"
    fi
fi

git submodule update --init --recursive
git submodule foreach --recursive git pull origin master

