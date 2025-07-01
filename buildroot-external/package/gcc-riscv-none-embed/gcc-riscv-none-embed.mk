################################################################################
#
# gcc-riscv-none-embed
#
################################################################################

GCC_RISCV_NONE_EMBED_VERSION = 8.3.0-1.2
GCC_RISCV_NONE_EMBED_SITE = https://github.com/xpack-dev-tools/riscv-none-embed-gcc-xpack/releases/download/v$(GCC_RISCV_NONE_EMBED_VERSION)
GCC_RISCV_NONE_EMBED_SOURCE = xpack-riscv-none-embed-gcc-$(GCC_RISCV_NONE_EMBED_VERSION)-linux-x64.tar.gz
GCC_RISCV_NONE_EMBED_LICENSE = GPL-3.0+

HOST_GCC_RISCV_NONE_EMBED_INSTALL_DIR = $(HOST_DIR)/opt/gcc-riscv-none-embed

define HOST_GCC_RISCV_NONE_EMBED_INSTALL_CMDS
	rm -rf $(HOST_GCC_RISCV_NONE_EMBED_INSTALL_DIR)
	mkdir -p $(HOST_GCC_RISCV_NONE_EMBED_INSTALL_DIR)
	cp -rf $(@D)/* $(HOST_GCC_RISCV_NONE_EMBED_INSTALL_DIR)/
endef

$(eval $(host-generic-package))
