FROM ruby:3.0.2-slim-bullseye
VOLUME /works

RUN apt-get update -qq && apt-get install -y build-essential git curl

# ONBUILD ADD . /works

ONBUILD WORKDIR /works
ONBUILD WORKDIR usr

ONBUILD WORKDIR /works

RUN apt-get install -y ncurses-dev libevent-dev pkg-config automake bison
ONBUILD RUN git clone https://github.com/tmux/tmux
ONBUILD WORKDIR tmux
ONBUILD RUN sh autogen.sh
ONBUILD RUN ./configure --prefix=/works/usr && make -j5 && make install && find /works/usr
ONBUILD WORKDIR ..

## RUN apt-get install -y zsh-autosuggestions zsh-syntax-highlighting
ONBUILD RUN git clone https://github.com/zsh-users/zsh.git
ONBUILD WORKDIR zsh
ONBUILD RUN ./Util/preconfig
ONBUILD RUN ./configure --with-tcsetpgrp --prefix=/works/usr && make -j5 && make install.bin && make install.modules
ONBUILD WORKDIR ..

RUN apt-get install -y libexpat-dev libffi-dev zlib1g-dev automake autoconf libtool rustc golang-go
# ADD . /works
RUN git clone https://github.com/openssl/openssl.git
WORKDIR openssl
RUN git checkout OpenSSL_1_1_1-stable
RUN ./config --prefix=/works/usr && make -j5 && make install_sw
WORKDIR ..

RUN curl -LO https://www.python.org/ftp/python/3.9.7/Python-3.9.7.tgz && tar xz < Python-3.9.7.tgz
WORKDIR Python-3.9.7
RUN ./configure --prefix=/works/usr --enable-shared --with-ensurepip=yes --enable-optimization
s --with-system-expat --with-system-ffi --enable-ipv6 --with-openssl=/works/usr/ --enable-optimizations && LD_LIBRARY_PATH=/works/usr/lib make -j5 && LD_LIBRARY_PATH=/works/usr/lib make install
RUN LD_LIBRARY_PATH=/works/usr/lib /works/usr/bin/pip3 install pip -U && LD_LIBRARY_PATH=/works/usr/lib /works/usr/bin/pip3 install pynvim neovim
WORKDIR ..


ONBUILD RUN git clone https://github.com/universal-ctags/ctags.git
ONBUILD WORKDIR ctags
ONBUILD RUN ./autogen.sh
ONBUILD RUN ./configure --prefix=/works/usr && make -j5 && make install
ONBUILD WORKDIR ..

ONBUILD RUN git clone https://github.com/junegunn/fzf.git
ONBUILD WORKDIR fzf
ONBUILD RUN make  && make install && cp bin/fzf /works/usr/bin/.
ONBUILD WORKDIR ..

ONBUILD RUN git clone https://github.com/BurntSushi/ripgrep.git
ONBUILD WORKDIR ripgrep
ONBUILD RUN cargo build --release &&  cp target/release/rg /works/usr/bin/.
ONBUILD WORKDIR ..


ONBUILD RUN git clone https://github.com/vim/vim.git
ONBUILD WORKDIR vim
ONBUILD RUN LD_LIBRARY_PATH=/works/usr/lib ./configure --prefix=/works/usr --with-features=huge --enable-python3interp=dynamic --with-python3-command=/works/usr/bin/python3 --enable-gpm --enable-acl --without-x --disable-gui --enable-multibyte --enable-cscope --disable-canberra --disable-netbeans --enable-fail-if-missing
ONBUILD RUN make -j5 && make install
ONBUILD WORKDIR ..

ONBUILD RUN tar czfv /works/usr usr.tar.gz

