FROM build_vm:latest


WORKDIR /works/usr
WORKDIR /works

RUN git clone https://github.com/tmux/tmux
WORKDIR tmux
RUN sh autogen.sh
RUN ./configure --prefix=/works/usr && make -j5 && make install
WORKDIR ..

RUN git clone https://github.com/zsh-users/zsh.git
WORKDIR zsh
RUN ./Util/preconfig
RUN ./configure --with-tcsetpgrp --prefix=/works/usr && make -j5 && make install.bin install.modules install.fns
WORKDIR ..


RUN git clone https://github.com/universal-ctags/ctags.git
WORKDIR ctags
RUN ./autogen.sh
RUN ./configure --prefix=/works/usr && make -j5 && make install
WORKDIR ..

RUN git clone https://github.com/junegunn/fzf.git
WORKDIR fzf
RUN make && make install && cp bin/fzf /works/usr/bin/.
WORKDIR ..

RUN git clone https://github.com/BurntSushi/ripgrep.git
WORKDIR ripgrep
RUN . $HOME/.cargo/env && cargo build --release -j6 && cp target/release/rg /works/usr/bin/.
WORKDIR ..

RUN git clone https://github.com/sharkdp/bat.git
WORKDIR bat
RUN . $HOME/.cargo/env && cargo build --release -j6 && cp target/release/bat /works/usr/bin/.
WORKDIR ..

RUN git clone https://github.com/sharkdp/fd.git
WORKDIR fd
RUN . $HOME/.cargo/env && cargo build --release -j6 && cp target/release/fd /works/usr/bin/.
WORKDIR ..

RUN git clone https://github.com/Peltoche/lsd.git
WORKDIR lsd
RUN . $HOME/.cargo/env && cargo build --release -j6 && cp target/release/lsd /works/usr/bin/.
WORKDIR ..

RUN git clone https://github.com/starship/starship.git
WORKDIR starship
RUN . $HOME/.cargo/env && cargo build --release -j6 && cp target/release/starship /works/usr/bin/.
WORKDIR ..

RUN git clone https://github.com/vim/vim.git
WORKDIR vim
RUN LD_LIBRARY_PATH=/works/usr/lib ./configure --prefix=/works/usr --with-features=huge --enable-python3interp=dynamic --with-python3-command=/works/usr/bin/python3 --enable-gpm --enable-acl --without-x --disable-gui --enable-multibyte --enable-cscope --disable-canberra --disable-netbeans --enable-fail-if-missing
RUN make -j5 && make install
WORKDIR ..

ENV token "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"
ENV tag "$(TZ="Asia/Tokyo" date +"%Y-%m-%d_%H:%M:%S")"
ENV repository_path "nmrnbpw/vim_install_script"
ENV file_path "usr.tar.gz"

RUN tar czf $file_path usr/
ENV response $(curl -X POST -H "Accept: application/vnd.github.v3+json" -H "Authorization: token $token" https://api.github.com/repos/$repository_path/releases -d "{\"tag_name\":\"$tag\"}")

RUN echo $response
ENV release_id "$(echo $response | jq '.id')"
RUN echo $release_id

COPY release.sh /works/
RUN ./release.sh

# RUN echo curl -X POST -H "Content-Type: $(file -b --mime-type $file_path)" -H "Authorization: token $token" --data-binary @$file_path "https://uploads.github.com/repos/$repository_path/releases/$release_id/assets?name=$(basename $file_path)"
# RUN curl -X POST -H "Content-Type: $(file -b --mime-type $file_path)" -H "Authorization: token $token" --data-binary @$file_path "https://uploads.github.com/repos/$repository_path/releases/$release_id/assets?name=$(basename $file_path)"

