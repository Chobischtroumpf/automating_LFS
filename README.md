# Automating LFS
this repository is made to help you build your lfs, it is a mean to win some time by not having to compile every single source by hand.

these scripts will only work if you execute them after section II, chapter 5.3, and they will only build the temporary system. (for now, there are plans to add a script for the compilations for the final system)

#### execution time (on an intel core i7 4700MQ cpu clocked at 2.40Ghz on all cores, with 16GB ram) has not been calculated yet

the script works in a fairly simple way : you run the "automating.sh" file, from the lfs user, and it wil in turn call every script to install and compile every package, from its sources.
if for some reason one of the scripts were to have an error, it will stop, and in turn the main script will stop as well.

## in order for the script to work, the $LFS variable needs to be set, and you will need to define the $LFS_SCRIPT variable as the absolute path to this repository.

### example : LFS_SCRIPT = /home/chobischtroumpf/automating_LFS/
### and LFS = /mnt/lfs
