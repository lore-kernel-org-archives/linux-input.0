From: Bernhard Seibold <mail@bernhard-seibold.de> (by way of Bernhard
	Seibold <mail@bernhard-seibold.de>)
Subject: [PATCH] HID: Driver for Lenovo Keyboard w/ Trackpoint
Date: Fri, 27 May 2011 18:04:23 +0200
Message-ID: <1306512263-8796-1-git-send-email-mail@bernhard-seibold.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mcp.e404.de ([78.47.239.181]:60905 "EHLO mcp.e404.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751044Ab1E0RQY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 May 2011 13:16:24 -0400
Received: from localhost (p4FCED4AE.dip.t-dialin.net [79.206.212.174])
	by mcp.e404.de (Postfix) with ESMTPSA id E6E8B10018B
	for <linux-input@vger.kernel.org>; Fri, 27 May 2011 19:06:55 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Bernhard Seibold <mail@bernhard-seibold.de>

This patch adds support for setting the trackpoint sensitivity
of the "Lenovo ThinkPad USB Keyboard with Trackpoint".

Signed-off-by: Bernhard Seibold <mail@bernhard-seibold.de>
---
 drivers/hid/Kconfig            |   10 +++
 drivers/hid/Makefile           |    1 +
 drivers/hid/hid-core.c         |    1 +
 drivers/hid/hid-ids.h          |    3 +
 drivers/hid/hid-lenovo-tpkbd.c |  166 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 181 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hid/hid-lenovo-tpkbd.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 67d2a75..85028c4 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -224,6 +224,16 @@ config HID_LCPOWER
 	---help---
 	Support for LC-Power RC1000MCE RF remote control.
 
+config HID_LENOVO_TPKBD
+	tristate "Lenovo ThinkPad USB Keyboard with TrackPoint"
+	depends on USB_HID
+	---help---
+	Support for the Lenovo ThinkPad USB Keyboard with TrackPoint.
+
+	Say Y here if you have a Lenovo ThinkPad USB Keyboard with TrackPoint
+	and would like to change the sensitivity of the trackpoint using a
+	sysfs attribute.
+
 config HID_LOGITECH
 	tristate "Logitech devices" if EXPERT
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index f8cc4ea..8dc5890 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_HID_KENSINGTON)	+= hid-kensington.o
 obj-$(CONFIG_HID_KEYTOUCH)	+= hid-keytouch.o
 obj-$(CONFIG_HID_KYE)		+= hid-kye.o
 obj-$(CONFIG_HID_LCPOWER)       += hid-lcpower.o
+obj-$(CONFIG_HID_LENOVO_TPKBD)	+= hid-lenovo-tpkbd.o
 obj-$(CONFIG_HID_LOGITECH)	+= hid-logitech.o
 obj-$(CONFIG_HID_MAGICMOUSE)    += hid-magicmouse.o
 obj-$(CONFIG_HID_MICROSOFT)	+= hid-microsoft.o
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index c957c4b..baee8b0 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1394,6 +1394,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_ERGO_525V) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LABTEC, USB_DEVICE_ID_LABTEC_WIRELESS_KEYBOARD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LCPOWER, USB_DEVICE_ID_LCPOWER_LC1000 ) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPKBD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_MX3000_RECEIVER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_S510_RECEIVER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_S510_RECEIVER_2) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0b374a6..1e1defd 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -413,6 +413,9 @@
 #define USB_DEVICE_ID_LD_HYBRID		0x2090
 #define USB_DEVICE_ID_LD_HEATCONTROL	0x20A0
 
+#define USB_VENDOR_ID_LENOVO		0x17ef
+#define USB_DEVICE_ID_LENOVO_TPKBD	0x6009
+
 #define USB_VENDOR_ID_LOGITECH		0x046d
 #define USB_DEVICE_ID_LOGITECH_RECEIVER	0xc101
 #define USB_DEVICE_ID_LOGITECH_HARMONY_FIRST  0xc110
