LOCAL_PATH := $(call my-dir)

####################################################################

# When adding GL support, will have to specify this?
#-include vendor/intel/g945/Android.mk

# include more board specific stuff here? Audio params?! <shrug>


####################################################################
### Include input devices specific files

include $(CLEAR_VARS)
LOCAL_SRC_FILES := AT_Translated_Set_2_keyboard.kcm
include $(BUILD_KEY_CHAR_MAP)

define add-prebuilt-target

file := $(1)/$(2)
$$(file): $$(LOCAL_PATH)/$(2) | $$(ACP)
	$$(transform-prebuilt-to-target)
ALL_PREBUILT += $$(file)

endef

$(eval $(call add-prebuilt-target,$(TARGET_ROOT_OUT),init.rc))
$(INSTALLED_RAMDISK_TARGET): $(file)
$(eval $(call add-prebuilt-target,$(TARGET_ROOT_OUT),init.eeepc.rc))
$(INSTALLED_RAMDISK_TARGET): $(file)
$(eval $(call add-prebuilt-target,$(TARGET_OUT_DATA_ETC),init.eeepc.sh))
# /etc/Wireless is the current temp location of the firmware, we will
# move to /lib/firmware
$(eval $(call add-prebuilt-target,$(TARGET_OUT_DATA_ETC)/Wireless/RT2860STA,RT2860STA.dat))
$(eval $(call add-prebuilt-target,$(TARGET_OUT_KEYLAYOUT),AT_Translated_Set_2_keyboard.kl))

file := $(TARGET_ROOT_OUT)/mountd.conf
$(file): $(LOCAL_PATH)/mountd.conf | $(ACP) $(TARGET_OUT_DATA_ETC)/NOTICE.html.gz
	$(transform-prebuilt-to-target)
	ln -sf ../../mountd.conf $(TARGET_OUT_DATA_ETC)
ALL_PREBUILT += $(file)
$(INSTALLED_RAMDISK_TARGET): $(file)
