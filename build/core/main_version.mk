# Build fingerprint
ifneq ($(BUILD_FINGERPRINT),)
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)
endif

# Cyclone System Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.cyclone.version=$(CYCLONE_BASE_VERSION)-$(CYCLONE_BUILD_TYPE)-$(BUILD_DATE)-$(BUILD_TIME) \
    ro.cyclone.base.version=$(CYCLONE_BASE_VERSION) \
    ro.cyclone.codename=$(CYCLONE_CODENAME) \
    ro.cyclone.build.version=$(CYCLONE_PLATFORM_VERSION) \
    ro.mod.version=$(BUILD_ID)-$(BUILD_DATE)-$(CYCLONE_BASE_VERSION) \
    ro.cyclone.fingerprint=$(ROM_FINGERPRINT) \
    ro.cyclone.buildtype=$(CYCLONE_BUILD_TYPE) \
    ro.cyclone.device=$(TARGET_PRODUCT_SHORT) \
    ro.cyclone.platform.version=$(PLATFORM_CYCLONE_VERSION) \
    ro.cyclone.build_date=$(BUILD_DATE)
