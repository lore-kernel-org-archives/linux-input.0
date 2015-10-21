From: Petri Gynther <pgynther@google.com>
Subject: [PATCH] hid-gfrm: Google Fiber TV Box remote controls
Date: Wed, 21 Oct 2015 12:04:46 -0700
Message-ID: <1445454286-134412-1-git-send-email-pgynther@google.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36244 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755168AbbJUTFC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Oct 2015 15:05:02 -0400
Received: by pacfv9 with SMTP id fv9so65085690pac.3
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2015 12:05:02 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org, dmitry.torokhov@gmail.com, Petri Gynther <pgynther@google.com>

Add HID driver for Google Fiber TV Box remote controls

Signed-off-by: Petri Gynther <pgynther@google.com>
---
 drivers/hid/Kconfig    |   6 ++
 drivers/hid/Makefile   |   1 +
 drivers/hid/hid-gfrm.c | 158 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+)
 create mode 100644 drivers/hid/hid-gfrm.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 6ab51ae..7245b7f 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -257,6 +257,12 @@ config HID_GEMBIRD
 	---help---
 	Support for Gembird JPD-DualForce 2.
 
+config HID_GFRM
+	tristate "Google Fiber TV Box remote control support"
+	depends on HID
+	---help---
+	Support for Google Fiber TV Box remote controls
+
 config HID_HOLTEK
 	tristate "Holtek HID devices"
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index e6441bc..571d176 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_HID_ELECOM)	+= hid-elecom.o
 obj-$(CONFIG_HID_ELO)		+= hid-elo.o
 obj-$(CONFIG_HID_EZKEY)		+= hid-ezkey.o
 obj-$(CONFIG_HID_GEMBIRD)	+= hid-gembird.o
+obj-$(CONFIG_HID_GFRM)		+= hid-gfrm.o
 obj-$(CONFIG_HID_GT683R)	+= hid-gt683r.o
 obj-$(CONFIG_HID_GYRATION)	+= hid-gyration.o
 obj-$(CONFIG_HID_HOLTEK)	+= hid-holtek-kbd.o
diff --git a/drivers/hid/hid-gfrm.c b/drivers/hid/hid-gfrm.c
new file mode 100644
index 0000000..4d7b7e7
--- /dev/null
+++ b/drivers/hid/hid-gfrm.c
@@ -0,0 +1,158 @@
+/*
+ * HID driver for Google Fiber TV Box remote controls
+ *
+ * Copyright (c) 2014-2015 Google Inc.
+ *
+ * Author: Petri Gynther <pgynther@google.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/input.h>
+#include <linux/module.h>
+
+#include "hid-ids.h"
+
+#define GFRM100  1  /* Google Fiber GFRM100 (Bluetooth classic) */
+#define GFRM200  2  /* Google Fiber GFRM200 (Bluetooth LE) */
+
+#define GFRM100_SEARCH_KEY_REPORT_ID   0xF7
+#define GFRM100_SEARCH_KEY_DOWN        0x0
+#define GFRM100_SEARCH_KEY_AUDIO_DATA  0x1
+#define GFRM100_SEARCH_KEY_UP          0x2
+
+static u8 search_key_dn[3] = {0x40, 0x21, 0x02};
+static u8 search_key_up[3] = {0x40, 0x00, 0x00};
+
+static int gfrm_input_mapping(struct hid_device *hdev, struct hid_input *hi,
+		struct hid_field *field, struct hid_usage *usage,
+		unsigned long **bit, int *max)
+{
+	unsigned long hdev_type = (unsigned long) hid_get_drvdata(hdev);
+
+	if (hdev_type == GFRM100) {
+		if (usage->hid == (HID_UP_CONSUMER | 0x4)) {
+			/* Consumer.0004 -> KEY_INFO */
+			hid_map_usage_clear(hi, usage, bit, max, EV_KEY, KEY_INFO);
+			return 1;
+		}
+
+		if (usage->hid == (HID_UP_CONSUMER | 0x41)) {
+			/* Consumer.0041 -> KEY_OK */
+			hid_map_usage_clear(hi, usage, bit, max, EV_KEY, KEY_OK);
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+static int gfrm_raw_event(struct hid_device *hdev, struct hid_report *report,
+		u8 *data, int size)
+{
+	unsigned long hdev_type = (unsigned long) hid_get_drvdata(hdev);
+	int ret = 0;
+
+	if (hdev_type != GFRM100)
+		return 0;
+
+	if (size < 2 || data[0] != GFRM100_SEARCH_KEY_REPORT_ID)
+		return 0;
+
+	/*
+	 * Convert GFRM100 Search key reports into Consumer.0221 (Key.Search)
+	 * reports. Ignore audio data.
+	 */
+	switch (data[1]) {
+	case GFRM100_SEARCH_KEY_DOWN:
+		ret = hid_report_raw_event(hdev, HID_INPUT_REPORT, search_key_dn,
+					   sizeof(search_key_dn), 1);
+		break;
+
+	case GFRM100_SEARCH_KEY_AUDIO_DATA:
+		break;
+
+	case GFRM100_SEARCH_KEY_UP:
+		ret = hid_report_raw_event(hdev, HID_INPUT_REPORT, search_key_up,
+					   sizeof(search_key_up), 1);
+		break;
+
+	default:
+		break;
+	}
+
+	return (ret < 0) ? ret : -1;
+}
+
+static void gfrm_input_configured(struct hid_device *hid, struct hid_input *hidinput)
+{
+	/*
+	 * Enable software autorepeat with:
+	 * - repeat delay: 400 msec
+	 * - repeat period: 100 msec
+	 */
+	input_enable_softrepeat(hidinput->input, 400, 100);
+}
+
+static int gfrm_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	int ret;
+
+	hid_set_drvdata(hdev, (void *) id->driver_data);
+
+	ret = hid_parse(hdev);
+	if (ret)
+		goto done;
+
+	if (id->driver_data == GFRM100) {
+		/*
+		 * GFRM100 HID Report Descriptor does not describe the Search
+		 * key reports. Thus, we need to add it manually here, so that
+		 * those reports reach gfrm_raw_event() from hid_input_report().
+		 */
+		if (!hid_register_report(hdev, HID_INPUT_REPORT,
+					 GFRM100_SEARCH_KEY_REPORT_ID)) {
+			ret = -ENOMEM;
+			goto done;
+		}
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+done:
+	return ret;
+}
+
+static void gfrm_remove(struct hid_device *hdev)
+{
+	hid_hw_stop(hdev);
+	hid_set_drvdata(hdev, NULL);
+}
+
+static const struct hid_device_id gfrm_devices[] = {
+	{ HID_BLUETOOTH_DEVICE(0x58, 0x2000),
+		.driver_data = GFRM100 },
+	{ HID_BLUETOOTH_DEVICE(0x471, 0x2210),
+		.driver_data = GFRM200 },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, gfrm_devices);
+
+static struct hid_driver gfrm_driver = {
+	.name = "gfrm",
+	.id_table = gfrm_devices,
+	.probe = gfrm_probe,
+	.remove = gfrm_remove,
+	.input_mapping = gfrm_input_mapping,
+	.raw_event = gfrm_raw_event,
+	.input_configured = gfrm_input_configured,
+};
+
+module_hid_driver(gfrm_driver);
+
+MODULE_AUTHOR("Petri Gynther <pgynther@google.com>");
+MODULE_DESCRIPTION("Google Fiber TV Box remote control driver");
+MODULE_LICENSE("GPL");
-- 
2.6.0.rc2.230.g3dd15c0

