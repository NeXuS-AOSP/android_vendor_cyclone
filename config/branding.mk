# Copyright (C) 2016-2017 AOSiP
# Copyright (C) 2022 CycloneOS
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Versioning System
CYCLONE_CODENAME := Vortex 
CYCLONE_NUM_VER := 1.0

TARGET_PRODUCT_SHORT := $(subst cyclone_,,$(CYCLONE_BUILD_TYPE))

CYCLONE_BUILD_TYPE ?= UNOFFICIAL

# Only include Updater for official  build
ifeq ($(filter-out OFFICIAL,$(CYCLONE_BUILD_TYPE)),)
    PRODUCT_PACKAGES += \
        Updater
endif

# Sign builds if building an official build
ifeq ($(filter-out OFFICIAL,$(CYCLONE_BUILD_TYPE)),)
    PRODUCT_DEFAULT_DEV_CERTIFICATE := $(KEYS_LOCATION)
endif

# Set all versions
BUILD_DATE := $(shell date -u +%Y%m%d)
BUILD_TIME := $(shell date -u +%H%M)
CYCLONE_BUILD_VERSION := $(CYCLONE_NUM_VER)-$(CYCLONE_CODENAME)
CYCLONE_VERSION := $(CYCLONE_BUILD_VERSION)-$(CYCLONE_BUILD)-$(CYCLONE_BUILD_TYPE)-Vanilla-$(BUILD_TIME)-$(BUILD_DATE)
ifeq ($(USE_GAPPS), true)
CYCLONE_VERSION := $(CYCLONE_BUILD_VERSION)-$(CYCLONE_BUILD)-$(CYCLONE_BUILD_TYPE)-Gapps-$(BUILD_TIME)-$(BUILD_DATE)
endif
ROM_FINGERPRINT := Cyclone/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(BUILD_TIME)
CYCLONE_DISPLAY_VERSION := $(CYCLONE_VERSION)
RELEASE_TYPE := $(CYCLONE_BUILD_TYPE)
