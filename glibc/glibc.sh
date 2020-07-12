#!/bin/bash

cd $LFS/sources/
tar xf $LFS/sources/glibc-2.31.tar.xz

cd $LFS/sources/glibc-2.31/

mkdir -v $LFS/sources/glibc-2.31/build
cd       $LFS/sources/glibc-2.31/build

../configure                             \
      --prefix=/tools                    \
      --host=$LFS_TGT                    \
      --build=$(../scripts/config.guess) \
      --enable-kernel=3.2                \
      --with-headers=/tools/include

make || exit

make install || exit

echo 'int main(){}' > dummy.c
$LFS_TGT-gcc dummy.c
readelf -l a.out | grep ': /tools' 


rm -v dummy.c a.out

for i in 1 2 3 4 5 6 7 8 9 10
do
	echo "check result ! waiting ($i)";
	echo "if result is different from excpected, ctrl+c";
	sleep 1;
done

