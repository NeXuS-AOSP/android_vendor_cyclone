# Inherit full common Cyclone stuff
$(call inherit-product, vendor/cyclone/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include Cyclone LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/cyclone/overlay/dictionaries

$(call inherit-product, vendor/cyclone/config/telephony.mk)
