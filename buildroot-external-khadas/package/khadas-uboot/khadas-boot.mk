################################################################################
#
# Khadas AMLogic secure boot loader
#
################################################################################

KHADAS_UBOOT_VERSION = 081023
KHADAS_UBOOT_SOURCE = fip-$(KHADAS_UBOOT_VERSION).tar.xz
KHADAS_UBOOT_SITE = https://github.com/khadas/khadas-uboot/releases/download/tc
KHADAS_UBOOT_LICENSE = GPL-2.0+
KHADAS_UBOOT_LICENSE_FILES = Licenses/gpl-2.0.txt
KHADAS_UBOOT_INSTALL_IMAGES = YES
KHADAS_UBOOT_DEPENDENCIES = uboot

ifeq ($(BR2_PACKAGE_KHADAS_UBOOT_VIM3),y)
KHADAS_UBOOT_FIP_DIR = $(@D)/VIM3

KHADAS_UBOOT_AML_ENCRYPT = aml_encrypt_g12b

endif

ifeq ($(BR2_PACKAGE_KHADAS_UBOOT_VIM3L),y)
KHADAS_UBOOT_FIP_DIR = $(@D)/VIM3L

KHADAS_UBOOT_AML_ENCRYPT = aml_encrypt_g12a

endif

ifneq (,$(filter y,$(BR2_PACKAGE_KHADAS_UBOOT_VIM3) $(BR2_PACKAGE_KHADAS_UBOOT_VIM3L)))

KHADAS_UBOOT_BINS += u-boot.gxl

define KHADAS_UBOOT_BUILD_CMDS
	# Implement signing u-boot.bin similar to how its done in
	# https://github.com/spikerguy/khadas-uboot/blob/master/packages/u-boot-mainline/package.mk
	mkdir -p $(@D)/fip

	cp $(KHADAS_UBOOT_FIP_DIR)/bl301.bin $(@D)/fip/
	cp $(KHADAS_UBOOT_FIP_DIR)/acs.bin $(@D)/fip/
	cp $(KHADAS_UBOOT_FIP_DIR)/bl2.bin $(@D)/fip/
	cp $(KHADAS_UBOOT_FIP_DIR)/bl30.bin $(@D)/fip/
	cp $(KHADAS_UBOOT_FIP_DIR)/bl31.img $(@D)/fip/
	cp $(KHADAS_UBOOT_FIP_DIR)/ddr3_1d.fw $(@D)/fip/
	cp $(KHADAS_UBOOT_FIP_DIR)/ddr4_1d.fw $(@D)/fip/
	cp $(KHADAS_UBOOT_FIP_DIR)/ddr4_2d.fw $(@D)/fip/
	cp $(KHADAS_UBOOT_FIP_DIR)/diag_lpddr4.fw $(@D)/fip/
	cp $(KHADAS_UBOOT_FIP_DIR)/lpddr3_1d.fw $(@D)/fip/
	cp $(KHADAS_UBOOT_FIP_DIR)/lpddr4_1d.fw $(@D)/fip/
	cp $(KHADAS_UBOOT_FIP_DIR)/lpddr4_2d.fw $(@D)/fip/
	cp $(KHADAS_UBOOT_FIP_DIR)/piei.fw $(@D)/fip/
	cp $(KHADAS_UBOOT_FIP_DIR)/aml_ddr.fw $(@D)/fip/
	cp $(BINARIES_DIR)/u-boot.bin $(@D)/fip/bl33.bin

	cd $(@D); $(KHADAS_UBOOT_FIP_DIR)/blx_fix.sh \
		fip/bl30.bin \
		fip/zero_tmp \
		fip/bl30_zero.bin \
		fip/bl301.bin \
		fip/bl301_zero.bin \
		fip/bl30_new.bin \
		bl30

	cd $(@D); $(KHADAS_UBOOT_FIP_DIR)/blx_fix.sh \
		fip/bl2.bin \
		fip/zero_tmp \
		fip/bl2_zero.bin \
		fip/acs.bin \
		fip/bl21_zero.bin \
		fip/bl2_new.bin \
		bl2

	cd $(@D); \
	$(KHADAS_UBOOT_FIP_DIR)/$(KHADAS_UBOOT_AML_ENCRYPT) --bl30sig --input fip/bl30_new.bin \
					--output fip/bl30_new.bin.g12a.enc \
					--level v3
	cd $(@D); \
	$(KHADAS_UBOOT_FIP_DIR)/$(KHADAS_UBOOT_AML_ENCRYPT) --bl3sig --input fip/bl30_new.bin.g12a.enc \
					--output fip/bl30_new.bin.enc \
					--level v3 --type bl30
	cd $(@D); \
	$(KHADAS_UBOOT_FIP_DIR)/$(KHADAS_UBOOT_AML_ENCRYPT) --bl3sig --input fip/bl31.img \
					--output fip/bl31.img.enc \
					--level v3 --type bl31
	cd $(@D); \
	$(KHADAS_UBOOT_FIP_DIR)/$(KHADAS_UBOOT_AML_ENCRYPT) --bl3sig --input fip/bl33.bin --compress lz4 \
					--output fip/bl33.bin.enc \
					--level v3 --type bl33 --compress lz4
	cd $(@D); \
	$(KHADAS_UBOOT_FIP_DIR)/$(KHADAS_UBOOT_AML_ENCRYPT) --bl2sig --input fip/bl2_new.bin \
					--output fip/bl2.n.bin.sig
	cd $(@D); \
	$(KHADAS_UBOOT_FIP_DIR)/$(KHADAS_UBOOT_AML_ENCRYPT) --bootmk \
		--output fip/u-boot.bin \
		--bl2 fip/bl2.n.bin.sig \
		--bl30 fip/bl30_new.bin.enc \
		--bl31 fip/bl31.img.enc \
		--bl33 fip/bl33.bin.enc \
		--ddrfw1 fip/ddr4_1d.fw \
		--ddrfw2 fip/ddr4_2d.fw \
		--ddrfw3 fip/ddr3_1d.fw \
		--ddrfw4 fip/piei.fw \
		--ddrfw5 fip/lpddr4_1d.fw \
		--ddrfw6 fip/lpddr4_2d.fw \
		--ddrfw7 fip/diag_lpddr4.fw \
		--ddrfw8 fip/aml_ddr.fw \
		--ddrfw9 fip/lpddr3_1d.fw \
		--level v3

	cp -f $(@D)/fip/u-boot.bin.sd.bin  $(@D)/u-boot.gxl
endef

endif

define KHADAS_UBOOT_INSTALL_IMAGES_CMDS
	$(foreach f,$(KHADAS_UBOOT_BINS), \
			cp -dpf $(@D)/$(f) $(BINARIES_DIR)/
	)
endef

$(eval $(generic-package))
