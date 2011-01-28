From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 1/3] Input: rename hid-drff.c to hid-dr.c
Date: Fri, 28 Jan 2011 14:50:51 +0300
Message-ID: <1296215454-2586-2-git-send-email-spbnick@gmail.com>
References: <1296215454-2586-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59067 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594Ab1A1LvQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jan 2011 06:51:16 -0500
Received: by eye27 with SMTP id 27so1476100eye.19
        for <linux-input@vger.kernel.org>; Fri, 28 Jan 2011 03:51:15 -0800 (PST)
In-Reply-To: <1296215454-2586-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Vladislav Naumov <vnaum@vnaum.com>, Nikolai Kondrashov <spbnick@gmail.com>

Rename drivers/hid/hid-drff.c (a DragonRise Inc. force feedback gamepad driver)
to driver/hid/hid-dr.c.

This prepares it for addition of support for another gamepad, without force
feedback.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---
 drivers/hid/Makefile   |    2 +-
 drivers/hid/hid-dr.c   |  197 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-drff.c |  197 ------------------------------------------------
 3 files changed, 198 insertions(+), 198 deletions(-)
 create mode 100644 drivers/hid/hid-dr.c
 delete mode 100644 drivers/hid/hid-drff.c

diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 6efc2a0..bb744e6 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -34,7 +34,7 @@ obj-$(CONFIG_HID_CANDO)		+= hid-cando.o
 obj-$(CONFIG_HID_CHERRY)	+= hid-cherry.o
 obj-$(CONFIG_HID_CHICONY)	+= hid-chicony.o
 obj-$(CONFIG_HID_CYPRESS)	+= hid-cypress.o
-obj-$(CONFIG_HID_DRAGONRISE)	+= hid-drff.o
+obj-$(CONFIG_HID_DRAGONRISE)	+= hid-dr.o
 obj-$(CONFIG_HID_EMS_FF)	+= hid-emsff.o
 obj-$(CONFIG_HID_EGALAX)	+= hid-egalax.o
 obj-$(CONFIG_HID_ELECOM)	+= hid-elecom.o
