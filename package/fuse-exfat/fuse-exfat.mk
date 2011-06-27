#############################################################
#
# fuse-exfat
#
#############################################################

FUSE_EXFAT_VERSION = 0.9.5
FUSE_EXFAT_SOURCE = fuse-exfat-0.9.5.tar.gz
FUSE_EXFAT_SITE = http://exfat.googlecode.com/files
FUSE_EXFAT_INSTALL_STAGING = YES
FUSE_EXFAT_DEPENDENCIES = libfuse


define FUSE_EXFAT_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" AR="$(TARGET_AR)" -C $(@D)
endef

define FUSE_EXFAT_INSTALL_STAGING_CMDS
	cp -f $(@D)/fuse/mount.exfat-fuse $(STAGING_DIR)/sbin/mount.exfat-fuse
	ln -f -s $(STAGING_DIR)/sbin/mount.exfat-fuse $(STAGING_DIR)/sbin/mount.exfat
endef

define FUSE_EXFAT_INSTALL_TARGET_CMDS
	cp -f $(@D)/fuse/mount.exfat-fuse $(TARGET_DIR)/sbin/mount.exfat-fuse
	ln -f -s $(STAGING_DIR)/sbin/mount.exfat-fuse $(TARGET_DIR)/sbin/mount.exfat
endef

#fuse-exfat:


#ifeq ($(BR2_PACKAGE_FUSE_EXFAT),y)
#	TARGETS += fuse-exfat
#endif
$(eval $(call GENTARGETS,package,fuse-exfat))
