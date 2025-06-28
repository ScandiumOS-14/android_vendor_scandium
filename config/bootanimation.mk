# Set a default value if the variable is not defined.
# Using this line simplifies the logic below.
TARGET_BOOT_ANIMATION_RES ?= 1080

# Check for specific, supported resolutions.
ifeq ($(TARGET_BOOT_ANIMATION_RES),480)
    PRODUCT_COPY_FILES += vendor/scandium/prebuilt/bootanimation/480.zip:$(TARGET_COPY_OUT_SYSTEM)/media/bootanimation.zip
else ifeq ($(TARGET_BOOT_ANIMATION_RES),720)
    PRODUCT_COPY_FILES += vendor/scandium/prebuilt/bootanimation/720.zip:$(TARGET_COPY_OUT_SYSTEM)/media/bootanimation.zip
else ifeq ($(TARGET_BOOT_ANIMATION_RES),1080)
    PRODUCT_COPY_FILES += vendor/scandium/prebuilt/bootanimation/1080.zip:$(TARGET_COPY_OUT_SYSTEM)/media/bootanimation.zip
else ifeq ($(TARGET_BOOT_ANIMATION_RES),1440)
    PRODUCT_COPY_FILES += vendor/scandium/prebuilt/bootanimation/1440.zip:$(TARGET_COPY_OUT_SYSTEM)/media/bootanimation.zip
else
    # The variable is defined but is not a recognized value.
    # Default to 1080p and issue a warning.
    $(warning Defined bootanimation res "$(TARGET_BOOT_ANIMATION_RES)" is not valid, using 1080p)
    PRODUCT_COPY_FILES += vendor/scandium/prebuilt/bootanimation/1080.zip:$(TARGET_COPY_OUT_SYSTEM)/media/bootanimation.zip
endif
