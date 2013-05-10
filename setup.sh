#!/bin/bash

### Check if exists git command.
type -P git >/dev/null || { echo -e "\e[31mGit not found." ; exit 1; }

### NeoBundle
if [ ! -d ./vimfiles/bundle ] ; then
    mkdir -p ./vimfiles/bundle
fi

if [ ! -s ./vimfiles/bundle/neobundle.vim ] ; then
    git clone https://github.com/Shougo/neobundle.vim.git ./vimfiles/bundle/neobundle.vim
fi

### vimproc
if [ ! -s ./vimfiles/bundle/vimproc ] ; then
    git clone https://github.com/Shougo/vimproc.git ./vimfiles/bundle/vimproc
    # For UNIX
    OS=`uname -s`
    case $OS in
        "Linux")
        VIMPROC_MAKE=make_unix.mak
        ;;
        "Darwin")
        VIMPROC_MAKE=make_mac.mak
        ;;
        *)
        VIMPROC_MAKE=
        ;;
    esac
    # Build library
    if [ $VIMPROC_MAKE ] ; then
        pushd ./vimfiles/bundle/vimproc
        make -f $VIMPROC_MAKE
        popd
    else
        echo -e "\e[32m[INFO] You should run 'make -f your_machines_makefile' in ./vimfiles/bundle/vimproc.\e[m"
    fi
fi

### Create symbolic links
function symlink() {
    if [ ! -e $2 ] ; then
        f=$(cd $(dirname $1) && pwd)/$(basename $1)
        echo -e "\e[32m[INFO] Create a symbolic link : \e[m$2 -> ${f}"
        ln -s $f $2
    fi
}

VIMRC=
if [[ $OS == "Windows_NT" ]] ; then
    VIMRC=~/_vimrc
    symlink ./_vimrc ~/_vimrc
    symlink ./_gvimrc ~/_gvimrc
    symlink ./vimfiles ~/vimfiles
else
    VIMRC=~/.vimrc
    symlink ./_vimrc ~/.vimrc 
    symlink ./_gvimrc ~/.gvimrc
    symlink ./vimfiles ~/.vim
fi

### Install plugins
echo -e "\e[32m[INFO] Install plugins.\e[m"
if [[ $OS == "Windows_NT" ]] ; then
  gvim -u $VIMRC -c 'NeoBundleInstall' -c 'qall'
else
  vim -u $VIMRC -c 'NeoBundleInstall' -c 'qall'
fi

# vim: expandtab ts=4 sw=4 sts=4 ff=unix
