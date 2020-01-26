#!/bin/bash

git clone https://github.com/tmux/tmux

sudo yum install libevent-devel ncurses-devel autoconf automake pkg-config byacc -y

pushd tmux

sh autogen.sh
./configure --prefix=$HOME/usr && make -j5 && make install

popd
