#!/bin/bash

cd $LFS/sources || exit
tar xf $LFS/sources/binutils-2.34.tar.xz || exit
cd $LFS/sources/binutils-2.34 || exit
mkdir -v $LFS/sources/binutils-2.34/build
cd       $LFS/sources/binutils-2.34/build

../configure --prefix=/tools            \
             --with-sysroot=$LFS        \
             --with-lib-path=/tools/lib \
             --target=$LFS_TGT          \
             --disable-nls              \
             --disable-werror || exit

make || exit

case $(uname -m) in
  x86_64) mkdir -v /tools/lib && ln -sv lib /tools/lib64 ;;
esac || exit

make install || exit


