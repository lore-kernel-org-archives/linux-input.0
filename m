From: Robert Munteanu <rombert@apache.org>
Subject: [RFC PATCH] Fix modifier keys for Redragon Asura Keyboard
Date: Thu, 15 Jun 2017 13:38:12 +0300
Message-ID: <1497523092.5216.3.camel@apache.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hermes.apache.org ([140.211.11.3]:50770 "HELO mail.apache.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750830AbdFOKpB (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Jun 2017 06:45:01 -0400
Received: from [10.136.162.32] (unknown [193.105.140.131])
        by mail-relay.apache.org (ASF Mail Server at mail-relay.apache.org) with ESMTPSA id 758BA1A00A8
        for <linux-input@vger.kernel.org>; Thu, 15 Jun 2017 10:38:17 +0000 (UTC)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

The microdia family of keyboards uses a non-standard way of sending modifier
keys

The down event always sets the first bit to 0x04 and the second keycode to a
custom value For instance, left shift sends the following bits

04 02 00 00 00 00 00 00

while left control sends

04 01 00 00 00 00 00 00

As a result all modifier keys are mapped to left shift and the keyboard is
non-functional in that respect. To solve the problem, we capture the raw data 
in raw_event and manually genereate the correct input events.

I am sending this patch as a RFC to make sure I am taking the correct approach.
One functional issue that I'm facing is that the overriden modifier keys also
include a KEY_LEFTSHIFT event when pressed. evtest reports the following events
when the left control key is pressed:

Event: time 1497521832.320627, type 1 (EV_KEY), code 29 (KEY_LEFTCTRL), value 1
Event: time 1497521832.320627, type 4 (EV_MSC), code 4 (MSC_SCAN), value 700e1
Event: time 1497521832.320627, type 1 (EV_KEY), code 42 (KEY_LEFTSHIFT), value 1
Event: time 1497521832.320627, -------------- SYN_REPORT ------------
Event: time 1497521832.384558, type 1 (EV_KEY), code 29 (KEY_LEFTCTRL), value 0
Event: time 1497521832.384558, type 4 (EV_MSC), code 4 (MSC_SCAN), value 700e1
Event: time 1497521832.384558, type 1 (EV_KEY), code 42 (KEY_LEFTSHIFT), value 0
Event: time 1497521832.384558, -------------- SYN_REPORT ------------

I would expect the KEY_LEFTSHIFT event to not be sent since I'm returning 1
from microdia_raw_event.

The printk calls will be removed for the final submission.

Tested on Kernel 4.11.4.
---
 drivers/hid/Kconfig        |   7 +++
 drivers/hid/Makefile       |   1 +
 drivers/hid/hid-core.c     |   1 +
 drivers/hid/hid-ids.h      |   3 ++
 drivers/hid/hid-microdia.c | 121 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 133 insertions(+)
 create mode 100644 drivers/hid/hid-microdia.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 8c54cb8f5d6d..ef950b11ffbe 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -521,6 +521,13 @@ config HID_MAYFLASH
 	Say Y here if you have HJZ Mayflash PS3 game controller adapters
 	and want to enable force feedback support.
 
+config HID_MICRODIA
+	tristate "Microdia based keyboards"
+	depends on HID
+	default !EXPERT
+	---help---
+    Support for Microdia based keyboards such as the Redragon Asura.
+
 config HID_MICROSOFT
 	tristate "Microsoft non-fully HID-compliant devices"
 	depends on HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 4d111f23e801..d3c162d5ecb3 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_HID_LOGITECH_DJ)	+= hid-logitech-dj.o
 obj-$(CONFIG_HID_LOGITECH_HIDPP)	+= hid-logitech-hidpp.o
 obj-$(CONFIG_HID_MAGICMOUSE)	+= hid-magicmouse.o
 obj-$(CONFIG_HID_MAYFLASH)	+= hid-mf.o
