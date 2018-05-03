include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AdvertIDFaker
AdvertIDFaker_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += advertidfakercmd
include $(THEOS_MAKE_PATH)/aggregate.mk
