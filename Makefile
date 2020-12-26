# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.

include $(TOPDIR)/rules.mk

PKG_NAME:=crun
PKG_VERSION:=0.16
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://github.com/containers/crun/releases/download/$(PKG_VERSION)
PKG_HASH:=0c2d1af85d27bd1e7263e8be1384643629e3cbacc598437a811587db8e86027d

PKG_MAINTAINER:=Gaiyu <gaiyu8@163.com>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/crun
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=crun container runtime
	DEPENDS+= +yajl +libseccomp +libcap
endef

define Package/crun/description
crun container runtime
endef

CONFIGURE_ARGS+= \
	--enable-static=yes \
	--enable-shared=no \
	--with-python-bindings=no \
	--disable-systemd \
	--host=$(GNU_TARGET_NAME) \
	--build=$(GNU_HOST_NAME)

define Build/Configure
	(cd $(PKG_BUILD_DIR); ./autogen.sh)
	$(call Build/Configure/Default,$(CONFIGURE_ARGS))
endef

define Package/crun/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/crun $(1)/usr/bin/
endef

$(eval $(call BuildPackage,crun))
