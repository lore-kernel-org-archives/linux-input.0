From: Johnathon Harris <jmharris@gmail.com>
Subject: [PATCH] Linux 2.6.32.3 USB resource descriptor fix in new Ortek USB HID driver (not mangled)
Date: Thu, 21 Jan 2010 14:36:52 +0000
Message-ID: <201001211436.52919.john.harris@certus-tech.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f220.google.com ([209.85.220.220]:46091 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab0AUOgV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jan 2010 09:36:21 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, jkosina@suse.cz
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org

This patch adds a new USB HID driver for the Ortek WKB-2000, working around an
incorrect LogicalMaximum value in the USB resource descriptor. I have
attempted to follow the same pattern as for similar buggy USB HID devices.

Apologies for previous mail which was unintentionally mangled by Gmail.

Tracked by http://bugzilla.kernel.org/show_bug.cgi?id=14787
Bug originally reported by Ubuntu users: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/405390

I was advised to send this patch to stable@kernel.org by Daniel Blueman but Greg KH
stated whole new drivers are not -stable material.

Signed-off-by: Johnathon Harris <jmharris@gmail.com>
Tested-by: Daniel J Blueman <daniel.blueman@gmail.com>

---
diff -uprN linux-2.6.32.3.vanilla/drivers/hid/Kconfig linux-2.6.32.3/drivers/hid/Kconfig
--- linux-2.6.32.3.vanilla/drivers/hid/Kconfig	2010-01-11 20:09:17.876428259 +0000
+++ linux-2.6.32.3/drivers/hid/Kconfig	2010-01-11 21:16:24.529052956 +0000
@@ -204,6 +204,13 @@ config HID_NTRIG
 	---help---
 	Support for N-Trig touch screen.
 
+config HID_ORTEK
+	tristate "Ortek" if EMBEDDED
+	depends on USB_HID
+	default !EMBEDDED
+	---help---
+	Support for Ortek WKB-2000 wireless keyboard + mouse trackpad.
+
 config HID_PANTHERLORD
 	tristate "Pantherlord support" if EMBEDDED
 	depends on USB_HID
diff -uprN linux-2.6.32.3.vanilla/drivers/hid/Makefile linux-2.6.32.3/drivers/hid/Makefile
--- linux-2.6.32.3.vanilla/drivers/hid/Makefile	2010-01-11 20:09:17.877427529 +0000
+++ linux-2.6.32.3/drivers/hid/Makefile	2010-01-11 21:14:29.281429408 +0000
@@ -34,6 +34,7 @@ obj-$(CONFIG_HID_LOGITECH)	+= hid-logite
 obj-$(CONFIG_HID_MICROSOFT)	+= hid-microsoft.o
 obj-$(CONFIG_HID_MONTEREY)	+= hid-monterey.o
 obj-$(CONFIG_HID_NTRIG)		+= hid-ntrig.o
+obj-$(CONFIG_HID_ORTEK)		+= hid-ortek.o
 obj-$(CONFIG_HID_PANTHERLORD)	+= hid-pl.o
 obj-$(CONFIG_HID_PETALYNX)	+= hid-petalynx.o
 obj-$(CONFIG_HID_SAMSUNG)	+= hid-samsung.o
diff -uprN linux-2.6.32.3.vanilla/drivers/hid/hid-core.c linux-2.6.32.3/drivers/hid/hid-core.c
--- linux-2.6.32.3.vanilla/drivers/hid/hid-core.c	2010-01-11 20:09:17.872426973 +0000
+++ linux-2.6.32.3/drivers/hid/hid-core.c	2010-01-11 21:56:44.505053026 +0000
@@ -1333,6 +1333,7 @@ static const struct hid_device_id hid_bl
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_WIRELESS_OPTICAL_DESKTOP_3_0) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MONTEREY, USB_DEVICE_ID_GENIUS_KB29E) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_TOUCH_SCREEN) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_WKB2000) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PETALYNX, USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
diff -uprN linux-2.6.32.3.vanilla/drivers/hid/hid-ids.h linux-2.6.32.3/drivers/hid/hid-ids.h
--- linux-2.6.32.3.vanilla/drivers/hid/hid-ids.h	2010-01-11 20:09:17.880426925 +0000
+++ linux-2.6.32.3/drivers/hid/hid-ids.h	2010-01-11 20:20:01.931428309 +0000
@@ -352,6 +352,9 @@
 #define USB_VENDOR_ID_ONTRAK		0x0a07
 #define USB_DEVICE_ID_ONTRAK_ADU100	0x0064
 
+#define USB_VENDOR_ID_ORTEK		0x05a4
+#define USB_DEVICE_ID_ORTEK_WKB2000	0x2000
+
 #define USB_VENDOR_ID_PANJIT		0x134c
 
 #define USB_VENDOR_ID_PANTHERLORD	0x0810
diff -uprN linux-2.6.32.3.vanilla/drivers/hid/hid-ortek.c linux-2.6.32.3/drivers/hid/hid-ortek.c
--- linux-2.6.32.3.vanilla/drivers/hid/hid-ortek.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.32.3/drivers/hid/hid-ortek.c	2010-01-12 18:37:32.203180509 +0000
@@ -0,0 +1,56 @@
+/*
+ *  HID driver for Ortek WKB-2000 (wireless keyboard + mouse trackpad).
+ *  Fixes LogicalMaximum error in USB report description, see
+ *  http://bugzilla.kernel.org/show_bug.cgi?id=14787
+ *
+ *  Copyright (c) 2010 Johnathon Harris <jmharris@gmail.com>
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+
+#include "hid-ids.h"
+
+static void ortek_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+		unsigned int rsize)
+{
+	if (rsize >= 56 && rdesc[54] == 0x25 && rdesc[55] == 0x01) {
+		dev_info(&hdev->dev, "Fixing up Ortek WKB-2000 "
+				"report descriptor.\n");
+		rdesc[55] = 0x92;
+	}
+}
+
+static const struct hid_device_id ortek_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_WKB2000) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, ortek_devices);
+
+static struct hid_driver ortek_driver = {
+	.name = "ortek",
+	.id_table = ortek_devices,
+	.report_fixup = ortek_report_fixup
+};
+
+static int __init ortek_init(void)
+{
+	return hid_register_driver(&ortek_driver);
+}
+
+static void __exit ortek_exit(void)
+{
+	hid_unregister_driver(&ortek_driver);
+}
+
+module_init(ortek_init);
+module_exit(ortek_exit);
+MODULE_LICENSE("GPL");
