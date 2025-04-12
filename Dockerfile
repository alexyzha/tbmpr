## Ubuntu base image (Mac: ubuntu:22.04)
FROM nvidia/cuda:12.1.1-devel-ubuntu22.04
ENV DEBIAN_FRONTEND=noninteractive

## Install all packages (comment out cuda-* on Mac)
RUN apt-get update && apt-get install -y \
    build-essential \
    valgrind \
    gdb \
    cmake \
    wget \
    curl \
    git \
    unzip \
    nano \
    pkg-config \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libtbb2 \
    libtbb-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    python3 \
    python3-pip \
    python3-dev \
    python3-numpy \
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

## Install OpenCV
RUN git clone https://github.com/opencv/opencv.git && \
    cd /opencv && mkdir build && cd build && \
    cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local .. && \
    make -j"$(nproc)" && \
    make install && \
    rm -rf /opencv

## SETWD
WORKDIR /src/

## Bash
CMD ["/bin/bash"]
