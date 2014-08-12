From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] hid: Add mapping for special keys on compaq ku 0133 keyboard
Date: Wed, 13 Aug 2014 01:14:50 +0200
Message-ID: <1407885290-3067-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:28678 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239AbaHLXPA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Aug 2014 19:15:00 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

The compaq ku 0133 keyboard has 8 special keys at the top:
http://lackof.org/taggart/hacking/keyboard/cpqwireless.jpg

3 of these use standard HID usage codes from the consumer page, the 5
others use part of the reserved 0x07 - 0x1f range.

This commit adds mapping for this keyboard for these reserved codes, making
the other 5 keys work.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hid/Kconfig      |  8 ++++++
 drivers/hid/Makefile     |  1 +
 drivers/hid/hid-compaq.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-core.c   |  1 +
 drivers/hid/hid-ids.h    |  3 +++
 5 files changed, 81 insertions(+)
 create mode 100644 drivers/hid/hid-compaq.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 5e79c6a..fafd8d8 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -160,6 +160,14 @@ config HID_CHICONY
 	---help---
 	Support for Chicony Tactical pad.
 
+config HID_COMPAQ
+	tristate "Compaq non-fully HID-compliant devices" if EXPERT
+	depends on HID
+	default !EXPERT
+	---help---
+	Support for Compaq devices that are not fully compliant with
+	the HID standard.
+
 config HID_PRODIKEYS
 	tristate "Prodikeys PC-MIDI Keyboard support"
 	depends on HID && SND
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index a6fa6ba..560d2db 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_HID_AUREAL)        += hid-aureal.o
 obj-$(CONFIG_HID_BELKIN)	+= hid-belkin.o
 obj-$(CONFIG_HID_CHERRY)	+= hid-cherry.o
 obj-$(CONFIG_HID_CHICONY)	+= hid-chicony.o
+obj-$(CONFIG_HID_COMPAQ)	+= hid-compaq.o
 obj-$(CONFIG_HID_CP2112)	+= hid-cp2112.o
 obj-$(CONFIG_HID_CYPRESS)	+= hid-cypress.o
 obj-$(CONFIG_HID_DRAGONRISE)	+= hid-dr.o
diff --git a/drivers/hid/hid-compaq.c b/drivers/hid/hid-compaq.c
new file mode 100644
index 0000000..db14ca9
--- /dev/null
+++ b/drivers/hid/hid-compaq.c
@@ -0,0 +1,68 @@
+/*
+ *  HID driver for some compaq "special" devices
+ *
+ *  Copyright (c) 2014 Hans de Goede <hdegoede@redhat.com>
+ *
+ *  Based on hid-microsoft.c which is:
+ *
+ *  Copyright (c) 1999 Andreas Gal
+ *  Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
+ *  Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2, Inc
+ *  Copyright (c) 2006-2007 Jiri Kosina
+ *  Copyright (c) 2008 Jiri Slaby
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
+
+#include "hid-ids.h"
+
+#define compaq_map_key_clear(c)	hid_map_usage_clear(hi, usage, bit, max, \
+					EV_KEY, (c))
+
+static int compaq_input_mapping(struct hid_device *hdev, struct hid_input *hi,
+		struct hid_field *field, struct hid_usage *usage,
+		unsigned long **bit, int *max)
+{
+	pr_err("compaq input map called, page %04x usage %04x\n",
+		(usage->hid & HID_USAGE_PAGE), (usage->hid & HID_USAGE));
+
+	if ((usage->hid & HID_USAGE_PAGE) != HID_UP_CONSUMER)
+		return 0;
+
+
+	switch (usage->hid & HID_USAGE) {
+	case 0x0011: compaq_map_key_clear(KEY_PRESENTATION);	break;
+	case 0x0012: compaq_map_key_clear(KEY_ADDRESSBOOK);	break;
+	case 0x0013: compaq_map_key_clear(KEY_INFO);		break;
+	case 0x0014: compaq_map_key_clear(KEY_PROG1);		break;
+	case 0x0015: compaq_map_key_clear(KEY_MESSENGER);	break;
+	default:
+		return 0;
+	}
+	return 1;
+}
+
+static const struct hid_device_id compaq_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_COMPAQ, USB_DEVICE_ID_KU_0133_KBD) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, compaq_devices);
+
+static struct hid_driver compaq_driver = {
+	.name = "compaq",
+	.id_table = compaq_devices,
+	.input_mapping = compaq_input_mapping,
+};
+module_hid_driver(compaq_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 8ed66fd..3bbd87c 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1754,6 +1754,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_WIRELESS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_WIRELESS2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_AK1D) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_COMPAQ, USB_DEVICE_ID_KU_0133_KBD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CREATIVELABS, USB_DEVICE_ID_PRODIKEYS_PCMIDI) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYGNAL, USB_DEVICE_ID_CYGNAL_CP2112) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_BARCODE_1) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 48b66bb..9bf2c6d 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -236,6 +236,9 @@
 #define USB_DEVICE_ID_CODEMERCS_IOW_FIRST	0x1500
 #define USB_DEVICE_ID_CODEMERCS_IOW_LAST	0x15ff
 
+#define USB_VENDOR_ID_COMPAQ		0x049f
+#define USB_DEVICE_ID_KU_0133_KBD	0x0051
+
 #define USB_VENDOR_ID_CREATIVELABS	0x041e
 #define USB_DEVICE_ID_PRODIKEYS_PCMIDI	0x2801
 
-- 
2.0.4

