From: Bastien Nocera <hadess@hadess.net>
Subject: RFC: Wacom Bluetooth HID driver, first pass
Date: Fri, 13 Mar 2009 23:59:59 +0000
Message-ID: <1236988799.32264.6310.camel@cookie.hadess.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-StrkcqEmTzmUs2OwEHDi"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:37371 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659AbZCNAAM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Mar 2009 20:00:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>
Cc: mjg <mjg@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, zap@homelink.ru


--=-StrkcqEmTzmUs2OwEHDi
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

This is a first pass at a driver for the Wacom Graphire Bluetooth
tablet, based on work by Andrew Zabolotny[1]. It's mildly tested (eg. it
works in my very few tests).

I was looking for guidance for the code itself, possibly making it
easier to merge in the input/tablet/wacom* drivers into it in the
future, as well as some explanations as to how I'm supposed to reset
tools, etc. so the user-space drivers (the X.org linuxwacom driver)
doesn't need special-casing for the device.

Note that it requires a user-space activation to switch to Mode 2, using
bluetoothd (as the Bluetooth HID doesn't support hid_output_raw_event).
Patch at:
http://cvs.fedoraproject.org/viewvc/rpms/bluez/devel/bluez-activate-wacom-mode2.patch?view=markup

Cheers

[1]: http://cs.ozerki.net/zap/wacom-bt/

--=-StrkcqEmTzmUs2OwEHDi
Content-Disposition: attachment; filename="linux-bt-wacom-draft.patch"
Content-Type: text/x-patch; name="linux-bt-wacom-draft.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index e85c8fe..f3244e3 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -261,6 +261,13 @@ config THRUSTMASTER_FF
 	  Say Y here if you have a THRUSTMASTER FireStore Dual Power 2 or
 	  a THRUSTMASTER Ferrari GT Rumble Force or Force Feedback Wheel.
 
+config HID_WACOM
+	tristate "Wacom Bluetooth devices support" if EMBEDDED
+	depends on BT_HIDP
+	default !EMBEDDED
+	---help---
+	Support for Wacom Graphire Bluetooth tablet.
+
 config ZEROPLUS_FF
 	tristate "Zeroplus based game controller support"
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index fbd021f..410b302 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_GREENASIA_FF)	+= hid-gaff.o
 obj-$(CONFIG_THRUSTMASTER_FF)	+= hid-tmff.o
 obj-$(CONFIG_HID_TOPSEED)	+= hid-topseed.o
 obj-$(CONFIG_ZEROPLUS_FF)	+= hid-zpff.o
+obj-$(CONFIG_HID_WACOM)		+= hid-wacom.o
 
 obj-$(CONFIG_USB_HID)		+= usbhid/
 obj-$(CONFIG_USB_MOUSE)		+= usbhid/
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 1cc9674..d134f5d 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1305,6 +1305,7 @@ static const struct hid_device_id hid_blacklist[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb651) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb654) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPSEED, USB_DEVICE_ID_TOPSEED_CYBERLINK) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE_BLUETOOTH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0005) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0030) },
 
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 8851197..e8f96c2 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -400,6 +400,7 @@
 #define USB_DEVICE_ID_VERNIER_LCSPEC	0x0006
 
 #define USB_VENDOR_ID_WACOM		0x056a
+#define USB_DEVICE_ID_WACOM_GRAPHIRE_BLUETOOTH	0x81
 
 #define USB_VENDOR_ID_WISEGROUP		0x0925
 #define USB_DEVICE_ID_1_PHIDGETSERVO_20	0x8101
