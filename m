From: Ben Chen <ben_chen@bizlinktech.com>
Subject: [PATCH v2 1/1] Support for CMedia CM6533 HID audio jack controls
Date: Wed, 30 Dec 2015 15:35:04 +0800
Message-ID: <1451460904-7959-1-git-send-email-ben_chen@bizlinktech.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:32997 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbbL3Hfe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Dec 2015 02:35:34 -0500
Received: by mail-pa0-f44.google.com with SMTP id cy9so135101481pac.0
        for <linux-input@vger.kernel.org>; Tue, 29 Dec 2015 23:35:34 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Ben Chen <ben_chen@bizlinktech.com>

The C-Media CM6533 is a USB audio chip featuring it's jack detection capability.The device originates an interrupt transfer via HID interface each time when a jack event occurs.
The purpose of this patch is to handle hid raw events to keep the operating system informed of user interactions.

Signed-off-by: Ben Chen <ben_chen@bizlinktech.com>
---
Changes in v2:
- The return type of input_configured callback has been changed from void to be int.

 drivers/hid/Kconfig      |   6 ++
 drivers/hid/Makefile     |   1 +
 drivers/hid/hid-cm6533.c | 168 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-core.c   |   1 +
 drivers/hid/hid-ids.h    |   1 +
 5 files changed, 177 insertions(+)
 create mode 100644 drivers/hid/hid-cm6533.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 513a16c..4e0ca39 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -196,6 +196,12 @@ config HID_PRODIKEYS
 	  multimedia keyboard, but will lack support for the musical keyboard
 	  and some additional multimedia keys.
 
+config HID_CM6533
+	tristate "CMedia CM6533 HID audio jack controls"
+	depends on HID
+	---help---
+	Support for CMedia CM6533 HID audio jack controls.
+
 config HID_CP2112
 	tristate "Silicon Labs CP2112 HID USB-to-SMBus Bridge support"
 	depends on USB_HID && I2C && GPIOLIB
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 00011fe..63f99bd 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_HID_BELKIN)	+= hid-belkin.o
 obj-$(CONFIG_HID_BETOP_FF)	+= hid-betopff.o
 obj-$(CONFIG_HID_CHERRY)	+= hid-cherry.o
 obj-$(CONFIG_HID_CHICONY)	+= hid-chicony.o
+obj-$(CONFIG_HID_CM6533)	+= hid-cm6533.o
 obj-$(CONFIG_HID_CORSAIR)	+= hid-corsair.o
 obj-$(CONFIG_HID_CP2112)	+= hid-cp2112.o
 obj-$(CONFIG_HID_CYPRESS)	+= hid-cypress.o
