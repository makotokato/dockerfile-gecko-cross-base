FROM ubuntu:18.04
MAINTAINER Makoto Kato <m_kato@ga2.so-net.ne.jp>

ADD sources.list /etc/apt/
RUN mkdir /mozilla /root/.mozbuild
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
      autoconf2.13 \
      build-essential \
      ccache \
      clang \
      curl \
      g++ \
      gcc-multilib \
      llvm \
      mercurial \
      python \
      unzip \
      zip && \
    apt-get clean
RUN curl -s https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init -o rustup-init && \
    chmod +x rustup-init && \
    ./rustup-init -y && \
    rm rustup-init
RUN curl -s https://nodejs.org/dist/v8.11.4/node-v8.11.4-linux-x64.tar.xz | tar Jxf -
ENV PATH=$PATH:/root/.cargo/bin:/node-v8.11.4-linux-x64/bin
RUN cargo install cbindgen
ENV SHELL=/bin/bash
ENV NO_MERCURIAL_SETUP_CHECK=1
