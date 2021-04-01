cmake_minimum_required(VERSION 3.14.2)

project(libzlib)

set(LIBZLIB ${SRC}/zlib/src)

set(LIBZLIB_SRC_FILES
	${LIBZLIB}/adler32.c
	${LIBZLIB}/compress.c
	${LIBZLIB}/crc32.c
	${LIBZLIB}/deflate.c
	${LIBZLIB}/gzclose.c
	${LIBZLIB}/gzlib.c
	${LIBZLIB}/gzread.c
	${LIBZLIB}/gzwrite.c
	${LIBZLIB}/infback.c
	${LIBZLIB}/inffast.c
	${LIBZLIB}/inflate.c
	${LIBZLIB}/inftrees.c
	${LIBZLIB}/trees.c
	${LIBZLIB}/uncompr.c
	${LIBZLIB}/zutil.c
	)

set(CMAKE_C_FLAGS " \
	-DUSE_MMAP \
    -D_FILE_OFFSET_BITS=64 \
    -D_LARGEFILE64_SOURCE=1 \
    -DZLIB_CONST \
	")

include_directories(
	${common_include}
	)

add_library(zlib STATIC ${LIBZLIB_SRC_FILES})
target_link_libraries(zlib)
