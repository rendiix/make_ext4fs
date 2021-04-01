cmake_minimum_required(VERSION 3.14.2)

project(sefcontext_decompile)

set(SEFCONTEXT_DECOMPILE ${SRC}/sefcontext_decompile)

set(SEFCONTEXT_DECOMPILE_SRC_FILES
	${SEFCONTEXT_DECOMPILE}/sefcontext_decompile.cpp
	)

add_executable(sefcontext_decompile ${SEFCONTEXT_DECOMPILE_SRC_FILES})
target_link_libraries(sefcontext_decompile)

install(TARGETS sefcontext_decompile DESTINATION ${BIN})

