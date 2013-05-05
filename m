From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 01/26] HID: wiimote: extend driver description
Date: Sun,  5 May 2013 23:12:45 +0200
Message-ID: <1367788390-29835-2-git-send-email-dh.herrmann@gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:65224 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015Ab3EEVNo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 May 2013 17:13:44 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm19so1355404bkc.30
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 14:13:42 -0700 (PDT)
In-Reply-To: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

The hid-wiimote driver supports more than the Wii Remote. Nintendo
produced many devices based on the Wii Remote, which have extension
devices built-in. It is not clear to many users, that these devices have
anything in common with the Wii Remote, so fix the driver description.

This also updates the copyright information for the coming hotplugging
rework.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/Kconfig             | 20 ++++++++++++++++++--
 drivers/hid/hid-wiimote-core.c  |  6 +++---
 drivers/hid/hid-wiimote-debug.c |  4 ++--
 drivers/hid/hid-wiimote-ext.c   |  4 ++--
 drivers/hid/hid-wiimote.h       |  4 ++--
 5 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 613083a..e05dda3 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -696,13 +696,29 @@ config HID_WACOM
 	Support for Wacom Graphire Bluetooth and Intuos4 WL tablets.
 
 config HID_WIIMOTE
-	tristate "Nintendo Wii Remote support"
+	tristate "Nintendo Wii / Wii U peripherals"
 	depends on HID
 	depends on LEDS_CLASS
 	select POWER_SUPPLY
 	select INPUT_FF_MEMLESS
 	---help---
-	Support for the Nintendo Wii Remote bluetooth device.
+	Support for Nintendo Wii and Wii U Bluetooth peripherals. Supported
+	devices are the Wii Remote and its extension devices, but also devices
+	based on the Wii Remote like the Wii U Pro Controller or the
+	Wii Balance Board.
+
+	Support for all official Nintendo extensions is available, however, 3rd
+	party extensions might not be supported. Please report these devices to:
+	  http://github.com/dvdhrm/xwiimote/issues
+
+	Other Nintendo Wii U peripherals that are IEEE 802.11 based (including
+	the Wii U Gamepad) might be supported in the future. But currently
+	support is limited to Bluetooth based devices.
+
+	If unsure, say N.
+
+	To compile this driver as a module, choose M here: the
+	module will be called hid-wiimote.
 
 config HID_WIIMOTE_EXT
 	bool "Nintendo Wii Remote Extension support"
diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index e5ee1f2..119dc56 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -1,6 +1,6 @@
 /*
- * HID driver for Nintendo Wiimote devices
- * Copyright (c) 2011 David Herrmann
+ * HID driver for Nintendo Wii / Wii U peripherals
+ * Copyright (c) 2011-2013 David Herrmann <dh.herrmann@gmail.com>
  */
 
 /*
@@ -1331,4 +1331,4 @@ module_hid_driver(wiimote_hid_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("David Herrmann <dh.herrmann@gmail.com>");
-MODULE_DESCRIPTION(WIIMOTE_NAME " Device Driver");
+MODULE_DESCRIPTION("Driver for Nintendo Wii / Wii U peripherals");
diff --git a/drivers/hid/hid-wiimote-debug.c b/drivers/hid/hid-wiimote-debug.c
index 90124ff..fdd30dd 100644
--- a/drivers/hid/hid-wiimote-debug.c
+++ b/drivers/hid/hid-wiimote-debug.c
@@ -1,6 +1,6 @@
 /*
- * Debug support for HID Nintendo Wiimote devices
- * Copyright (c) 2011 David Herrmann
+ * Debug support for HID Nintendo Wii / Wii U peripherals
+ * Copyright (c) 2011-2013 David Herrmann <dh.herrmann@gmail.com>
  */
 
 /*
diff --git a/drivers/hid/hid-wiimote-ext.c b/drivers/hid/hid-wiimote-ext.c
index 0472191..1c104fc 100644
--- a/drivers/hid/hid-wiimote-ext.c
+++ b/drivers/hid/hid-wiimote-ext.c
@@ -1,6 +1,6 @@
 /*
- * HID driver for Nintendo Wiimote extension devices
- * Copyright (c) 2011 David Herrmann
+ * HID driver for Nintendo Wii / Wii U peripheral extensions
+ * Copyright (c) 2011-2013 David Herrmann <dh.herrmann@gmail.com>
  */
 
 /*
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index c81dbeb..a2629ed 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -2,8 +2,8 @@
 #define __HID_WIIMOTE_H
 
 /*
- * HID driver for Nintendo Wiimote devices
- * Copyright (c) 2011 David Herrmann
+ * HID driver for Nintendo Wii / Wii U peripherals
+ * Copyright (c) 2011-2013 David Herrmann <dh.herrmann@gmail.com>
  */
 
 /*
-- 
1.8.2.2

