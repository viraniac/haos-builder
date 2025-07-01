################################################################################
#
# gcc-linaro-aarch64-elf
#
################################################################################

GCC_LINARO_AARCH64_ELF_VERSION = 7.3.1-2018.05
GCC_LINARO_AARCH64_ELF_SHORT_VERSION = 7.3-2018.05
GCC_LINARO_AARCH64_ELF_SITE = https://releases.linaro.org/components/toolchain/binaries/$(GCC_LINARO_AARCH64_ELF_SHORT_VERSION)/aarch64-elf
GCC_LINARO_AARCH64_ELF_SOURCE = gcc-linaro-$(GCC_LINARO_AARCH64_ELF_VERSION)-x86_64_aarch64-elf.tar.xz
GCC_LINARO_AARCH64_ELF_LICENSE = GPL-3.0+

HOST_GCC_LINARO_AARCH64_ELF_INSTALL_DIR = $(HOST_DIR)/opt/gcc-linaro-aarch64-elf

define HOST_GCC_LINARO_AARCH64_ELF_INSTALL_CMDS
	rm -rf $(HOST_GCC_LINARO_AARCH64_ELF_INSTALL_DIR)
	mkdir -p $(HOST_GCC_LINARO_AARCH64_ELF_INSTALL_DIR)
	cp -rf $(@D)/* $(HOST_GCC_LINARO_AARCH64_ELF_INSTALL_DIR)/
endef

$(eval $(host-generic-package))
