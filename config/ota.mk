# Only include Updater for official  build
ifeq ($(filter-out OFFICIAL,$(SCANDIUM_BUILD_TYPE)),)
    PRODUCT_PACKAGES += \
        Updater

PRODUCT_COPY_FILES += \
    vendor/scandium/prebuilt/common/etc/init/init.scandium-updater.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.scandium-updater.rc
endif