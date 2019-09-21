LOCAL_PATH:= $(call my-dir)

libselinux_src_files := \
	../src/libselinux/src/callbacks.c \
	../src/libselinux/src/check_context.c \
	../src/libselinux/src/freecon.c \
	../src/libselinux/src/init.c \
	../src/libselinux/src/label.c \
	../src/libselinux/src/label_android_property.c \
	../src/libselinux/src/label_file.c \

libz_src_files  := \
	../src/zlib/src/adler32.c \
	../src/zlib/src/compress.c \
	../src/zlib/src/crc32.c \
	../src/zlib/src/deflate.c \
	../src/zlib/src/gzclose.c \
	../src/zlib/src/gzlib.c \
	../src/zlib/src/gzread.c \
	../src/zlib/src/gzwrite.c \
	../src/zlib/src/infback.c \
	../src/zlib/src/inffast.c \
	../src/zlib/src/inflate.c \
	../src/zlib/src/inftrees.c \
	../src/zlib/src/trees.c \
	../src/zlib/src/uncompr.c \
	../src/zlib/src/zutil.c \

libsparse_src_files  := \
	../src/core/libsparse/backed_block.c \
	../src/core/libsparse/img2simg.c \
	../src/core/libsparse/output_file.c \
	../src/core/libsparse/simg2img.c \
	../src/core/libsparse/simg2simg.c \
	../src/core/libsparse/sparse.c \
	../src/core/libsparse/sparse_crc32.c \
	../src/core/libsparse/sparse_err.c \
	../src/core/libsparse/sparse_read.c \

ext4fs_src_files := \
	../src/extras/ext4_utils/allocate.c \
	../src/extras/ext4_utils/canned_fs_config.c \
	../src/extras/ext4_utils/contents.c \
	../src/extras/ext4_utils/crc16.c \
	../src/extras/ext4_utils/ext4_sb.c \
	../src/extras/ext4_utils/ext4_utils.c \
	../src/extras/ext4_utils/ext4fixup.c \
	../src/extras/ext4_utils/extent.c \
	../src/extras/ext4_utils/indirect.c \
	../src/extras/ext4_utils/make_ext4fs.c \
	../src/extras/ext4_utils/make_ext4fs_main.c \
	../src/extras/ext4_utils/sha1.c \
	../src/extras/ext4_utils/uuid.c \
	../src/extras/ext4_utils/wipe.c \

common_cflags := \
  -g -O3 \
  -D__ANDROID__ \
  -DANDROID

common_includes := \
	src/core/include \
	src/core/libsparse \
	src/core/libsparse/include \
	src/libselinux/include

##
# libselinux
#
include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(libselinux_src_files)
LOCAL_MODULE := libselinux
LOCAL_CFLAGS := -std=gnu89 -DBUILD_HOST $(common_cflags)
LOCAL_C_INCLUDES := $(common_includes)

include $(BUILD_STATIC_LIBRARY)


##
# libz.a
#
include $(CLEAR_VARS)

LOCAL_MODULE := libz
LOCAL_C_INCLUDES := $(common_includes)
LOCAL_CFLAGS += -DUSE_MMAP \
    -D_FILE_OFFSET_BITS=64 \
    -D_LARGEFILE64_SOURCE=1 \
    -DZLIB_CONST

LOCAL_SRC_FILES := $(libz_src_files)

include $(BUILD_STATIC_LIBRARY)

##
# libsparse.a
#
include $(CLEAR_VARS)

LOCAL_MODULE := libsparse
LOCAL_MODULE_TAGES := optional
LOCAL_C_INCLUDES := $(common_includes)
LOCAL_SRC_FILES := $(libsparse_src_files)
LOCAL_STATIC_LIBRARIES := libz

include $(BUILD_STATIC_LIBRARY)

##
# make_ext4fs
#
include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(ext4fs_src_files)
LOCAL_MODULE := make_ext4fs
LOCAL_CFLAGS += -D_GNU_SOURCE -D__ANDROID__ -DHOST
LOCAL_STATIC_LIBRARIES := libselinux libz libsparse
LOCAL_C_INCLUDES := $(common_includes)
LOCAL_MODULE_TAGS := optional
ifeq ($(STATIC), 1)
LOCAL_LDFLAGS := -static
endif

include $(BUILD_EXECUTABLE)


##
# simg2img
#
include $(CLEAR_VARS)
LOCAL_SRC_FILES := \
	../src/core/libsparse/simg2img.c \
	../src/core/libsparse/sparse_crc32.c

LOCAL_MODULE := simg2img
LOCAL_CFLAGS := $(common_cflags) \
	-std=c11

LOCAL_STATIC_LIBRARIES := libz libsparse
LOCAL_C_INCLUDES := $(common_includes)
LOCAL_MODULE_TAGS := optional
ifeq ($(STATIC), 1)
LOCAL_LDFLAGS := -static
endif

include $(BUILD_EXECUTABLE)

##
# img2simg
#
include $(CLEAR_VARS)
LOCAL_SRC_FILES := \
	../src/core/libsparse/img2simg.c \
	../src/core/libsparse/sparse_crc32.c

LOCAL_MODULE := img2simg
LOCAL_CFLAGS := $(common_cflags)
LOCAL_STATIC_LIBRARIES := libz libsparse
LOCAL_C_INCLUDES := $(common_includes)
LOCAL_MODULE_TAGS := optional
ifeq ($(STATIC), 1)
LOCAL_LDFLAGS := -static
endif

include $(BUILD_EXECUTABLE)

##
# sefcontext_decompile
#

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	../src/sefcontext_decompile/sefcontext_decompile.cpp

LOCAL_MODULE := sefcontext_decompile
LOCAL_CPPFLAGS := $(common_cflags) -std=c++11

ifeq ($(STATIC), 1)
LOCAL_LDFLAGS := -static
endif

include $(BUILD_EXECUTABLE)

