# Add external packages to Buildroot
EXTERNAL_PACKAGES := aesd-assignments
include $(sort $(wildcard $(BR2_EXTERNAL)/package/*/*.mk))
BR2_EXTERNAL := ../base_external
BR2_DEFCONFIG := $(BR2_EXTERNAL)/configs/aesd_qemu_defconfig
