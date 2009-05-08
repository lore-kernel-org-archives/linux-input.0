From: Jussi Kivilinna <jussi.kivilinna@mbnet.fi>
Subject: [PATCH] hid: add force feedback support for SmartJoy PLUS PS2/USB
	adapter
Date: Fri, 08 May 2009 10:46:36 +0300
Message-ID: <20090508074636.16912.55839.stgit@fate.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp4.dnainternet.fi ([87.94.96.72]:49985 "EHLO
	smtp4.dnainternet.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755163AbZEHHqm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 May 2009 03:46:42 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

This driver adds force feedback support for SmartJoy PLUS PS2/USB adapter. I made this driver
one device spesific instead of making generic 'wisegroup-ff' because I have another Wisegroup
PS2/USB adapter that doesn't work same way as SmartJoy PLUS. If another device that is
compatible pops up, this driver could be then renamed to something more generic.

Signed-off-by: Jussi Kivilinna <jussi.kivilinna@mbnet.fi>
---

 drivers/hid/Kconfig      |    8 ++
 drivers/hid/Makefile     |    1 
 drivers/hid/hid-core.c   |    3 +
 drivers/hid/hid-ids.h    |    1 
 drivers/hid/hid-sjoyff.c |  175 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 188 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hid/hid-sjoyff.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 7e67dcb..d473956 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -256,6 +256,14 @@ config GREENASIA_FF
 	(like MANTA Warrior MM816 and SpeedLink Strike2 SL-6635) or adapter
 	and want to enable force feedback support for it.
 
+config SMARTJOYPLUS_FF
+	tristate "SmartJoy PLUS PS2/USB adapter force feedback support"
+	depends on USB_HID
+	select INPUT_FF_MEMLESS
+	---help---
+	Say Y here if you have a SmartJoy PLUS PS2/USB adapter and want to
+	enable force feedback support for it.
+
 config HID_TOPSEED
 	tristate "TopSeed Cyberlink remote control support" if EMBEDDED
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 1f7cb0f..d86c4f1 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_HID_SAMSUNG)	+= hid-samsung.o
 obj-$(CONFIG_HID_SONY)		+= hid-sony.o
 obj-$(CONFIG_HID_SUNPLUS)	+= hid-sunplus.o
 obj-$(CONFIG_GREENASIA_FF)	+= hid-gaff.o
+obj-$(CONFIG_SMARTJOYPLUS_FF)	+= hid-sjoyff.o
 obj-$(CONFIG_THRUSTMASTER_FF)	+= hid-tmff.o
 obj-$(CONFIG_HID_TOPSEED)	+= hid-topseed.o
 obj-$(CONFIG_ZEROPLUS_FF)	+= hid-zpff.o
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 8551693..8a215d4 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1312,6 +1312,9 @@ static const struct hid_device_id hid_blacklist[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb651) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb654) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPSEED, USB_DEVICE_ID_TOPSEED_CYBERLINK) },
+#if defined(CONFIG_SMARTJOYPLUS_FF) || defined(CONFIG_SMARTJOYPLUS_FF_MODULE)
+	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_SMARTJOY_PLUS) },
+#endif
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0005) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0030) },
 
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index aa1b995..61950e2 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -411,6 +411,7 @@
 #define USB_VENDOR_ID_WACOM		0x056a
 
 #define USB_VENDOR_ID_WISEGROUP		0x0925
+#define USB_DEVICE_ID_SMARTJOY_PLUS	0x0005
 #define USB_DEVICE_ID_1_PHIDGETSERVO_20	0x8101
 #define USB_DEVICE_ID_4_PHIDGETSERVO_20	0x8104
 #define USB_DEVICE_ID_8_8_4_IF_KIT	0x8201
diff --git a/drivers/hid/hid-sjoyff.c b/drivers/hid/hid-sjoyff.c
new file mode 100644
index 0000000..0828f72
--- /dev/null
+++ b/drivers/hid/hid-sjoyff.c
@@ -0,0 +1,175 @@
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
+#define debug(format, arg...) pr_debug("hid-sjoyff: " format "\n" , ## arg)
+
+#include <linux/input.h>
+#include <linux/usb.h>
+#include <linux/hid.h>
+#include "hid-ids.h"
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
+	debug("called with 0x%08x 0x%08x", left, right);
+
+	left = left * 0xff / 0xffff;
+	right = (right != 0); /* on/off only */
+
+	sjoyff->report->field[0]->value[1] = right;
+	sjoyff->report->field[0]->value[2] = left;
+	debug("running with 0x%02x 0x%02x", left, right);
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
+
+static int sj_probe(struct hid_device *hdev, const struct hid_device_id *id)
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
+static const struct hid_device_id sj_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_SMARTJOY_PLUS) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, sj_devices);
+
+static struct hid_driver sj_driver = {
+	.name = "smartjoyplus",
+	.id_table = sj_devices,
+	.probe = sj_probe,
+};
+
+static int sj_init(void)
+{
+	return hid_register_driver(&sj_driver);
+}
+
+static void sj_exit(void)
+{
+	hid_unregister_driver(&sj_driver);
+}
+
+module_init(sj_init);
+module_exit(sj_exit);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jussi Kivilinna");
+MODULE_DESCRIPTION("Driver for force feedback support for SmartJoy PLUS PS2/USB"
+	" adapter");

