# Build fingerprint
ifneq ($(BUILD_FINGERPRINT),)
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)
endif

# CycloneOS Platform Display Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.cyclone.display.version=$(CYCLONE_DISPLAY_VERSION) \
    ro.cyclone.build.version=$(CYCLONE_BUILD_VERSION) \
    ro.cyclone.build.date=$(BUILD_DATE) \
    ro.cyclone.buildtype=$(CYCLONE_BUILD_TYPE) \
    ro.cyclone.fingerprint=$(ROM_FINGERPRINT) \
    ro.cyclone.version=$(CYCLONE_VERSION) \
    ro.modversion=$(CYCLONE_VERSION)
