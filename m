From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@gmail.com>
Subject: Re: [PATCH] Fix autocentering command in hid-lgff driver
Date: Wed, 06 Jul 2011 01:04:37 +0200
Message-ID: <2081474.DKLA3NlTRQ@qosmio-x300>
References: <2502891.N5kVV5at6b@qosmio-x300> <4E0AF022.8020609@m-bauer.org> <b4f74749ffdf35c88a0523a6a5f1a31b.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:58906 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566Ab1GEXEn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 19:04:43 -0400
Received: by fxd18 with SMTP id 18so6610899fxd.11
        for <linux-input@vger.kernel.org>; Tue, 05 Jul 2011 16:04:41 -0700 (PDT)
In-Reply-To: <b4f74749ffdf35c88a0523a6a5f1a31b.squirrel@host171.canaca.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: Michael Bauer <michael@m-bauer.org>, linux-input@vger.kernel.org, peter@slim-one.de

Hello everone,

I challenged myself a bit so there is a preliminary version of reworked lg4ff driver. It has basic implementation of the sysfs 
interface and it can be used to change wheel's range. Currently only DFP is supported but adding the G2x/DFGT 
command will be a piece of cake.
It applies to 3.0-rc5 and depends Michael B.'s DFP descriptor patch. At also depends on a trivial patch which adds 
support for DFGT (included). I wonder if the driver handles multiple devices properly. If I understand it correctly it should 
be OK, but I can't test it myself.

Things to do are:
- Add range setting for G2x/DFGT
- Add wheel identification based on revision number
- Add native/fallback switching
- Clean up the code, make it more unified
- Add the rest of FF effects, will most likely need a patched ff_memless

Regards, Michal.

>From 65d77958097fa4b1e71f033822dbcdc441999bb8 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@gmail.com>
Date: Mon, 4 Jul 2011 14:18:07 +0200
Subject: [PATCH 2/3] Added Driving Force GT product ID.

---
 drivers/hid/hid-ids.h |    1 +
 drivers/hid/hid-lg.c  |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index a756ee6..79ba659 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -433,6 +433,7 @@
 #define USB_DEVICE_ID_LOGITECH_MOMO_WHEEL	0xc295
 #define USB_DEVICE_ID_LOGITECH_DFP_WHEEL	0xc298
 #define USB_DEVICE_ID_LOGITECH_G25_WHEEL	0xc299
+#define USB_DEVICE_ID_LOGITECH_DFGT_WHEEL	0xc29a
 #define USB_DEVICE_ID_LOGITECH_G27_WHEEL	0xc29b
 #define USB_DEVICE_ID_LOGITECH_WII_WHEEL	0xc29c
 #define USB_DEVICE_ID_LOGITECH_ELITE_KBD	0xc30a
diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index a15ce9e..52e8d65 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -452,6 +452,8 @@ static const struct hid_device_id lg_devices[] = {
 		.driver_data = LG_FF },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_DFP_WHEEL),
 		.driver_data = LG_NOGET | LG_FF },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_DFGT_WHEEL),
+		.driver_data = LG_FF },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WII_WHEEL),
 		.driver_data = LG_FF4 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WINGMAN_FFG ),
-- 
1.7.6

>From 7992434338d39959b26cdc1bed39a2a0f2afd59b Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@gmail.com>
Date: Wed, 6 Jul 2011 00:36:10 +0200
Subject: [PATCH 3/3] - Moved all Logitech wheel force feedback handling to
 lg4ff driver - Added basic sysfs support to se wheel's
 range (if supported). Currently   available for Driving
 Force pro only

---
 drivers/hid/hid-lg.c    |   26 +++++---
 drivers/hid/hid-lg.h    |    2 +
 drivers/hid/hid-lg4ff.c |  181 +++++++++++++++++++++++++++++++++++++++++------
 drivers/hid/hid-lgff.c  |    7 --
 4 files changed, 179 insertions(+), 37 deletions(-)

diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index 52e8d65..be77789 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -362,7 +362,7 @@ static int lg_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err_free;
 	}
 
-	if (quirks & (LG_FF | LG_FF2 | LG_FF3))
+	if (quirks & (LG_FF | LG_FF2 | LG_FF3 | LG_FF4))
 		connect_mask &= ~HID_CONNECT_FF;
 
 	ret = hid_hw_start(hdev, connect_mask);
@@ -371,7 +371,8 @@ static int lg_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err_free;
 	}
 
-	if (quirks & LG_FF4) {
+	/* Setup wireless link with Logitech Wii wheel */
+	if(hdev->product == USB_DEVICE_ID_LOGITECH_WII_WHEEL) {
 		unsigned char buf[] = { 0x00, 0xAF,  0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
 
 		ret = hdev->hid_output_raw_report(hdev, buf, sizeof(buf), HID_FEATURE_REPORT);
@@ -404,6 +405,12 @@ err_free:
 	return ret;
 }
 
+static void lg_remove(struct hid_device *hdev)
+{
+	if(hdev->quirks & LG_FF4)
+		lg4ff_deinit(hdev);
+}
+
 static const struct hid_device_id lg_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_MX3000_RECEIVER),
 		.driver_data = LG_RDESC | LG_WIRELESS },
@@ -430,7 +437,7 @@ static const struct hid_device_id lg_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_EXTREME_3D),
 		.driver_data = LG_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WHEEL),
-		.driver_data = LG_NOGET | LG_FF },
+		.driver_data = LG_NOGET | LG_FF4 },
 
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD_CORD),
 		.driver_data = LG_FF2 },
@@ -443,17 +450,17 @@ static const struct hid_device_id lg_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_FORCE3D_PRO),
 		.driver_data = LG_FF },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOMO_WHEEL),
-		.driver_data = LG_FF },
+		.driver_data = LG_FF4 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOMO_WHEEL2),
-		.driver_data = LG_FF },
+		.driver_data = LG_FF4 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G25_WHEEL),
-		.driver_data = LG_FF },
+		.driver_data = LG_FF4 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G27_WHEEL),
-		.driver_data = LG_FF },
+		.driver_data = LG_FF4 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_DFP_WHEEL),
-		.driver_data = LG_NOGET | LG_FF },
+		.driver_data = LG_NOGET | LG_FF4 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_DFGT_WHEEL),
-		.driver_data = LG_FF },
+		.driver_data = LG_FF4 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WII_WHEEL),
 		.driver_data = LG_FF4 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WINGMAN_FFG ),
@@ -479,6 +486,7 @@ static struct hid_driver lg_driver = {
 	.input_mapped = lg_input_mapped,
 	.event = lg_event,
 	.probe = lg_probe,
+	.remove = lg_remove
 };
 
 static int __init lg_init(void)
diff --git a/drivers/hid/hid-lg.h b/drivers/hid/hid-lg.h
index b0100ba..3a32959 100644
--- a/drivers/hid/hid-lg.h
+++ b/drivers/hid/hid-lg.h
@@ -21,8 +21,10 @@ static inline int lg3ff_init(struct hid_device *hdev) { return -1; }
 
 #ifdef CONFIG_LOGIWII_FF
 int lg4ff_init(struct hid_device *hdev);
+int lg4ff_deinit(struct hid_device *hdev);
 #else
 static inline int lg4ff_init(struct hid_device *hdev) { return -1; }
+static inline int lg4ff_deinit(struct hid_device *hdev) { return -1; }
 #endif
 
 #endif
diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index fa550c8..b3bcf06 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -29,19 +29,43 @@
 
 #include "usbhid/usbhid.h"
 #include "hid-lg.h"
+#include "hid-ids.h"
 
