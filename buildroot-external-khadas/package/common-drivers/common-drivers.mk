################################################################################
#
# aufs
#
################################################################################

COMMON_DRIVERS_VERSION = $(call qstrip,$(BR2_PACKAGE_COMMON_DRIVERS_VERSION))
COMMON_DRIVERS_LICENSE = GPL-2.0
COMMON_DRIVERS_LICENSE_FILES = COPYING

ifeq ($(BR2_COMMON_DRIVERS_CUSTOM_TARBALL),y)
COMMON_DRIVERS_TARBALL = $(call qstrip,$(BR2_COMMON_DRIVERS_CUSTOM_TARBALL_LOCATION))
COMMON_DRIVERS_SITE = $(patsubst %/,%,$(dir $(COMMON_DRIVERS_TARBALL)))
COMMON_DRIVERS_SOURCE = $(notdir $(COMMON_DRIVERS_TARBALL))
else ifeq ($(BR2_COMMON_DRIVERS_CUSTOM_GIT),y)
COMMON_DRIVERS_SITE = $(call qstrip,$(BR2_COMMON_DRIVERS_CUSTOM_REPO_URL))
COMMON_DRIVERS_SITE_METHOD = git
else
COMMON_DRIVERS_SITE = https://github.com/khadas/common_drivers
COMMON_DRIVERS_SITE_METHOD = git
endif

$(eval $(generic-package))
