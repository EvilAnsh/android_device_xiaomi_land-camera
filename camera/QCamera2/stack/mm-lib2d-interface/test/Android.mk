#lib2d sample test
OLD_LOCAL_PATH := $(LOCAL_PATH)
MM_LIB2D_TEST_PATH := $(call my-dir)

include $(LOCAL_PATH)/../../common.mk
include $(CLEAR_VARS)
LOCAL_PATH := $(MM_LIB2D_TEST_PATH)
LOCAL_MODULE_TAGS := optional

LOCAL_CFLAGS := -DCAMERA_ION_HEAP_ID=ION_IOMMU_HEAP_ID
LOCAL_CFLAGS += -Wall -Wextra -Werror -Wno-unused-parameter
LOCAL_CFLAGS += -D_ANDROID_

ifeq ($(MI8937_CAM_USE_RENAMED_BLOBS_L),true)
LOCAL_CFLAGS += -DRENAME_BLOBS
endif

ifeq ($(strip $(TARGET_USES_ION)),true)
LOCAL_CFLAGS += -DUSE_ION
endif

IMGLIB_HEADER_PATH := $(TARGET_OUT_INTERMEDIATES)/include/mm-camera/imglib

LOCAL_C_INCLUDES += \
    $(IMGLIB_HEADER_PATH) \
    $(LOCAL_PATH)/../../common \
    $(LOCAL_PATH)/../inc

LOCAL_HEADER_LIBRARIES += generated_kernel_headers

LOCAL_SRC_FILES := mm_lib2d_test.c

LOCAL_32_BIT_ONLY := $(BOARD_QTI_CAMERA_32BIT_ONLY)
LOCAL_MODULE           := Lm-lib2d-interface-test
LOCAL_VENDOR_MODULE := true
LOCAL_PRELINK_MODULE   := false
LOCAL_SHARED_LIBRARIES := libcutils libdl libLmlib2d_interface

include $(BUILD_EXECUTABLE)

LOCAL_PATH := $(OLD_LOCAL_PATH)
