From: Stefan Kriwanek <mail@stefankriwanek.de>
Subject: [PATCH] hid: Add driver to fix Speedlink VAD Cezanne support
Date: Fri, 27 May 2011 18:40:29 +0200
Message-ID: <4DDFD3FD.2060808@stefankriwanek.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wp123.webpack.hosteurope.de ([80.237.132.130]:49215 "EHLO
	wp123.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754682Ab1E0Qkc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 May 2011 12:40:32 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hello,

Speedlink VAD Cezanne have a hardware bug that makes the cursor "jump" from one place to another every now and then. The issue are relative motion events erroneously reported by the device, each having a distance value of +256. This 256 can in fact never occur due to real motion, therefore those events can safely be ignored.
The driver also drops useless EV_REL events with a value of 0, that the device sends every time it sends an "real" EV_REL or EV_KEY event.

Signed-off-by: Stefan Kriwanek <mail@stefankriwanek.de>

---

diff -X /tmp/dontdiff -urp linux-2.6.39/drivers/hid/hid-core.c linux-2.6.39-speedlink/drivers/hid/hid-core.c
--- linux-2.6.39/drivers/hid/hid-core.c	2011-05-26 11:28:21.846687753 +0200
+++ linux-2.6.39-speedlink/drivers/hid/hid-core.c	2011-05-27 01:49:09.315164904 +0200
@@ -1482,6 +1482,7 @@ static const struct hid_device_id hid_ha
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_SLIM_TABLET_12_1_INCH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_MEDIA_TABLET_10_6_INCH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_MEDIA_TABLET_14_1_INCH) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_X_TENSIONS, USB_DEVICE_ID_SPEEDLINK_VAD_CEZANNE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0005) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0030) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ZYDACRON, USB_DEVICE_ID_ZYDACRON_REMOTE_CONTROL) },
diff -X /tmp/dontdiff -urp linux-2.6.39/drivers/hid/hid-ids.h linux-2.6.39-speedlink/drivers/hid/hid-ids.h
--- linux-2.6.39/drivers/hid/hid-ids.h	2011-05-26 11:28:21.846687753 +0200
+++ linux-2.6.39-speedlink/drivers/hid/hid-ids.h	2011-05-26 11:29:10.526687734 +0200
@@ -607,6 +607,9 @@
 #define USB_VENDOR_ID_WISEGROUP_LTD2	0x6677
 #define USB_DEVICE_ID_SMARTJOY_DUAL_PLUS 0x8802
 
+#define USB_VENDOR_ID_X_TENSIONS               0x1ae7
+#define USB_DEVICE_ID_SPEEDLINK_VAD_CEZANNE    0x9001
+
 #define USB_VENDOR_ID_YEALINK		0x6993
 #define USB_DEVICE_ID_YEALINK_P1K_P4K_B2K	0xb001
 
diff -X /tmp/dontdiff -urp linux-2.6.39/drivers/hid/Kconfig linux-2.6.39-speedlink/drivers/hid/Kconfig
--- linux-2.6.39/drivers/hid/Kconfig	2011-05-26 11:28:21.846687753 +0200
+++ linux-2.6.39-speedlink/drivers/hid/Kconfig	2011-05-27 17:13:09.719864043 +0200
@@ -500,6 +500,12 @@ config HID_SONY
 	---help---
 	Support for Sony PS3 controller.
 
+config HID_SPEEDLINK
+	tristate "Speedlink VAD Cezanne mouse support"
+	depends on USB_HID
+	---help---
+	Support for Speedlink Vicious and Divine Cezanne mouse.
+
 config HID_STANTUM
 	tristate "Stantum multitouch panel"
 	depends on USB_HID
diff -X /tmp/dontdiff -urp linux-2.6.39/drivers/hid/Makefile linux-2.6.39-speedlink/drivers/hid/Makefile
--- linux-2.6.39/drivers/hid/Makefile	2011-05-26 11:28:21.846687753 +0200
+++ linux-2.6.39-speedlink/drivers/hid/Makefile	2011-05-26 11:29:10.536687734 +0200
@@ -66,6 +66,7 @@ obj-$(CONFIG_HID_ROCCAT_PYRA)	+= hid-roc
 obj-$(CONFIG_HID_SAMSUNG)	+= hid-samsung.o
 obj-$(CONFIG_HID_SMARTJOYPLUS)	+= hid-sjoy.o
 obj-$(CONFIG_HID_SONY)		+= hid-sony.o
+obj-$(CONFIG_HID_SPEEDLINK)	+= hid-speedlink.o
 obj-$(CONFIG_HID_STANTUM)	+= hid-stantum.o
 obj-$(CONFIG_HID_SUNPLUS)	+= hid-sunplus.o
 obj-$(CONFIG_HID_GREENASIA)	+= hid-gaff.o
--- /dev/null	2011-05-27 13:53:55.863652998 +0200
+++ linux-2.6.39-speedlink/drivers/hid/hid-speedlink.c	2011-05-27 18:00:34.719863577 +0200
@@ -0,0 +1,89 @@
+/*
+ *  HID driver for Speedlink Vicious and Divine Cezanne (USB mouse).
+ *  Fixes "jumpy" cursor and removes nonexistent keyboard LEDS from
+ *  the HID descriptor.
+ *
+ *  Copyright (c) 2011 Stefan Kriwanek <mail@stefankriwanek.de>
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
+#include <linux/usb.h>
+
+#include "hid-ids.h"
+#include "usbhid/usbhid.h"
+
+static const struct hid_device_id speedlink_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_X_TENSIONS, USB_DEVICE_ID_SPEEDLINK_VAD_CEZANNE)},
+	{ }
+};
+
+static int speedlink_input_mapping(struct hid_device *hdev,
+		struct hid_input *hi,
+		struct hid_field *field, struct hid_usage *usage,
+		unsigned long **bit, int *max)
+{
+	/*
+	 * The Cezanne mouse has a second "keyboard" USB endpoint for it is
+	 * able to map keyboard events to the button presses.
+	 * It sends a standard keyboard report descriptor, though, whose
+	 * LEDs we ignore.
+	 */
+	switch (usage->hid & HID_USAGE_PAGE) {
+	case HID_UP_LED:
+		return -1;
+	}
+	return 0;
+}
+
+static int speedlink_event(struct hid_device *hdev, struct hid_field *field,
+		struct hid_usage *usage, __s32 value)
+{
+	/* No other conditions due to usage_table. */
+	/* Fix "jumpy" cursor (invalid events sent by device). */
+	if (value == 256)
+		return 1;
+	/* Drop useless distance 0 events (on button clicks etc.) as well */
+	if (value == 0)
+		return 1;
+
+	return 0;
+}
+
+MODULE_DEVICE_TABLE(hid, speedlink_devices);
+
+static const struct hid_usage_id speedlink_grabbed_usages[] = {
+	{ HID_GD_X, EV_REL, 0 },
+	{ HID_GD_Y, EV_REL, 1 },
+	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1}
+};
+
+static struct hid_driver speedlink_driver = {
+	.name = "speedlink",
+	.id_table = speedlink_devices,
+	.usage_table = speedlink_grabbed_usages,
+	.input_mapping = speedlink_input_mapping,
+	.event = speedlink_event,
+};
+
+static int __init speedlink_init(void)
+{
+	return hid_register_driver(&speedlink_driver);
+}
+
+static void __exit speedlink_exit(void)
+{
+	hid_unregister_driver(&speedlink_driver);
+}
+
+module_init(speedlink_init);
+module_exit(speedlink_exit);
+MODULE_LICENSE("GPL");
