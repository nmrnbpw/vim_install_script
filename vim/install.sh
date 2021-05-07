#!/bin/bash

CICA_VER=5.0.2


sudo yum install unzip ncurses-devel python3-devel -y

mkdir -p cica
pushd cica
curl -LO https://github.com/miiton/Cica/releases/download/v${CICA_VER}/Cica_v${CICA_VER}_with_emoji.zip
unzip Cica_v${CICA_VER}_with_emoji.zip

mkdir -p ${HOME}/.fonts
mv *.ttf ${HOME}/.fonts/
popd


# git clone https://github.com/vim/vim.git
# pushd vim
# 
# ./configure --enable-python3interp --prefix=$HOME/usr && make -j5 && make install
# 
# popd


git clone https://github.com/Shougo/dein.vim ${HOME}/.cache/dein/repos/github.com/Shougo/dein.vim


echo ********************************************************************************
echo    * edit terminal font *
echo ********************************************************************************

