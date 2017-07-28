From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] HID: wacom: add USB_HID dependency
Date: Fri, 28 Jul 2017 15:18:00 +0200
Message-ID: <20170728131826.180483-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Jason Gerecke <jason.gerecke@wacom.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The driver has gained a compile-time dependency that we should
express in Kconfig to avoid this link error:

drivers/hid/wacom_sys.o: In function `wacom_parse_and_register':
wacom_sys.c:(.text+0x2eec): undefined reference to `usb_hid_driver'

Fixes: 09dc28acaec7 ("HID: wacom: Improve generic name generation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hid/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 3cd60f460b61..0a3117cc29e7 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -924,7 +924,7 @@ config HID_UDRAW_PS3
 
 config HID_WACOM
 	tristate "Wacom Intuos/Graphire tablet support (USB)"
-	depends on HID
+	depends on USB_HID
 	select POWER_SUPPLY
 	select NEW_LEDS
 	select LEDS_CLASS
-- 
2.9.0
