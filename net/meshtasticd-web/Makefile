# SPDX-License-Identifier: GPL-2.0-only

include $(TOPDIR)/rules.mk

PKG_NAME:=meshtasticd-web
PKG_VERSION:=2.6.7
PKG_RELEASE:=1

PKG_SOURCE:=build.tar
PKG_SOURCE_URL:=https://github.com/meshtastic/web/releases/download/v$(PKG_VERSION)/
PKG_HASH:=a34f4360a0486543a698de20de533557492e763ab459fc27fcea95d0495144ed

PKG_MAINTAINER:=Austin Lane <vidplace7@gmail.com>
PKG_LICENSE:=GPL-3.0-only

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
UNPACK_CMD=\
	mkdir -p $(1)/web; \
	$(TAR) -xf $(DL_DIR)/$(PKG_SOURCE) -C $(1)/web; \
	gzip -dr $(1)/web/

include $(INCLUDE_DIR)/package.mk

define Package/meshtasticd-web
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Meshtastic daemon web interface
  URL:=https://github.com/meshtastic/web
  DEPENDS:=meshtasticd
endef

define Package/meshtasticd-web/description
  The official Meshtastic web interface
endef

define Build/Compile
endef

define Package/meshtasticd-web/install
	$(INSTALL_DIR) $(1)/usr/share/meshtasticd/web
	$(CP) $(PKG_BUILD_DIR)/web/* $(1)/usr/share/meshtasticd/web
	$(INSTALL_DIR) $(1)/etc/meshtasticd/ssl
endef

$(eval $(call BuildPackage,meshtasticd-web))
