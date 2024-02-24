FROM rust:bookworm

LABEL maintainer="seth@falco.fun"

RUN git clone https://github.com/bats-core/bats-core.git /tmp/bats-core && \
    /tmp/bats-core/install.sh /usr/local && \
    cargo install tealdeer && \
    rm -r /tmp/*

WORKDIR /home/tldr
COPY Makefile tldr.bats /home/tldr/
