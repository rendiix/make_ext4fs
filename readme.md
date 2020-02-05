[![GitHub](https://img.shields.io/github/license/rendiix/make_ext4fs.svg)](https://github.com/rendiix/make_ext4fs/blob/master/LICENSE)
[![HitCount](http://hits.dwyl.io/rendiix/make_ext4fs.svg)](http://github.com/rendiix/make_ext4fs)
[![GitHub release](https://img.shields.io/github/release/rendiix/make_ext4fs.svg)](https://GitHub.com/rendiix/make_ext4fs/releases/)
[![Github all releases](https://img.shields.io/github/downloads/rendiix/make_ext4fs/total.svg)](https://GitHub.com/rendiix/make_ext4fs/releases/)
[![GitHub forks](https://img.shields.io/github/forks/rendiix/make_ext4fs.svg?style=social&label=Fork&maxAge=2592000)](https://GitHub.com/rendiix/make_ext4fs/network/)
[![GitHub stars](https://img.shields.io/github/stars/rendiix/make_ext4fs.svg?style=social&label=Star&maxAge=2592000)](https://GitHub.com/rendiix/make_ext4fs/stargazers/)
[![GitHub watchers](https://img.shields.io/github/watchers/rendiix/make_ext4fs.svg?style=social)](https://github.com/rendiix/make_ext4fs/watchers)
[![GitHub followers](https://img.shields.io/github/followers/rendiix.svg?style=social&label=Follow&maxAge=2592000)](https://github.com/rendiix?tab=followers)
[![GitHub contributors](https://img.shields.io/github/contributors/rendiix/make_ext4fs.svg)](https://GitHub.com/rendiix/make_ext4fs/graphs/contributors/)

# make_ext4fs for android
## termux make_ext4fs img2simg simg2img sefcontext_decompile

#### Join Discord or follow me on Twitter:

[![Discord](https://img.shields.io/discord/404576842419273729.svg?label=join%20discord&logo=discord)](https://discord.gg/5PmKhrc)
[![Twitter Follow](https://img.shields.io/twitter/follow/rendiix.svg?color=green&label=follow&logo=twitter&style=social)](https://twitter.com/rendiix)

#### How to build

>Make sure the NDK android is installed

```console
user@localhost:~/make_ext4fs$ build.sh --help
Usage ./build.sh <options>

Options:
  -t, --target   build single target i.e: <arm|aarch64|x86|x86_64>.
  -s, --static   compile static executable binary.
  -c, --compiler select compiler gcc or clang.
  -d, --debug    compile with debugable binary.
  -v, --verbose  verbose compilation.
  -h, --help     show this help message and exit.
  -q, --quiet    build with silent stdout
```
#### 

```console
user@localhost:~/make_ext4fs$ ./bin/make_ext4fs_android_arm64-v8a
Expected filename after options
make_ext4fs_android_arm64-v8a [ -l <len> ] [ -j <journal size> ] [ -b <block_size> ]
    [ -g <blocks per group> ] [ -i <inodes> ] [ -I <inode size> ]
    [ -L <label> ] [ -f ] [ -a <android mountpoint> ]
    [ -S file_contexts ] [ -C fs_config ] [ -T timestamp ]
    [ -z | -s ] [ -w ] [ -c ] [ -J ] [ -v ] [ -B <block_list_file> ]
    <filename> [<directory>]

user@localhost:~/make_ext4fs$ file bin/*
bin/img2simg_android_arm64-v8a:               ELF 64-bit LSB shared object, ARM aarch64, version 1 (SYSV), dynamically linked, interpreter /system/bin/linker64, BuildID[sha1]=4a0914b8ff1c7f6563f1fcbc95a824b70d39fca4, stripped
bin/img2simg_android_armeabi-v7a:             ELF 32-bit LSB shared object, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /system/bin/linker, BuildID[sha1]=ba8b4822d562d0fbfcf76402c9180cc37cbde6f4, stripped
bin/img2simg_android_x86:                     ELF 32-bit LSB shared object, Intel 80386, version 1 (SYSV), dynamically linked, interpreter /system/bin/linker, BuildID[sha1]=f811a702cd46a4ae0d69780c2fe90d05fe634476, stripped
bin/img2simg_android_x86_64:                  ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, interpreter /system/bin/linker64, BuildID[sha1]=81f7f27494b673e6039fac23fd1b0b833f7ece88, stripped
bin/make_ext4fs_android_arm64-v8a:            ELF 64-bit LSB shared object, ARM aarch64, version 1 (SYSV), dynamically linked, interpreter /system/bin/linker64, BuildID[sha1]=448be26434b14135733105a1494611625e9c8524, stripped
bin/make_ext4fs_android_armeabi-v7a:          ELF 32-bit LSB shared object, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /system/bin/linker, BuildID[sha1]=d0e65b8bf9fe139790d00a4f201f84fb4c713054, stripped
bin/make_ext4fs_android_x86:                  ELF 32-bit LSB shared object, Intel 80386, version 1 (SYSV), dynamically linked, interpreter /system/bin/linker, BuildID[sha1]=c03e941f31285551fa537b4d4697612dbf8ed393, stripped
bin/make_ext4fs_android_x86_64:               ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, interpreter /system/bin/linker64, BuildID[sha1]=eb4b19bbb67379aef883fa3471e918fe16c61b5f, stripped
bin/sefcontext_decompile_android_arm64-v8a:   ELF 64-bit LSB shared object, ARM aarch64, version 1 (SYSV), dynamically linked, interpreter /system/bin/linker64, BuildID[sha1]=7b04f766a0c4b58febeb08405d2657ab18f2a5c5, stripped
bin/sefcontext_decompile_android_armeabi-v7a: ELF 32-bit LSB shared object, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /system/bin/linker, BuildID[sha1]=4d823768f4bb325aa461d1dc710997db4f5c571c, stripped
bin/sefcontext_decompile_android_x86:         ELF 32-bit LSB shared object, Intel 80386, version 1 (SYSV), dynamically linked, interpreter /system/bin/linker, BuildID[sha1]=6be90443174c92123d72e01b02fba930f0d6772a, stripped
bin/sefcontext_decompile_android_x86_64:      ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, interpreter /system/bin/linker64, BuildID[sha1]=176df06e06f65c9dde1c030992a6d725c0a4daea, stripped
bin/simg2img_android_arm64-v8a:               ELF 64-bit LSB shared object, ARM aarch64, version 1 (SYSV), dynamically linked, interpreter /system/bin/linker64, BuildID[sha1]=1db907b8d878e925e9323992313501f249926b30, stripped
bin/simg2img_android_armeabi-v7a:             ELF 32-bit LSB shared object, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /system/bin/linker, BuildID[sha1]=787e54731af077392b5575b72794b8431336e23a, stripped
bin/simg2img_android_x86:                     ELF 32-bit LSB shared object, Intel 80386, version 1 (SYSV), dynamically linked, interpreter /system/bin/linker, BuildID[sha1]=3795a7c04d57740f7b79670a6ea375e300a6ff09, stripped
bin/simg2img_android_x86_64:                  ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, interpreter /system/bin/linker64, BuildID[sha1]=41bec9d211e7852deca7901ade2bbd9589561ffb, stripped
```
