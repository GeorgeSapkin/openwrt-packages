# Copyright (C) 2007-2026 OpenWrt.org
#
# SPDX-License-Identifier: GPL-2.0-only

include $(TOPDIR)/rules.mk

PKG_NAME:=protobuf-legacy
PKG_VERSION:=3.17.3
PKG_RELEASE:=1

PKG_SOURCE:=protobuf-cpp-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/google/protobuf/releases/download/v$(PKG_VERSION)
PKG_HASH:=51cec99f108b83422b7af1170afd7aeb2dd77d2bcbb7b6bad1f92509e9ccf8cb

PKG_MAINTAINER:=Alexandru Ardelean <ardeleanalex@gmail.com>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE
PKG_CPE_ID:=cpe:/a:google:protobuf
PKG_BUILD_DIR:=$(BUILD_DIR)/protobuf-$(PKG_VERSION)

CMAKE_SOURCE_SUBDIR:=cmake

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/protobuf-legacy/Default
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=A structured data encoding library (legacy version)
  URL:=https://github.com/google/protobuf
  DEPENDS:=+zlib +libatomic +libstdcpp
endef

define Package/protobuf-legacy
  $(call Package/protobuf-legacy/Default)
  DEPENDS+=+protobuf-legacy-lite
  PROVIDES:=protobuf
endef

define Package/protobuf-legacy-lite
  $(call Package/protobuf-legacy/Default)
  PROVIDES:=protobuf-lite
endef

define Package/protobuf-legacy/description/Default
 Protocol Buffers are a way of encoding structured data in an efficient yet
 extensible format. Google uses Protocol Buffers for almost all of its
 internal RPC protocols and file formats.
endef

define Package/protobuf-legacy/description
 $(call Package/protobuf-legacy/description/Default)

 This package provides the libprotoc, libprotobuf, and libprotobuf-lite
 libraries. For a much smaller protobuf package, see
 "protobuf-legacy-lite".
endef

define Package/protobuf-legacy-lite/description
 $(call Package/protobuf-legacy/description/Default)

 This package provides the libprotobuf-lite library.
endef

CMAKE_HOST_OPTIONS += \
	-DBUILD_SHARED_LIBS=OFF \
	-DCMAKE_INSTALL_LIBDIR=lib \
	-Dprotobuf_BUILD_PROTOC_BINARIES=ON \
	-Dprotobuf_BUILD_TESTS=OFF

CMAKE_OPTIONS += \
	-DBUILD_SHARED_LIBS=ON \
	-Dprotobuf_BUILD_PROTOC_BINARIES=ON \
	-Dprotobuf_BUILD_TESTS=OFF \
	-Dprotobuf_WITH_ZLIB=ON

TARGET_LDFLAGS += -latomic

define Build/InstallDev
	$(call Build/InstallDev/cmake,$(1))
	$(SED) 's,/usr/include,$$$${prefix}/include,g' $(1)/usr/lib/pkgconfig/protobuf.pc
	$(SED) 's,/usr/lib,$$$${exec_prefix}/lib,g' $(1)/usr/lib/pkgconfig/protobuf.pc
	$(SED) 's,/usr/include,$$$${prefix}/include,g' $(1)/usr/lib/pkgconfig/protobuf-lite.pc
	$(SED) 's,/usr/lib,$$$${exec_prefix}/lib,g' $(1)/usr/lib/pkgconfig/protobuf-lite.pc
endef

define Package/protobuf-legacy-lite/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libprotobuf-lite.so.* $(1)/usr/lib/
endef

define Package/protobuf-legacy/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libprotobuf.so.* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libprotoc.so.*  $(1)/usr/lib/
endef

$(eval $(call BuildPackage,protobuf-legacy))
$(eval $(call BuildPackage,protobuf-legacy-lite))
$(eval $(call HostBuild))
