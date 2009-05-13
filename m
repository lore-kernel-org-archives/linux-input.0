From: Jussi Kivilinna <jussi.kivilinna@mbnet.fi>
Subject: [PATCH v2] hid: add force feedback support for SmartJoy PLUS PS2/USB
	adapter
Date: Wed, 13 May 2009 10:31:18 +0300
Message-ID: <20090513073118.30072.39923.stgit@fate.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp4.dnainternet.fi ([87.94.96.72]:28371 "EHLO
	smtp4.dnainternet.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbZEMHbY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 May 2009 03:31:24 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Jiri Slaby <jslaby@suse.cz>

This driver adds force feedback support for SmartJoy PLUS PS2/USB adapter. I made this driver
one device spesific instead of making generic 'wisegroup-ff' because I have another Wisegroup
PS2/USB adapter that doesn't work same way as SmartJoy PLUS. If another device that is
compatible pops up, this driver could be then renamed to something more generic.

v2 changes:
 - use pr_fmt
 - remove #ifdef from hid-core.c and made driver unable-to-disable if !EMBEDDED

Signed-off-by: Jussi Kivilinna <jussi.kivilinna@mbnet.fi>
---

 drivers/hid/Kconfig    |   15 ++++
 drivers/hid/Makefile   |    1 
 drivers/hid/hid-core.c |    1 
 drivers/hid/hid-ids.h  |    1 
 drivers/hid/hid-sjoy.c |  182 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 200 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hid/hid-sjoy.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 7e67dcb..939c305 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -256,6 +256,21 @@ config GREENASIA_FF
 	(like MANTA Warrior MM816 and SpeedLink Strike2 SL-6635) or adapter
 	and want to enable force feedback support for it.
 
+config HID_SMARTJOYPLUS
+	tristate "SmartJoy PLUS PS2/USB adapter support" if EMBEDDED
+	depends on USB_HID
+	default !EMBEDDED
+	---help---
+	Support for SmartJoy PLUS PS2/USB adapter.
+
+config SMARTJOYPLUS_FF
+	bool "SmartJoy PLUS PS2/USB adapter force feedback support"
+	depends on HID_SMARTJOYPLUS
+	select INPUT_FF_MEMLESS
+	---help---
+	Say Y here if you have a SmartJoy PLUS PS2/USB adapter and want to
+	enable force feedback support for it.
+
 config HID_TOPSEED
 	tristate "TopSeed Cyberlink remote control support" if EMBEDDED
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 1f7cb0f..2ba82ce 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_HID_NTRIG)		+= hid-ntrig.o
 obj-$(CONFIG_HID_PANTHERLORD)	+= hid-pl.o
 obj-$(CONFIG_HID_PETALYNX)	+= hid-petalynx.o
 obj-$(CONFIG_HID_SAMSUNG)	+= hid-samsung.o
+obj-$(CONFIG_HID_SMARTJOYPLUS)	+= hid-sjoy.o
 obj-$(CONFIG_HID_SONY)		+= hid-sony.o
 obj-$(CONFIG_HID_SUNPLUS)	+= hid-sunplus.o
 obj-$(CONFIG_GREENASIA_FF)	+= hid-gaff.o
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 8551693..b485ac2 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1312,6 +1312,7 @@ static const struct hid_device_id hid_blacklist[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb651) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb654) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPSEED, USB_DEVICE_ID_TOPSEED_CYBERLINK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_SMARTJOY_PLUS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0005) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0030) },
 
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 4d5ee2b..faf20c5 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -416,6 +416,7 @@
 #define USB_VENDOR_ID_WACOM		0x056a
 
 #define USB_VENDOR_ID_WISEGROUP		0x0925
+#define USB_DEVICE_ID_SMARTJOY_PLUS	0x0005
 #define USB_DEVICE_ID_1_PHIDGETSERVO_20	0x8101
 #define USB_DEVICE_ID_4_PHIDGETSERVO_20	0x8104
 #define USB_DEVICE_ID_8_8_4_IF_KIT	0x8201
