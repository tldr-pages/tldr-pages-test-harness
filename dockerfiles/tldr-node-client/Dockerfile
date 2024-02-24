FROM node:20

LABEL maintainer="seth@falco.fun"

RUN git clone https://github.com/bats-core/bats-core.git /tmp/bats-core && \
    /tmp/bats-core/install.sh /usr/local && \
    npm install -g tldr && \
    rm -r /tmp/*

WORKDIR /home/tldr
COPY Makefile tldr.bats /home/tldr/
