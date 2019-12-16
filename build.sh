#!/data/data/com.termux/files/usr/bin/env bash
# File       : build.sh
# Author     : rendiix <vanzdobz@gmail.com>
# Create date: 28-Jun-2019 19:10
# package/lolcat/build.sh
# Copyright (c) 2019 rendiix <vanzdobz@gmail.com>
#
#      DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#               Version 2, December 2004
#
# Everyone is permitted to copy and distribute verbatim or 
# modified copies of this license document,and changing it
# is allowed as long as the name is changed.
#
#      DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#           TERMS AND CONDITIONS FOR COPYING,
#             DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.

VAR_PKG_NAME="ext4fs-tools"
VAR_PKG_VERSION="8.1.0"
VAR_PKG_URL="https://github.com/rendiix/make_ext4fs/archive/8.1.0.tar.gz"
VAR_PKG_DEPEND=""
VAR_PKG_HOMEPAGE="https://github.com/rendiix/make_ext4fs"
VAR_PKG_DESCRIPTION="Android img tools: make_ext4fs img2simg simg2img sefcontext_decompile."
VAR_ABI="arm aarch64"

function BUILD_PACKAGE() {
	cd $SOURCE_DIR
	if [ "$BUILD_ARCH" = "aarch64" ]; then
		lib_dir=libs/arm64-v8a
		target=arm64
	else
		lib_dir=libs/armeabi-v7a
		target=arm
	fi
	bash ./build.sh -t $target -n
	mkdir -p ${PKG_PREFIX}/usr/bin
	mv $lib_dir/* ${PKG_PREFIX}/usr/bin/
	rm -rf libs obj
}
