#!/bin/bash

# this script is only for compiling and setting up the archives in the sources folder

bash $LFS_SCRIPT/Binutils/binutils_pass1.sh || exit
bash $LFS_SCRIPT/GCC/GCC_pass1.sh || exit
bash $LFS_SCRIPT/Linux_API/Linux_API_Headers.sh || exit
bash $LFS_SCRIPT/glibc/glibc.sh || exit
bash $LFS_SCRIPT/GCC/Libstdc++.sh || exit
bash $LFS_SCRIPT/Binutils/binutils_pass2.sh || exit
bash $LFS_SCRIPT/GCC/GCC_pass2.sh || exit
bash $LFS_SCRIPT/Tcl/tcl_pass1.sh || exit
