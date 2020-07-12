#!/bin/bash

rm -rf $LFS/sources/gcc-9.2.0

cd $LFS/sources/
tar xf $LFS/sources/gcc-9.2.0.tar.xz || exit

cd $LFS/sources/gcc-9.2.0/

mkdir -v $LFS/sources/gcc-9.2.0/build || exit
cd       $LFS/sources/gcc-9.2.0/build || exit

../libstdc++-v3/configure           \
    --host=$LFS_TGT                 \
    --prefix=/tools                 \
    --disable-multilib              \
    --disable-nls                   \
    --disable-libstdcxx-threads     \
    --disable-libstdcxx-pch         \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/9.2.0 || exit

make -j4 || exit

make install || exit

