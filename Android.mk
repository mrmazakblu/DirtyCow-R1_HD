LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := dirtycow
LOCAL_SRC_FILES := \
	dirtycow.c
LOCAL_CFLAGS += -DDEBUG
LOCAL_SHARED_LIBRARIES := liblog
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_MODULE := recowvery-app_process32
LOCAL_SRC_FILES := \
	recowvery-app_process32.c
LOCAL_CFLAGS += -DDEBUG
LOCAL_SHARED_LIBRARIES := liblog libcutils libselinux
LOCAL_LDLIBS := -llog -lselinux -lcutils
include $(BUILD_EXECUTABLE)
