#############################################################
#
# U-Boot
#
#############################################################

U_BOOT_DIR:=$(BUILD_DIR)/u-boot


$(U_BOOT_DIR):
	@echo "uboot: mkdir"
	mkdir -pv $(U_BOOT_DIR)



u-boot: $(U_BOOT_DIR) $(U_BOOT_DIR)/.unpacked
	@echo "uboot: me"
	cd $(BUILD_DIR)/u-boot/src; \
	tar -xf u-boot-1.1.6.tar.gz; \
	cd u-boot-1.1.6; \
	make aw1623_config; \
	make; \
	cp u-boot.bin $(BINARIES_DIR)/


$(U_BOOT_DIR)/.unpacked:
	@echo "uboot: unpack"
	mkdir -p $(@D)
	cp -r boot/u-boot $(U_BOOT_DIR)/src
	touch $@


$(U_BOOT_DIR)/.configured: $(U_BOOT_DIR)/.unpacked
	@echo "uboot: config"
	touch $@


#############################################################
#
# Toplevel Makefile options
#
#############################################################
ifeq ($(BR2_TARGET_UBOOT_AW1623),y)
TARGETS+=u-boot
endif
