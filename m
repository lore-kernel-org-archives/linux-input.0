From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 1/3] Input: split hid-drff into general and ff parts
Date: Thu, 13 Jan 2011 21:56:41 +0300
Message-ID: <1294945003-7687-2-git-send-email-spbnick@gmail.com>
References: <1294945003-7687-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59514 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab1AMS5L (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Jan 2011 13:57:11 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so1078333ewy.19
        for <linux-input@vger.kernel.org>; Thu, 13 Jan 2011 10:57:11 -0800 (PST)
In-Reply-To: <1294945003-7687-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Vladislav Naumov <vnaum@vnaum.com>, Nikolai Kondrashov <spbnick@gmail.com>

Split DragonRise Inc. HID gamepad driver (hid-drff.c) into a general
(hid-dr.[hc]) and a force feedback part (hid-drff.c).

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---
 drivers/hid/Makefile   |    7 ++++-
 drivers/hid/hid-dr.c   |   71 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-dr.h   |   13 +++++++++
 drivers/hid/hid-drff.c |   63 +-----------------------------------------
 4 files changed, 92 insertions(+), 62 deletions(-)
 create mode 100644 drivers/hid/hid-dr.c
 create mode 100644 drivers/hid/hid-dr.h

diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index c335605..3e18fdd 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -25,6 +25,11 @@ ifdef CONFIG_LOGIWII_FF
 	hid-logitech-objs	+= hid-lg4ff.o
 endif
 
+hid-dragonrise-objs		:= hid-dr.o
+ifdef CONFIG_DRAGONRISE_FF
+	hid-dragonrise-objs	+= hid-drff.o
+endif
+
 obj-$(CONFIG_HID_3M_PCT)	+= hid-3m-pct.o
 obj-$(CONFIG_HID_A4TECH)	+= hid-a4tech.o
 obj-$(CONFIG_HID_ACRUX_FF)	+= hid-axff.o
@@ -34,7 +39,7 @@ obj-$(CONFIG_HID_CANDO)		+= hid-cando.o
 obj-$(CONFIG_HID_CHERRY)	+= hid-cherry.o
 obj-$(CONFIG_HID_CHICONY)	+= hid-chicony.o
 obj-$(CONFIG_HID_CYPRESS)	+= hid-cypress.o
-obj-$(CONFIG_HID_DRAGONRISE)	+= hid-drff.o
+obj-$(CONFIG_HID_DRAGONRISE)	+= hid-dragonrise.o
 obj-$(CONFIG_HID_EGALAX)	+= hid-egalax.o
 obj-$(CONFIG_HID_ELECOM)	+= hid-elecom.o
 obj-$(CONFIG_HID_EZKEY)		+= hid-ezkey.o
diff --git a/drivers/hid/hid-dr.c b/drivers/hid/hid-dr.c
new file mode 100644
index 0000000..bafd530
--- /dev/null
+++ b/drivers/hid/hid-dr.c
@@ -0,0 +1,71 @@
+/*
+ *  HID driver for DragonRise Inc. devices not fully compliant with HID standard
+ *
+ *  Copyright (c) 2010 Nikolai Kondrashov <spbnick@gmail.com>
+ *  Copyright (c) 2009 Richard Walmsley <richwalm@gmail.com>
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/input.h>
+#include <linux/usb.h>
+#include <linux/hid.h>
+
+#include "hid-ids.h"
+#include "hid-dr.h"
+
+static int dr_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	int ret;
+
+	dev_dbg(&hdev->dev, "DragonRise Inc. HID hardware probe...");
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		dev_err(&hdev->dev, "parse failed\n");
+		goto err;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
+	if (ret) {
+		dev_err(&hdev->dev, "hw start failed\n");
+		goto err;
+	}
+
+	drff_init(hdev);
+
+	return 0;
+err:
+	return ret;
+}
+
+static const struct hid_device_id dr_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, 0x0006),  },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, dr_devices);
+
+static struct hid_driver dr_driver = {
+	.name = "dragonrise",
+	.id_table = dr_devices,
+	.probe = dr_probe,
+};
+
+static int __init dr_init(void)
+{
+	return hid_register_driver(&dr_driver);
+}
+
+static void __exit dr_exit(void)
+{
+	hid_unregister_driver(&dr_driver);
+}
+
+module_init(dr_init);
+module_exit(dr_exit);
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-dr.h b/drivers/hid/hid-dr.h
new file mode 100644
index 0000000..43eb631
--- /dev/null
+++ b/drivers/hid/hid-dr.h
@@ -0,0 +1,13 @@
+#ifndef __HID_DR_H
+#define __HID_DR_H
+
+#ifdef CONFIG_DRAGONRISE_FF
+extern int drff_init(struct hid_device *hid);
+#else
+static inline int drff_init(struct hid_device *hid)
+{
+	return 0;
+}
+#endif
+
+#endif
diff --git a/drivers/hid/hid-drff.c b/drivers/hid/hid-drff.c
index 968b04f..89adafe 100644
--- a/drivers/hid/hid-drff.c
+++ b/drivers/hid/hid-drff.c
@@ -32,10 +32,8 @@
 #include <linux/usb.h>
 #include <linux/hid.h>
 
-#include "hid-ids.h"
-
-#ifdef CONFIG_DRAGONRISE_FF
 #include "usbhid/usbhid.h"
+#include "hid-dr.h"
 
 struct drff_device {
 	struct hid_report *report;
@@ -84,7 +82,7 @@ static int drff_play(struct input_dev *dev, void *data,
 	return 0;
 }
 
-static int drff_init(struct hid_device *hid)
+int drff_init(struct hid_device *hid)
 {
 	struct drff_device *drff;
 	struct hid_report *report;
@@ -138,60 +136,3 @@ static int drff_init(struct hid_device *hid)
 
 	return 0;
 }
-#else
-static inline int drff_init(struct hid_device *hid)
-{
-	return 0;
-}
-#endif
-
-static int dr_probe(struct hid_device *hdev, const struct hid_device_id *id)
-{
-	int ret;
-
-	dev_dbg(&hdev->dev, "DragonRise Inc. HID hardware probe...");
-
-	ret = hid_parse(hdev);
-	if (ret) {
-		dev_err(&hdev->dev, "parse failed\n");
-		goto err;
-	}
-
-	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
-	if (ret) {
-		dev_err(&hdev->dev, "hw start failed\n");
-		goto err;
-	}
-
-	drff_init(hdev);
-
-	return 0;
-err:
-	return ret;
-}
-
-static const struct hid_device_id dr_devices[] = {
-	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, 0x0006),  },
-	{ }
-};
-MODULE_DEVICE_TABLE(hid, dr_devices);
-
-static struct hid_driver dr_driver = {
-	.name = "dragonrise",
-	.id_table = dr_devices,
-	.probe = dr_probe,
-};
-
-static int __init dr_init(void)
-{
-	return hid_register_driver(&dr_driver);
-}
-
-static void __exit dr_exit(void)
-{
-	hid_unregister_driver(&dr_driver);
-}
-
-module_init(dr_init);
-module_exit(dr_exit);
-MODULE_LICENSE("GPL");
-- 
1.7.2.3

