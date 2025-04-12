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
    libgtk2.0-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libopenexr-dev \
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

## Install OpenCV
ARG OPENCV_VERSION=4.8.0
RUN git clone -b ${OPENCV_VERSION} --depth 1 https://github.com/opencv/opencv.git /opencv && \
    git clone -b ${OPENCV_VERSION} --depth 1 https://github.com/opencv/opencv_contrib.git /opencv_contrib && \
    mkdir -p /opencv/build && cd /opencv/build && \
    cmake -D CMAKE_BUILD_TYPE=Release \
          -D CMAKE_INSTALL_PREFIX=/usr/local \
          -D WITH_CUDA=ON \
          -D CUDA_ARCH_BIN=all \
          -D OPENCV_EXTRA_MODULES_PATH=/opencv_contrib/modules \
          -D WITH_CUBLAS=ON \
          -D WITH_GTK=ON \
          -D BUILD_EXAMPLES=OFF \
          .. && \
    make -j$(nproc) && make install && ldconfig && \
    rm -rf /opencv /opencv_contrib

## SETWD
WORKDIR /src/

## Bash
CMD ["/bin/bash"]
