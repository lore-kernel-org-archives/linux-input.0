From: David King <amigadave@amigadave.com>
Subject: [PATCH] HID: clarify Magic Mouse KConfig description
Date: Sat, 20 Apr 2013 20:13:52 +0100
Message-ID: <1366485232-3692-1-git-send-email-amigadave@amigadave.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, David King <amigadave@amigadave.com>
List-Id: linux-input@vger.kernel.org

The Magic Mouse driver also supports the Magic Trackpad, so mention it
in the KConfig description for the driver.

Signed-off-by: David King <amigadave@amigadave.com>
---
 drivers/hid/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 5f07d85..a5984f0 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -373,13 +373,13 @@ config LOGIWHEELS_FF
 	  - Logitech Formula Force EX
 
 config HID_MAGICMOUSE
-	tristate "Apple MagicMouse multi-touch support"
+	tristate "Apple Magic Mouse/Trackpad multi-touch support"
 	depends on BT_HIDP
 	---help---
-	Support for the Apple Magic Mouse multi-touch.
+	Support for the Apple Magic Mouse/Trackpad multi-touch.
 
 	Say Y here if you want support for the multi-touch features of the
-	Apple Wireless "Magic" Mouse.
+	Apple Wireless "Magic" Mouse and the Apple Wireless "Magic" Trackpad.
 
 config HID_MICROSOFT
 	tristate "Microsoft non-fully HID-compliant devices" if EXPERT
-- 
1.8.1.5
