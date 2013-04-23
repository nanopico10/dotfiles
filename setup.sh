#!/bin/bash

mkdir -p ./vimfiles/bundle

### NeoBundle
git clone https://github.com/Shougo/neobundle.vim.git ./vimfiles/bundle/neobundle.vim

### vimproc
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


### Create symbolic links
function symlink() {
    if [ ! -e $2 ] ; then
        f=$(cd $(dirname $1) && pwd)/$(basename $1)
        echo -e "\e[32m[INFO] Create a symbolic link : \e[m$2 -> ${f}"
        ln -s $f $2
    fi
}

symlink ./_vimrc ~/.vimrc 
symlink ./_gvimrc ~/.gvimrc
symlink ./vimfiles ~/.vim

### Install plugins
echo -e "\e[32m[INFO] Install plugins.\e[m"
vim -u ~/.vimrc -c 'NeoBundleInstall' -c 'qall'

