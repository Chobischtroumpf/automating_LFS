#!/bin/bash

cd $LFS/sources
tar xf $LFS/sources/linux-5.5.3.tar.xz || exit
cd $LFS/sources/linux-5.3.3/

make mrproper || exit

make headers || exit

cp -rv usr/include/* /tools/include || exit
