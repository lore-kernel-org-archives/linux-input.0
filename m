From: Yuxuan Shui <yshuiv7@gmail.com>
Subject: [PATCH] hid: Add support for the Elecom DEFT trackball
Date: Wed,  6 Jul 2016 21:58:25 -0400
Message-ID: <20160707015825.17915-2-yshuiv7@gmail.com>
References: <20160707015825.17915-1-yshuiv7@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35003 "EHLO
	mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbcGGB6p (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Jul 2016 21:58:45 -0400
Received: by mail-qk0-f194.google.com with SMTP id s7so489451qkf.2
        for <linux-input@vger.kernel.org>; Wed, 06 Jul 2016 18:58:44 -0700 (PDT)
In-Reply-To: <20160707015825.17915-1-yshuiv7@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: yshuiv7@gmail.com
Cc: linux-input@vger.kernel.org

The DEFT trackball has three non-standard buttons at the top which is
not supported by the hid-generic driver.

This patch add a driver that modifies the HID report, so those three
buttons can be supported like standard buttons.
---
 drivers/hid/Kconfig    |  6 ++++++
 drivers/hid/Makefile   |  1 +
 drivers/hid/hid-deft.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-ids.h  |  2 ++
 4 files changed, 61 insertions(+)
 create mode 100644 drivers/hid/hid-deft.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 5646ca4..9c3ee05 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -263,6 +263,12 @@ config HID_ELECOM
 	---help---
 	Support for the ELECOM BM084 (bluetooth mouse).
 
+config HID_ELECOM_DEFT
+	tristate "ELECOM DEFT trackball"
+	depends on HID
+	---help---
+	Support for the Fn keys found on ELECOM DEFT trackball.
+
 config HID_ELO
 	tristate "ELO USB 4000/4500 touchscreen"
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index a2fb562..3cc582e 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_HID_CYPRESS)	+= hid-cypress.o
 obj-$(CONFIG_HID_DRAGONRISE)	+= hid-dr.o
 obj-$(CONFIG_HID_EMS_FF)	+= hid-emsff.o
 obj-$(CONFIG_HID_ELECOM)	+= hid-elecom.o
+obj-$(CONFIG_HID_ELECOM_DEFT)	+= hid-deft.o
 obj-$(CONFIG_HID_ELO)		+= hid-elo.o
 obj-$(CONFIG_HID_EZKEY)		+= hid-ezkey.o
 obj-$(CONFIG_HID_GEMBIRD)	+= hid-gembird.o
diff --git a/drivers/hid/hid-deft.c b/drivers/hid/hid-deft.c
new file mode 100644
index 0000000..4e2621d
--- /dev/null
+++ b/drivers/hid/hid-deft.c
@@ -0,0 +1,52 @@
+/*
+ *  HID driver for Elecom DEFT (trackball).
+ *  Extend the number of buttons to 8, and
+ *  remove a non-standard item in the HID
+ *  descriptor.
+ *  (This module is based on "hid-elecom".)
+ *
+ *  Copyright (c) 2016 Yuxuan Shui <yshuiv7@gmail.com>
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
+static __u8 *deft_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+		unsigned int *rsize)
+{
+	if (*rsize >= 34 && rdesc[20] == 0x29 && rdesc[21] == 0x05) {
+		hid_info(hdev, "Fixing up Elecom DEFT report descriptor %x\n", rdesc[13]);
+		rdesc[21] = 0x08;
+		rdesc[13] = 0x08;
+
+		memmove(rdesc+28, rdesc+34, *rsize-34);
+		*rsize -= 6;
+	}
+	return rdesc;
+}
+
+static const struct hid_device_id deft_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_DEFT)},
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_DEFTW)},
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, deft_devices);
+
+static struct hid_driver deft_driver = {
+	.name = "elecom-deft",
+	.id_table = deft_devices,
+	.report_fixup = deft_report_fixup,
+};
+module_hid_driver(deft_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 3eec09a1..534ae73 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -332,6 +332,8 @@
 
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
+#define USB_DEVICE_ID_ELECOM_DEFT	0x00fe
+#define USB_DEVICE_ID_ELECOM_DEFTW	0x00ff
 
 #define USB_VENDOR_ID_DREAM_CHEEKY	0x1d34
 
-- 
2.9.0

