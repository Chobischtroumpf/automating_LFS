#!/bin/bash

cd $LFS/sources/
tar xf $LFS/sources/tcl8.6.10-src.tar.gz || exit

cd $LFS/sources/tcl8.6.10/

cd $LFS/sources/tcl8.6.10/unix
./configure --prefix=/tools || exit

make -j4 || exit

TZ=UTC make test || exit

sleep 20

make install || exit

chmod -v u+w /tools/lib/libtcl8.6.so || exit

make install-private-headers || exit

ln -sv tclsh8.6 /tools/bin/tclsh || exit


