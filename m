From: Tomasz Kramkowski <tk@the-tk.com>
Subject: [PATCH 1/2] HID: add innomedia INNEX GENESIS/ATARI adapter support
Date: Fri, 16 Dec 2016 21:31:29 +0000
Message-ID: <20161216213130.19303-2-tk@the-tk.com>
References: <20161216213130.19303-1-tk@the-tk.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from erebus.the-tk.com ([109.74.205.187]:37666 "EHLO
        erebus.the-tk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933364AbcLPViV (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 16 Dec 2016 16:38:21 -0500
In-Reply-To: <20161216213130.19303-1-tk@the-tk.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Tomasz Kramkowski <tk@the-tk.com>

Add a new module named hid-innomedia which implements support for the
(1292:4745) innomedia INNEX GENESIS/ATARI Controller USB adapter.

This device mis-reports the X and Y axis on the DPad when up or left are
pressed. The value reported is outside the range reported by the report
descriptor. The device reports -2 for left or up, 1 for right or down, 0
for nothing pressed and -1 for up and down or left and right pressed
simultaneously. This means that when left or up are pressed, the value
gets dropped by hid-input. Additionally, when both up and down or left
and right are pressed the device incorrectly reports up or left
respectively.

Signed-off-by: Tomasz Kramkowski <tk@the-tk.com>
---
 drivers/hid/Kconfig         |  6 +++++
 drivers/hid/Makefile        |  1 +
 drivers/hid/hid-core.c      |  1 +
 drivers/hid/hid-ids.h       |  3 +++
 drivers/hid/hid-innomedia.c | 63 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 74 insertions(+)
 create mode 100644 drivers/hid/hid-innomedia.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 4070b73..2b1829b 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -369,6 +369,12 @@ config HID_ICADE
 	To compile this driver as a module, choose M here: the
 	module will be called hid-icade.
 
+config HID_INNOMEDIA
+	tristate "Innomedia GENESIS/ATARI Controller USB adapter"
+	depends on HID
+	---help---
+	Support for the Innomedia GENESIS/ATARI Controller USB adapter.
+
 config HID_TWINHAN
 	tristate "Twinhan IR remote control"
 	depends on HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 4d111f2..10a802b 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_HID_HOLTEK)	+= hid-holtek-mouse.o
 obj-$(CONFIG_HID_HOLTEK)	+= hid-holtekff.o
 obj-$(CONFIG_HID_HYPERV_MOUSE)	+= hid-hyperv.o
 obj-$(CONFIG_HID_ICADE)		+= hid-icade.o
+obj-$(CONFIG_HID_INNOMEDIA)	+= hid-innomedia.o
 obj-$(CONFIG_HID_KENSINGTON)	+= hid-kensington.o
 obj-$(CONFIG_HID_KEYTOUCH)	+= hid-keytouch.o
 obj-$(CONFIG_HID_KYE)		+= hid-kye.o
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index cff060b..e410e75 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1912,6 +1912,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A081) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A0C2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HUION, USB_DEVICE_ID_HUION_TABLET) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_INNOMEDIA, USB_DEVICE_ID_INNEX_GENESIS_ATARI) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS2, USB_DEVICE_ID_JESS2_COLOR_RUMBLE_PAD) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ION, USB_DEVICE_ID_ICADE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KENSINGTON, USB_DEVICE_ID_KS_SLIMBLADE) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index ec277b9..b0e6f7c 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -537,6 +537,9 @@
 #define USB_VENDOR_ID_IRTOUCHSYSTEMS	0x6615
 #define USB_DEVICE_ID_IRTOUCH_INFRARED_USB	0x0070
 
+#define USB_VENDOR_ID_INNOMEDIA			0x1292
+#define USB_DEVICE_ID_INNEX_GENESIS_ATARI	0x4745
+
 #define USB_VENDOR_ID_ITE               0x048d
 #define USB_DEVICE_ID_ITE_LENOVO_YOGA   0x8386
 #define USB_DEVICE_ID_ITE_LENOVO_YOGA2  0x8350
diff --git a/drivers/hid/hid-innomedia.c b/drivers/hid/hid-innomedia.c
new file mode 100644
index 0000000..325cd7e
--- /dev/null
+++ b/drivers/hid/hid-innomedia.c
@@ -0,0 +1,63 @@
+/*
+ *  HID driver for quirky Innomedia devices
+ *
+ *  Copyright (c) 2016 Tomasz Kramkowski <tk@the-tk.com>
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
+static inline u8 fixaxis(u8 bits, int shift)
+{
+	u8 mask = 0x3 << shift;
+	u8 axis = (bits & mask) >> shift;
+
+	/*
+	 * These controllers report -2 (2) for left/up direction and -1 (3) for
+	 * both up-down or left-right pressed.
+	 */
+	if (axis == 3)
+		axis = 0;
+	else if (axis == 2)
+		axis = 3;
+
+	return (bits & ~mask) | (axis << shift);
+}
+
+static int im_raw_event(struct hid_device *hdev, struct hid_report *report,
+			u8 *data, int size)
+{
+	if (size == 3 && (data[0] == 1 || data[0] == 2)) {
+		data[1] = fixaxis(data[1], 0);
+		data[1] = fixaxis(data[1], 2);
+	}
+
+	return 0;
+}
+
+static const struct hid_device_id im_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_INNOMEDIA, USB_DEVICE_ID_INNEX_GENESIS_ATARI) },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(hid, im_devices);
+
+static struct hid_driver im_driver = {
+	.name = "innomedia",
+	.id_table = im_devices,
+	.raw_event = im_raw_event,
+};
+
+module_hid_driver(im_driver);
+
+MODULE_LICENSE("GPL");
-- 
2.10.2

