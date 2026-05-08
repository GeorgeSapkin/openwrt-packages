# SPDX-License-Identifier: GPL-2.0-only

include $(TOPDIR)/rules.mk

PKG_NAME:=meshtasticd
PKG_VERSION:=2.7.15
PKG_RELEASE:=1
PKG_SOURCE_VERSION:=v2.7.15.567b8ea

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/meshtastic/firmware.git
PKG_MIRROR_HASH:=494c4f4f84719237b08fc487c66c2c7a3b760b4b1d9a929358fcc801c67d8bcc

PKG_BUILD_DEPENDS:=python3/host python-platformio/host

PKG_MAINTAINER:=Austin Lane <vidplace7@gmail.com>, George Sapkin <george@sapk.in>
PKG_LICENSE:=GPL-3.0-only
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-host.mk
include $(INCLUDE_DIR)/nls.mk

define Package/meshtasticd/Default
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Meshtastic Daemon
  URL:=https://github.com/meshtastic/firmware
  DEPENDS:= \
	+bluez-libs \
	+libgpiod \
	+libi2c \
	+libuv \
	+libyaml-cpp \
	+zlib \
	+MESHTASTICD_ENABLE_SPI:kmod-spi-dev \
	+MESHTASTICD_ENABLE_USB:libusb-1.0 \
	+MESHTASTICD_ENABLE_WEB:libopenssl \
	+MESHTASTICD_ENABLE_WEB:liborcania \
	+MESHTASTICD_ENABLE_WEB:libulfius-gnutls \
	+MESHTASTICD_ENABLE_WEB:libyder \
	$(INTL_DEPENDS)
endef

Package/meshtasticd = $(Package/meshtasticd/Default)

define Package/meshtasticd-avahi-service
  $(call Package/meshtasticd/Default)
  TITLE+= (avahi service)
  DEPENDS:=meshtasticd +avahi-daemon
endef

define Package/meshtasticd/description
  Meshtastic daemon
endef

define Package/meshtasticd-avahi-service/description
  Service definition for announcing the Meshtastic daemon via mDNS
endef

define Package/meshtasticd/config
config MESHTASTICD_ENABLE_SPI
	bool "SPI LoRa radio support"
	default y
	help
	  SPI LoRa radio support for meshtasticd

config MESHTASTICD_ENABLE_USB
	bool "USB LoRa radio support"
	default y
	help
	  USB LoRa radio support for meshtasticd

config MESHTASTICD_ENABLE_WEB
	bool "Web UI support"
	select PACKAGE_meshtasticd-web
	default y
	help
	  Adds support for the meshtasticd web UI
endef

PLATFORMIO_BUILD_FLAGS = \
	-Os -ffunction-sections -fdata-sections -Wl,--gc-sections \
	$(if $(INTL_FULL),-lintl) \
	$(if $(CONFIG_USE_GLIBC),,-largp) \
	$(if $(CONFIG_MESHTASTICD_ENABLE_WEB),-lssl -lcrypto) \
	$(if $(CONFIG_MESHTASTICD_ENABLE_WEB),-lorcania -lyder -lulfius)

define Build/Compile
	TARGET_AR="$(TARGET_AR)" \
	TARGET_AS="$(TARGET_CC) -c $(TARGET_ASFLAGS)" \
	TARGET_CFLAGS="$(TARGET_CFLAGS)" \
	TARGET_CC="$(TARGET_CC)" \
	TARGET_CXX="$(TARGET_CXX)" \
	TARGET_CXXFLAGS="$(TARGET_CXXFLAGS)" \
	TARGET_LD="$(TARGET_LD)" \
	TARGET_LDFLAGS="$(TARGET_LDFLAGS)" \
	TARGET_OBJCOPY="$(TARGET_CROSS)objcopy" \
	TARGET_RANLIB="$(TARGET_RANLIB)" \
	PLATFORMIO_BUILD_CACHE_DIR="$(PKG_BUILD_DIR)/.pio_build_cache" \
	PLATFORMIO_BUILD_FLAGS="$(PLATFORMIO_BUILD_FLAGS)" \
	PLATFORMIO_CACHE_DIR="$(DL_DIR)/.platformio_cache" \
	$(HOST_PYTHON3_BIN) -m platformio run --environment buildroot --project-dir $(PKG_BUILD_DIR)
endef

define Package/meshtasticd/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/.pio/build/buildroot/program $(1)/usr/bin/meshtasticd

	$(INSTALL_DIR) $(1)/etc/meshtasticd
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/bin/config-dist.yaml $(1)/etc/meshtasticd/config.yaml

	$(INSTALL_DIR) $(1)/etc/meshtasticd/available.d
	$(CP) -R $(PKG_BUILD_DIR)/bin/config.d/* $(1)/etc/meshtasticd/available.d

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/meshtasticd.init $(1)/etc/init.d/meshtasticd

	$(INSTALL_DIR) $(1)/etc/meshtasticd/config.d
	$(INSTALL_DIR) $(1)/srv/meshtasticd
endef

define Package/meshtasticd-avahi-service/install
	$(INSTALL_DIR) $(1)/etc/avahi/services
	$(INSTALL_CONF) ./files/meshtasticd.service $(1)/etc/avahi/services/
endef

define Package/meshtasticd/conffiles
/etc/meshtasticd/config.yaml
endef

define Package/meshtasticd-avahi-service/conffiles
/etc/avahi/services/meshtasticd.service
endef

$(eval $(call BuildPackage,meshtasticd))
$(eval $(call BuildPackage,meshtasticd-avahi-service))
