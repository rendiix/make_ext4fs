cmake_minimum_required(VERSION 3.14.2)

project(libselinux)

set(LIBSELINUX ${SRC}/libselinux/src)

set(LIBSELINUX_SRC_FILES
	${LIBSELINUX}/callbacks.c
	${LIBSELINUX}/check_context.c
	${LIBSELINUX}/freecon.c
	${LIBSELINUX}/init.c
	${LIBSELINUX}/label.c
	${LIBSELINUX}/label_android_property.c
	${LIBSELINUX}/label_file.c
	)

set(CMAKE_C_FLAGS " \
	-std=gnu89 -DBUILD_HOST \
	")

include_directories(
	${common_include}
	)

add_library(selinux STATIC ${LIBSELINUX_SRC_FILES})
target_link_libraries(selinux)
