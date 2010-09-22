From: simon@mungewell.org
Subject: [PATCH] USB: HID: Add support for Logitech Speed Force Wireless gaming wheel
Date: Tue, 21 Sep 2010 23:02:33 -0600
Message-ID: <1285131753-28572-1-git-send-email-simon@mungewell.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from idcmail-mo2no.shaw.ca ([64.59.134.9]:42723 "EHLO
	idcmail-mo2no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab0IVFCv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Sep 2010 01:02:51 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, bonbons@linux-vserver.org, chatty@enac.fr, dhprince-devel@yahoo.co.uk, erazor_de@users.sourceforge.net, dtor@mail.ru, LordCnidarian@gmail.com, lcastelli@gmail.com, sam@ravnborg.org, mmarek@suse.cz, simon <simon@mungewell.org>

From: simon <simon@mungewell.org>

The following patch adds support for the Logitech Speed Force Wireless
gaming wheel. Originally designed for the WII console but it has been
reverse engineered, details:
http://wiibrew.org/wiki/Logitech_USB_steering_wheel

This patch relies on previous patch:
"Don't Send Feature Reports on Interrupt Endpoint"
https://patchwork.kernel.org/patch/198112/

Logitech as produce a very similar wheel for the PS2/PS3, it is
expected that this patch could also support the PS2/PS3 wheel if the
USB ID's are added and (if required) the HID descriptor is modified.

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/Kconfig     |    8 +++
 drivers/hid/Makefile    |    3 +
 drivers/hid/hid-core.c  |    1 +
 drivers/hid/hid-ids.h   |    1 +
 drivers/hid/hid-lg.c    |   38 +++++++++++++
 drivers/hid/hid-lg.h    |    6 ++
 drivers/hid/hid-lg4ff.c |  137 +++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 194 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hid/hid-lg4ff.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 6369ba7..6664c57 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -235,6 +235,14 @@ config LOGIG940_FF
 	  Say Y here if you want to enable force feedback support for Logitech
 	  Flight System G940 devices.
 
+config LOGIWII_FF
+	bool "Logitech Speed Force Wireless force feedback support"
+	depends on HID_LOGITECH
+	select INPUT_FF_MEMLESS
+	help
+	  Say Y here if you want to enable force feedback support for Logitech
+	  Speed Force Wireless (Wii) devices.
+
 config HID_MAGICMOUSE
 	tristate "Apple MagicMouse multi-touch support"
 	depends on BT_HIDP
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 46f037f..d46a455 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -21,6 +21,9 @@ endif
 ifdef CONFIG_LOGIG940_FF
 	hid-logitech-objs	+= hid-lg3ff.o
 endif
+ifdef CONFIG_LOGIWII_FF
+	hid-logitech-objs	+= hid-lg4ff.o
+endif
 
 obj-$(CONFIG_HID_3M_PCT)	+= hid-3m-pct.o
 obj-$(CONFIG_HID_A4TECH)	+= hid-a4tech.o
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 3f72924..19d4547 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1335,6 +1335,7 @@ static const struct hid_device_id hid_blacklist[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOMO_WHEEL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOMO_WHEEL2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G25_WHEEL) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WII_WHEEL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_SPACETRAVELLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_SPACENAVIGATOR) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 765a4f5..6b111e1 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -350,6 +350,7 @@
 #define USB_DEVICE_ID_LOGITECH_WINGMAN_FFG	0xc293
 #define USB_DEVICE_ID_LOGITECH_MOMO_WHEEL	0xc295
 #define USB_DEVICE_ID_LOGITECH_G25_WHEEL	0xc299
+#define USB_DEVICE_ID_LOGITECH_WII_WHEEL	0xc29c
 #define USB_DEVICE_ID_LOGITECH_ELITE_KBD	0xc30a
 #define USB_DEVICE_ID_S510_RECEIVER	0xc50c
 #define USB_DEVICE_ID_S510_RECEIVER_2	0xc517
diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index f6433d8..8989f15 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -19,6 +19,9 @@
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
+#include <linux/random.h>
+#include <linux/sched.h>
+#include <linux/wait.h>
 
 #include "hid-ids.h"
 #include "hid-lg.h"
@@ -35,6 +38,7 @@
 #define LG_FF2			0x400
 #define LG_RDESC_REL_ABS	0x800
 #define LG_FF3			0x1000
+#define LG_FF4			0x2000
 
 /*
  * Certain Logitech keyboards send in report #3 keys which are far
@@ -60,6 +64,17 @@ static void lg_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 				"report descriptor\n");
 		rdesc[33] = rdesc[50] = 0x02;
 	}
+
+	if ((quirks & LG_FF4) && rsize >= 101 &&
+			rdesc[41] == 0x95 && rdesc[42] == 0x0B &&
+			rdesc[47] == 0x05 && rdesc[48] == 0x09) {
+		dev_info(&hdev->dev, "fixing up Logitech Speed Force Wireless "
+			"button descriptor\n");
+		rdesc[41] = 0x05;
+		rdesc[42] = 0x09;
+		rdesc[47] = 0x95;
+		rdesc[48] = 0x0B;
+	}
 }
 
 #define lg_map_key_clear(c)	hid_map_usage_clear(hi, usage, bit, max, \
@@ -285,12 +300,33 @@ static int lg_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err_free;
 	}
 
+	if (quirks & LG_FF4) {
+		unsigned char buf[] = { 0x00, 0xAF,  0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+
+		ret = hdev->hid_output_raw_report(hdev, buf, sizeof(buf), HID_FEATURE_REPORT);
+
+		if (ret >= 0) {
+			/* insert a little delay of 10 jiffies ~ 40ms */
+			wait_queue_head_t wait;
+			init_waitqueue_head (&wait);
+			wait_event_interruptible_timeout(wait, 0, 10);
+
+			/* Select random Address */
+			buf[1] = 0xB2;
+			get_random_bytes(&buf[2], 2);
+
+			ret = hdev->hid_output_raw_report(hdev, buf, sizeof(buf), HID_FEATURE_REPORT);
+		}
+	}
+
 	if (quirks & LG_FF)
 		lgff_init(hdev);
 	if (quirks & LG_FF2)
 		lg2ff_init(hdev);
 	if (quirks & LG_FF3)
 		lg3ff_init(hdev);
+	if (quirks & LG_FF4)
+		lg4ff_init(hdev);
 
 	return 0;
 err_free:
@@ -339,6 +375,8 @@ static const struct hid_device_id lg_devices[] = {
 		.driver_data = LG_FF },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G25_WHEEL),
 		.driver_data = LG_FF },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WII_WHEEL),
+		.driver_data = LG_FF4 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WINGMAN_FFG ),
 		.driver_data = LG_FF },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD2),
diff --git a/drivers/hid/hid-lg.h b/drivers/hid/hid-lg.h
index ce2ac86..b0100ba 100644
--- a/drivers/hid/hid-lg.h
+++ b/drivers/hid/hid-lg.h
@@ -19,4 +19,10 @@ int lg3ff_init(struct hid_device *hdev);
 static inline int lg3ff_init(struct hid_device *hdev) { return -1; }
 #endif
 
+#ifdef CONFIG_LOGIWII_FF
+int lg4ff_init(struct hid_device *hdev);
+#else
+static inline int lg4ff_init(struct hid_device *hdev) { return -1; }
+#endif
+
 #endif
diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
new file mode 100644
index 0000000..f18e135
--- /dev/null
+++ b/drivers/hid/hid-lg4ff.c
@@ -0,0 +1,137 @@
+/*
+ *  Force feedback support for Logitech Speed Force Wireless
+ *
+ *  Reverse Engineered information:
+ *  http://wiibrew.org/wiki/Logitech_USB_steering_wheel
+ *
+ *  Copyright (c) 2010 Simon Wood <simon@mungewell.org>
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
+
+#include <linux/input.h>
+#include <linux/usb.h>
+#include <linux/hid.h>
+
+#include "usbhid/usbhid.h"
+#include "hid-lg.h"
+
+struct lg4ff_device {
+	struct hid_report *report;
+};
+
+static const signed short ff4_wheel_ac[] = {
+	FF_CONSTANT,
+	FF_AUTOCENTER,
+	-1
+};
+
+static int hid_lg4ff_play(struct input_dev *dev, void *data,
+			 struct ff_effect *effect)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+	struct list_head *report_list = &hid->report_enum[HID_OUTPUT_REPORT].report_list;
+	struct hid_report *report = list_entry(report_list->next, struct hid_report, list);
+	int x;
+
+#define CLAMP(x) if (x < 0) x = 0; if (x > 0xff) x = 0xff
+
+	switch (effect->type) {
+	case FF_CONSTANT:
+		x = effect->u.ramp.start_level + 0x80;	/* 0x80 is no force */
+		CLAMP(x);
+		report->field[0]->value[0] = 0x11;	/* Slot 1 */
+		report->field[0]->value[1] = 0x10;
+		report->field[0]->value[2] = x;
+		report->field[0]->value[3] = 0x00;
+		report->field[0]->value[4] = 0x00;
+		report->field[0]->value[5] = 0x08;
+		report->field[0]->value[6] = 0x00;
+		dbg_hid("Autocenter, x=0x%02X\n", x);
+
+		usbhid_submit_report(hid, report, USB_DIR_OUT);
+		break;
+	}
+	return 0;
+}
+
+static void hid_lg4ff_set_autocenter(struct input_dev *dev, u16 magnitude)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+	struct list_head *report_list = &hid->report_enum[HID_OUTPUT_REPORT].report_list;
+	struct hid_report *report = list_entry(report_list->next, struct hid_report, list);
+	__s32 *value = report->field[0]->value;
+
+	*value++ = 0xfe;
+	*value++ = 0x0d;
+	*value++ = 0x07;
+	*value++ = 0x07;
+	*value++ = (magnitude >> 8) & 0xff;
+	*value++ = 0x00;
+	*value = 0x00;
+
+	usbhid_submit_report(hid, report, USB_DIR_OUT);
+}
+
+
+int lg4ff_init(struct hid_device *hid)
+{
+	struct hid_input *hidinput = list_entry(hid->inputs.next, struct hid_input, list);
+	struct list_head *report_list = &hid->report_enum[HID_OUTPUT_REPORT].report_list;
+	struct input_dev *dev = hidinput->input;
+	struct hid_report *report;
+	struct hid_field *field;
+	const signed short *ff_bits = ff4_wheel_ac;
+	int error;
+	int i;
+
+	/* Find the report to use */
+	if (list_empty(report_list)) {
+		err_hid("No output report found");
+		return -1;
+	}
+
+	/* Check that the report looks ok */
+	report = list_entry(report_list->next, struct hid_report, list);
+	if (!report) {
+		err_hid("NULL output report");
+		return -1;
+	}
+
+	field = report->field[0];
+	if (!field) {
+		err_hid("NULL field");
+		return -1;
+	}
+
+	for (i = 0; ff_bits[i] >= 0; i++)
+		set_bit(ff_bits[i], dev->ffbit);
+
+	error = input_ff_create_memless(dev, NULL, hid_lg4ff_play);
+
+	if (error)
+		return error;
+
+	if (test_bit(FF_AUTOCENTER, dev->ffbit))
+		dev->ff->set_autocenter = hid_lg4ff_set_autocenter;
+
+	dev_info(&hid->dev, "Force feedback for Logitech Speed Force Wireless by "
+			"Simon Wood <simon@mungewell.org>\n");
+	return 0;
+}
+
-- 
1.7.0.4