-struct lg4ff_device {
-	struct hid_report *report;
-};
+#define to_hid_device(pdev) container_of(pdev, struct hid_device, dev)
+
+unsigned short ff4_wheel_range;
+
+static void hid_lg4ff_set_autocenter_default(struct input_dev *hid, u16 magnitude);
+void (*hid_ff4_set_range)(struct hid_device *hid, u16 range);
+static ssize_t ff4_range_show(struct device *dev, struct device_attribute *attr, char *buf);
+static ssize_t ff4_range_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count);
+
+static DEVICE_ATTR(range_set, S_IWUSR | S_IRUGO, ff4_range_show, ff4_range_store);
 
-static const signed short ff4_wheel_ac[] = {
+static const signed short ff4_wheel_effects[] = {
 	FF_CONSTANT,
 	FF_AUTOCENTER,
 	-1
 };
 
-static int hid_lg4ff_play(struct input_dev *dev, void *data,
-			 struct ff_effect *effect)
+struct ff4_wheel_device {
+	__u32 product_id;
+	const signed short *ff_effects;
+	void (*set_autocenter)(struct input_dev *dev, u16 magnitude);
+	const int adj_range;	/* 0 - Not available, 1 - G2x/DFGT command, 2 - DFP command */
+};
+
+static const struct ff4_wheel_device ff4_devices[] = {
+	{USB_DEVICE_ID_LOGITECH_WHEEL,       ff4_wheel_effects, hid_lg4ff_set_autocenter_default, 0},
+	{USB_DEVICE_ID_LOGITECH_MOMO_WHEEL,  ff4_wheel_effects, hid_lg4ff_set_autocenter_default, 0},
+	{USB_DEVICE_ID_LOGITECH_DFP_WHEEL,   ff4_wheel_effects, hid_lg4ff_set_autocenter_default, 2},
+	{USB_DEVICE_ID_LOGITECH_G25_WHEEL,   ff4_wheel_effects, hid_lg4ff_set_autocenter_default, 1},
+	{USB_DEVICE_ID_LOGITECH_DFGT_WHEEL,  ff4_wheel_effects, hid_lg4ff_set_autocenter_default, 1},
+	{USB_DEVICE_ID_LOGITECH_G27_WHEEL,   ff4_wheel_effects, hid_lg4ff_set_autocenter_default, 1},
+	{USB_DEVICE_ID_LOGITECH_MOMO_WHEEL2, ff4_wheel_effects, hid_lg4ff_set_autocenter_default, 0}
+};
+
+static int hid_lg4ff_play(struct input_dev *dev, void *data, struct ff_effect *effect)
 {
 	struct hid_device *hid = input_get_drvdata(dev);
 	struct list_head *report_list = &hid->report_enum[HID_OUTPUT_REPORT].report_list;
@@ -55,11 +79,11 @@ static int hid_lg4ff_play(struct input_dev *dev, void *data,
 		x = effect->u.ramp.start_level + 0x80;	/* 0x80 is no force */
 		CLAMP(x);
 		report->field[0]->value[0] = 0x11;	/* Slot 1 */
-		report->field[0]->value[1] = 0x10;
+		report->field[0]->value[1] = 0x08;
 		report->field[0]->value[2] = x;
-		report->field[0]->value[3] = 0x00;
+		report->field[0]->value[3] = 0x80;
 		report->field[0]->value[4] = 0x00;
-		report->field[0]->value[5] = 0x08;
+		report->field[0]->value[5] = 0x00;
 		report->field[0]->value[6] = 0x00;
 		dbg_hid("Autocenter, x=0x%02X\n", x);
 
@@ -69,7 +93,9 @@ static int hid_lg4ff_play(struct input_dev *dev, void *data,
 	return 0;
 }
 
-static void hid_lg4ff_set_autocenter(struct input_dev *dev, u16 magnitude)
+/* Sends default autocentering command compatible with
+ * all wheels except Formula Force EX */
+static void hid_lg4ff_set_autocenter_default(struct input_dev *dev, u16 magnitude)
 {
 	struct hid_device *hid = input_get_drvdata(dev);
 	struct list_head *report_list = &hid->report_enum[HID_OUTPUT_REPORT].report_list;
@@ -78,15 +104,88 @@ static void hid_lg4ff_set_autocenter(struct input_dev *dev, u16 magnitude)
 
 	*value++ = 0xfe;
 	*value++ = 0x0d;
-	*value++ = 0x07;
-	*value++ = 0x07;
-	*value++ = (magnitude >> 8) & 0xff;
+	*value++ = magnitude >> 13;
+	*value++ = magnitude >> 13;
+	*value++ = magnitude >> 8;
 	*value++ = 0x00;
 	*value = 0x00;
 
 	usbhid_submit_report(hid, report, USB_DIR_OUT);
 }
 
+/* Sends commands to set range compatible with Driving Force Pro wheel */
+static void hid_lg4ff_set_range_dfp(struct hid_device *hid, u16 range)
+{
+	struct list_head *report_list = &hid->report_enum[HID_OUTPUT_REPORT].report_list;
+	struct hid_report *report = list_entry(report_list->next, struct hid_report, list);
+	int start_left, start_right, full_range;
+	dbg_hid("Driving Force Pro: setting range to %u\n", range);
+	
+	/* Prepare "coarse" limit command */
+	report->field[0]->value[0] = 0xf8;
+	report->field[0]->value[1] = 0x00; 	/* Set later */
+	report->field[0]->value[2] = 0x00;
+	report->field[0]->value[3] = 0x00;
+	report->field[0]->value[4] = 0x00;
+	report->field[0]->value[5] = 0x00;
+	report->field[0]->value[6] = 0x00;
+    
+	if(range > 200) {
+		report->field[0]->value[1] = 0x03;
+		full_range = 900;
+	} else {
+		report->field[0]->value[1] = 0x02;
+		full_range = 200;
+	}
+	usbhid_submit_report(hid, report, USB_DIR_OUT);
+	
+	/* Prepare "fine" limit command */
+	report->field[0]->value[0] = 0x81;
+	report->field[0]->value[1] = 0x0b;
+	report->field[0]->value[2] = 0x00;
+	report->field[0]->value[3] = 0x00;
+	report->field[0]->value[4] = 0x00;
+	report->field[0]->value[5] = 0x00;
+	report->field[0]->value[6] = 0x00;
+	
+	if(range == 200 || range == 900) {	/* Do not apply any fine limit */
+		usbhid_submit_report(hid, report, USB_DIR_OUT);
+		ff4_wheel_range = range;
+		return;
+	}
+
+	/* Construct range limiting command */
+	start_left = (((full_range - range + 1) * 2047) / full_range);
+	start_right = 0xfff - start_left;
+
+	report->field[0]->value[2] = start_left >> 4;
+	report->field[0]->value[3] = start_right >> 4;
+	report->field[0]->value[4] = 0xff;
+	report->field[0]->value[5] = (start_right & 0xe) << 4 | (start_left & 0xe);
+	report->field[0]->value[6] = 0xff;
+
+	usbhid_submit_report(hid, report, USB_DIR_OUT);
+	ff4_wheel_range = range;
+}
+
+/* Read current range and display it in terminal */
+static ssize_t ff4_range_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%d\n", ff4_wheel_range);
+}
+
+/* Set range to user specified value, call appropriate function
+ * according to the type of the wheel */
+static ssize_t ff4_range_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+{
+	u16 range = simple_strtoul(buf, NULL, 10);
+	/* Check that the range is within margins and that the wheel
+	 * supports setting a custom range */
+	if(range > 39 && range < 901 && hid_ff4_set_range != 0)
+		hid_ff4_set_range(to_hid_device(dev), range);
+
+	return count;
+}
 
 int lg4ff_init(struct hid_device *hid)
 {
@@ -95,9 +194,7 @@ int lg4ff_init(struct hid_device *hid)
 	struct input_dev *dev = hidinput->input;
 	struct hid_report *report;
 	struct hid_field *field;
-	const signed short *ff_bits = ff4_wheel_ac;
-	int error;
-	int i;
+	int error, i, j;
 
 	/* Find the report to use */
 	if (list_empty(report_list)) {
@@ -117,19 +214,61 @@ int lg4ff_init(struct hid_device *hid)
 		hid_err(hid, "NULL field\n");
 		return -1;
 	}
-
-	for (i = 0; ff_bits[i] >= 0; i++)
-		set_bit(ff_bits[i], dev->ffbit);
+	
+	/* Check what model of wheel has been connected */
+	for(i = 0; i < ARRAY_SIZE(ff4_devices); i++) {
+		if(hid->product == ff4_devices[i].product_id) {
+			dbg_hid("Found compatible device %04X\n", ff4_devices[i].product_id);
+			break;
+		}
+	}
+	
+	if(i == ARRAY_SIZE(ff4_devices)) {
+		hid_info(hid, "Device not supported yet\n");
+		return -1;
+	}
+	
+	/* Set supported force feedback capabilities */
+	for (j = 0; ff4_devices[i].ff_effects[j] >= 0; j++)
+		set_bit(ff4_devices[i].ff_effects[j], dev->ffbit);
 
 	error = input_ff_create_memless(dev, NULL, hid_lg4ff_play);
 
 	if (error)
 		return error;
 
-	if (test_bit(FF_AUTOCENTER, dev->ffbit))
-		dev->ff->set_autocenter = hid_lg4ff_set_autocenter;
+	/* Check if autocentering is available and
+	 * disable it by default */
+	if (test_bit(FF_AUTOCENTER, dev->ffbit)) {
+		dev->ff->set_autocenter = ff4_devices[i].set_autocenter;
+		dev->ff->set_autocenter(dev, (u16)0);
+	}
+
+	/* Check if the wheel supports range adjustment, if it does,
+	 * set appropirate range setting function. */
+	switch(ff4_devices[i].adj_range) {
+		case 2:
+			hid_ff4_set_range = hid_lg4ff_set_range_dfp;
+			break;
+		default:
+			hid_ff4_set_range = 0;
+	}
 
+	/* Create /sys interface */
+	if(ff4_devices[i].adj_range > 0) {
+		error = device_create_file(&hid->dev, &dev_attr_range_set);
+		if(error)
+			return error;
+		dbg_hid("/sys interface created\n");
+		hid_ff4_set_range(hid, (u16)900);
+	}
+	
 	hid_info(hid, "Force feedback for Logitech Speed Force Wireless by Simon Wood <simon@mungewell.org>\n");
 	return 0;
 }
 
+int lg4ff_deinit(struct hid_device *hid)
+{
+	device_remove_file(&hid->dev, &dev_attr_range_set);
+	return 0;
+}
diff --git a/drivers/hid/hid-lgff.c b/drivers/hid/hid-lgff.c
index 088f850..a53175e 100644
--- a/drivers/hid/hid-lgff.c
+++ b/drivers/hid/hid-lgff.c
@@ -71,14 +71,7 @@ static const struct dev_type devices[] = {
 	{ 0x046d, 0xc286, ff_joystick_ac },
 	{ 0x046d, 0xc287, ff_joystick_ac },
 	{ 0x046d, 0xc293, ff_joystick },
-	{ 0x046d, 0xc294, ff_wheel },
-	{ 0x046d, 0xc298, ff_wheel },
-	{ 0x046d, 0xc299, ff_wheel },
-	{ 0x046d, 0xc29b, ff_wheel },
 	{ 0x046d, 0xc295, ff_joystick },
-	{ 0x046d, 0xc298, ff_wheel },
-	{ 0x046d, 0xc299, ff_wheel },
-	{ 0x046d, 0xca03, ff_wheel },
 };
 
 static int hid_lgff_play(struct input_dev *dev, void *data, struct ff_effect *effect)
-- 
1.7.6


