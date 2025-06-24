# Inherit full common scandium stuff
$(call inherit-product, vendor/scandium/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include scandium LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/scandium/overlay/dictionaries
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/scandium/overlay/dictionaries

# Enable support of one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode?=true

$(call inherit-product, vendor/scandium/config/telephony.mk)
