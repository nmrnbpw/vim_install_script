#!/bin/bash

CICA_VER=5.0.2


if [ -f /etc/debian_version ]; then
  # vim, python
  su -c "apt-get install curl ncurses-dev gcc make libexpat-dev libffi-dev zlib1g-dev -y"
  # libressl
  # su -c "apt-get install automake autoconf libtool -y"
  # coc.vim
  su -c "apt-get install nodejs golang -y"
fi

if [ -f /etc/redhat_release ]; then
  sudo yum install unzip ncurses-devel python3-devel -y
fi

### LibreSSL
# git clone https://github.com/libressl-portable/portable.git
# cd portable
# ./autogen.sh
# ./configure --enable-shared --enable-static --enable-nc --prefix=$HOME/usr
# make check -j5 && make install -j5
# cd -

### OpenSSL 1.1.1
git clone https://github.com/openssl/openssl.git
cd openssl
git checkout OpenSSL_1_1_1-stable
./config --prefix=$HOME/usr
make -j5 && make
cd -

### Python
curl -LO https://www.python.org/ftp/python/3.9.5/Python-3.9.5.tgz
tar xz < Python-3.9.5.tgz
cd Python-3.9.5
./configure --prefix=$HOME/usr --enable-shared --with-ensurepip=yes --enable-optimizations --with-system-expat --with-system-ffi --enable-ipv6 --with-openssl=$HOME/usr/
cd -

LD_LIBRARY_PATH=$HOME/usr/lib ~/usr/bin/pip3 install pynvim neovim
 
### Cica
mkdir -p cica
pushd cica
curl -LO https://github.com/miiton/Cica/releases/download/v${CICA_VER}/Cica_v${CICA_VER}_with_emoji.zip
unzip -f Cica_v${CICA_VER}_with_emoji.zip

mkdir -p ${HOME}/.fonts
mv *.ttf ${HOME}/.fonts/
popd


git clone https://github.com/vim/vim.git
pushd vim

./configure --prefix=$HOME/usr --with-features=huge --enable-python3interp=dynamic --enable-gpm --enable-acl --with-x=no --disable-gui --enable-multibyte --enable-cscope --disable-camberra --enable-fail-if-missing && make -j5 && make install


popd


git clone https://github.com/Shougo/dein.vim ${HOME}/.cache/dein/repos/github.com/Shougo/dein.vim


echo ********************************************************************************
echo    * edit terminal font *
echo ********************************************************************************

