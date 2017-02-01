From: Jonathan Tomer <jktomer@google.com>
Subject: [PATCH v2] HID: Add quirk driver for NTI USB-SUN adapter
Date: Wed,  1 Feb 2017 11:54:57 -0800
Message-ID: <20170201195457.31060-1-jktomer@google.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34999 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752623AbdBATzJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 1 Feb 2017 14:55:09 -0500
Received: by mail-pf0-f175.google.com with SMTP id f144so120696883pfa.2
        for <linux-input@vger.kernel.org>; Wed, 01 Feb 2017 11:55:08 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jonathan Tomer <jktomer@google.com>

These adapters allow pre-USB Sun keyboards to be connected to USB-only
machines, but include the wrong maximum keycode in their report
descriptor, making most of the keys present on Sun keyboards but not
101-key PC keyboards nonfunctional.

This patch implements a quirk that overrides the maximum keycode in the
report descriptor.

Signed-off-by: Jonathan Tomer <jktomer@google.com>
---
Changes in v2:
  - Remove unneeded guard in Kconfig
  - Simplify registration code by using module_hid_driver() instead of
    module_{init,exit}
  - add MODULE_{AUTHOR,DESCRIPTION}

 drivers/hid/Kconfig    |  6 +++++
 drivers/hid/Makefile   |  1 +
 drivers/hid/hid-core.c |  1 +
 drivers/hid/hid-ids.h  |  3 +++
 drivers/hid/hid-nti.c  | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 70 insertions(+)
 create mode 100644 drivers/hid/hid-nti.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 4070b7386e9d..98f90410b94e 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -580,6 +580,12 @@ config HID_MULTITOUCH
 	  To compile this driver as a module, choose M here: the
 	  module will be called hid-multitouch.
 
+config HID_NTI
+	tristate "NTI keyboard adapters"
+	---help---
+	Support for the "extra" Sun keyboard keys on keyboards attached
+	through Network Technologies USB-SUN keyboard adapters.
+
 config HID_NTRIG
 	tristate "N-Trig touch screen"
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 4d111f23e801..c0a844b43dcc 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_HID_MAYFLASH)	+= hid-mf.o
 obj-$(CONFIG_HID_MICROSOFT)	+= hid-microsoft.o
 obj-$(CONFIG_HID_MONTEREY)	+= hid-monterey.o
 obj-$(CONFIG_HID_MULTITOUCH)	+= hid-multitouch.o
+obj-$(CONFIG_HID_NTI)			+= hid-nti.o
 obj-$(CONFIG_HID_NTRIG)		+= hid-ntrig.o
 obj-$(CONFIG_HID_ORTEK)		+= hid-ortek.o
 obj-$(CONFIG_HID_PRODIKEYS)	+= hid-prodikeys.o
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index cff060b56da9..3a435bf75e4d 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1997,6 +1997,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MONTEREY, USB_DEVICE_ID_GENIUS_KB29E) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_NTI, USB_DEVICE_ID_USB_SUN) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_TOUCH_SCREEN) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_TOUCH_SCREEN_1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_TOUCH_SCREEN_2) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 54bd22dc1411..9f79e7e657a4 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -767,6 +767,9 @@
 #define USB_DEVICE_ID_NOVATEK_PCT	0x0600
 #define USB_DEVICE_ID_NOVATEK_MOUSE	0x1602
 
+#define USB_VENDOR_ID_NTI               0x0757
+#define USB_DEVICE_ID_USB_SUN           0x0a00
+
 #define USB_VENDOR_ID_NTRIG		0x1b96
 #define USB_DEVICE_ID_NTRIG_TOUCH_SCREEN   0x0001
 #define USB_DEVICE_ID_NTRIG_TOUCH_SCREEN_1   0x0003
diff --git a/drivers/hid/hid-nti.c b/drivers/hid/hid-nti.c
new file mode 100644
index 000000000000..5bb827b223ba
--- /dev/null
+++ b/drivers/hid/hid-nti.c
@@ -0,0 +1,59 @@
+/*
+ *  USB HID quirks support for Network Technologies, Inc. "USB-SUN" USB
+ *  adapter for pre-USB Sun keyboards
+ *
+ *  Copyright (c) 2011 Google, Inc.
+ *
+ * Based on HID apple driver by
+ *  Copyright (c) 1999 Andreas Gal
+ *  Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
+ *  Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2, Inc
+ *  Copyright (c) 2006-2007 Jiri Kosina
+ *  Copyright (c) 2008 Jiri Slaby <jirislaby@gmail.com>
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
+MODULE_AUTHOR("Jonathan Klabunde Tomer <jktomer@google.com>");
+MODULE_DESCRIPTION("HID driver for Network Technologies USB-SUN keyboard adapter");
+
+/*
+ * NTI Sun keyboard adapter has wrong logical maximum in report descriptor
+ */
+static __u8 *nti_usbsun_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+		unsigned int *rsize)
+{
+	if (*rsize >= 60 && rdesc[53] == 0x65 && rdesc[59] == 0x65) {
+		hid_info(hdev, "fixing up NTI USB-SUN keyboard adapter report descriptor\n");
+		rdesc[53] = rdesc[59] = 0xe7;
+	}
+	return rdesc;
+}
+
+static const struct hid_device_id nti_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_NTI, USB_DEVICE_ID_USB_SUN) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, nti_devices);
+
+static struct hid_driver nti_driver = {
+	.name = "nti",
+	.id_table = nti_devices,
+	.report_fixup = nti_usbsun_report_fixup
+};
+
+module_hid_driver(nti_driver);
+
+MODULE_LICENSE("GPL");
-- 
2.11.0.483.g087da7b7c-goog

