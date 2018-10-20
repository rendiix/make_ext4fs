LOCAL_PATH:= $(call my-dir)

libselinux_src_files := \
	libselinux/src/callbacks.c \
	libselinux/src/check_context.c \
	libselinux/src/freecon.c \
	libselinux/src/init.c \
	libselinux/src/label.c \
	libselinux/src/label_file.c \
	libselinux/src/label_android_property.c
	
libz_src_files  := $(wildcard $(LOCAL_PATH)/zlib/src/*.c)
libsparse_src_files  := $(wildcard $(LOCAL_PATH)/core/libsparse/*.c)
ext4fs_src_files := := $(wildcard $(LOCAL_PATH)/extras/ext4_utils/*.c)

common_cflags := \
  -g -O3 \
  -D__ANDROID__ \
  -DANDROID


common_ldlibs := \
  -lc

common_includes := \
	core/include \
	core/libsparse/include \
	libselinux/include \
	pcre/dist2 \
	pcre/include_internal \
	pcre/include \
	libpcre/dist

##
# libselinux
#
include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(libselinux_src_files)
LOCAL_MODULE := libselinux
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS := -std=gnu89 -DBUILD_HOST $(common_cflags)
LOCAL_C_INCLUDES := $(common_includes)
LOCAL_MODULE_CLASS := STATIC_LIBRARIES

include $(BUILD_STATIC_LIBRARY)


##
# libz.a
#
include $(CLEAR_VARS)

LOCAL_MODULE := libz
LOCAL_MODULE_TAGS := optional
LOCAL_C_INCLUDES := $(common_includes)
LOCAL_CFLAGS += -DUSE_MMAP -D_FILE_OFFSET_BITS=64 -D_LARGEFILE64_SOURCE=1 -DZLIB_CONST
LOCAL_LDFLAGS += -Wl,--hash-style=both
LOCAL_SRC_FILES := $(libz_src_files)
LOCAL_MODULE_CLASS := STATIC_LIBRARIES

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
LOCAL_MODULE_CLASS := STATIC_LIBRARIES

include $(BUILD_STATIC_LIBRARY)

##
# make_ext4fs
#
include $(CLEAR_VARS)
LOCAL_SRC_FILES := \
	extras/ext4_utils/make_ext4fs_main.c \
	extras/ext4_utils/make_ext4fs.c \
	extras/ext4_utils/ext4fixup.c \
	extras/ext4_utils/ext4_utils.c \
	extras/ext4_utils/allocate.c \
	extras/ext4_utils/contents.c \
	extras/ext4_utils/extent.c \
	extras/ext4_utils/indirect.c \
	extras/ext4_utils/uuid.c \
	extras/ext4_utils/sha1.c \
	extras/ext4_utils/wipe.c \
	extras/ext4_utils/crc16.c \
	extras/ext4_utils/ext4_sb.c \
	extras/ext4_utils/canned_fs_config.c

LOCAL_MODULE := make_ext4fs
LOCAL_CFLAGS += -D_FILE_OFFSET_BITS=64 -D_LARGEFILE64_SOURCE=1 -D_GNU_SOURCE -D__ANDROID__ -DHOST
LOCAL_STATIC_LIBRARIES := libselinux libz libsparse
LOCAL_C_INCLUDES := $(common_includes)
LOCAL_MODULE_TAGS := optional
LOCAL_LDFLAGS := -static

include $(BUILD_EXECUTABLE)


##
# simg2img
#
include $(CLEAR_VARS)
LOCAL_SRC_FILES := \
	core/libsparse/simg2img.c \
	core/libsparse/sparse_crc32.c

LOCAL_MODULE := simg2img
LOCAL_CFLAGS := $(common_cflags)
LOCAL_STATIC_LIBRARIES := libz libsparse
LOCAL_C_INCLUDES := $(common_includes)
LOCAL_MODULE_TAGS := optional
LOCAL_LDFLAGS := -static

include $(BUILD_EXECUTABLE)

##
# img2simg
#
include $(CLEAR_VARS)
LOCAL_SRC_FILES := \
	core/libsparse/img2simg.c \
	core/libsparse/sparse_crc32.c

LOCAL_MODULE := img2simg
LOCAL_CFLAGS := $(common_cflags)
LOCAL_STATIC_LIBRARIES := libz libsparse
LOCAL_C_INCLUDES := $(common_includes)
LOCAL_MODULE_TAGS := optional
LOCAL_LDFLAGS := -static

include $(BUILD_EXECUTABLE)

