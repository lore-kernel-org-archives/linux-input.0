From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: [PATCH] HID: add support for PenMount HID TouchScreen Driver v4
Date: Wed,  3 Sep 2014 10:33:53 +0200
Message-ID: <1409733233-11533-1-git-send-email-christian.gmeiner@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:38506 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283AbaICIed (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Sep 2014 04:34:33 -0400
Received: by mail-we0-f177.google.com with SMTP id u56so8054023wes.8
        for <linux-input@vger.kernel.org>; Wed, 03 Sep 2014 01:34:32 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: benjamin.tissoires@gmail.com, jkosina@suse.cz, Christian Gmeiner <christian.gmeiner@gmail.com>

This patch adds a seperate hid-penmount driver to work
around an issue with the HID report descriptor. The
descriptor does not contain the ContactID usage and as
result the touchscreen is represented as normal mouse
to the system.

This driver maps the button 0 emitted by the touchscreen
to BTN_TOUCH. This makes it possible to use touch events
in userspace.

changes from v1 to v2
 - incorporated feedback from Benjamin Tissoires
changes from v2 to v3
 - add missing hid-core.c and hid-ids.h changes
changes from v3 to v4
 - incorporated feedback from Benjamin Tissoires

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---
 drivers/hid/Kconfig        |  6 ++++++
 drivers/hid/Makefile       |  1 +
 drivers/hid/hid-core.c     |  1 +
 drivers/hid/hid-ids.h      |  1 +
 drivers/hid/hid-penmount.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 58 insertions(+)
 create mode 100644 drivers/hid/hid-penmount.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index c18d5d7..0351b66 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -530,6 +530,17 @@ config PANTHERLORD_FF
 	  Say Y here if you have a PantherLord/GreenAsia based game controller
 	  or adapter and want to enable force feedback support for it.
 
+config HID_PENMOUNT
+	tristate "Penmount touch device"
+	depends on USB_HID
+	---help---
+	  This selects a driver for the PenMount 6000 touch controller.
+
+	  The driver works around a problem in the report descript allowing
+	  the userspace to touch events instead of mouse events.
+
+	  Say Y here if you have a Penmount based touch controller.
+
 config HID_PETALYNX
 	tristate "Petalynx Maxter remote control"
 	depends on HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 4dbac7f..e2850d8 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_HID_NTRIG)		+= hid-ntrig.o
 obj-$(CONFIG_HID_ORTEK)		+= hid-ortek.o
 obj-$(CONFIG_HID_PRODIKEYS)	+= hid-prodikeys.o
 obj-$(CONFIG_HID_PANTHERLORD)	+= hid-pl.o
+obj-$(CONFIG_HID_PENMOUNT)	+= hid-penmount.o
 obj-$(CONFIG_HID_PETALYNX)	+= hid-petalynx.o
 obj-$(CONFIG_HID_PICOLCD)	+= hid-picolcd.o
 hid-picolcd-y			+= hid-picolcd_core.o
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 12b6e67..6827196 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1880,6 +1880,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_TOUCH_SCREEN_18) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_PKB1700) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_WKB2000) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_6000) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PETALYNX, USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_KEYBOARD) },
 #if IS_ENABLED(CONFIG_HID_ROCCAT)
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 25cd674..3943ffe 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -722,6 +722,7 @@
 #define USB_DEVICE_ID_PENMOUNT_PCI	0x3500
 #define USB_DEVICE_ID_PENMOUNT_1610	0x1610
 #define USB_DEVICE_ID_PENMOUNT_1640	0x1640
+#define USB_DEVICE_ID_PENMOUNT_6000	0x6000
 
 #define USB_VENDOR_ID_PETALYNX		0x18b1
 #define USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE	0x0037
diff --git a/drivers/hid/hid-penmount.c b/drivers/hid/hid-penmount.c
new file mode 100644
index 0000000..c11dce8
--- /dev/null
+++ b/drivers/hid/hid-penmount.c
@@ -0,0 +1,49 @@
+/*
+ *  HID driver for PenMount touchscreens
+ *
+ *  Copyright (c) 2014 Christian Gmeiner <christian.gmeiner <at> gmail.com>
+ *
+ *  based on hid-penmount copyrighted by
+ *    PenMount Touch Solutions <penmount <at> seed.net.tw>
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/hid.h>
+#include "hid-ids.h"
+
+static int penmount_input_mapping(struct hid_device *hdev,
+		struct hid_input *hi, struct hid_field *field,
+		struct hid_usage *usage, unsigned long **bit, int *max)
+{
+	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON) {
+		hid_map_usage(hi, usage, bit, max, EV_KEY, BTN_TOUCH);
+		return 1;
+	}
+
+	return 0;
+}
+
+static const struct hid_device_id penmount_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_6000) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, penmount_devices);
+
+static struct hid_driver penmount_driver = {
+	.name = "hid-penmount",
+	.id_table = penmount_devices,
+	.input_mapping = penmount_input_mapping,
+};
+
+module_hid_driver(penmount_driver);
+
+MODULE_AUTHOR("Christian Gmeiner <christian.gmeiner@gmail.com>");
+MODULE_DESCRIPTION("PenMount HID TouchScreen driver");
+MODULE_LICENSE("GPL");
-- 
1.9.3