diff --git a/drivers/hid/hid-lenovo-tpkbd.c b/drivers/hid/hid-lenovo-tpkbd.c
new file mode 100644
index 0000000..90ebc3e
--- /dev/null
+++ b/drivers/hid/hid-lenovo-tpkbd.c
@@ -0,0 +1,166 @@
+/*
+ *  HID driver for Lenovo ThinkPad USB Keyboard with TrackPoint
+ *
+ *  Copyright (c) 2011 Bernhard Seibold
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
+#include <linux/sysfs.h>
+#include <linux/device.h>
+#include <linux/usb.h>
+#include <linux/hid.h>
+#include <linux/input.h>
+#include "usbhid/usbhid.h"
+
+#include "hid-ids.h"
+
+static int lenovo_tpkbd_input_mapping(struct hid_device *hdev,
+		struct hid_input *hi, struct hid_field *field,
+		struct hid_usage *usage, unsigned long **bit, int *max)
+{
+	return 0;
+}
+
+static ssize_t pointer_sensitivity_show(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct hid_device *hdev;
+	struct hid_report *report;
+	hdev = container_of(dev, struct hid_device, dev);
+
+	if (hdev == NULL)
+		return -ENODEV;
+
+	report = hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[4];
+	usbhid_submit_report(hdev, report, USB_DIR_IN);
+	usbhid_wait_io(hdev);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n",
+		report->field[2]->value[0]);
+}
+
+static ssize_t pointer_sensitivity_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t count)
+{
+	struct hid_device *hdev;
+	struct hid_report *report;
+	int value;
+
+	if (kstrtoint(buf, 10, &value) || value < 1 || value > 255)
+		return -EINVAL;
+
+	hdev = container_of(dev, struct hid_device, dev);
+	if (hdev == NULL)
+		return -ENODEV;
+
+	report = hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[4];
+	usbhid_submit_report(hdev, report, USB_DIR_IN);
+	usbhid_wait_io(hdev);
+	report->field[0]->value[0] = 0x6a;
+	report->field[1]->value[0] = 0x03;
+	report->field[2]->value[0] = value;
+	report->field[3]->value[0] = 0x38;
+	usbhid_submit_report(hdev, report, USB_DIR_OUT);
+	return count;
+}
+
+static struct device_attribute dev_attr_pointer_sensitivity =
+	__ATTR(sensitivity, S_IWUSR | S_IRUGO,
+			pointer_sensitivity_show,
+			pointer_sensitivity_store);
+
+static struct attribute *lenovo_tpkbd_attributes_pointer[] = {
+	&dev_attr_pointer_sensitivity.attr,
+	NULL
+};
+
+static const struct attribute_group lenovo_tpkbd_attr_group_pointer = {
+	.attrs = lenovo_tpkbd_attributes_pointer,
+};
+
+static int lenovo_tpkbd_probe(struct hid_device *hdev,
+		const struct hid_device_id *id)
+{
+	int ret;
+	struct usbhid_device *uhdev;
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "hid_parse failed\n");
+		goto err_free;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret) {
+		hid_err(hdev, "hid_hw_start failed\n");
+		goto err_free;
+	}
+
+	uhdev = (struct usbhid_device *) hdev->driver_data;
+
+	if (uhdev->ifnum == 1) {
+		if (sysfs_create_group(&hdev->dev.kobj,
+					&lenovo_tpkbd_attr_group_pointer)) {
+			printk(KERN_WARNING "hid-lenovo-tpkbd: Could not "
+						"create sysfs group\n");
+		}
+
+	}
+
+	return 0;
+err_free:
+	return ret;
+}
+
+static void lenovo_tpkbd_remove(struct hid_device *hdev)
+{
+	struct usbhid_device *uhdev;
+
+	uhdev = (struct usbhid_device *) hdev->driver_data;
+
+	if (uhdev->ifnum == 1)
+		sysfs_remove_group(&hdev->dev.kobj,
+				&lenovo_tpkbd_attr_group_pointer);
+
+	hid_hw_stop(hdev);
+}
+
+static const struct hid_device_id lenovo_tpkbd_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPKBD) },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(hid, lenovo_tpkbd_devices);
+
+static struct hid_driver lenovo_tpkbd_driver = {
+	.name = "lenovo_tpkbd",
+	.id_table = lenovo_tpkbd_devices,
+	.input_mapping = lenovo_tpkbd_input_mapping,
+	.probe = lenovo_tpkbd_probe,
+	.remove = lenovo_tpkbd_remove,
+};
+
+static int __init lenovo_tpkbd_init(void)
+{
+	return hid_register_driver(&lenovo_tpkbd_driver);
+}
+
+static void __exit lenovo_tpkbd_exit(void)
+{
+	hid_unregister_driver(&lenovo_tpkbd_driver);
+}
+
+module_init(lenovo_tpkbd_init);
+module_exit(lenovo_tpkbd_exit);
+
+MODULE_LICENSE("GPL");
-- 
1.7.5.1

