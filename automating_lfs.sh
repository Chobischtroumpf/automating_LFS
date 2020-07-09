#!/bin/bash

# this script is only for compiling and setting up the archives in the sources folder

sh ./Binutils/binutils_pass1.sh || exit
cd ..
sh ./GCC/GCC_pass1.sh || exit
cd ..
sh ./Linux_API/Linux_API_Headers.sh || exit
cd ..
