# Inherit common mobile scandium stuff
$(call inherit-product, vendor/scandium/config/common.mk)

# Themes
PRODUCT_PACKAGES += \
    ThemePicker \
    ThemesStub

# Customizations
PRODUCT_PACKAGES += \
    NavigationBarMode2ButtonOverlay \
    NavigationBarNoHintOverlay
