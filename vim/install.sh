#!/bin/bash

CICA_VER=5.0.2


if [ -f /etc/debian_version ]; then
  # vim, python
  su -c "apt-get install curl ncurses-dev gcc make libexpat-dev libffi-dev zlib1g-dev -y"
  # libressl
  su -c "apt-get install automake autoconf libtool -y"
  # rust
  su -c "apt-get install rustc -y"
  # coc.vim
  # su -c "apt-get install nodejs golang -y"
  su -c "apt-get install nodejs -y"
fi

if [ -f /etc/redhat-release ]; then
  sudo yum install unzip ncurses-devel expat-devel libffi-devel xz-devel -y
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
make -j5 && make install
cd -

# python package
LD_LIBRARY_PATH=$HOME/usr/lib ~/usr/bin/pip3 install pynvim neovim

# universal ctags
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh
./configure --prefix=$HOME/usr
make -j5 && make install
cd -

# golang
curl -LO https://golang.org/dl/go1.16.4.linux-amd64.tar.gz
tar xz < go1.16.4.linux-amd64.tar.gz

# fzf
git clone https://github.com/junegunn/fzf.git
cd fzf
PATH=../go/bin:$PATH make -j5
make install
cp bin/fzf $HOME/usr/bin/.
cd -

# ripgrep
git clone https://github.com/BurntSushi/ripgrep.git
cd ripgrep
cargo build --release
cp target/release/rg $HOME/usr/bin/.
cd -
 
### Cica
mkdir -p cica
pushd cica
curl -LO https://github.com/miiton/Cica/releases/download/v${CICA_VER}/Cica_v${CICA_VER}_with_emoji.zip
unzip -f Cica_v${CICA_VER}_with_emoji.zip

mkdir -p ${HOME}/.fonts
mv *.ttf ${HOME}/.fonts/
popd


git clone https://github.com/vim/vim.git
cd vim

LD_LIBRARY_PATH=$HOME/usr/lib ./configure --prefix=$HOME/usr --with-features=huge --enable-python3interp=dynamic --with-python3-command=$HOME/usr/bin/python3 --enable-gpm --enable-acl --without-x --disable-gui --enable-multibyte --enable-cscope --disable-canberra --disable-netbeans --enable-fail-if-missing
make -j5 && make install

cd -


git clone https://github.com/Shougo/dein.vim ${HOME}/.cache/dein/repos/github.com/Shougo/dein.vim


echo ********************************************************************************
echo    * edit terminal font *
echo ********************************************************************************

