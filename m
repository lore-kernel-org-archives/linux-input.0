From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/2] HID: ite: Add hid-ite driver
Date: Wed, 10 May 2017 17:12:53 +0200
Message-ID: <20170510151253.30324-2-hdegoede@redhat.com>
References: <20170510151253.30324-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752828AbdEJPM7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 10 May 2017 11:12:59 -0400
In-Reply-To: <20170510151253.30324-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

The ITE8595 keyboard uses the HID_GD_RFKILL_BTN usage code
from the Wireless Radio Controls Application Collection Microsoft
has defined for Windows 8 and later.

However it has a quirk, when the rfkill hotkey is pressed it does
generate a report for the collection, but the reported value is
always 0. Luckily it is the only button in this collection / report,
and it sends a report on release only, so receiving a report means the
button was pressed.

This commit adds a hid-ite driver which watches for the Wireless Radio
Controls Application Collection report and then reports a KEY_RFKILL event,
ignoring the value, making the rfkill on this keyboard work.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hid/Kconfig    |  7 +++++++
 drivers/hid/Makefile   |  1 +
 drivers/hid/hid-core.c |  1 +
 drivers/hid/hid-ids.h  |  1 +
 drivers/hid/hid-ite.c  | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 66 insertions(+)
 create mode 100644 drivers/hid/hid-ite.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 8c54cb8f5d6d..8db13f2b748b 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -370,6 +370,13 @@ config HID_ICADE
 	To compile this driver as a module, choose M here: the
 	module will be called hid-icade.
 
+config HID_ITE
+	tristate "ITE devices"
+	depends on HID
+	default !EXPERT
+	---help---
+	Support for ITE devices not fully compliant with HID standard.
+
 config HID_TWINHAN
 	tristate "Twinhan IR remote control"
 	depends on HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 4d111f23e801..606545745cfe 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_HID_HOLTEK)	+= hid-holtek-mouse.o
 obj-$(CONFIG_HID_HOLTEK)	+= hid-holtekff.o
 obj-$(CONFIG_HID_HYPERV_MOUSE)	+= hid-hyperv.o
 obj-$(CONFIG_HID_ICADE)		+= hid-icade.o
+obj-$(CONFIG_HID_ITE)		+= hid-ite.o
 obj-$(CONFIG_HID_KENSINGTON)	+= hid-kensington.o
 obj-$(CONFIG_HID_KEYTOUCH)	+= hid-keytouch.o
 obj-$(CONFIG_HID_KYE)		+= hid-kye.o
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 63ec1993eaaa..9348a6f589f7 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1911,6 +1911,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A081) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A0C2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HUION, USB_DEVICE_ID_HUION_TABLET) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ITE, USB_DEVICE_ID_ITE8595) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_JESS_ZEN_AIO_KBD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS2, USB_DEVICE_ID_JESS2_COLOR_RUMBLE_PAD) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ION, USB_DEVICE_ID_ICADE) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 4e2648c86c8c..975c82993308 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -552,6 +552,7 @@
 #define USB_DEVICE_ID_ITE_LENOVO_YOGA   0x8386
 #define USB_DEVICE_ID_ITE_LENOVO_YOGA2  0x8350
 #define USB_DEVICE_ID_ITE_LENOVO_YOGA900	0x8396
+#define USB_DEVICE_ID_ITE8595		0x8595
 
 #define USB_VENDOR_ID_JABRA		0x0b0e
 #define USB_DEVICE_ID_JABRA_SPEAK_410	0x0412
diff --git a/drivers/hid/hid-ite.c b/drivers/hid/hid-ite.c
new file mode 100644
index 000000000000..1882a4ab0f29
--- /dev/null
+++ b/drivers/hid/hid-ite.c
@@ -0,0 +1,56 @@
+/*
+ * HID driver for some ITE "special" devices
+ * Copyright (c) 2017 Hans de Goede <hdegoede@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/device.h>
+#include <linux/input.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+
+#include "hid-ids.h"
+
+static int ite_event(struct hid_device *hdev, struct hid_field *field,
+		     struct hid_usage *usage, __s32 value)
+{
+	struct input_dev *input;
+
+	if (!(hdev->claimed & HID_CLAIMED_INPUT) || !field->hidinput)
+		return 0;
+
+	input = field->hidinput->input;
+
+	/*
+	 * The ITE8595 always reports 0 as value for the rfkill button. Luckily
+	 * it is the only button in its report, and it sends a report on
+	 * release only, so receiving a report means the button was pressed.
+	 */
+	if (usage->hid == HID_GD_RFKILL_BTN) {
+		input_event(input, EV_KEY, KEY_RFKILL, 1);
+		input_sync(input);
+		input_event(input, EV_KEY, KEY_RFKILL, 0);
+		input_sync(input);
+		return 1;
+	}
+
+	return 0;
+}
+
+static const struct hid_device_id ite_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ITE, USB_DEVICE_ID_ITE8595) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, ite_devices);
+
+static struct hid_driver ite_driver = {
+	.name = "itetech",
+	.id_table = ite_devices,
+	.event = ite_event,
+};
+module_hid_driver(ite_driver);
+
+MODULE_LICENSE("GPL");
-- 
2.12.2

