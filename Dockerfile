## Ubuntu base image (Mac: ubuntu:22.04)
FROM nvidia/cuda:12.1.1-devel-ubuntu22.04
ENV DEBIAN_FRONTEND=noninteractive

## Install all packages (comment out cuda-* on Mac)
RUN apt-get update && apt-get install -y \
    cuda-gdb cuda-memcheck \
    build-essential \
    valgrind \
    gdb \
    cmake \
    wget \
    curl \
    git \
    unzip \
    nano \
    python3 \
    python3-pip \
    locales \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

## Set up UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

## Install GTEST
RUN git clone -q https://github.com/google/googletest.git /googletest \
    && mkdir -p /googletest/build \
    && cd /googletest/build \
    && cmake .. && make -j$(nproc) && make install \
    && ldconfig \
    && rm -rf /googletest

## SETWD
WORKDIR /src/

## Bash
CMD ["/bin/bash"]
