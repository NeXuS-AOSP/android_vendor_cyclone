# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)

PRODUCT_BRAND ?= CycloneOS

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0

# Disable extra StrictMode features on all non-engineering builds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.strictmode.disable=true

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/cyclone/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/cyclone/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/cyclone/prebuilt/common/bin/50-cyclone.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-cyclone.sh

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/addon.d/50-cyclone.sh

ifneq ($(strip $(AB_OTA_PARTITIONS) $(AB_OTA_POSTINSTALL_CONFIG)),)
PRODUCT_COPY_FILES += \
    vendor/cyclone/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/cyclone/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/cyclone/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/backuptool_ab.sh \
    system/bin/backuptool_ab.functions \
    system/bin/backuptool_postinstall.sh

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif
endif

# Cyclone-specific broadcast actions whitelist
PRODUCT_COPY_FILES += \
    vendor/cyclone/config/permissions/cyclone-sysconfig.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/cyclone-sysconfig.xml

# Cyclone-specific init rc file
PRODUCT_COPY_FILES += \
    vendor/cyclone/prebuilt/common/etc/init/init.cyclone-system_ext.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.cyclone-system_ext.rc

# Enable Android Beam on all targets
PRODUCT_COPY_FILES += \
    vendor/cyclone/config/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.software.nfc.beam.xml

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_PRODUCT)/usr/keylayout/Vendor_045e_Product_0719.kl

# Enforce privapp-permissions whitelist
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
      ro.control_privapp_permissions=log

# Face Unlock
TARGET_FACE_UNLOCK_SUPPORTED ?= true
ifeq ($(TARGET_FACE_UNLOCK_SUPPORTED),true)
PRODUCT_PACKAGES += \
    FaceUnlockService
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.face_unlock_service.enabled=$(TARGET_FACE_UNLOCK_SUPPORTED)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.biometrics.face.xml
endif

# Fonts
include vendor/cyclone/config/fonts.mk

# Gapps
ifeq ($(USE_GAPPS),true)
$(call inherit-product, vendor/gapps/gapps.mk)
endif

# Include AOSP audio files
include vendor/cyclone/config/aosp_audio.mk

# Include cyclone audio files
include vendor/cyclone/config/cyclone_audio.mk

# Include extra packages
include vendor/cyclone/config/packages.mk

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# Bootanimation
TARGET_SCREEN_WIDTH ?= 1080
TARGET_SCREEN_HEIGHT ?= 1920

PRODUCT_COPY_FILES += \
    vendor/cyclone/bootanimation/bootanimation.zip:$(TARGET_COPY_OUT_SYSTEM)/media/bootanimation.zip


# Config
PRODUCT_PACKAGES += \
    SimpleDeviceConfig

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    procmem

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/procmem
endif

# Root
PRODUCT_PACKAGES += \
    adb_root

PRODUCT_PACKAGES += \
	Camera

# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/cyclone/overlay/no-rro
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/cyclone/overlay/common \
    vendor/cyclone/overlay/no-rro

PRODUCT_PACKAGES += \
    TrebuchetOverlay

PRODUCT_EXTRA_RECOVERY_KEYS += \
    vendor/cyclone/build/target/product/security/cyclone

include vendor/cyclone/config/version.mk

-include vendor/cyclone-priv/keys/keys.mk

-include vendor/gms/gms.mk

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/cyclone/config/partner_gms.mk
