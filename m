From: Brendan McGrath <redmcg@redmandi.dyndns.org>
Subject: [PATCH] HID: asus: Add i2c touchpad support
Date: Tue, 29 Nov 2016 18:59:25 +1100
Message-ID: <1480406365-31640-1-git-send-email-redmcg@redmandi.dyndns.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:49931 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752894AbcK2H7c (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 29 Nov 2016 02:59:32 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Brendan McGrath <redmcg@redmandi.dyndns.org>, Victor Vlasenko <victor.vlasenko@sysgears.com>, Frederik Wenigwieser <frederik.wenigwieser@gmail.com>

Update the hid-asus module to add multitouch support for the Asus i2c touchpad.

Signed-off-by: Brendan McGrath <redmcg@redmandi.dyndns.org>
Signed-off-by: Victor Vlasenko <victor.vlasenko@sysgears.com>
Signed-off-by: Frederik Wenigwieser <frederik.wenigwieser@gmail.com>
---
This patch aims to resolve the issue raised here:
https://bugzilla.kernel.org/show_bug.cgi?id=120181

The issue is in relation to an Asus touchpad device which currently does not have
multitouch support.

The device currently falls through to the hid-generic driver which
treats the device as a mouse.

This patch aims to add the multitouch support.

A DKMS driver has been developed to test this and can found here:
https://github.com/vlasenko/hid-asus-dkms

GitHub statistics show that this repository has had over 100 unique cloners.

We have also been able to resolve over 20 raised issues with each user confirming
the driver is working well for them. There are currently no outstanding issues
directly related to this driver.


 drivers/hid/Kconfig    |   2 +-
 drivers/hid/hid-asus.c | 299 ++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/hid/hid-core.c |   1 +
 drivers/hid/hid-ids.h  |   1 +
 4 files changed, 296 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 3156517..9abd726 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -138,7 +138,7 @@ config HID_ASUS
 	tristate "Asus"
 	depends on I2C_HID
 	---help---
-	Support for Asus notebook built-in keyboard via i2c.
+	Support for Asus notebook built-in keyboard and touchpad via i2c.
 
 	Supported devices:
 	- EeeBook X205TA
diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 7a811ec..96179b2 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -11,6 +11,12 @@
  *  This module based on hid-ortek by
  *  Copyright (c) 2010 Johnathon Harris <jmharris@gmail.com>
  *  Copyright (c) 2011 Jiri Kosina
+ *
+ *  This module has been updated to add support for Asus i2c touchpad.
+ *
+ *  Copyright (c) 2016 Brendan McGrath <redmcg@redmandi.dyndns.org>
+ *  Copyright (c) 2016 Victor Vlasenko <victor.vlasenko@sysgears.com>
+ *  Copyright (c) 2016 Frederik Wenigwieser <frederik.wenigwieser@gmail.com>
  */
 
 /*
@@ -20,16 +26,287 @@
  * any later version.
  */
 
-#include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
+#include <linux/input/mt.h>
 
 #include "hid-ids.h"
 
+MODULE_AUTHOR("Yusuke Fujimaki <usk.fujimaki@gmail.com>");
+MODULE_AUTHOR("Brendan McGrath <redmcg@redmandi.dyndns.org>");
+MODULE_AUTHOR("Victor Vlasenko <victor.vlasenko@sysgears.com>");
+MODULE_AUTHOR("Frederik Wenigwieser <frederik.wenigwieser@gmail.com>");
+MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
+
+#define FEATURE_REPORT_ID 0x0d
+#define INPUT_REPORT_ID 0x5d
+
+#define INPUT_REPORT_SIZE 28
+
+#define MAX_CONTACTS 5
+
+#define MAX_X 2794
+#define MAX_Y 1758
+#define MAX_TOUCH_MAJOR 8
+#define MAX_PRESSURE 128
+
+#define CONTACT_DATA_SIZE 5
+
+#define BTN_LEFT_MASK 0x01
+#define CONTACT_TOOL_TYPE_MASK 0x80
+#define CONTACT_X_MSB_MASK 0xf0
+#define CONTACT_Y_MSB_MASK 0x0f
+#define CONTACT_TOUCH_MAJOR_MASK 0x07
+#define CONTACT_PRESSURE_MASK 0x7f
+
+#define QUIRK_FIX_NOTEBOOK_REPORT	BIT(0)
+#define QUIRK_NO_INIT_REPORTS		BIT(1)
+#define QUIRK_SKIP_INPUT_MAPPING	BIT(2)
+#define QUIRK_IS_MULTITOUCH		BIT(3)
+
+#define NOTEBOOK_QUIRKS			QUIRK_FIX_NOTEBOOK_REPORT
+#define TOUCHPAD_QUIRKS			(QUIRK_NO_INIT_REPORTS | \
+						 QUIRK_SKIP_INPUT_MAPPING | \
+						 QUIRK_IS_MULTITOUCH)
+
+#define TRKID_SGN       ((TRKID_MAX + 1) >> 1)
+
+struct asus_drvdata {
+	unsigned long quirks;
+	struct input_dev *input;
+};
+
+static void asus_report_contact_down(struct input_dev *input,
+		int toolType, u8 *data)
+{
+	int touch_major, pressure;
+	int x = (data[0] & CONTACT_X_MSB_MASK) << 4 | data[1];
+	int y = MAX_Y - ((data[0] & CONTACT_Y_MSB_MASK) << 8 | data[2]);
+
+	if (toolType == MT_TOOL_PALM) {
+		touch_major = MAX_TOUCH_MAJOR;
+		pressure = MAX_PRESSURE;
+	} else {
+		touch_major = (data[3] >> 4) & CONTACT_TOUCH_MAJOR_MASK;
+		pressure = data[4] & CONTACT_PRESSURE_MASK;
+	}
+
+	input_report_abs(input, ABS_MT_POSITION_X, x);
+	input_report_abs(input, ABS_MT_POSITION_Y, y);
+	input_report_abs(input, ABS_MT_TOUCH_MAJOR, touch_major);
+	input_report_abs(input, ABS_MT_PRESSURE, pressure);
+}
+
+/* Required for Synaptics Palm Detection */
+static void asus_report_tool_width(struct input_dev *input)
+{
+	struct input_mt *mt = input->mt;
+	struct input_mt_slot *oldest;
+	int oldid, count, i;
+
+	oldest = NULL;
+	oldid = mt->trkid;
+	count = 0;
+
+	for (i = 0; i < mt->num_slots; ++i) {
+		struct input_mt_slot *ps = &mt->slots[i];
+		int id = input_mt_get_value(ps, ABS_MT_TRACKING_ID);
+
+		if (id < 0)
+			continue;
+		if ((id - oldid) & TRKID_SGN) {
+			oldest = ps;
+			oldid = id;
+		}
+		count++;
+	}
+
+	if (oldest) {
+		input_report_abs(input, ABS_TOOL_WIDTH,
+			input_mt_get_value(oldest, ABS_MT_TOUCH_MAJOR));
+	}
+}
+
+static void asus_report_input(struct input_dev *input, u8 *data)
+{
+	int i;
+	u8 *contactData = data + 2;
+
+	for (i = 0; i < MAX_CONTACTS; i++) {
+		bool down = !!(data[1] & BIT(i+3));
+		int toolType = contactData[3] & CONTACT_TOOL_TYPE_MASK ?
+						MT_TOOL_PALM : MT_TOOL_FINGER;
+
+		input_mt_slot(input, i);
+		input_mt_report_slot_state(input, toolType, down);
+
+		if (down) {
+			asus_report_contact_down(input, toolType, contactData);
+			contactData += CONTACT_DATA_SIZE;
+		}
+	}
+
+	input_report_key(input, BTN_LEFT, data[1] & BTN_LEFT_MASK);
+	asus_report_tool_width(input);
+
+	input_mt_sync_frame(input);
+	input_sync(input);
+}
+
+static int asus_raw_event(struct hid_device *hdev,
+		struct hid_report *report, u8 *data, int size)
+{
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+
+	if (drvdata->quirks & QUIRK_IS_MULTITOUCH &&
+					 data[0] == INPUT_REPORT_ID &&
+						size == INPUT_REPORT_SIZE) {
+		asus_report_input(drvdata->input, data);
+		return 1;
+	}
+
+	return 0;
+}
+
+static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
+{
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+
+	if (drvdata->quirks & QUIRK_IS_MULTITOUCH) {
+		int ret;
+		struct input_dev *input = hi->input;
+
+		input_set_abs_params(input, ABS_MT_POSITION_X, 0, MAX_X, 0, 0);
+		input_set_abs_params(input, ABS_MT_POSITION_Y, 0, MAX_Y, 0, 0);
+		input_set_abs_params(input, ABS_TOOL_WIDTH, 0, MAX_TOUCH_MAJOR, 0, 0);
+		input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, MAX_TOUCH_MAJOR, 0, 0);
+		input_set_abs_params(input, ABS_MT_PRESSURE, 0, MAX_PRESSURE, 0, 0);
+
+		__set_bit(BTN_LEFT, input->keybit);
+		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
+
+		ret = input_mt_init_slots(input, MAX_CONTACTS, INPUT_MT_POINTER);
+
+		if (ret) {
+			hid_err(hdev, "Asus input mt init slots failed: %d\n", ret);
+			return ret;
+		}
+
+		drvdata->input = input;
+	}
+
+	return 0;
+}
+
+static int asus_input_mapping(struct hid_device *hdev,
+		struct hid_input *hi, struct hid_field *field,
+		struct hid_usage *usage, unsigned long **bit,
+		int *max)
+{
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+
+	if (drvdata->quirks & QUIRK_SKIP_INPUT_MAPPING) {
+		/* Don't map anything from the HID report.
+		 * We do it all manually in asus_input_configured
+		 */
+		return -1;
+	}
+
+	return 0;
+}
+
+static int asus_start_multitouch(struct hid_device *hdev)
+{
+	int ret;
+	const unsigned char buf[] = { FEATURE_REPORT_ID, 0x00, 0x03, 0x01, 0x00 };
+	unsigned char *dmabuf = kmemdup(buf, sizeof(buf), GFP_KERNEL);
+
+	if (!dmabuf) {
+		ret = -ENOMEM;
+		hid_err(hdev, "Asus failed to alloc dma buf: %d\n", ret);
+		return ret;
+	}
+
+	ret = hid_hw_raw_request(hdev, dmabuf[0], dmabuf, sizeof(buf),
+					HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+
+	kfree(dmabuf);
+
+	if (ret != sizeof(buf)) {
+		hid_err(hdev, "Asus failed to start multitouch: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused asus_reset_resume(struct hid_device *hdev)
+{
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+
+	if (drvdata->quirks & QUIRK_IS_MULTITOUCH)
+		return asus_start_multitouch(hdev);
+
+	return 0;
+}
+
+static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	int ret;
+	struct asus_drvdata *drvdata;
+
+	drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (drvdata == NULL) {
+		hid_err(hdev, "Can't alloc Asus descriptor\n");
+		return -ENOMEM;
+	}
+
+	hid_set_drvdata(hdev, drvdata);
+
+	drvdata->quirks = id->driver_data;
+
+	if (drvdata->quirks & QUIRK_NO_INIT_REPORTS)
+		hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "Asus hid parse failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret) {
+		hid_err(hdev, "Asus hw start failed: %d\n", ret);
+		return ret;
+	}
+
+	if (!drvdata->input) {
+		hid_err(hdev, "Asus input not registered\n");
+		ret = -ENOMEM;
+		goto err_stop_hw;
+	}
+
+	drvdata->input->name = "Asus TouchPad";
+
+	if (drvdata->quirks & QUIRK_IS_MULTITOUCH) {
+		ret = asus_start_multitouch(hdev);
+		if (ret)
+			goto err_stop_hw;
+	}
+
+	return 0;
+err_stop_hw:
+	hid_hw_stop(hdev);
+	return ret;
+}
+
 static __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
-	if (*rsize >= 56 && rdesc[54] == 0x25 && rdesc[55] == 0x65) {
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+
+	if (drvdata->quirks & QUIRK_FIX_NOTEBOOK_REPORT &&
+			*rsize >= 56 && rdesc[54] == 0x25 && rdesc[55] == 0x65) {
 		hid_info(hdev, "Fixing up Asus notebook report descriptor\n");
 		rdesc[55] = 0xdd;
 	}
@@ -37,15 +314,25 @@ static __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 }
 
 static const struct hid_device_id asus_devices[] = {
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_NOTEBOOK_KEYBOARD) },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
+		 USB_DEVICE_ID_ASUSTEK_NOTEBOOK_KEYBOARD), NOTEBOOK_QUIRKS},
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
+			 USB_DEVICE_ID_ASUSTEK_TOUCHPAD), TOUCHPAD_QUIRKS },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, asus_devices);
 
 static struct hid_driver asus_driver = {
-	.name = "asus",
-	.id_table = asus_devices,
-	.report_fixup = asus_report_fixup
+	.name			= "hid-asus",
+	.id_table		= asus_devices,
+	.report_fixup		= asus_report_fixup,
+	.probe                  = asus_probe,
+	.input_mapping          = asus_input_mapping,
+	.input_configured       = asus_input_configured,
+#ifdef CONFIG_PM
+	.reset_resume           = asus_reset_resume,
+#endif
+	.raw_event		= asus_raw_event
 };
 module_hid_driver(asus_driver);
 
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b43df2d..5d1f61d 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1858,6 +1858,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_NOTEBOOK_KEYBOARD) },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_TOUCHPAD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AUREAL, USB_DEVICE_ID_AUREAL_W01RN) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BELKIN, USB_DEVICE_ID_FLIP_KVM) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BETOP_2185BFM, 0x2208) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 222b966..9806587 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -171,6 +171,7 @@
 #define USB_DEVICE_ID_ASUSTEK_LCM	0x1726
 #define USB_DEVICE_ID_ASUSTEK_LCM2	0x175b
 #define USB_DEVICE_ID_ASUSTEK_NOTEBOOK_KEYBOARD	0x8585
+#define USB_DEVICE_ID_ASUSTEK_TOUCHPAD	0x0101
 
 #define USB_VENDOR_ID_ATEN		0x0557
 #define USB_DEVICE_ID_ATEN_UC100KM	0x2004
-- 
2.7.4

