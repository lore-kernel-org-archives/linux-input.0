From: Michael Poole <mdpoole@troilus.org>
Subject: [RFC PATCH 3/3] Add a device driver for the Apple Magic Mouse.
Date: Mon, 25 Jan 2010 00:04:37 -0500
Message-ID: <f12580aea111bac8b67b14e30a223565dddbbca6.1264395708.git.mdpoole@troilus.org>
References: <1264395877-2582-1-git-send-email-mdpoole@troilus.org>
 <411caeb60f5b808d0524636a03fc99e6216e67c6.1264395708.git.mdpoole@troilus.org>
 <ad7d2406ee127c0686463dadae9792ba7d8692a8.1264395708.git.mdpoole@troilus.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:33145 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751012Ab0AYFEy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jan 2010 00:04:54 -0500
Received: by qyk26 with SMTP id 26so1531689qyk.5
        for <linux-input@vger.kernel.org>; Sun, 24 Jan 2010 21:04:52 -0800 (PST)
In-Reply-To: <ad7d2406ee127c0686463dadae9792ba7d8692a8.1264395708.git.mdpoole@troilus.org>
In-Reply-To: <411caeb60f5b808d0524636a03fc99e6216e67c6.1264395708.git.mdpoole@troilus.org>
References: <411caeb60f5b808d0524636a03fc99e6216e67c6.1264395708.git.mdpoole@troilus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Michael Poole <mdpoole@troilus.org>

Signed-off-by: Michael Poole <mdpoole@troilus.org>
---
 drivers/hid/Kconfig          |   10 +
 drivers/hid/Makefile         |    1 +
 drivers/hid/hid-core.c       |    1 +
 drivers/hid/hid-ids.h        |    1 +
 drivers/hid/hid-magicmouse.c |  395 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 408 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hid/hid-magicmouse.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 24d90ea..a3d503f 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -183,6 +183,16 @@ config LOGIRUMBLEPAD2_FF
 	  Say Y here if you want to enable force feedback support for Logitech
 	  Rumblepad 2 devices.
 
+config HID_MAGICMOUSE
+	tristate "Apple" if EMBEDDED
+	depends on (USB_HID || BT_HIDP)
+	default !EMBEDDED
+	---help---
+	Support for the Apple Magic Mouse.
+
+	Say Y here if you want support for the multi-touch features of the
+	Apple Wireless "Magic" Mouse.
+
 config HID_MICROSOFT
 	tristate "Microsoft" if EMBEDDED
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 0de2dff..45d81e9 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_HID_GYRATION)	+= hid-gyration.o
 obj-$(CONFIG_HID_KENSINGTON)	+= hid-kensington.o
 obj-$(CONFIG_HID_KYE)		+= hid-kye.o
 obj-$(CONFIG_HID_LOGITECH)	+= hid-logitech.o
+obj-$(CONFIG_HID_MAGICMOUSE)    += hid-magicmouse.o
 obj-$(CONFIG_HID_MICROSOFT)	+= hid-microsoft.o
 obj-$(CONFIG_HID_MONTEREY)	+= hid-monterey.o
 obj-$(CONFIG_HID_NTRIG)		+= hid-ntrig.o
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index e39055b..f23ca76 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1254,6 +1254,7 @@ static const struct hid_device_id hid_blacklist[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ATV_IRCONTROL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL4) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MIGHTYMOUSE) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGICMOUSE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_ANSI) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_ISO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ANSI) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 010368e..11e5218 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -56,6 +56,7 @@
 
 #define USB_VENDOR_ID_APPLE		0x05ac
 #define USB_DEVICE_ID_APPLE_MIGHTYMOUSE	0x0304
+#define USB_DEVICE_ID_APPLE_MAGICMOUSE	0x030d
 #define USB_DEVICE_ID_APPLE_FOUNTAIN_ANSI	0x020e
 #define USB_DEVICE_ID_APPLE_FOUNTAIN_ISO	0x020f
 #define USB_DEVICE_ID_APPLE_GEYSER_ANSI	0x0214
diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
new file mode 100644
index 0000000..26a5f47
--- /dev/null
+++ b/drivers/hid/hid-magicmouse.c
@@ -0,0 +1,395 @@
+/*
+ *   Apple "Magic" Wireless Mouse driver
+ *
+ *   Copyright (c) 2010 Michael Poole <mdpoole@troilus.org>
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+
+#include "hid-ids.h"
+
+static bool emulate_3button = 1;
+module_param(emulate_3button, bool, 0644);
+MODULE_PARM_DESC(emulate_3button, "Emulate a middle button");
+
+static int middle_button_start = -350;
+static int middle_button_stop = +350;
+
+static bool emulate_scroll_wheel = 1;
+module_param(emulate_scroll_wheel, bool, 0644);
+MODULE_PARM_DESC(emulate_scroll_wheel, "Emulate a scroll wheel");
+
+static bool report_touches = 1;
+module_param(report_touches, bool, 0644);
+MODULE_PARM_DESC(report_touches, "Emit touch records (otherwise, only use them for emulation)");
+
+static bool report_undeciphered = 0;
+module_param(report_undeciphered, bool, 0644);
+MODULE_PARM_DESC(report_undeciphered, "Report undeciphered multi-touch state field using a MSC_RAW event");
+
+/**
+ * struct magicmouse_sc - Tracks Magic Mouse-specific data.
+ * @last_timestamp: Timestamp from most recent (18-bit) touch report
+ *     (units of milliseconds over short windows, but seems to
+ *     increase faster when there are no touches).
+ * @delta_time: 18-bit difference between the two most recent touch
+ *     reports from the mouse.
+ * @ntouches: Number of touches in most recent touch report.
+ * @touches: Most recent data for a touch, indexed by tracking ID.
+ */
+struct magicmouse_sc {
+	struct input_dev *input;
+	unsigned long quirks;
+
+	int last_timestamp;
+	int delta_time;
+	int ntouches;
+
+	struct {
+		short x;
+		short y;
+		short scroll_y;
+	} touches[16];
+	int tracking_ids[16];
+};
+
+static void magicmouse_emit_buttons(struct magicmouse_sc *msc, u8 state)
+{
+	if (emulate_3button) {
+		/* If some button was pressed before, keep it held
+		 * down.  Otherwise, if there's only one touch, use
+		 * that to override the mouse's guess.
+		 */
+		if (!state) {
+			/* The button was released. */
+		} else if (test_bit(BTN_LEFT, msc->input->key) ||
+			   test_bit(BTN_RIGHT, msc->input->key) ||
+			   test_bit(BTN_MIDDLE, msc->input->key)) {
+			state = test_bit(BTN_LEFT, msc->input->key) |
+				test_bit(BTN_RIGHT, msc->input->key) << 1 |
+				test_bit(BTN_MIDDLE, msc->input->key) << 2;
+		} else if (msc->ntouches == 1) {
+			int id = msc->tracking_ids[0];
+			int x = msc->touches[id].x;
+			if (x < middle_button_start)
+				state = 1;
+			else if (x > middle_button_stop)
+				state = 2;
+			else
+				state = 4;
+		}
+
+		input_report_key(msc->input, BTN_MIDDLE, state & 4);
+	}
+
+	input_report_key(msc->input, BTN_LEFT, state & 1);
+	input_report_key(msc->input, BTN_RIGHT, state & 2);
+}
+
+static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tdata)
+{
+	struct input_dev *input = msc->input;
+	__s32 x_y = tdata[0] << 8 | tdata[1] << 16 | tdata[2] << 24;
+	__u16 misc = tdata[5] | tdata[6] << 8;
+	int id = (misc >> 6) & 15;
+	int x = x_y << 12 >> 20;
+	int y = -(x_y >> 20);
+
+	/* Store tracking ID sequence. */
+	msc->tracking_ids[raw_id] = id;
+
+	/* If requested, emulate a scroll wheel by detecting small
+	 * vertical touch motions near the middle-button area.
+	 */
+	if (emulate_scroll_wheel && y < 0 &&
+	    middle_button_start < x && x < middle_button_stop) {
+		int step = (msc->touches[id].scroll_y - y) / 128;
+
+		if ((tdata[7] & 0xf0) != 0x40) {
+			msc->touches[id].scroll_y = y;
+		} else if (step != 0) {
+			msc->touches[id].scroll_y = y;
+			input_report_rel(input, REL_WHEEL, step);
+		}
+	}
+
+	/* Stash the coordinates that we might use later. */
+	msc->touches[id].x = x;
+	msc->touches[id].y = y;
+
+	/* Generate the input events for this touch. */
+	if (report_touches) {
+		input_report_abs(input, ABS_MT_TRACKING_ID, id);
+		input_report_abs(input, ABS_MT_TOUCH_MAJOR, tdata[3]);
+		input_report_abs(input, ABS_MT_TOUCH_MINOR, tdata[4]);
+		input_report_abs(input, ABS_MT_ORIENTATION, (int)(misc >> 10) - 32);
+		input_report_abs(input, ABS_MT_POSITION_X, x);
+		input_report_abs(input, ABS_MT_POSITION_Y, y);
+		input_mt_sync(input);
+	}
+
+	if (report_undeciphered) {
+		input_event(input, EV_MSC, MSC_RAW, tdata[7]);
+	}
+}
+
+static int magicmouse_raw_event(struct hid_device *hdev,
+		struct hid_report *report, u8 *data, int size)
+{
+	struct magicmouse_sc *msc = hid_get_drvdata(hdev);
+	struct input_dev *input = msc->input;
+	int ts;
+	int ii;
+
+	switch (data[0]) {
+	case 0x10:
+		if (size != 6)
+			return 0;
+		magicmouse_emit_buttons(msc, data[1] & 3);
+		input_report_rel(input, REL_X, (short)(data[2] | data[3] << 8));
+		input_report_rel(input, REL_Y, (short)(data[4] | data[5] << 8));
+		input_sync(input);
+		return 1;
+	case 0x29:
+		/* Expect six bytes of prefix, and N*8 bytes of touch data. */
+		if (size < 6 || ((size - 6) % 8) != 0)
+			return 0;
+		ts = data[3] >> 6 | data[4] << 2 | data[5] << 10;
+		msc->delta_time = (ts - msc->last_timestamp) & 0x3ffff;
+		msc->last_timestamp = ts;
+		msc->ntouches = (size - 6) / 8;
+		for (ii = 0; ii < msc->ntouches; ii++)
+			magicmouse_emit_touch(msc, ii, data + ii * 8 + 6);
+		/* When emulating three-button mode, it is important
+		 * to have the current touch information before
+		 * generating a click event.
+		 */
+		magicmouse_emit_buttons(msc, data[3] & 3);
+		input_report_rel(input, REL_X, (signed char)data[1]);
+		input_report_rel(input, REL_Y, (signed char)data[2]);
+		input_sync(input);
+		return 1;
+	case 0x20: /* Theoretically battery status (0-100), but I have
+		    * never seen it -- maybe it is only upon request.
+		    */
+	case 0x60: /* Unknown, maybe laser on/off. */
+	case 0x61: /* Laser reflection status change.
+		    * data[1]: 0 = spotted, 1 = lost
+		    */
+	default:
+		return 0;
+	}
+}
+
+static int magicmouse_input_open(struct input_dev *dev)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+
+	return hid->ll_driver->open(hid);
+}
+
+static void magicmouse_input_close(struct input_dev *dev)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+
+	hid->ll_driver->close(hid);
+}
+
+static void magicmouse_setup_input(struct input_dev *input, struct hid_device *hdev)
+{
+	input_set_drvdata(input, hdev);
+	input->event = hdev->ll_driver->hidinput_input_event;
+	input->open = magicmouse_input_open;
+	input->close = magicmouse_input_close;
+
+	input->name = hdev->name;
+	input->phys = hdev->phys;
+	input->uniq = hdev->uniq;
+	input->id.bustype = hdev->bus;
+	input->id.vendor = hdev->vendor;
+	input->id.product = hdev->product;
+	input->id.version = hdev->version;
+	input->dev.parent = hdev->dev.parent;
+
+	set_bit(EV_KEY, input->evbit);
+	set_bit(BTN_LEFT, input->keybit);
+	set_bit(BTN_RIGHT, input->keybit);
+	if (emulate_3button)
+		set_bit(BTN_MIDDLE, input->keybit);
+	set_bit(BTN_TOOL_FINGER, input->keybit);
+
+	set_bit(EV_REL, input->evbit);
+	set_bit(REL_X, input->relbit);
+	set_bit(REL_Y, input->relbit);
+	if (emulate_scroll_wheel)
+		set_bit(REL_WHEEL, input->relbit);
+
+	if (report_touches) {
+		set_bit(EV_ABS, input->evbit);
+
+		set_bit(ABS_MT_TRACKING_ID, input->absbit);
+		input->absmin[ABS_MT_TRACKING_ID] = 0;
+		input->absmax[ABS_MT_TRACKING_ID] = 15;
+		input->absfuzz[ABS_MT_TRACKING_ID] = 0;
+
+		set_bit(ABS_MT_TOUCH_MAJOR, input->absbit);
+		input->absmin[ABS_MT_TOUCH_MAJOR] = 0;
+		input->absmax[ABS_MT_TOUCH_MAJOR] = 255;
+		input->absfuzz[ABS_MT_TOUCH_MAJOR] = 4;
+
+		set_bit(ABS_MT_TOUCH_MINOR, input->absbit);
+		input->absmin[ABS_MT_TOUCH_MINOR] = 0;
+		input->absmax[ABS_MT_TOUCH_MINOR] = 255;
+		input->absfuzz[ABS_MT_TOUCH_MINOR] = 4;
+
+		set_bit(ABS_MT_ORIENTATION, input->absbit);
+		input->absmin[ABS_MT_ORIENTATION] = -32;
+		input->absmax[ABS_MT_ORIENTATION] = 31;
+		input->absfuzz[ABS_MT_ORIENTATION] = 1;
+
+		set_bit(ABS_MT_POSITION_X, input->absbit);
+		input->absmin[ABS_MT_POSITION_X] = -1100;
+		input->absmax[ABS_MT_POSITION_X] = 1358;
+		input->absfuzz[ABS_MT_POSITION_X] = 4;
+
+		/* Note: Touch Y position from the device is inverted relative
+		 * to how pointer motion is reported (and relative to how USB
+		 * HID recommends the coordinates work).  This driver keeps
+		 * the origin at the same position, and just uses the additive
+		 * inverse of the reported Y.
+		 */
+		set_bit(ABS_MT_POSITION_Y, input->absbit);
+		input->absmin[ABS_MT_POSITION_Y] = -1589;
+		input->absmax[ABS_MT_POSITION_Y] = 2047;
+		input->absfuzz[ABS_MT_POSITION_Y] = 4;
+	}
+
+	if (report_undeciphered) {
+		set_bit(EV_MSC, input->evbit);
+		set_bit(MSC_RAW, input->mscbit);
+	}
+}
+
+static int magicmouse_probe(struct hid_device *hdev,
+	const struct hid_device_id *id)
+{
+	__u8 feature_1[] = { 0xd7, 0x01 };
+	__u8 feature_2[] = { 0xf8, 0x01, 0x32 };
+	struct input_dev *input;
+	struct magicmouse_sc *msc;
+	struct hid_report *report;
+	int ret;
+
+	msc = kzalloc(sizeof(*msc), GFP_KERNEL);
+	if (msc == NULL) {
+		dev_err(&hdev->dev, "can't alloc magicmouse descriptor\n");
+		return -ENOMEM;
+	}
+
+	msc->quirks = id->driver_data;
+	hid_set_drvdata(hdev, msc);
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		dev_err(&hdev->dev, "magicmouse hid parse failed\n");
+		goto err_free;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret) {
+		dev_err(&hdev->dev, "magicmouse hw start failed\n");
+		goto err_free;
+	}
+
+	report = hid_register_report(hdev, HID_INPUT_REPORT, 0x29);
+	if (!report) {
+		dev_err(&hdev->dev, "unable to register touch report\n");
+		ret = -ENOMEM;
+		goto err_free;
+	}
+	report->size = 6;
+
+	ret = hdev->ll_driver->hid_set_report(hdev, HID_FEATURE_REPORT,
+			feature_1, sizeof(feature_1));
+	if (!ret) {
+		ret = hdev->ll_driver->hid_set_report(hdev, HID_FEATURE_REPORT,
+				feature_2, sizeof(feature_2));
+	}
+	if (ret) {
+		dev_err(&hdev->dev, "unable to request touch data\n");
+		goto err_free;
+	}
+
+	input = input_allocate_device();
+	if (!input) {
+		dev_err(&hdev->dev, "can't alloc input device\n");
+		ret = -ENOMEM;
+		goto err_free;
+	}
+	magicmouse_setup_input(input, hdev);
+
+	ret = input_register_device(input);
+	if (ret) {
+		dev_err(&hdev->dev, "input device registration failed\n");
+		goto err_both;
+	}
+	msc->input = input;
+
+	return 0;
+ err_both:
+	input_free_device(input);
+ err_free:
+	kfree(msc);
+	return ret;
+}
+
+static void magicmouse_remove(struct hid_device *hdev)
+{
+	hid_hw_stop(hdev);
+	kfree(hid_get_drvdata(hdev));
+}
+
+static const struct hid_device_id magic_mice[] = {
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGICMOUSE),
+		.driver_data = 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, magic_mice);
+
+static struct hid_driver magicmouse_driver = {
+	.name = "magicmouse",
+	.id_table = magic_mice,
+	.probe = magicmouse_probe,
+	.remove = magicmouse_remove,
+	.raw_event = magicmouse_raw_event,
+};
+
+static int __init magicmouse_init(void)
+{
+	int ret;
+
+	ret = hid_register_driver(&magicmouse_driver);
+	if (ret)
+		printk(KERN_ERR "can't register magicmouse driver\n");
+
+	return ret;
+}
+
+static void __exit magicmouse_exit(void)
+{
+	hid_unregister_driver(&magicmouse_driver);
+}
+
+module_init(magicmouse_init);
+module_exit(magicmouse_exit);
+MODULE_LICENSE("GPL");
-- 
1.6.5.6

