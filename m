From: Marcel Hasler <mahasler@gmail.com>
Subject: [PATCH 2/2] Add new force feedback driver for Mayflash game
 controller adapters.
Date: Sun, 30 Oct 2016 23:13:13 +0100
Message-ID: <20161030221313.GA15445@arch-desktop>
References: <cover.1477863542.git.mahasler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35625 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754498AbcJ3WNU (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 30 Oct 2016 18:13:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id 68so9212428wmz.2
        for <linux-input@vger.kernel.org>; Sun, 30 Oct 2016 15:13:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1477863542.git.mahasler@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org

Add a new module named hid-mf that implements force feedback for game controller adapters
manufactured by Mayflash. Currently only the PS3 adapter is supported, other adapters still need
to be tested.

Signed-off-by: Marcel Hasler <mahasler@gmail.com>
---
 drivers/hid/Kconfig    |   8 +++
 drivers/hid/Makefile   |   1 +
 drivers/hid/hid-core.c |   1 +
 drivers/hid/hid-mf.c   | 165 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 175 insertions(+)
 create mode 100644 drivers/hid/hid-mf.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index cd4599c..1530d28 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -512,6 +512,14 @@ config HID_MAGICMOUSE
 	Say Y here if you want support for the multi-touch features of the
 	Apple Wireless "Magic" Mouse and the Apple Wireless "Magic" Trackpad.
 
+config HID_MAYFLASH
+	tristate "Mayflash game controller adapter force feedback"
+	depends on HID
+	select INPUT_FF_MEMLESS
+	---help---
+	Say Y here if you have HJZ Mayflash PS3 game controller adapters
+	and want to enable force feedback support.
+
 config HID_MICROSOFT
 	tristate "Microsoft non-fully HID-compliant devices"
 	depends on HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 86b2b57..c0453f1 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_HID_LOGITECH)	+= hid-logitech.o
 obj-$(CONFIG_HID_LOGITECH_DJ)	+= hid-logitech-dj.o
 obj-$(CONFIG_HID_LOGITECH_HIDPP)	+= hid-logitech-hidpp.o
 obj-$(CONFIG_HID_MAGICMOUSE)	+= hid-magicmouse.o
+obj-$(CONFIG_HID_MAYFLASH)	+= hid-mf.o
 obj-$(CONFIG_HID_MICROSOFT)	+= hid-microsoft.o
 obj-$(CONFIG_HID_MONTEREY)	+= hid-monterey.o
 obj-$(CONFIG_HID_MULTITOUCH)	+= hid-multitouch.o
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 2b89c70..8470e22 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1883,6 +1883,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELCOM, USB_DEVICE_ID_DELCOM_VISUAL_IND) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, 0x0006) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, 0x0011) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_PS3) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, USB_DEVICE_ID_DREAM_CHEEKY_WN) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, USB_DEVICE_ID_DREAM_CHEEKY_FA) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084) },
diff --git a/drivers/hid/hid-mf.c b/drivers/hid/hid-mf.c
new file mode 100644
index 0000000..6791ce7
--- /dev/null
+++ b/drivers/hid/hid-mf.c
@@ -0,0 +1,165 @@
+/*
+ * Force feedback support for Mayflash game controller adapters.
+ *
+ * These devices are manufactured by Mayflash but identify themselves
+ * using the vendor ID of DragonRise Inc.
+ *
+ * Tested with:
+ * 0079:1801 "DragonRise Inc. Mayflash PS3 Game Controller Adapter"
+ *
+ * The following adapters probably work too, but need to be tested:
+ * 0079:1800 "DragonRise Inc. Mayflash WIIU Game Controller Adapter"
+ * 0079:1843 "DragonRise Inc. Mayflash GameCube Game Controller Adapter"
+ *
+ * Copyright (c) 2016 Marcel Hasler <mahasler@gmail.com>
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
+ */
+
+#include <linux/input.h>
+#include <linux/slab.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+
+#include "hid-ids.h"
+
+struct mf_device {
+	struct hid_report *report;
+};
+
+static int mf_play(struct input_dev *dev, void *data, struct ff_effect *effect)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+	struct mf_device *mf = data;
+	int strong, weak;
+
+	strong = effect->u.rumble.strong_magnitude;
+	weak = effect->u.rumble.weak_magnitude;
+
+	dbg_hid("Called with 0x%04x 0x%04x.\n", strong, weak);
+
+	strong = strong * 0xff / 0xffff;
+	weak = weak * 0xff / 0xffff;
+
+	dbg_hid("Running with 0x%02x 0x%02x.\n", strong, weak);
+
+	mf->report->field[0]->value[0] = weak;
+	mf->report->field[0]->value[1] = strong;
+	hid_hw_request(hid, mf->report, HID_REQ_SET_REPORT);
+
+	return 0;
+}
+
+static int mf_init(struct hid_device *hid)
+{
+	struct mf_device *mf;
+
+	struct list_head *report_list =
+			&hid->report_enum[HID_OUTPUT_REPORT].report_list;
+
+	struct list_head *report_ptr;
+	struct hid_report *report;
+
+	struct hid_input *input =
+			list_first_entry(&hid->inputs, struct hid_input, list);
+
+	struct input_dev *dev;
+
+	int error;
+
+	/* Setup each of the four inputs */
+	list_for_each(report_ptr, report_list) {
+		report = list_entry(report_ptr, struct hid_report, list);
+
+		if (report->maxfield < 1 || report->field[0]->report_count < 2) {
+			hid_err(hid, "Invalid report, this should never happen!\n");
+			return -ENODEV;
+		}
+
+		if (input == NULL) {
+			hid_err(hid, "Missing input, this should never happen!\n");
+			return -ENODEV;
+		}
+
+		dev = input->input;
+		input = list_next_entry(input, list);
+
+		mf = kzalloc(sizeof(struct mf_device), GFP_KERNEL);
+		if (!mf)
+			return -ENOMEM;
+
+		set_bit(FF_RUMBLE, dev->ffbit);
+
+		error = input_ff_create_memless(dev, mf, mf_play);
+		if (error) {
+			kfree(mf);
+			return error;
+		}
+
+		mf->report = report;
+		mf->report->field[0]->value[0] = 0x00;
+		mf->report->field[0]->value[1] = 0x00;
+		hid_hw_request(hid, mf->report, HID_REQ_SET_REPORT);
+	}
+
+	hid_info(hid, "Force feedback for HJZ Mayflash game controller "
+		      "adapters by Marcel Hasler <mahasler@gmail.com>\n");
+
+	return 0;
+}
+
+static int mf_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	int error;
+
+	dev_dbg(&hdev->dev, "Mayflash HID hardware probe...\n");
+
+	/* Split device into four inputs */
+	hdev->quirks |= HID_QUIRK_MULTI_INPUT;
+
+	error = hid_parse(hdev);
+	if (error) {
+		hid_err(hdev, "HID parse failed.\n");
+		return error;
+	}
+
+	error = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
+	if (error) {
+		hid_err(hdev, "HID hw start failed\n");
+		return error;
+	}
+
+	error = mf_init(hdev);
+	if (error) {
+		hid_err(hdev, "Force feedback init failed.\n");
+		hid_hw_stop(hdev);
+		return error;
+	}
+
+	return 0;
+}
+
+static const struct hid_device_id mf_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_PS3),  },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, mf_devices);
+
+static struct hid_driver mf_driver = {
+	.name = "hid_mf",
+	.id_table = mf_devices,
+	.probe = mf_probe,
+};
+module_hid_driver(mf_driver);
+
+MODULE_LICENSE("GPL");
-- 
2.10.1

