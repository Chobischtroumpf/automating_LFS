#!/bin/bash

cd $LFS/sources/
tar -xf $LFS/sources/gcc-9.2.0.tar.xz || exit
cd $LFS/sources/gcc-9.2.0/ || exit

cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include-fixed/limits.h || exit

for file in gcc/config/{linux,i386/linux{,64}}.h
do
  cp -uv $file{,.orig}
  sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
      -e 's@/usr@/tools@g' $file.orig > $file
  echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
  touch $file.orig
done || exit

case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
  ;;
esac || exit

tar -xf ../mpfr-4.0.2.tar.xz || exit
mv -v mpfr-4.0.2 mpfr || exit
tar -xf ../gmp-6.2.0.tar.xz || exit
mv -v gmp-6.2.0 gmp || exit
tar -xf ../mpc-1.1.0.tar.gz || exit
mv -v mpc-1.1.0 mpc ||exit

sed -e '1161 s|^|//|' \
    -i libsanitizer/sanitizer_common/sanitizer_platform_limits_posix.cc || exit

mkdir -v $LFS/sources/gcc-9.2.0/build/
cd $LFS/sources/gcc-9.2.0/build/

CC=$LFS_TGT-gcc                                    \
CXX=$LFS_TGT-g++                                   \
AR=$LFS_TGT-ar                                     \
RANLIB=$LFS_TGT-ranlib                             \
../configure                                       \
    --prefix=/tools                                \
    --with-local-prefix=/tools                     \
    --with-native-system-header-dir=/tools/include \
    --enable-languages=c,c++                       \
    --disable-libstdcxx-pch                        \
    --disable-multilib                             \
    --disable-bootstrap                            \
    --disable-libgomp || exit

make || exit

make install || exit

ln -sv gcc /tools/bin/cc || exit


echo 'int main(){}' > dummy.c
cc dummy.c
readelf -l a.out | grep ': /tools'


for i in 1 2 3 4 5 6 7 8 9 10
do
	echo "check result ! waiting ($i)";
	echo "if result is different from excpected, ctrl+c";
	sleep 1;
done

rm -v dummy.c a.out
