#!/bin/bash

brew update
brew install autoconf \
            automake \
            libtool \
            pkgconfig \
            wget \
            nim \
            cmake \
            ninja \
            git \
            boost \
            gcc \
            gnu-sed \
            llvm \
            llvm@9

brew upgrade llvm
export CC=/usr/local/opt/llvm@9/bin/clang
export CXX=/usr/local/opt/llvm@9/bin/clang++
export MACOSX_DEPLOYMENT_TARGET=10.13

# get SDKs 
git clone https://github.com/phracker/MacOSX-SDKs $HOME/sdk

# get curl
git clone https://github.com/curl/curl.git
cd curl
git checkout curl-7_70_0
./buildconf
./configure --disable-shared --enable-static --without-libidn2 --without-ssl --without-nghttp2 --disable-ldap --with-darwinssl
make -j3 install
cd ../

# get wally
export OSX_SDK=$HOME/sdk/MacOSX10.13.sdk
export CFLAGS="$CFLAGS -isysroot $OSX_SDK -mmacosx-version-min=$MACOSX_DEPLOYMENT_TARGET"
export CXXFLAGS="$CXXFLAGS -isysroot $OSX_SDK -mmacosx-version-min=$MACOSX_DEPLOYMENT_TARGET"
export LDFLAGS="$LDFLAGS -isysroot $OSX_SDK -mmacosx-version-min=$MACOSX_DEPLOYMENT_TARGET"
git clone https://github.com/KomodoPlatform/libwally-core.git
cd libwally-core
./tools/autogen.sh
./configure --disable-shared
sudo make -j3 install
cd ..
unset CFLAGS
unset CXXFLAGS
unset LDFLAGS
