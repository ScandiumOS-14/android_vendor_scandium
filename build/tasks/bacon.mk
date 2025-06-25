# Copyright (C) 2017 Unlegacy-Android
# Copyright (C) 2017,2020 The LineageOS Project
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

# -----------------------------------------------------------------
# ScandiumOS OTA update package

SCANDIUM_TARGET_PACKAGE := $(PRODUCT_OUT)/ScandiumOS-$(SCANDIUM_VERSION).zip

MD5 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/md5sum

.PHONY: bacon
bacon: $(DEFAULT_GOAL) $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(SCANDIUM_TARGET_PACKAGE)
	$(hide) $(MD5) $(SCANDIUM_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(SCANDIUM_TARGET_PACKAGE).md5sum
	$(hide) ./vendor/scandium/tools/generate_json_build_info.sh $(SCANDIUM_TARGET_PACKAGE)
	@echo -e "\033[0;34m=======================================================================================\033[m"
	@echo -e "\033[1;37m                                                                                      \033[m"
	@echo -e "\033[1;37m                                                                                      \033[m"
	@echo -e "\033[1;37m											  \033[m"
	@echo -e "\033[1;37m ███████╗ ██████╗ █████╗ ███╗   ██╗██████╗ ██╗██╗   ██╗███╗   ███╗   ██████╗ ███████╗ \033[m"
	@echo -e "\033[1;37m ██╔════╝██╔════╝██╔══██╗████╗  ██║██╔══██╗██║██║   ██║████╗ ████║  ██╔═══██╗██╔════╝ \033[m"
	@echo -e "\033[1;37m ███████╗██║     ███████║██╔██╗ ██║██║  ██║██║██║   ██║██╔████╔██║  ██║   ██║███████╗ \033[m"
	@echo -e "\033[1;37m ╚════██║██║     ██╔══██║██║╚██╗██║██║  ██║██║██║   ██║██║╚██╔╝██║  ██║   ██║╚════██║ \033[m"
	@echo -e "\033[1;37m ███████║╚██████╗██║  ██║██║ ╚████║██████╔╝██║╚██████╔╝██║ ╚═╝ ██║  ╚██████╔╝███████║ \033[m"
	@echo -e "\033[1;37m ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝ ╚═════╝ ╚═╝     ╚═╝   ╚═════╝ ╚══════╝ \033[m"
	@echo -e "\033[1;37m                                                                                      \033[m"
	@echo -e "\033[1;37m											  \033[m"
	@echo -e "\033[1;37m                                  Build completed !                                   \033[m"
	@echo -e "\033[1;37m		 									  \033[m"
	@echo -e "\033[0;34m=======================================================================================\033[m"
	@echo -e "\033[0m Package Complete : $(SCANDIUM_TARGET_PACKAGE)						\033[m"
	@echo -e "\033[0m Size             : `du -sh $(SCANDIUM_TARGET_PACKAGE) | awk '{print $$1}'`		\033[m"
	@echo -e "\033[0m md5sum           : `cat $(SCANDIUM_TARGET_PACKAGE).md5sum | cut -d ' ' -f 1`		\033[m"
	@echo -e "\033[0;34m=======================================================================================\033[m"