--- /dev/null	2009-03-13 17:21:47.514016387 +0000
+++ linux-2.6/drivers/hid/hid-wacom.c	2009-03-13 23:39:05.000000000 +0000
@@ -0,0 +1,268 @@
+/*
+ *  Bluetooth Wacom Tablet support
+ *
+ *  Copyright (c) 1999 Andreas Gal
+ *  Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
+ *  Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2, Inc
+ *  Copyright (c) 2006-2007 Jiri Kosina
+ *  Copyright (c) 2007 Paul Walmsley
+ *  Copyright (c) 2008 Jiri Slaby <jirislaby@gmail.com>
+ *  Copyright (c) 2006 Andrew Zabolotny <zap@homelink.ru>
+ *  Copyright (c) 2009 Bastien Nocera <hadess@hadess.net>
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
+
+#include "hid-ids.h"
+
+struct wacom_data {
+	__u16 tool;
+	unsigned char butstate;
+};
+
+static int wacom_raw_event(struct hid_device *hdev, struct hid_report *report,
+		u8 *raw_data, int size)
+{
+	struct wacom_data *wdata = hid_get_drvdata(hdev);
+	struct hid_input *hidinput;
+	struct input_dev *input;
+	unsigned char *data = (unsigned char *) raw_data;
+	int tool, x, y, rw, need_sync;
+
+	if (!(hdev->claimed & HID_CLAIMED_INPUT))
+		return 0;
+
+	tool = 0;
+	need_sync = 0;
+	hidinput = list_entry(hdev->inputs.next, struct hid_input, list);
+	input = hidinput->input;
+
+	/* Check if this is a tablet report */
+	if (data[0] != 0x03)
+		return 0;
+
+	/* Get X & Y positions */
+	x = le16_to_cpu(*(__le16 *) &data[2]);
+	y = le16_to_cpu(*(__le16 *) &data[4]);
+
+	/* Get current tool identifier */
+	if (data [1] & 0x90) { /* If pen is in the in/active area */
+		switch ((data[1] >> 5) & 3) {
+		case 0:	/* Pen */
+			tool = BTN_TOOL_PEN;
+			break;
+
+		case 1: /* Rubber */
+			tool = BTN_TOOL_RUBBER;
+			break;
+
+		case 2: /* Mouse with wheel */
+		case 3: /* Mouse without wheel */
+			tool = BTN_TOOL_MOUSE;
+			break;
+		}
+
+		/* Reset tool if out of active tablet area */
+		if (!(data [1] & 0x10))
+			tool = 0;
+	}
+
+	/* If tool changed, notify input subsystem */
+	if (wdata->tool != tool) {
+		if (wdata->tool) {
+			/* Completely reset old tool state */
+			if (wdata->tool == BTN_TOOL_MOUSE) {
+				input_report_key(input, BTN_LEFT, 0);
+				input_report_key(input, BTN_RIGHT, 0);
+				input_report_key(input, BTN_MIDDLE, 0);
+				input_report_abs(input, ABS_DISTANCE, input->absmax[ABS_DISTANCE]);
+			} else {
+				input_report_key(input, BTN_TOUCH, 0);
+				input_report_key(input, BTN_STYLUS, 0);
+				input_report_key(input, BTN_STYLUS2, 0);
+				input_report_abs(input, ABS_PRESSURE, 0);
+			}
+			input_sync(input);
+			input_report_key(input, wdata->tool, 0);
+			input_sync(input);
+		}
+		if ((wdata->tool = tool)) {
+			input_report_key(input, tool, 1);
+			need_sync = 1;
+		}
+	}
+
+	if (tool) {
+		input_report_abs(input, ABS_X, x);
+		input_report_abs(input, ABS_Y, y);
+		need_sync = 1;
+
+		switch ((data[1] >> 5) & 3) {
+		case 2: /* Mouse with wheel */
+			input_report_key(input, BTN_MIDDLE, data[1] & 0x04);
+			rw = (data[6] & 0x01) ? +1 :
+				(data[6] & 0x02) ? -1 : 0;
+			input_report_rel(input, REL_WHEEL, rw);
+			/* fall through */
+
+		case 3: /* Mouse without wheel */
+			input_report_key(input, BTN_LEFT, data[1] & 0x01);
+			input_report_key(input, BTN_RIGHT, data[1] & 0x02);
+			/* Compute distance between mouse and tablet */
+			rw = 44 - (data[6] >> 2);
+			if (rw < 0) rw = 0;
+			if (rw > 31) rw = 31;
+			input_report_abs(input, ABS_DISTANCE, rw);
+			break;
+
+		default:
+			input_report_abs(input, ABS_PRESSURE,
+					 data[6] | (((__u16) (data[1] & 0x08)) << 5));
+			input_report_key(input, BTN_TOUCH, data[1] & 0x01);
+			input_report_key(input, BTN_STYLUS, data[1] & 0x02);
+			input_report_key(input, BTN_STYLUS2, data[1] & 0x04);
+			break;
+		}
+	}
+
+	if (need_sync) {
+		input_sync(input);
+		need_sync = 0;
+	}
+
+	/* Report the state of the two buttons at the top of the tablet
+	 * as two extra fingerpad keys (buttons 4 & 5). */
+	rw = data [7] & 0x03;
+	if (rw != wdata->butstate) {
+		wdata->butstate = rw;
+		input_report_key(input, BTN_0, rw & 0x02);
+		input_report_key(input, BTN_1, rw & 0x01);
+		need_sync = 1;
+	}
+
+	if (need_sync) {
+		input_event(input, EV_MSC, MSC_SERIAL, 0xf0);
+		input_sync(input);
+	}
+
+	return 1;
+}
+
+static int wacom_probe(struct hid_device *hdev,
+		const struct hid_device_id *id)
+{
+	struct hid_input *hidinput;
+	struct input_dev *input;
+	struct wacom_data *wdata;
+	int ret;
+
+	wdata = kzalloc(sizeof(*wdata), GFP_KERNEL);
+	if (wdata == NULL) {
+		dev_err(&hdev->dev, "can't alloc wacom descriptor\n");
+		return -ENOMEM;
+	}
+
+	hid_set_drvdata(hdev, wdata);
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		dev_err(&hdev->dev, "parse failed\n");
+		goto err_free;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret) {
+		dev_err(&hdev->dev, "hw start failed\n");
+		goto err_free;
+	}
+
+	hidinput = list_entry(hdev->inputs.next, struct hid_input, list);
+	input = hidinput->input;
+
+	/* Basics */
+	input->evbit[0] |= BIT(EV_KEY) | BIT(EV_ABS) | BIT(EV_REL);
+	input->absbit[0] |= BIT(ABS_X) | BIT(ABS_Y) |
+		BIT(ABS_PRESSURE) | BIT(ABS_DISTANCE);
+	input->relbit[0] |= BIT(REL_WHEEL);
+	set_bit(BTN_TOOL_PEN, input->keybit);
+	set_bit(BTN_TOUCH, input->keybit);
+	set_bit(BTN_STYLUS, input->keybit);
+	set_bit(BTN_STYLUS2, input->keybit);
+	set_bit(BTN_LEFT, input->keybit);
+	set_bit(BTN_RIGHT, input->keybit);
+	set_bit(BTN_MIDDLE, input->keybit);
+
+	/* Pad */
+	input->evbit[0] |= BIT(EV_MSC);
+	input->mscbit[0] |= BIT(MSC_SERIAL);
+
+	/* Distance, rubber and mouse */
+	input->absbit[0] |= BIT(ABS_DISTANCE);
+	set_bit(BTN_TOOL_RUBBER, input->keybit);
+	set_bit(BTN_TOOL_MOUSE, input->keybit);
+
+	input->absmax[ABS_PRESSURE] = 511;
+	input->absmax[ABS_DISTANCE] = 32;
+
+	input->absmax[ABS_X] = 16704;
+	input->absmax[ABS_Y] = 12064;
+	input->absfuzz[ABS_X] = 4;
+	input->absfuzz[ABS_Y] = 4;
+
+	return 0;
+err_free:
+	kfree(wdata);
+	return ret;
+}
+
+static void wacom_remove(struct hid_device *hdev)
+{
+	hid_hw_stop(hdev);
+	kfree(hid_get_drvdata(hdev));
+}
+
+static const struct hid_device_id wacom_devices[] = {
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE_BLUETOOTH) },
+
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, wacom_devices);
+
+static struct hid_driver wacom_driver = {
+	.name = "wacom",
+	.id_table = wacom_devices,
+	.probe = wacom_probe,
+	.remove = wacom_remove,
+	.raw_event = wacom_raw_event,
+};
+
+static int wacom_init(void)
+{
+	int ret;
+
+	ret = hid_register_driver(&wacom_driver);
+	if (ret)
+		printk(KERN_ERR "can't register wacom driver\n");
+	printk(KERN_ERR "wacom driver registered\n");
+	return ret;
+}
+
+static void wacom_exit(void)
+{
+	hid_unregister_driver(&wacom_driver);
+}
+
+module_init(wacom_init);
+module_exit(wacom_exit);
+MODULE_LICENSE("GPL");
+
+HID_COMPAT_LOAD_DRIVER(wacom);

--=-StrkcqEmTzmUs2OwEHDi--

