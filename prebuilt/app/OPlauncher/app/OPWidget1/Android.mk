LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := OPWidget1
LOCAL_MODULE_STEM := OPWidget1.apk
LOCAL_SRC_FILES := OPWidget1.apk
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT)/app/OPWidget1

include $(BUILD_PREBUILT)
