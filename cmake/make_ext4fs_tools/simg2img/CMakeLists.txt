cmake_minimum_required(VERSION 3.14.2)

project(simg2img)

set(SIMG2IMG ${SRC}/core/libsparse)

set(SIMG2IMG_SRC_FILES
	${SIMG2IMG}/simg2img.c
	)

include_directories(
	${common_include}
	)

add_executable(simg2img ${SIMG2IMG_SRC_FILES})
target_link_libraries(simg2img
	sparse
	zlib)

install(TARGETS simg2img DESTINATION ${BIN}) 


