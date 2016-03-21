From: Yusuke Fujimaki <usk.fujimaki@gmail.com>
Subject: [PATCH] HID: Asus X205TA keyboard driver
Date: Mon, 21 Mar 2016 16:18:42 +0900
Message-ID: <1458544722-31997-1-git-send-email-usk.fujimaki@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35764 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbcCUHUF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Mar 2016 03:20:05 -0400
Received: by mail-pf0-f180.google.com with SMTP id n5so254662932pfn.2
        for <linux-input@vger.kernel.org>; Mon, 21 Mar 2016 00:20:04 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Yusuke Fujimaki <usk.fujimaki@gmail.com>

Asus X205TA built-in keyboard contains wrong
logical maximum value in report descriptor.

0x05, 0x01,  // Usage Page (Generic Desktop)
0x09, 0x06,  // Usage (Keyboard)
0xa1, 0x01,  // Collection (Application)
0x85, 0x01,  // Report ID (1)
0x05, 0x07,  // Usage Page (Keyboard/Keypad)
0x19, 0xe0,  // Usage Minimum (224)
0x29, 0xe7,  // Usage Maximum (231)
0x15, 0x00,  // Logical Minimum (0)
0x25, 0x01,  // Logical Maximum (1)
0x75, 0x01,  // Report Size (1)
0x95, 0x08,  // Report Count (8)
0x81, 0x02,  // Input (Data,Array,Abs)
0x95, 0x01,  // Report Count (1)
0x75, 0x08,  // Report Size (8)
0x81, 0x03,  // Input (Const,Var,Abs)
0x95, 0x05,  // Report Count (5)
0x75, 0x01,  // Report Size (1)
0x05, 0x08,  // Usage (LED)
0x19, 0x01,  // Usage Minimum (1)
0x29, 0x05,  // Usage Maximum (5)
0x91, 0x02,  // Output (Data,Var,Abs)
0x95, 0x01,  // Report Count (1)
0x75, 0x03,  // Report Size (3)
0x91, 0x03,  // Output (Const,Var,Abs)
0x95, 0x06,  // Report Count (6)
0x75, 0x08,  // Report Size (8)
0x15, 0x00,  // Logical Minimum (0)
0x25, 0x65,  // Logical Maximum (101)  * too small *
0x05, 0x07,  // Usage Page (Keyboard/Keypad)
0x19, 0x00,  // Usage Minimum (0)
0x29, 0xdd,  // Usage Maximum (221)
0x81, 0x00,  // Input(Data,Array,Abs)

In Asus X205TA japanese keyboard model,there are language
specific keys over usage id 101.
This patch correct wrong logical maximum in report
descriptor.

Signed-off-by: Yusuke Fujimaki <usk.fujimaki@gmail.com>
---
 drivers/hid/Kconfig    |  6 ++++++
 drivers/hid/Makefile   |  1 +
 drivers/hid/hid-asus.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-core.c |  1 +
 drivers/hid/hid-ids.h  |  1 +
 5 files changed, 57 insertions(+)
 create mode 100644 drivers/hid/hid-asus.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 4117225..513c93e 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -134,6 +134,12 @@ config HID_APPLEIR
 
 	Say Y here if you want support for Apple infrared remote control.
 
+config HID_ASUS
+	tristate "Asus"
+	depends on I2C_HID
+	---help---
+	Support for Asus X205TA built-in keyboard via i2c.
+
 config HID_AUREAL
 	tristate "Aureal"
 	depends on HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index be56ab6..a2fb562 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_HID_A4TECH)	+= hid-a4tech.o
 obj-$(CONFIG_HID_ACRUX)		+= hid-axff.o
 obj-$(CONFIG_HID_APPLE)		+= hid-apple.o
 obj-$(CONFIG_HID_APPLEIR)	+= hid-appleir.o
+obj-$(CONFIG_HID_ASUS)		+= hid-asus.o
 obj-$(CONFIG_HID_AUREAL)	+= hid-aureal.o
 obj-$(CONFIG_HID_BELKIN)	+= hid-belkin.o
 obj-$(CONFIG_HID_BETOP_FF)	+= hid-betopff.o
diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
new file mode 100644
index 0000000..1734e11
--- /dev/null
+++ b/drivers/hid/hid-asus.c
@@ -0,0 +1,48 @@
+/*
+ *  HID driver for Asus X205TA built-in keyboard.
+ *  Fixes small logical maximum to match usage maximum.
+ *
+ *  Copyright (c) 2016 Yusuke Fujimaki <usk.fujimaki@gmail.com>
+ *
+ *  This module based on hid-ortek by
+ *  Copyright (c) 2010 Johnathon Harris <jmharris@gmail.com>
+ *  Copyright (c) 2011 Jiri Kosina
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
+static __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+		unsigned int *rsize)
+{
+	if (*rsize >= 180 && rdesc[54] == 0x25 && rdesc[55] == 0x65) {
+		hid_info(hdev, "Fixing up Asus X205TA report descriptor\n");
+		rdesc[55] = 0xdd;
+	}
+	return rdesc;
+}
+
+static const struct hid_device_id asus_devices[] = {
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_X205TA_KEYBOARD) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, asus_devices);
+
+static struct hid_driver asus_driver = {
+	.name = "asus",
+	.id_table = asus_devices,
+	.report_fixup = asus_report_fixup
+};
+module_hid_driver(asus_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index bdb8cc8..7426b5a 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1856,6 +1856,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_JIS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_X205TA_KEYBOARD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AUREAL, USB_DEVICE_ID_AUREAL_W01RN) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BELKIN, USB_DEVICE_ID_FLIP_KVM) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BETOP_2185BFM, 0x2208) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 5c0e43e..f83e7fd 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -163,6 +163,7 @@
 #define USB_VENDOR_ID_ASUSTEK		0x0b05
 #define USB_DEVICE_ID_ASUSTEK_LCM	0x1726
 #define USB_DEVICE_ID_ASUSTEK_LCM2	0x175b
+#define USB_DEVICE_ID_ASUSTEK_X205TA_KEYBOARD  0x8585
 
 #define USB_VENDOR_ID_ATEN		0x0557
 #define USB_DEVICE_ID_ATEN_UC100KM	0x2004
-- 
2.1.4

