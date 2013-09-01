#
# These flags represent the build-time configuration of OpenSSL for android
#
# The value of $(openssl_cflags) was pruned from the Makefile generated
# by running ./Configure from import_openssl.sh.
#
# This script performs minor but required patching for the Android build.
#

LOCAL_CFLAGS += $(openssl_cflags)

LOCAL_CFLAGS := $(filter-out -DTERMIO, $(LOCAL_CFLAGS))

ifeq ($(HOST_OS),windows)
LOCAL_CFLAGS := $(filter-out -DDSO_DLFCN -DHAVE_DLFCN_H,$(LOCAL_CFLAGS))
endif

# Directories
LOCAL_CFLAGS += \
  -DOPENSSLDIR="\"/system/lib/ssl\"" \
  -DENGINESDIR="\"/system/lib/ssl/engines\""

# Intentionally excluded http://b/7079965
LOCAL_CFLAGS := $(filter-out -DZLIB, $(LOCAL_CFLAGS))

# OpenSSL isn't ready to be built with strict aliasing, and fixing it without
# breaking both API and ABI is hard 
LOCAL_CFLAGS += -fno-strict-aliasing 

# Debug
# LOCAL_CFLAGS += -DCIPHER_DEBUG
