include vendor/cyclone/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/cyclone/config/BoardConfigQcom.mk
endif

include vendor/cyclone/config/BoardConfigSoong.mk
