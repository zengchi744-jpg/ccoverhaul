ARCHS = arm64 arm64e
TARGET = iphone:13.0:13.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CCOverhaul
CCOverhaul_FILES = Tweak.xm
CCOverhaul_CFLAGS = -fobjc-arc
CCOverhaul_PRIVATE_FRAMEWORKS = UIKit CoreGraphics ControlCenterUIKit
CCOverhaul_LIBRARIES = substrate

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
