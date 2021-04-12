cmake_minimum_required(VERSION 3.14.2)

project(make_ext4fs_tools)

set(SEFCONTEXT_DECOMPILE ${SRC}/sefcontext_decompile)
set(MAKE_EXT4FS ${SRC}/extras/ext4_utils)
set(IMG2SIMG ${SRC}/core/libsparse)

set(SEFCONTEXT_DECOMPILE_SRC_FILES
	${SEFCONTEXT_DECOMPILE}/sefcontext_decompile.cpp
	)

set(IMG2SIMG_SRC_FILES
	${IMG2SIMG}/img2simg.c
	)

set(SIMG2IMG_SRC_FILES
	${IMG2SIMG}/simg2img.c
	)

set(MAKE_EXT4FS_SRC_FILES
	${MAKE_EXT4FS}/allocate.c
	${MAKE_EXT4FS}/canned_fs_config.c
	${MAKE_EXT4FS}/contents.c
	${MAKE_EXT4FS}/crc16.c
	${MAKE_EXT4FS}/ext4_sb.c
	${MAKE_EXT4FS}/ext4_utils.c
	${MAKE_EXT4FS}/ext4fixup.c
	${MAKE_EXT4FS}/extent.c
	${MAKE_EXT4FS}/indirect.c
	${MAKE_EXT4FS}/make_ext4fs.c
	${MAKE_EXT4FS}/make_ext4fs_main.c
	${MAKE_EXT4FS}/sha1.c
	${MAKE_EXT4FS}/uuid.c
	${MAKE_EXT4FS}/wipe.c
	)

set(CMAKE_C_FLAGS " \
	-D_GNU_SOURCE \
	-DANDROID \
	-DHOST \
	")

include_directories(
	${common_include}
	${MAKE_EXT4FS_SRC_FILES}
	)


add_executable(make_ext4fs ${MAKE_EXT4FS_SRC_FILES})
target_link_libraries(make_ext4fs
	selinux
	sparse
	zlib)

add_executable(img2simg ${IMG2SIMG_SRC_FILES})
target_link_libraries(img2simg
	sparse
	zlib)

add_executable(simg2img ${SIMG2IMG_SRC_FILES})
target_link_libraries(simg2img
	sparse
	zlib)

add_executable(sefcontext_decompile ${SEFCONTEXT_DECOMPILE_SRC_FILES})
target_link_libraries(sefcontext_decompile)
