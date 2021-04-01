cmake_minimum_required(VERSION 3.14.2)

project(cmake)

set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/modules)

set(GLOBAL_C_FLAGS " \
    -fPIC \
    -Wall \
    -Wno-unused \
    -Wno-unused-parameter \
    -fcolor-diagnostics \
    ")

add_subdirectory(lib)

add_subdirectory(make_ext4fs_tools)