diff --git a/drivers/hid/hid-sjoy.c b/drivers/hid/hid-sjoy.c
new file mode 100644
index 0000000..bc0c94d
--- /dev/null
+++ b/drivers/hid/hid-sjoy.c
@@ -0,0 +1,182 @@
+/*
+ *  Force feedback support for SmartJoy PLUS PS2->USB adapter
+ *
+ *  Copyright (c) 2009 Jussi Kivilinna <jussi.kivilinna@mbnet.fi>
+ *
+ *  Based of hid-pl.c and hid-gaff.c
+ *   Copyright (c) 2007, 2009 Anssi Hannula <anssi.hannula@gmail.com>
+ *   Copyright (c) 2008 Lukasz Lubojanski <lukasz@lubojanski.info>
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
+/* #define DEBUG */
+
+#define pr_fmt(fmt) "hid-sjoyff: " fmt "\n"
+
+#include <linux/input.h>
+#include <linux/usb.h>
+#include <linux/hid.h>
+#include "hid-ids.h"
+
+#ifdef CONFIG_SMARTJOYPLUS_FF
+#include "usbhid/usbhid.h"
+
+struct sjoyff_device {
+	struct hid_report *report;
+};
+
+static int hid_sjoyff_play(struct input_dev *dev, void *data,
+			 struct ff_effect *effect)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+	struct sjoyff_device *sjoyff = data;
+	u32 left, right;
+
+	left = effect->u.rumble.strong_magnitude;
+	right = effect->u.rumble.weak_magnitude;
+	pr_debug("called with 0x%08x 0x%08x", left, right);
+
+	left = left * 0xff / 0xffff;
+	right = (right != 0); /* on/off only */
+
+	sjoyff->report->field[0]->value[1] = right;
+	sjoyff->report->field[0]->value[2] = left;
+	pr_debug("running with 0x%02x 0x%02x", left, right);
+	usbhid_submit_report(hid, sjoyff->report, USB_DIR_OUT);
+
+	return 0;
+}
+
+static int sjoyff_init(struct hid_device *hid)
+{
+	struct sjoyff_device *sjoyff;
+	struct hid_report *report;
+	struct hid_input *hidinput = list_entry(hid->inputs.next,
+						struct hid_input, list);
+	struct list_head *report_list =
+			&hid->report_enum[HID_OUTPUT_REPORT].report_list;
+	struct list_head *report_ptr = report_list;
+	struct input_dev *dev;
+	int error;
+
+	if (list_empty(report_list)) {
+		dev_err(&hid->dev, "no output reports found\n");
+		return -ENODEV;
+	}
+
+	report_ptr = report_ptr->next;
+
+	if (report_ptr == report_list) {
+		dev_err(&hid->dev, "required output report is "
+				"missing\n");
+		return -ENODEV;
+	}
+
+	report = list_entry(report_ptr, struct hid_report, list);
+	if (report->maxfield < 1) {
+		dev_err(&hid->dev, "no fields in the report\n");
+		return -ENODEV;
+	}
+
+	if (report->field[0]->report_count < 3) {
+		dev_err(&hid->dev, "not enough values in the field\n");
+		return -ENODEV;
+	}
+
+	sjoyff = kzalloc(sizeof(struct sjoyff_device), GFP_KERNEL);
+	if (!sjoyff)
+		return -ENOMEM;
+
+	dev = hidinput->input;
+
+	set_bit(FF_RUMBLE, dev->ffbit);
+
+	error = input_ff_create_memless(dev, sjoyff, hid_sjoyff_play);
+	if (error) {
+		kfree(sjoyff);
+		return error;
+	}
+
+	sjoyff->report = report;
+	sjoyff->report->field[0]->value[0] = 0x01;
+	sjoyff->report->field[0]->value[1] = 0x00;
+	sjoyff->report->field[0]->value[2] = 0x00;
+	usbhid_submit_report(hid, sjoyff->report, USB_DIR_OUT);
+
+	dev_info(&hid->dev,
+		"Force feedback for SmartJoy PLUS PS2/USB adapter\n");
+
+	return 0;
+}
+#else
+static inline int sjoyff_init(struct hid_device *hid)
+{
+	return 0;
+}
+#endif
+
+static int sjoy_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	int ret;
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
+	sjoyff_init(hdev);
+
+	return 0;
+err:
+	return ret;
+}
+
+static const struct hid_device_id sjoy_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_SMARTJOY_PLUS) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, sjoy_devices);
+
+static struct hid_driver sjoy_driver = {
+	.name = "smartjoyplus",
+	.id_table = sjoy_devices,
+	.probe = sjoy_probe,
+};
+
+static int sjoy_init(void)
+{
+	return hid_register_driver(&sjoy_driver);
+}
+
+static void sjoy_exit(void)
+{
+	hid_unregister_driver(&sjoy_driver);
+}
+
+module_init(sjoy_init);
+module_exit(sjoy_exit);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jussi Kivilinna");
+

