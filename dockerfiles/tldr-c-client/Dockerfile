FROM debian:bookworm

LABEL maintainer="seth@falco.fun"

RUN apt-get update && \
    apt-get install -y build-essential git make && \
    git clone https://github.com/bats-core/bats-core.git /tmp/bats-core && \
    /tmp/bats-core/install.sh /usr/local && \
    git clone https://github.com/tldr-pages/tldr-c-client.git /tmp/tldr-c-client/ && \
    /tmp/tldr-c-client/deps.sh && \
    (cd /tmp/tldr-c-client && make && make install) && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* && \
    rm -r /tmp/*

WORKDIR /home/tldr
COPY Makefile tldr.bats /home/tldr/
