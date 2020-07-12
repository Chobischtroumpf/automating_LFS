#!/bin/bash

rm -rf $LFS/sources/binutils-2.34
cd $LFS/sources/

tar xf binutils-2.34.tar.xz || exit

cd $LFS/sources/binutils-2.34/ || exit
mkdir	-v $LFS/sources/binutils-2.34/build
cd	$LFS/sources/binutils-2.34/build

CC=$LFS_TGT-gcc                \
AR=$LFS_TGT-ar                 \
RANLIB=$LFS_TGT-ranlib         \
../configure                   \
    --prefix=/tools            \
    --disable-nls              \
    --disable-werror           \
    --with-lib-path=/tools/lib \
    --with-sysroot || exit

make || exit

make install || exit

make -C ld clean
make -C ld LIB_PATH=/usr/lib:/lib
cp -v ld/ld-new /tools/bin
