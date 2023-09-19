FROM debian:bookworm-slim

RUN apt update && apt upgrade && \
  apt install -y git curl cmake build-essential pkg-config libssl-dev && \
  apt clean && \
  rm -rf /var/lib/apt/lists/*

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

COPY ./scripts/build.sh /root/.
WORKDIR /root
ENTRYPOINT [ "/root/build.sh" ]

VOLUME [ "/build", "/scripts" ]

CMD ["bash"]

