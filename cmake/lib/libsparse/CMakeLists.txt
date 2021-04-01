cmake_minimum_required(VERSION 3.14.2)

project(libsparse)

set(LIBSPARSE ${SRC}/core/libsparse)

set(LIBSPARSE_SRC_FILES
	${LIBSPARSE}/backed_block.c
	${LIBSPARSE}/img2simg.c
	${LIBSPARSE}/output_file.c
	${LIBSPARSE}/simg2img.c
	${LIBSPARSE}/simg2simg.c
	${LIBSPARSE}/sparse.c
	${LIBSPARSE}/sparse_crc32.c
	${LIBSPARSE}/sparse_err.c
	${LIBSPARSE}/sparse_read.c
	)

include_directories(
	${common_include}
	)

add_library(sparse STATIC ${LIBSPARSE_SRC_FILES})
target_link_libraries(sparse)
