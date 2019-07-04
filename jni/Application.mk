APP_PLATFORM := android-26

ifeq ($(BUILD), aarch64)
APP_ABI := arm64-v8a
endif

ifeq ($(BUILD), arm)
APP_ABI := armeabi-v7a
endif

ifeq ($(BUILD), x86_64)
APP_ABI := x86_64
endif

ifeq ($(BUILD), x86)
APP_ABI := x86
endif

ifeq ($(BUILD), all)
APP_ABI := arm64-v8a armeabi-v7a x86 x86_64
endif

ifeq ($(TOOLCHAINS), gcc)
NDK_TOOLCHAIN_VERSION=4.9
endif

ifeq ($(TOOLCHAINS), clang)
NDK_TOOLCHAIN_VERSION=clang
endif
