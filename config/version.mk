# Copyright (C) 2022-2024 ScandiumOS
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

ANDROID_VERSION := 14
SCANDIUMVERSION := 2.0-Karawang

SCANDIUM_BUILD_TYPE ?= UNOFFICIAL
SCANDIUM_MAINTAINER ?= UNKNOWN
SCANDIUM_DATE_YEAR := $(shell date -u +%Y)
SCANDIUM_DATE_MONTH := $(shell date -u +%m)
SCANDIUM_DATE_DAY := $(shell date -u +%d)
SCANDIUM_DATE_HOUR := $(shell date -u +%H)
SCANDIUM_DATE_MINUTE := $(shell date -u +%M)
SCANDIUM_BUILD_DATE := $(SCANDIUM_DATE_YEAR)$(SCANDIUM_DATE_MONTH)$(SCANDIUM_DATE_DAY)-$(SCANDIUM_DATE_HOUR)$(SCANDIUM_DATE_MINUTE)
TARGET_PRODUCT_SHORT := $(subst scandium_,,$(SCANDIUM_BUILD))

OFFICIAL_DEVICES_LIST = $(shell cat vendor/scandium-maintainer/config/scandium.devices)
OFFICIAL_MAINTAINER_LIST = $(shell cat vendor/scandium-maintainer/config/scandium.maintainer)

ifeq ($(filter $(SCANDIUM_BUILD), $(OFFICIAL_DEVICES_LIST)), $(SCANDIUM_BUILD))
   ifeq ($(filter $(SCANDIUM_MAINTAINER), $(OFFICIAL_MAINTAINER_LIST)), $(SCANDIUM_MAINTAINER))
      SCANDIUM_BUILD_TYPE := OFFICIAL
  else
     # the builder is overriding official flag on purpose
     ifeq ($(SCANDIUM_BUILD_TYPE), OFFICIAL)
       $(error **********************************************************)
       $(error *     A violation has been detected, aborting build      *)
       $(error **********************************************************)
       SCANDIUM_BUILD_TYPE := UNOFFICIAL
     else
       $(warning **********************************************************************)
       $(warning *   There is already an official maintainer for $(SCANDIUM_BUILD)    *)
       $(warning *              Setting build type to UNOFFICIAL                      *)
       $(warning *    Please contact current official maintainer before distributing  *)
       $(warning *              the current build to the community.                   *)
       $(warning **********************************************************************)
       SCANDIUM_BUILD_TYPE := UNOFFICIAL
     endif
  endif
else
   ifeq ($(SCANDIUM_BUILD_TYPE), OFFICIAL)
     $(error **********************************************************)
     $(error *     A violation has been detected, aborting build      *)
     $(error **********************************************************)
   endif
  SCANDIUM_BUILD_TYPE := UNOFFICIAL
endif

SCANDIUM_VERSION := $(SCANDIUMVERSION)-$(SCANDIUM_BUILD)-$(SCANDIUM_BUILD_DATE)-VANILLA-$(SCANDIUM_BUILD_TYPE)
ifeq ($(SCANDIUM_BUILD_GAPPS), true)
    WITH_GAPPS := true
endif
ifeq ($(WITH_GAPPS), true)
SCANDIUM_VERSION := $(SCANDIUMVERSION)-$(SCANDIUM_BUILD)-$(SCANDIUM_BUILD_DATE)-GAPPS-$(SCANDIUM_BUILD_TYPE)
endif
SCANDIUM_MOD_VERSION :=$(ANDROID_VERSION)-$(SCANDIUMVERSION)
SCANDIUM_DISPLAY_VERSION := ScandiumOS-$(SCANDIUMVERSION)-$(SCANDIUM_BUILD_TYPE)
SCANDIUM_DISPLAY_BUILDTYPE := $(SCANDIUM_BUILD_TYPE)
SCANDIUM_FINGERPRINT := ScandiumOS/$(SCANDIUM_MOD_VERSION)/$(TARGET_PRODUCT_SHORT)/$(SCANDIUM_BUILD_DATE)

# SCANDIUM System Version
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.scandium.version=$(SCANDIUM_DISPLAY_VERSION) \
  ro.scandium.build.status=$(SCANDIUM_BUILD_TYPE) \
  ro.modversion=$(SCANDIUM_MOD_VERSION) \
  ro.scandium.build.date=$(SCANDIUM_BUILD_DATE) \
  ro.scandium.buildtype=$(SCANDIUM_BUILD_TYPE) \
  ro.scandium.fingerprint=$(SCANDIUM_FINGERPRINT) \
  ro.scandium.device=$(SCANDIUM_BUILD) \
  org.scandium.version=$(SCANDIUMVERSION)

ifdef SCANDIUM_MAINTAINER
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
   ro.scandium.maintainer=$(SCANDIUM_MAINTAINER)
endif

# Sign Build
ifneq (eng,$(TARGET_BUILD_VARIANT))
ifneq (,$(wildcard vendor/scandium/signing/keys/releasekey.pk8))
PRODUCT_DEFAULT_DEV_CERTIFICATE := vendor/scandium/signing/keys/releasekey
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.oem_unlock_supported=1
endif
ifneq (,$(wildcard vendor/scandium/signing/keys/otakey.x509.pem))
PRODUCT_OTA_PUBLIC_KEYS := vendor/scandium/signing/keys/otakey.x509.pem
endif
endif
