################################################################################
#
# Patch the linux kernel with aufs extension
#
################################################################################

LINUX_EXTENSIONS += common-drivers

# Prepare kernel patch
define COMMON_DRIVERS_PREPARE_KERNEL
	if test -e $(LINUX_DIR)/common_drivers ; then \
		rm $(LINUX_DIR)/common_drivers ; \
	fi ; \
	ln -sf $(COMMON_DRIVERS_DIR) $(LINUX_DIR)/common_drivers
endef

ifeq ($(BR2_LINUX_KERNEL_EXT_COMMON_DRIVERS),y)
define LINUX_INSTALL_DTB
	# dtbs moved from arch/<ARCH>/boot to arch/<ARCH>/boot/dts since 3.8-rc1
	$(foreach dtb,$(LINUX_DTBS), \
		install -D \
			$(LINUX_DIR)/common_drivers/arch/$(KERNEL_ARCH)/boot/dts/amlogic/$(dtb) \
			$(1)/$(if $(BR2_LINUX_KERNEL_DTB_KEEP_DIRNAME),$(dtb),$(notdir $(dtb)))
	)
endef
endif # BR2_LINUX_KERNEL_EXT_COMMON_DRIVERS
