From: Robert Munteanu <rombert@apache.org>
Subject: [RFC v2 PATCH] Fix modifier keys for Redragon Asura Keyboard
Date: Fri, 16 Jun 2017 01:24:18 +0300
Message-ID: <1497565458.8428.1.camel@apache.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hermes.apache.org ([140.211.11.3]:35949 "HELO mail.apache.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751644AbdFOWYX (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Jun 2017 18:24:23 -0400
Received: from [192.168.1.57] (unknown [109.103.80.27])
        by mail-relay.apache.org (ASF Mail Server at mail-relay.apache.org) with ESMTPSA id 881A91A0280
        for <linux-input@vger.kernel.org>; Thu, 15 Jun 2017 22:24:21 +0000 (UTC)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Changelog:

- v2: modifier keys work, some combinations are still troublesome

The microdia family of keyboards uses a non-standard way of sending modifier
keys.

The down event always sets the first bit to 0x04 and the second keycode to a
custom value For instance, left shift sends the following bits

04 02 00 00 00 00 00 00

while left control sends

04 01 00 00 00 00 00 00

As a result all modifier keys are mapped to left shift and the keyboard is
non-functional in that respect. To solve the problem, we capture the raw data
in raw_event and manually genereate the correct input events.

The keyboard functions mostly as expected now, with only a few minor issues;

- two USB devices are detected instead of 1
- some key combinations are not triggered - e.g. left shift + left ctrl + p.
  However, the same combination is recognized with the right shift key.

The printk calls will be removed for the final submission.

Tested on Kernel 4.11.4.
---
 drivers/hid/Kconfig        |   7 +++
 drivers/hid/Makefile       |   2 +-
 drivers/hid/hid-core.c     |   1 +
 drivers/hid/hid-ids.h      |   3 +
 drivers/hid/hid-microdia.c | 147 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 159 insertions(+), 1 deletion(-)
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
index 4d111f23e801..72dcfa925086 100644
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
@@ -116,4 +117,3 @@ obj-$(CONFIG_USB_KBD)		+= usbhid/
 
 obj-$(CONFIG_I2C_HID)		+= i2c-hid/
 
-obj-$(CONFIG_INTEL_ISH_HID)	+= intel-ish-hid/
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
index 000000000000..7d20554ec8f5
--- /dev/null
+++ b/drivers/hid/hid-microdia.c
@@ -0,0 +1,147 @@
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
+#include <linux/log2.h>
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
+//
+// 1. Some modifiers keys still don't work, e.g. Ctrl-Shift-P
+//   Interestingly enough, this happens when pressing the physical left shift key, but now
+//   when pressing the physical right shift key. hexdump does not show them either.
+//   Test on Windows maybe?
+// 2. A second USB keyboard is registered, but it should be removed
+
+static int microdia_input_configured(struct hid_device *hdev, struct hid_input *hi)
+{
+	hid_set_drvdata(hdev, hi);
+
+	return 0;
+}
+
+static int microdia_input_mapping(struct hid_device *hdev, struct hid_input *hi,
+		struct hid_field *field, struct hid_usage *usage,
+		unsigned long **bit, int *max)
+{
+	// do not map left shift since we will manually generate input
+	// events in microdia_raw_event
+	if ( (usage->hid & HID_USAGE_PAGE) == HID_UP_KEYBOARD ) {
+		if ( (usage->hid & HID_USAGE ) == 0xe1 ) {
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+// array index of a modifier matches the bit index in the data payload
+// the modifier data is always stored in the second int
+// e.g. for left alt the 1 bit is set - 04 04 ...
+static int microdia_modifiers[7] = {
+		KEY_LEFTCTRL,
+		KEY_RIGHTSHIFT, // TODO should be left shift, but not possible since it's ignored in the mapping
+		KEY_LEFTALT,
+		KEY_LEFTMETA,
+		KEY_RIGHTCTRL,
+		KEY_RIGHTSHIFT,
+		KEY_RIGHTALT
+};
+
+static int microdia_last_handled_modifier = 0;
+
+static int microdia_raw_event(struct hid_device *hdev, struct hid_report *report,
+		u8 *data, int size)
+{
+	int i, changed_key, new_value, mapped_key;
+	struct hid_input *hi;
+
+	// 1. validate that we get 8 bits of the for 04 xx 00 00 00 00 00 00
+	if ( size != 8 ) {
+        return 0;
+    }
+
+    if ( data[0] != 4) {
+    	return 0;
+    }
+
+    // TODO - can I somehow use a bit mask? data & 0x00ffffff != 0
+    for ( i = 2; i < size; i++ ) {
+        if ( data[i] != 0 ) {
+            return 0;
+        }
+    }
+
+    // 2. detect based on previous data what key was pressed or depressed
+    // a key was pressed or depressed if its bit has a different value
+    // between this and the previous invocation. If the bit is set
+    // it was pressed
+
+    changed_key = data[1] ^ microdia_last_handled_modifier;
+    new_value = ( data[1] & changed_key )!= 0;
+    // TODO - is ilog2 really needed?
+    mapped_key = microdia_modifiers[ilog2(changed_key)];
+
+    printk("[hid-microdia] Got payload 0x%x\n", data[1]);
+    printk("[hid-microdia] Detected key %d value %d\n", changed_key, new_value);
+
+    // 3. report the key event and track what was sent
+    hi = hid_get_drvdata(hdev);
+
+    input_report_key(hi->input, mapped_key , new_value);
+
+    microdia_last_handled_modifier = data[1];
+
+    return 1;
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
+	.input_mapping = microdia_input_mapping,
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

