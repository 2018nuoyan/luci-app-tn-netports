#
# Copyright (C) 2021 Tano Systems (https://github.com/tano-systems/luci-app-tn-netports)
#
# This is free software, licensed under the MIT License.
#

include $(TOPDIR)/rules.mk

LUCI_NAME:=luci-app-tn-netports
PKG_VERSION:=2.0.5

LUCI_TITLE:=Network Interfaces Ports Status
LUCI_DEPENDS:=+luabitop
LUCI_PKGARCH:=all
PKG_LICENSE:=MIT

define Package/$(LUCI_NAME)/conffiles
/etc/config/luci_netports
endef

define Package/$(LUCI_NAME)/postinst
#!/bin/sh
if [ ! -f "$${IPKG_INSTROOT}/etc/config/luci_netports" ]; then
	echo "config global 'global'" > "$${IPKG_INSTROOT}/etc/config/luci_netports"
fi
if [ -z "$${IPKG_INSTROOT}" ]; then
	/etc/init.d/rpcd restart
fi
endef

define Package/$(LUCI_NAME)/prerm
endef

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