diff --git a/drivers/hid/hid-cm6533.c b/drivers/hid/hid-cm6533.c
new file mode 100644
index 0000000..7230f85
--- /dev/null
+++ b/drivers/hid/hid-cm6533.c
@@ -0,0 +1,168 @@
+/*
+ * HID driver for CMedia CM6533 audio jack controls
+ *
+ * Copyright (C) 2015 Ben Chen <ben_chen@bizlinktech.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+#include "hid-ids.h"
+
+MODULE_AUTHOR("Ben Chen");
+MODULE_DESCRIPTION("CM6533 HID jack controls");
+MODULE_LICENSE("GPL");
+
+#define CM6533_JD_TYPE_COUNT      1
+#define CM6533_JD_RAWEV_LEN	 16
+#define CM6533_JD_SFX_OFFSET	  8
+
+/*
+*
+*CM6533 audio jack HID raw events:
+*
+*Plug in:
+*01000600 002083xx 080008c0 10000000
+*about 3 seconds later...
+*01000a00 002083xx 08000380 10000000
+*01000600 002083xx 08000380 10000000
+*
+*Plug out:
+*01000400 002083xx 080008c0 x0000000
+*/
+
+static const u8 ji_sfx[] = { 0x08, 0x00, 0x08, 0xc0 };
+static const u8 ji_in[]  = { 0x01, 0x00, 0x06, 0x00 };
+static const u8 ji_out[] = { 0x01, 0x00, 0x04, 0x00 };
+
+static int jack_switch_types[CM6533_JD_TYPE_COUNT] = {
+	SW_HEADPHONE_INSERT,
+};
+
+struct cmhid {
+	struct input_dev *input_dev;
+	struct hid_device *hid;
+	unsigned short switch_map[CM6533_JD_TYPE_COUNT];
+};
+
+static void hp_ev(struct hid_device *hid, struct cmhid *cm, int value)
+{
+	input_report_switch(cm->input_dev, SW_HEADPHONE_INSERT, value);
+	input_sync(cm->input_dev);
+}
+
+static int cmhid_raw_event(struct hid_device *hid, struct hid_report *report,
+	 u8 *data, int len)
+{
+	struct cmhid *cm = hid_get_drvdata(hid);
+
+	if (len != CM6533_JD_RAWEV_LEN)
+		goto out;
+	if (memcmp(data+CM6533_JD_SFX_OFFSET, ji_sfx, sizeof(ji_sfx)))
+		goto out;
+
+	if (!memcmp(data, ji_out, sizeof(ji_out))) {
+		hp_ev(hid, cm, 0);
+		goto out;
+	}
+	if (!memcmp(data, ji_in, sizeof(ji_in))) {
+		hp_ev(hid, cm, 1);
+		goto out;
+	}
+
+out:
+	return 0;
+}
+
+static int cmhid_input_configured(struct hid_device *hid,
+		struct hid_input *hidinput)
+{
+	struct input_dev *input_dev = hidinput->input;
+	struct cmhid *cm = hid_get_drvdata(hid);
+	int i;
+
+	cm->input_dev = input_dev;
+	memcpy(cm->switch_map, jack_switch_types, sizeof(cm->switch_map));
+	input_dev->evbit[0] = BIT(EV_SW);
+	for (i = 0; i < CM6533_JD_TYPE_COUNT; i++)
+		input_set_capability(cm->input_dev,
+				EV_SW, jack_switch_types[i]);
+	return 0;
+}
+
+static int cmhid_input_mapping(struct hid_device *hid,
+		struct hid_input *hi, struct hid_field *field,
+		struct hid_usage *usage, unsigned long **bit, int *max)
+{
+	return -1;
+}
+
+static int cmhid_probe(struct hid_device *hid, const struct hid_device_id *id)
+{
+	int ret;
+	struct cmhid *cm;
+
+	cm = kzalloc(sizeof(struct cmhid), GFP_KERNEL);
+	if (!cm) {
+		ret = -ENOMEM;
+		goto allocfail;
+	}
+
+	cm->hid = hid;
+
+	hid->quirks |= HID_QUIRK_HIDINPUT_FORCE;
+	hid_set_drvdata(hid, cm);
+
+	ret = hid_parse(hid);
+	if (ret) {
+		hid_err(hid, "parse failed\n");
+		goto fail;
+	}
+
+	ret = hid_hw_start(hid, HID_CONNECT_DEFAULT | HID_CONNECT_HIDDEV_FORCE);
+	if (ret) {
+		hid_err(hid, "hw start failed\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	kfree(cm);
+allocfail:
+	return ret;
+}
+
+static void cmhid_remove(struct hid_device *hid)
+{
+	struct cmhid *cm = hid_get_drvdata(hid);
+
+	hid_hw_stop(hid);
+	kfree(cm);
+}
+
+static const struct hid_device_id cmhid_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CMEDIA, USB_DEVICE_ID_CM6533) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, cmhid_devices);
+
+static struct hid_driver cmhid_driver = {
+	.name = "cm6533_jd",
+	.id_table = cmhid_devices,
+	.raw_event = cmhid_raw_event,
+	.input_configured = cmhid_input_configured,
+	.probe = cmhid_probe,
+	.remove = cmhid_remove,
+	.input_mapping = cmhid_input_mapping,
+};
+module_hid_driver(cmhid_driver);
+
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index c6f7a69..d8e55fe 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2056,6 +2056,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_WIIMOTE) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_WIIMOTE2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_RAZER, USB_DEVICE_ID_RAZER_BLADE_14) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CMEDIA, USB_DEVICE_ID_CM6533) },
 	{ }
 };
 
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 9024a3d..86fa1e6 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -246,6 +246,7 @@
 
 #define USB_VENDOR_ID_CMEDIA		0x0d8c
 #define USB_DEVICE_ID_CM109		0x000e
+#define USB_DEVICE_ID_CM6533		0x0022
 
 #define USB_VENDOR_ID_CODEMERCS		0x07c0
 #define USB_DEVICE_ID_CODEMERCS_IOW_FIRST	0x1500
-- 
1.9.1

