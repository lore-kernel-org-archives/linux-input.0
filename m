From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 01/12] HID: wiimote: Add Nintendo Wii Remote driver stub
Date: Mon, 27 Jun 2011 16:30:02 +0200
Message-ID: <1309185013-484-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:59763 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab1F0Oau (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jun 2011 10:30:50 -0400
Received: by fxd18 with SMTP id 18so1868751fxd.11
        for <linux-input@vger.kernel.org>; Mon, 27 Jun 2011 07:30:49 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: padovan@profusion.mobi, jkosina@suse.cz, oliver@neukum.org, David Herrmann <dh.herrmann@googlemail.com>

Add stub driver for the Nintendo Wii Remote. The wii remote uses
the HID protocol to communicate with the host over bluetooth. Hence,
add dependency for HIDP and place driver in hid subsystem.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/Kconfig       |    6 ++++++
 drivers/hid/Makefile      |    1 +
 drivers/hid/hid-wiimote.c |   32 ++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hid/hid-wiimote.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 67d2a75..e84bdd8 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -567,6 +567,12 @@ config HID_WACOM_POWER_SUPPLY
 	  Say Y here if you want to enable power supply status monitoring for
 	  Wacom Bluetooth devices.
 
+config HID_WIIMOTE
+	tristate "Nintendo Wii Remote support"
+	depends on BT_HIDP
+	---help---
+	Support for the Nintendo Wii Remote bluetooth device.
+
 config HID_ZEROPLUS
 	tristate "Zeroplus based game controller support"
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index f8cc4ea..4ed9bed 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_HID_ZEROPLUS)	+= hid-zpff.o
 obj-$(CONFIG_HID_ZYDACRON)	+= hid-zydacron.o
 obj-$(CONFIG_HID_WACOM)		+= hid-wacom.o
 obj-$(CONFIG_HID_WALTOP)	+= hid-waltop.o
+obj-$(CONFIG_HID_WIIMOTE)	+= hid-wiimote.o
 
 obj-$(CONFIG_USB_HID)		+= usbhid/
 obj-$(CONFIG_USB_MOUSE)		+= usbhid/
diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
new file mode 100644
index 0000000..8a770e6
--- /dev/null
+++ b/drivers/hid/hid-wiimote.c
@@ -0,0 +1,32 @@
+/*
+ * HID driver for Nintendo Wiimote devices
+ * Copyright (c) 2011 David Herrmann
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <linux/module.h>
+
+#define WIIMOTE_VERSION "0.1"
+#define WIIMOTE_NAME "Nintendo Wii Remote"
+
+static int __init wiimote_init(void)
+{
+	return 0;
+}
+
+static void __exit wiimote_exit(void)
+{
+}
+
+module_init(wiimote_init);
+module_exit(wiimote_exit);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("David Herrmann <dh.herrmann@gmail.com>");
+MODULE_DESCRIPTION(WIIMOTE_NAME " Device Driver");
+MODULE_VERSION(WIIMOTE_VERSION);
-- 
1.7.5.2

