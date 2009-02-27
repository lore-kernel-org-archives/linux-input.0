From: Richard Walmsley <richwalm@gmail.com>
Subject: [PATCH] input: DragonRise Inc. game controller force feedback support
Date: Fri, 27 Feb 2009 14:44:11 +1300
Message-ID: <167575d80902261744h3d133416g1afeb5b68d760cbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:18379 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656AbZB0BoN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Feb 2009 20:44:13 -0500
Received: by rv-out-0506.google.com with SMTP id g37so816577rvb.1
        for <linux-input@vger.kernel.org>; Thu, 26 Feb 2009 17:44:11 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

Adds force feedback support for USB DragonRise Inc. game controllers.
These devices are mass produced in China and distributed under several vendors.

Signed-off-by: Richard Walmsley <richwalm@gmail.com>
---

diff -uprN a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
--- a/drivers/hid/hid-core.c	2009-02-26 11:30:12.000000000 +0100
+++ b/drivers/hid/hid-core.c	2009-02-26 11:43:42.000000000 +0100
@@ -1262,6 +1262,7 @@ static const struct hid_device_id hid_bl
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_BARCODE_1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_BARCODE_2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_MOUSE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, 0x0006) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_EZKEY, USB_DEVICE_ID_BTC_8193) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMERON,
USB_DEVICE_ID_GAMERON_DUAL_PSX_ADAPTOR) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMERON,
USB_DEVICE_ID_GAMERON_DUAL_PCS_ADAPTOR) },
diff -uprN a/drivers/hid/hid-drff.c b/drivers/hid/hid-drff.c
--- a/drivers/hid/hid-drff.c	1970-01-01 01:00:00.000000000 +0100
+++ b/drivers/hid/hid-drff.c	2009-02-26 11:44:52.000000000 +0100
@@ -0,0 +1,193 @@
+/*
+ * Force feedback support for DragonRise Inc. game controllers
+ *
+ * From what I have gathered, these devices are mass produced in China and are
+ * distrubuted under several vendors. They often share the same design as
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
+#include <linux/usb.h>
+#include <linux/hid.h>
+
+#include "hid-ids.h"
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
+	struct hid_input *hidinput = list_entry(hid->inputs.next,
+						struct hid_input, list);
+	struct list_head *report_list =
+			&hid->report_enum[HID_OUTPUT_REPORT].report_list;
+	struct list_head *report_ptr = report_list;
+	struct input_dev *dev = hidinput->input;
+	int error;
+
+	if (list_empty(report_list)) {
+		dev_err(&hid->dev, "no output reports found\n");
+		return -ENODEV;
+	}
+
+	report_ptr = report_ptr->next;
+
+	report = list_entry(report_ptr, struct hid_report, list);
+	if (report->maxfield < 1) {
+		dev_err(&hid->dev, "no fields in the report\n");
+		return -ENODEV;
+	}
+
+	if (report->field[0]->report_count < 7) {
+		dev_err(&hid->dev, "not enough values in the field\n");
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
+	dev_info(&hid->dev, "Force Feedback for DragonRise Inc. game "
+	       "controllers by Richard Walmsley <richwalm@gmail.com>\n");
+
+	return 0;
+}
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
+
+HID_COMPAT_LOAD_DRIVER(dragonrise);
diff -uprN a/drivers/hid/hid-dummy.c b/drivers/hid/hid-dummy.c
--- a/drivers/hid/hid-dummy.c	2009-02-26 11:30:12.000000000 +0100
+++ b/drivers/hid/hid-dummy.c	2009-02-26 11:43:42.000000000 +0100
@@ -28,6 +28,9 @@ static int __init hid_dummy_init(void)
 #ifdef CONFIG_HID_DELL_MODULE
 	HID_COMPAT_CALL_DRIVER(dell);
 #endif
+#ifdef CONFIG_DRAGONRISE_FF_MODULE
+	HID_COMPAT_CALL_DRIVER(dragonrise);
+#endif
 #ifdef CONFIG_HID_EZKEY_MODULE
 	HID_COMPAT_CALL_DRIVER(ezkey);
 #endif
diff -uprN a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
--- a/drivers/hid/hid-ids.h	2009-02-26 11:30:12.000000000 +0100
+++ b/drivers/hid/hid-ids.h	2009-02-26 11:43:42.000000000 +0100
@@ -148,6 +148,8 @@
 #define USB_VENDOR_ID_DMI		0x0c0b
 #define USB_DEVICE_ID_DMI_ENC		0x5fab

+#define USB_VENDOR_ID_DRAGONRISE	0x0079
+
 #define USB_VENDOR_ID_ELO		0x04E7
 #define USB_DEVICE_ID_ELO_TS2700	0x0020

diff -uprN a/drivers/hid/Kconfig b/drivers/hid/Kconfig
--- a/drivers/hid/Kconfig	2009-02-26 11:30:12.000000000 +0100
+++ b/drivers/hid/Kconfig	2009-02-26 11:43:42.000000000 +0100
@@ -128,6 +128,14 @@ config HID_CYPRESS
 	---help---
 	Support for cypress mouse and barcode readers.

+config DRAGONRISE_FF
+	tristate "DragonRise Inc. force feedback support"
+	depends on USB_HID
+	select INPUT_FF_MEMLESS
+	---help---
+	Say Y here if you want to enable force feedback support for DragonRise Inc.
+	game controllers.
+
 config HID_EZKEY
 	tristate "Ezkey" if EMBEDDED
 	depends on USB_HID
diff -uprN a/drivers/hid/Makefile b/drivers/hid/Makefile
--- a/drivers/hid/Makefile	2009-02-26 11:30:12.000000000 +0100
+++ b/drivers/hid/Makefile	2009-02-26 11:43:42.000000000 +0100
@@ -26,6 +26,7 @@ obj-$(CONFIG_HID_BELKIN)	+= hid-belkin.o
 obj-$(CONFIG_HID_CHERRY)	+= hid-cherry.o
 obj-$(CONFIG_HID_CHICONY)	+= hid-chicony.o
 obj-$(CONFIG_HID_CYPRESS)	+= hid-cypress.o
+obj-$(CONFIG_DRAGONRISE_FF)	+= hid-drff.o
 obj-$(CONFIG_HID_EZKEY)		+= hid-ezkey.o
 obj-$(CONFIG_HID_GYRATION)	+= hid-gyration.o
 obj-$(CONFIG_HID_LOGITECH)	+= hid-logitech.o
