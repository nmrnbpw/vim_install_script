FROM ruby:3.0.2-slim-bullseye

RUN apt-get update -qq && apt-get install -y build-essential git curl

WORKDIR /works
RUN apt-get install -y ncurses-dev libevent-dev pkg-config automake bison libexpat-dev libffi-dev zlib1g-dev automake autoconf libtool rustc golang-go
# ADD . /works
RUN git clone https://github.com/openssl/openssl.git
WORKDIR openssl
RUN git checkout OpenSSL_1_1_1-stable
RUN ./config --prefix=/works/usr && make -j5 && make install_sw
WORKDIR ..

RUN curl -LO https://www.python.org/ftp/python/3.9.7/Python-3.9.7.tgz && tar xz < Python-3.9.7.tgz
WORKDIR Python-3.9.7
RUN ./configure --prefix=/works/usr --enable-shared --with-ensurepip=yes --enable-optimizations --with-system-expat --with-system-ffi --enable-ipv6 --with-openssl=/works/usr/ --enable-optimizations && LD_LIBRARY_PATH=/works/usr/lib make -j5 && LD_LIBRARY_PATH=/works/usr/lib make install
# RUN LD_LIBRARY_PATH=/works/usr/lib /works/usr/bin/pip3 install pip -U
# RUN LD_LIBRARY_PATH=/works/usr/lib /works/usr/bin/pip3 install pynvim neovim
WORKDIR ..
 

