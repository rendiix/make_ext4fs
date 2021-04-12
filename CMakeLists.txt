cmake_minimum_required(VERSION 3.14.2)

project(make_ext4fs_tools)

set(SRC ${CMAKE_SOURCE_DIR}/src)
set(BIN ${CMAKE_SOURCE_DIR}/bin)

set(common_include
	${SRC}/core/include
	${SRC}/core/libsparse
	${SRC}/core/libsparse/include
	${SRC}/libselinux/include
	)

add_subdirectory(cmake)

install(TARGETS sefcontext_decompile img2simg simg2img make_ext4fs DESTINATION ${BIN})
