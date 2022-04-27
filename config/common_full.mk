# Inherit common Cyclone stuff
$(call inherit-product, vendor/cyclone/config/common_mobile.mk)

PRODUCT_SIZE := full

# Recorder
PRODUCT_PACKAGES += \
    Recorder