diff --git a/drivers/hid/hid-dr.c b/drivers/hid/hid-dr.c
new file mode 100644
index 0000000..afcf3d6
--- /dev/null
+++ b/drivers/hid/hid-dr.c
@@ -0,0 +1,197 @@
+/*
+ * Force feedback support for DragonRise Inc. game controllers
+ *
+ * From what I have gathered, these devices are mass produced in China and are
+ * distributed under several vendors. They often share the same design as
+ * the original PlayStation DualShock controller.
+ *
+ * 0079:0006 "DragonRise Inc.   Generic   USB  Joystick  "
+ *  - tested with a Tesun USB-703 game controller.
+ *
+ * Copyright (c) 2009 Richard Walmsley <richwalm@gmail.com>
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/input.h>
+#include <linux/slab.h>
+#include <linux/usb.h>
+#include <linux/hid.h>
+
+#include "hid-ids.h"
+
+#ifdef CONFIG_DRAGONRISE_FF
+#include "usbhid/usbhid.h"
+
+struct drff_device {
+	struct hid_report *report;
+};
+
+static int drff_play(struct input_dev *dev, void *data,
+				 struct ff_effect *effect)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+	struct drff_device *drff = data;
+	int strong, weak;
+
+	strong = effect->u.rumble.strong_magnitude;
+	weak = effect->u.rumble.weak_magnitude;
+
+	dbg_hid("called with 0x%04x 0x%04x", strong, weak);
+
+	if (strong || weak) {
+		strong = strong * 0xff / 0xffff;
+		weak = weak * 0xff / 0xffff;
+
+		/* While reverse engineering this device, I found that when
+		   this value is set, it causes the strong rumble to function
+		   at a near maximum speed, so we'll bypass it. */
+		if (weak == 0x0a)
+			weak = 0x0b;
+
+		drff->report->field[0]->value[0] = 0x51;
+		drff->report->field[0]->value[1] = 0x00;
+		drff->report->field[0]->value[2] = weak;
+		drff->report->field[0]->value[4] = strong;
+		usbhid_submit_report(hid, drff->report, USB_DIR_OUT);
+
+		drff->report->field[0]->value[0] = 0xfa;
+		drff->report->field[0]->value[1] = 0xfe;
+	} else {
+		drff->report->field[0]->value[0] = 0xf3;
+		drff->report->field[0]->value[1] = 0x00;
+	}
+
+	drff->report->field[0]->value[2] = 0x00;
+	drff->report->field[0]->value[4] = 0x00;
+	dbg_hid("running with 0x%02x 0x%02x", strong, weak);
+	usbhid_submit_report(hid, drff->report, USB_DIR_OUT);
+
+	return 0;
+}
+
+static int drff_init(struct hid_device *hid)
+{
+	struct drff_device *drff;
+	struct hid_report *report;
+	struct hid_input *hidinput = list_first_entry(&hid->inputs,
+						struct hid_input, list);
+	struct list_head *report_list =
+			&hid->report_enum[HID_OUTPUT_REPORT].report_list;
+	struct input_dev *dev = hidinput->input;
+	int error;
+
+	if (list_empty(report_list)) {
+		hid_err(hid, "no output reports found\n");
+		return -ENODEV;
+	}
+
+	report = list_first_entry(report_list, struct hid_report, list);
+	if (report->maxfield < 1) {
+		hid_err(hid, "no fields in the report\n");
+		return -ENODEV;
+	}
+
+	if (report->field[0]->report_count < 7) {
+		hid_err(hid, "not enough values in the field\n");
+		return -ENODEV;
+	}
+
+	drff = kzalloc(sizeof(struct drff_device), GFP_KERNEL);
+	if (!drff)
+		return -ENOMEM;
+
+	set_bit(FF_RUMBLE, dev->ffbit);
+
+	error = input_ff_create_memless(dev, drff, drff_play);
+	if (error) {
+		kfree(drff);
+		return error;
+	}
+
+	drff->report = report;
+	drff->report->field[0]->value[0] = 0xf3;
+	drff->report->field[0]->value[1] = 0x00;
+	drff->report->field[0]->value[2] = 0x00;
+	drff->report->field[0]->value[3] = 0x00;
+	drff->report->field[0]->value[4] = 0x00;
+	drff->report->field[0]->value[5] = 0x00;
+	drff->report->field[0]->value[6] = 0x00;
+	usbhid_submit_report(hid, drff->report, USB_DIR_OUT);
+
+	hid_info(hid, "Force Feedback for DragonRise Inc. "
+		 "game controllers by Richard Walmsley <richwalm@gmail.com>\n");
+
+	return 0;
+}
+#else
+static inline int drff_init(struct hid_device *hid)
+{
+	return 0;
+}
+#endif
+
+static int dr_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	int ret;
+
+	dev_dbg(&hdev->dev, "DragonRise Inc. HID hardware probe...");
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "parse failed\n");
+		goto err;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
+	if (ret) {
+		hid_err(hdev, "hw start failed\n");
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
diff --git a/drivers/hid/hid-drff.c b/drivers/hid/hid-drff.c
deleted file mode 100644
index afcf3d6..0000000
--- a/drivers/hid/hid-drff.c
+++ /dev/null
@@ -1,197 +0,0 @@
-/*
- * Force feedback support for DragonRise Inc. game controllers
- *
- * From what I have gathered, these devices are mass produced in China and are
- * distributed under several vendors. They often share the same design as
- * the original PlayStation DualShock controller.
- *
- * 0079:0006 "DragonRise Inc.   Generic   USB  Joystick  "
- *  - tested with a Tesun USB-703 game controller.
- *
- * Copyright (c) 2009 Richard Walmsley <richwalm@gmail.com>
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-#include <linux/input.h>
-#include <linux/slab.h>
-#include <linux/usb.h>
-#include <linux/hid.h>
-
-#include "hid-ids.h"
-
-#ifdef CONFIG_DRAGONRISE_FF
-#include "usbhid/usbhid.h"
-
-struct drff_device {
-	struct hid_report *report;
-};
-
-static int drff_play(struct input_dev *dev, void *data,
-				 struct ff_effect *effect)
-{
-	struct hid_device *hid = input_get_drvdata(dev);
-	struct drff_device *drff = data;
-	int strong, weak;
-
-	strong = effect->u.rumble.strong_magnitude;
-	weak = effect->u.rumble.weak_magnitude;
-
-	dbg_hid("called with 0x%04x 0x%04x", strong, weak);
-
-	if (strong || weak) {
-		strong = strong * 0xff / 0xffff;
-		weak = weak * 0xff / 0xffff;
-
-		/* While reverse engineering this device, I found that when
-		   this value is set, it causes the strong rumble to function
-		   at a near maximum speed, so we'll bypass it. */
-		if (weak == 0x0a)
-			weak = 0x0b;
-
-		drff->report->field[0]->value[0] = 0x51;
-		drff->report->field[0]->value[1] = 0x00;
-		drff->report->field[0]->value[2] = weak;
-		drff->report->field[0]->value[4] = strong;
-		usbhid_submit_report(hid, drff->report, USB_DIR_OUT);
-
-		drff->report->field[0]->value[0] = 0xfa;
-		drff->report->field[0]->value[1] = 0xfe;
-	} else {
-		drff->report->field[0]->value[0] = 0xf3;
-		drff->report->field[0]->value[1] = 0x00;
-	}
-
-	drff->report->field[0]->value[2] = 0x00;
-	drff->report->field[0]->value[4] = 0x00;
-	dbg_hid("running with 0x%02x 0x%02x", strong, weak);
-	usbhid_submit_report(hid, drff->report, USB_DIR_OUT);
-
-	return 0;
-}
-
-static int drff_init(struct hid_device *hid)
-{
-	struct drff_device *drff;
-	struct hid_report *report;
-	struct hid_input *hidinput = list_first_entry(&hid->inputs,
-						struct hid_input, list);
-	struct list_head *report_list =
-			&hid->report_enum[HID_OUTPUT_REPORT].report_list;
-	struct input_dev *dev = hidinput->input;
-	int error;
-
-	if (list_empty(report_list)) {
-		hid_err(hid, "no output reports found\n");
-		return -ENODEV;
-	}
-
-	report = list_first_entry(report_list, struct hid_report, list);
-	if (report->maxfield < 1) {
-		hid_err(hid, "no fields in the report\n");
-		return -ENODEV;
-	}
-
-	if (report->field[0]->report_count < 7) {
-		hid_err(hid, "not enough values in the field\n");
-		return -ENODEV;
-	}
-
-	drff = kzalloc(sizeof(struct drff_device), GFP_KERNEL);
-	if (!drff)
-		return -ENOMEM;
-
-	set_bit(FF_RUMBLE, dev->ffbit);
-
-	error = input_ff_create_memless(dev, drff, drff_play);
-	if (error) {
-		kfree(drff);
-		return error;
-	}
-
-	drff->report = report;
-	drff->report->field[0]->value[0] = 0xf3;
-	drff->report->field[0]->value[1] = 0x00;
-	drff->report->field[0]->value[2] = 0x00;
-	drff->report->field[0]->value[3] = 0x00;
-	drff->report->field[0]->value[4] = 0x00;
-	drff->report->field[0]->value[5] = 0x00;
-	drff->report->field[0]->value[6] = 0x00;
-	usbhid_submit_report(hid, drff->report, USB_DIR_OUT);
-
-	hid_info(hid, "Force Feedback for DragonRise Inc. "
-		 "game controllers by Richard Walmsley <richwalm@gmail.com>\n");
-
-	return 0;
-}
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
-		hid_err(hdev, "parse failed\n");
-		goto err;
-	}
-
-	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
-	if (ret) {
-		hid_err(hdev, "hw start failed\n");
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