+obj-$(CONFIG_HID_MICRODIA)  += hid-microdia.o
 obj-$(CONFIG_HID_MICROSOFT)	+= hid-microsoft.o
 obj-$(CONFIG_HID_MONTEREY)	+= hid-monterey.o
 obj-$(CONFIG_HID_MULTITOUCH)	+= hid-multitouch.o
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index d162f0dc76e3..7a54ab0a59b1 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1974,6 +1974,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_PICOLCD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_PICOLCD_BOOTLOADER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_LUXAFOR) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICRODIA,  USB_DEVICE_ID_REDRAGON_ASURA) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_COMFORT_MOUSE_4500) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_COMFORT_KEYBOARD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_SIDEWINDER_GV) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b26c030926c1..7e4f716c3a98 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1127,4 +1127,7 @@
 #define USB_VENDOR_ID_UGTIZER			0x2179
 #define USB_DEVICE_ID_UGTIZER_TABLET_GP0610	0x0053
 
+#define USB_VENDOR_ID_MICRODIA          0x0c45
+#define USB_DEVICE_ID_REDRAGON_ASURA    0x760b
+
 #endif
diff --git a/drivers/hid/hid-microdia.c b/drivers/hid/hid-microdia.c
new file mode 100644
index 000000000000..1a7093ea0ad3
--- /dev/null
+++ b/drivers/hid/hid-microdia.c
@@ -0,0 +1,121 @@
+/*
+ *  HID driver for Microdia-based keyboards
+ *
+ *  Copyright (c) 2017 Robert Munteanu
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
+#include <linux/input.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/input-event-codes.h>
+
+#include "hid-ids.h"
+
+
+// The microdia family of keyboards uses a non-standard way of sending modifier keys
+//
+// The down event always sets the first bit to 0x04 and the second keycode to a custom value
+// For instance, left shift sends the following bits
+//
+// 04 02 00 00 00 00 00 00
+//
+// while left control sends
+//
+// 04 01 00 00 00 00 00 00
+//
+// Unfortunately these are all mapped to left shift and the keyboard is non-functional in that respect
+// To solve the problem, we capture the raw data in raw_event and manually genereate the correct input
+// events
+//
+// TODO
+// 1. When overriding pressed keys the left shift key code is also sent
+// 2. A second USB keyboard is registered, but it should be removed
+
+static int microdia_input_configured(struct hid_device *hdev, struct hid_input *hi)
+{
+	hid_set_drvdata(hdev, hi);
+
+	return 0;
+}
+
+static int last_key;
+
+static int microdia_raw_event(struct hid_device *hdev, struct hid_report *report,
+		u8 *data, int size)
+{
+	int ret = 0, key, value;
+	struct hid_input *hi = hid_get_drvdata(hdev);
+
+	if ( size >= 2 && data[0] == 4 && data[1] != 2) {
+		value = data[1] != 0;
+		printk("[hid-microdia] raw (sz=%d) %d %d: ", size, data[0], data[1]);
+		if ( !value ) {
+			key = last_key;
+			last_key = 0;
+			ret = 1;
+		} else {
+			switch(data[1]) {
+				case 1: // left control
+					key = KEY_LEFTCTRL;
+					ret = 1;
+					break;
+		//		case 2: // left shift
+				case 4: // left alt
+					key = KEY_LEFTALT;
+					ret = 1;
+					break;
+				case 8: // left win key
+					key = KEY_LEFTMETA;
+					ret = 1;
+					break;
+				case 16: // right ctrl
+					key = KEY_RIGHTCTRL;
+					ret = 1;
+					break;
+				case 32: // right shift
+					key = KEY_RIGHTSHIFT;
+					ret = 1;
+					break;
+				case 64: // right alt
+					key = KEY_RIGHTALT;
+					ret = 1;
+					break;
+				}
+		}
+
+		if ( ret ) {
+			input_report_key(hi->input, key, value);
+			last_key = key;
+			printk("Remapped %d %d to key %d value %d\n", data[0], data[1], key, value);
+		}
+	}
+	printk("Returning %d\n", ret);
+	return ret;
+}
+
+static const struct hid_device_id microdia_devices[] = {
+	{HID_USB_DEVICE(USB_VENDOR_ID_MICRODIA, USB_DEVICE_ID_REDRAGON_ASURA)},
+	{}
+};
+
+MODULE_DEVICE_TABLE(hid, microdia_devices);
+
+static struct hid_driver microdia_driver = {
+	.name = "microdia",
+	.id_table = microdia_devices,
+	.raw_event = microdia_raw_event,
+	.input_configured = microdia_input_configured,
+};
+
+module_hid_driver(microdia_driver);
+
+MODULE_LICENSE("GPL");
-- 
2.13.1

