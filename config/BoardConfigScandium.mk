include vendor/scandium/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/scandium/config/BoardConfigQcom.mk
endif

include vendor/scandium/config/BoardConfigSoong.mk
