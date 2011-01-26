From: Chris Schlund <chrisschlund@gmx.de>
Subject: Re: Re: [PATCH] hid kernel module for wireless remote LC Power model
 RC1000MCE
Date: Wed, 26 Jan 2011 13:56:12 +0100
Message-ID: <4D4019EC.8060301@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:53354 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752267Ab1AZM4E (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Jan 2011 07:56:04 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

Hi Jiri,

>>First, I am missing your Signed-off-by: line, without which I can't apply your driver. Please see Documentation/SubmittingPatches for details..
>>Second, your mailer has damaged (line-wrapped) the patch..
>>Also, we are not going the EMBEDDED path any more (see commit 73d5e8f77e88a4 for explanation).

I attached the newly prepared patch with removed EMBEDDED path and hopefully without line-wrap.
I also added the Signed-off-by line.

Thanks,
Chris


Signed-off-by: Chris Schlund <chrisschlund@gmx.de>
---


diff -uprN linux-2.6.37/drivers/hid/hid-core.c linux/drivers/hid/hid-core.c
--- linux-2.6.37/drivers/hid/hid-core.c	2011-01-05 01:50:19.000000000 +0100
+++ linux/drivers/hid/hid-core.c	2011-01-24 17:01:00.000000000 +0100
@@ -1312,6 +1312,7 @@ static const struct hid_device_id hid_bl
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KENSINGTON, USB_DEVICE_ID_KS_SLIMBLADE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_ERGO_525V) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LABTEC, USB_DEVICE_ID_LABTEC_WIRELESS_KEYBOARD) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LCPOWER, USB_DEVICE_ID_LCPOWER_LC1000 ) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_MX3000_RECEIVER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_S510_RECEIVER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_S510_RECEIVER_2) },
diff -uprN linux-2.6.37/drivers/hid/hid-ids.h linux/drivers/hid/hid-ids.h
--- linux-2.6.37/drivers/hid/hid-ids.h	2011-01-05 01:50:19.000000000 +0100
+++ linux/drivers/hid/hid-ids.h	2011-01-24 17:01:00.000000000 +0100
@@ -330,6 +330,9 @@
 #define USB_VENDOR_ID_LABTEC		0x1020
 #define USB_DEVICE_ID_LABTEC_WIRELESS_KEYBOARD	0x0006
 
+#define USB_VENDOR_ID_LCPOWER		0x1241
+#define USB_DEVICE_ID_LCPOWER_LC1000	0xf767
+
 #define USB_VENDOR_ID_LD		0x0f11
 #define USB_DEVICE_ID_LD_CASSY		0x1000
 #define USB_DEVICE_ID_LD_POCKETCASSY	0x1010
diff -uprN linux-2.6.37/drivers/hid/hid-lcpower.c linux/drivers/hid/hid-lcpower.c
--- linux-2.6.37/drivers/hid/hid-lcpower.c	1970-01-01 01:00:00.000000000 +0100
+++ linux/drivers/hid/hid-lcpower.c	2011-01-24 17:01:00.000000000 +0100
@@ -0,0 +1,70 @@
+/*
+ *  HID driver for LC Power Model RC1000MCE
+ *
+ *  Copyright (c) 2011 Chris Schlund 
+ *  based on hid-topseed module
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
+#define ts_map_key_clear(c)	hid_map_usage_clear(hi, usage, bit, max, \
+					EV_KEY, (c))
+static int ts_input_mapping(struct hid_device *hdev, struct hid_input *hi,
+		struct hid_field *field, struct hid_usage *usage,
+		unsigned long **bit, int *max)
+{
+	if ((usage->hid & HID_USAGE_PAGE) != 0x0ffbc0000)
+		return 0;
+
+	switch (usage->hid & HID_USAGE) {
+        case 0x046: ts_map_key_clear(KEY_YELLOW);         break;
+        case 0x047: ts_map_key_clear(KEY_GREEN);          break;
+        case 0x049: ts_map_key_clear(KEY_RED);            break;
+        case 0x04a: ts_map_key_clear(KEY_BLUE);           break;
+        case 0x00d: ts_map_key_clear(KEY_HOME);           break;
+        case 0x025: ts_map_key_clear(KEY_TV);             break;
+        case 0x048: ts_map_key_clear(KEY_VCR);            break;
+        case 0x024: ts_map_key_clear(KEY_MENU);           break;
+        default:
+        return 0;
+	}
+
+	return 1;
+}
+
+static const struct hid_device_id ts_devices[] = {
+	{ HID_USB_DEVICE( USB_VENDOR_ID_LCPOWER, USB_DEVICE_ID_LCPOWER_LC1000) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, ts_devices);
+
+static struct hid_driver ts_driver = {
+	.name = "LC RC1000MCE",
+	.id_table = ts_devices,
+	.input_mapping = ts_input_mapping,
+};
+
+static int __init ts_init(void)
+{
+	return hid_register_driver(&ts_driver);
+}
+
+static void __exit ts_exit(void)
+{
+	hid_unregister_driver(&ts_driver);
+}
+
+module_init(ts_init);
+module_exit(ts_exit);
+MODULE_LICENSE("GPL");
diff -uprN linux-2.6.37/drivers/hid/Kconfig linux/drivers/hid/Kconfig
--- linux-2.6.37/drivers/hid/Kconfig	2011-01-05 01:50:19.000000000 +0100
+++ linux/drivers/hid/Kconfig	2011-01-26 13:04:15.000000000 +0100
@@ -207,6 +207,12 @@ config HID_KENSINGTON
 	---help---
 	Support for Kensington Slimblade Trackball.
 
+config HID_LCPOWER
+	tristate "LC-Power"
+	depends on USB_HID
+	---help---
+	Support for LC-Power RC1000MCE RF remote control.
+
 config HID_LOGITECH
 	tristate "Logitech devices" if EMBEDDED
 	depends on USB_HID
diff -uprN linux-2.6.37/drivers/hid/Makefile linux/drivers/hid/Makefile
--- linux-2.6.37/drivers/hid/Makefile	2011-01-05 01:50:19.000000000 +0100
+++ linux/drivers/hid/Makefile	2011-01-24 17:01:00.000000000 +0100
@@ -41,6 +41,7 @@ obj-$(CONFIG_HID_EZKEY)		+= hid-ezkey.o
 obj-$(CONFIG_HID_GYRATION)	  += hid-gyration.o
 obj-$(CONFIG_HID_KENSINGTON)	  += hid-kensington.o
 obj-$(CONFIG_HID_KYE)		  += hid-kye.o
+obj-$(CONFIG_HID_LCPOWER)	  += hid-lcpower.o
 obj-$(CONFIG_HID_LOGITECH)	  += hid-logitech.o
 obj-$(CONFIG_HID_MAGICMOUSE)     += hid-magicmouse.o
 obj-$(CONFIG_HID_MICROSOFT)	  += hid-microsoft.o
