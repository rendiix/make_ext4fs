cmake_minimum_required(VERSION 3.14.2)

project(img2simg)

set(IMG2SIMG ${SRC}/core/libsparse)

set(IMG2SIMG_SRC_FILES
	${IMG2SIMG}/img2simg.c
	)

include_directories(
	${common_include}
	)

add_executable(img2simg ${IMG2SIMG_SRC_FILES})
target_link_libraries(img2simg
	sparse
	zlib)

install(TARGETS img2simg DESTINATION ${BIN}) 


