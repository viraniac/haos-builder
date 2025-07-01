################################################################################
#
# Khadas AMLogic secure boot loader
#
################################################################################

KHADAS_FIRMWARE_VERSION = 1.7.3
KHADAS_FIRMWARE_SITE = $(BR2_EXTERNAL_SBC_PATH)/package/khadas-firmware/src
KHADAS_FIRMWARE_SITE_METHOD = local
KHADAS_FIRMWARE_LICENSE = GPL-2.0+
KHADAS_FIRMWARE_LICENSE_FILES = Licenses/gpl-2.0.txt

define KHADAS_FIRMWARE_INSTALL_TARGET_CMDS
	cp -rdf --preserve=mode $(@D)/brcm $(TARGET_DIR)/lib/firmware/

	## Wi-Fi firmware
	mv $(TARGET_DIR)/lib/firmware/brcm/fw_bcm4359c0_ag_apsta_ap6398s.bin $(TARGET_DIR)/lib/firmware/brcm/fw_bcm4359c0_ag_apsta.bin
	mv $(TARGET_DIR)/lib/firmware/brcm/fw_bcm4359c0_ag_ap6398s.bin $(TARGET_DIR)/lib/firmware/brcm/fw_bcm4359c0_ag.bin
	mv $(TARGET_DIR)/lib/firmware/brcm/fw_bcm4359c0_ag_p2p_ap6398s.bin $(TARGET_DIR)/lib/firmware/brcm/fw_bcm4359c0_ag_p2p.bin
	mv $(TARGET_DIR)/lib/firmware/brcm/brcmfmac4359-sdio_ap6398s.bin $(TARGET_DIR)/lib/firmware/brcm/brcmfmac4359-sdio.bin
	mv $(TARGET_DIR)/lib/firmware/brcm/brcmfmac4359-sdio_ap6398s.txt $(TARGET_DIR)/lib/firmware/brcm/brcmfmac4359-sdio.txt

	## Bluetooth firmware
	mv $(TARGET_DIR)/lib/firmware/brcm/BCM4359C0_ap6398s.hcd $(TARGET_DIR)/lib/firmware/brcm/BCM4359C0.hcd
	mkdir $(TARGET_DIR)/etc/systemd/system/NetworkManager.service.d
	cp $(@D)/override.conf $(TARGET_DIR)/etc/systemd/system/NetworkManager.service.d/
endef

$(eval $(generic-package))
