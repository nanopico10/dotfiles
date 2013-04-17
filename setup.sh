#!/bin/bash

mkdir -p ./vimfiles/bundle
### NeoBundle
git clone https://github.com/Shougo/neobundle.vim.git ./vimfiles/bundle/neobundle.vim

### vimproc
git clone https://github.com/Shougo/vimproc.git ./vimfiles/bundle/
# For UNIX
OS=`uname -s`
echo $OS
case $OS in
  "Linux")
    VIMPROC_MAKE=make_unix.mak
    ;;
  "Darwin")
    VIMPROC_MAKE=make_mac.mak
    ;;
  *)
    VIMPROC_MAKE=
esac

if [ $VIMPROC_MAKE ] ; then
  pushd ./vimfiles/bundle/vimproc
  make -f $VIMPROC_MAKE
  popd
else
  echo -e "\e[32m[INFO] You should run 'make -f YOUR_COMPUTER_MAKEFILE' in ./vimfiles/bundle/vimproc.\e[m"
fi
