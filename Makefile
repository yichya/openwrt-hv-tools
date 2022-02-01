# SPDX-License-Identifier: MIT

include $(TOPDIR)/rules.mk

PKG_NAME:=hv-tools
PKG_VERSION:=0.0.1
PKG_RELEASE:=1
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/kernel.mk

define Package/hv-tools
    SECTION:=lang
    CATEGORY:=Extra packages
    TITLE:=hv-tools
    MAINTAINER:=yichya <mail@yichya.dev>
endef

define Package/hv-tools/description
	Hyper-V Linux Guest Services for OpenWrt
endef

define Build/Compile
	cd $(LINUX_DIR)/tools/hv; $(MAKE_VARS) $(MAKE) $(MAKE_FLAGS) all
endef

define Package/hv-tools/install
	$(INSTALL_DIR) $(1)/sbin
	$(INSTALL_BIN) $(LINUX_DIR)/tools/hv/hv_kvp_daemon $(1)/sbin/
	$(INSTALL_BIN) $(LINUX_DIR)/tools/hv/hv_vss_daemon $(1)/sbin/
	$(INSTALL_BIN) $(LINUX_DIR)/tools/hv/hv_fcopy_daemon $(1)/sbin/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./hv_kvp_daemon.init $(1)/etc/init.d/hv_kvp_daemon
	$(INSTALL_BIN) ./hv_vss_daemon.init $(1)/etc/init.d/hv_vss_daemon
	$(INSTALL_BIN) ./hv_fcopy_daemon.init $(1)/etc/init.d/hv_fcopy_daemon
endef

$(eval $(call BuildPackage,hv-tools))

