From: chatty@lii-enac.fr (Stephane Chatty)
Subject: [PATCH 2/2] Support for Stantum multitouch panel
Date: Wed, 09 Dec 2009 22:49:28 +0100
Message-ID: <20091209214928.1E24D9520C@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:48562 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756054AbZLIV4N (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Dec 2009 16:56:13 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Added support for the Stantum multitouch panel.

Signed-off-by: Stephane Chatty <chatty@enac.fr>

diff -uprN a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
--- a/drivers/hid/hid-core.c	2009-12-08 22:32:21.000000000 +0100
+++ b/drivers/hid/hid-core.c	2009-12-08 22:36:19.000000000 +0100
@@ -1337,6 +1337,7 @@ static const struct hid_device_id hid_bl
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STANTUM, USB_DEVICE_ID_MTP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SUNPLUS, USB_DEVICE_ID_SUNPLUS_WDESKTOP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb300) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb304) },
diff -uprN a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
--- a/drivers/hid/hid-ids.h	2009-12-03 04:51:21.000000000 +0100
+++ b/drivers/hid/hid-ids.h	2009-12-08 22:43:10.000000000 +0100
@@ -383,6 +383,9 @@
 #define USB_DEVICE_ID_SOUNDGRAPH_IMON_FIRST	0x0034
 #define USB_DEVICE_ID_SOUNDGRAPH_IMON_LAST	0x0046
 
+#define USB_VENDOR_ID_STANTUM		0x1f87
+#define USB_DEVICE_ID_MTP		0x0002
+
 #define USB_VENDOR_ID_SUN		0x0430
 #define USB_DEVICE_ID_RARITAN_KVM_DONGLE	0xcdab
 
diff -uprN a/drivers/hid/hid-stantum.c b/drivers/hid/hid-stantum.c
--- a/drivers/hid/hid-stantum.c	1970-01-01 01:00:00.000000000 +0100
+++ b/drivers/hid/hid-stantum.c	2009-12-08 22:41:12.000000000 +0100
@@ -0,0 +1,291 @@
+/*
+ *  HID driver for Stantum multitouch panels
+ *
+ *  Copyright (c) 2009 Stephane Chatty <chatty@enac.fr>
+ *
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
+MODULE_VERSION("1.0");
+MODULE_AUTHOR("Stephane Chatty <chatty@enac.fr>");
+MODULE_DESCRIPTION("Stantum HID multitouch panels");
+MODULE_LICENSE("GPL");
+
+static int emulate_touchscreen = 1;
+module_param_named(emulate_touchscreen, emulate_touchscreen, int, 0600);
+MODULE_PARM_DESC(emulate_touchscreen,
+		"Touchscreen emulation on Stantum multitouch panel (0=off, 1=on)");
+
+#include "hid-ids.h"
+
+struct stantum_data {
+	__s32 x, y, z, w, h;	/* x, y, pressure, width, height */
+	__u16 id;		/* touch id */
+	int valid:1;		/* valid finger data, or just placeholder? */
+	int first:1;		/* is this the first finger in the HID packet? */
+	int activity:1;		/* is there at least one active finger so far? */
+};
+
+static int stantum_input_mapping(struct hid_device *hdev, struct hid_input *hi,
+		struct hid_field *field, struct hid_usage *usage,
+		unsigned long **bit, int *max)
+{
+	switch (usage->hid & HID_USAGE_PAGE) {
+
+	case HID_UP_GENDESK:
+		switch (usage->hid) {
+		case HID_GD_X:
+			hid_map_usage(hi, usage, bit, max,
+					EV_ABS, ABS_MT_POSITION_X);
+			if (emulate_touchscreen)
+				input_set_abs_params(hi->input, ABS_X,
+						field->logical_minimum,
+						field->logical_maximum, 0, 0);
+			return 1;
+		case HID_GD_Y:
+			hid_map_usage(hi, usage, bit, max,
+					EV_ABS, ABS_MT_POSITION_Y);
+			if (emulate_touchscreen)
+				input_set_abs_params(hi->input, ABS_Y,
+						field->logical_minimum,
+						field->logical_maximum, 0, 0);
+			return 1;
+		}
+		return 0;
+
+	case HID_UP_DIGITIZER:
+		switch (usage->hid) {
+		case HID_DG_INRANGE:
+		case HID_DG_CONFIDENCE:
+		case HID_DG_INPUTMODE:
+		case HID_DG_DEVICEINDEX:
+		case HID_DG_CONTACTCOUNT:
+		case HID_DG_CONTACTMAX:
+		case HID_DG_TIPPRESSURE:
+			return -1;
+
+		case HID_DG_TIPSWITCH:
+			if (emulate_touchscreen) {
+				hid_map_usage(hi, usage, bit, max,
+					EV_KEY, BTN_TOUCH);
+				return 1;
+			} else
+				return -1;
+
+		case HID_DG_WIDTH:
+			hid_map_usage(hi, usage, bit, max,
+						EV_ABS, ABS_MT_TOUCH_MAJOR);
+			return 1;
+		case HID_DG_HEIGHT:
+			hid_map_usage(hi, usage, bit, max,
+					EV_ABS, ABS_MT_TOUCH_MINOR);
+			input_set_abs_params(hi->input,
+					ABS_MT_ORIENTATION,
+					1, 1, 0, 0);
+			return 1;
+		case HID_DG_CONTACTID:
+			hid_map_usage(hi, usage, bit, max,
+					EV_ABS, ABS_MT_TRACKING_ID);
+			return 1;
+
+		}
+		return 0;
+
+	case 0xff000000:
+		/* no input-oriented meaning */
+		return -1;
+	}
+
+	return 0;
+}
+
+static int stantum_input_mapped(struct hid_device *hdev, struct hid_input *hi,
+		struct hid_field *field, struct hid_usage *usage,
+		unsigned long **bit, int *max)
+{
+	if (usage->type == EV_KEY || usage->type == EV_REL
+			|| usage->type == EV_ABS)
+		clear_bit(usage->code, *bit);
+
+	return 0;
+}
+
+/*
+ * this function is called when a whole finger has been parsed,
+ * so that it can decide what to send to the input layer.
+ */
+static void stantum_filter_event (struct stantum_data *sd,
+					struct input_dev *input)
+{
+	int wide;
+	if (!sd->valid) {
+		/* if the first finger is not valid and there previously
+		 * was finger activity, this is a release */
+		if (emulate_touchscreen && sd->first && sd->activity) {
+			input_event(input, EV_KEY, BTN_TOUCH, 0);
+			sd->activity = 0;
+		}
+		return;
+	}
+
+	input_event(input, EV_ABS, ABS_MT_TRACKING_ID, sd->id);
+	input_event(input, EV_ABS, ABS_MT_POSITION_X, sd->x);
+	input_event(input, EV_ABS, ABS_MT_POSITION_Y, sd->y);
+
+	wide = (sd->w > sd->h);
+	input_event(input, EV_ABS, ABS_MT_ORIENTATION, wide);
+	input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR,
+				wide ? sd->w : sd->h);
+	input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR,
+				wide ? sd->h : sd->w);
+
+#if 0
+	/* MT_PRESSURE does not exist yet */
+	input_event(input, EV_ABS, ABS_MT_PRESSURE, sd->z);
+#endif
+
+	if (emulate_touchscreen) {
+		if (sd->first) {
+			if (!sd->activity) {
+				input_event(input, EV_KEY, BTN_TOUCH, 1);
+				sd->activity = 1;
+			}
+			input_event(input, EV_ABS, ABS_X, sd->x);
+			input_event(input, EV_ABS, ABS_Y, sd->y);
+		}
+	}
+	input_mt_sync(input);
+	sd->valid = 0;
+	sd->first = 0;
+}
+
+
+static int stantum_event (struct hid_device *hid, struct hid_field *field,
+		                        struct hid_usage *usage, __s32 value)
+{
+	struct stantum_data *sd = hid_get_drvdata(hid);
+
+        if (hid->claimed & HID_CLAIMED_INPUT) {
+		struct input_dev *input = field->hidinput->input;
+		switch (usage->hid) {
+		case HID_DG_INRANGE:
+			/* this is the last field in a finger */
+			stantum_filter_event (sd, input);
+			break;
+		case HID_DG_WIDTH:
+			sd->w = value;
+			break;
+		case HID_DG_HEIGHT:
+			sd->h = value;
+			break;
+		case HID_GD_X:
+			sd->x = value;
+			break;
+		case HID_GD_Y:
+			sd->y = value;
+			break;
+		case HID_DG_TIPPRESSURE:
+			sd->z = value;
+			break;
+		case HID_DG_CONTACTID:
+			sd->id = value;
+			break;
+		case HID_DG_CONFIDENCE:
+			sd->valid = !!value;
+			break;
+		case 0xff000002:
+			/* this comes only before the first finger */
+			sd->first = 1;
+			break;
+
+		default:
+			/* ignore the others */
+                	return 1;
+		}
+	}
+
+	/* we have handled the hidinput part, now remains hiddev */
+        if (hid->claimed & HID_CLAIMED_HIDDEV && hid->hiddev_hid_event)
+                hid->hiddev_hid_event(hid, field, usage, value);
+
+	return 1;
+}
+
+static int stantum_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	int ret;
+	struct stantum_data *sd;
+
+	sd = kmalloc(sizeof(struct stantum_data), GFP_KERNEL);
+	if (!sd) {
+		dev_err(&hdev->dev, "cannot allocate Stantum data\n");
+		return -ENOMEM;
+	}
+	sd->valid = 0;
+	sd->first = 0;
+	sd->activity = 0;
+	hid_set_drvdata(hdev, sd);
+
+	ret = hid_parse(hdev);
+	if (!ret)
+		ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	else
+		printk ("STANTUM ERROR %d\n", ret);
+
+	if (ret)
+		kfree (sd);
+
+	return ret;
+}
+
+static void stantum_remove(struct hid_device *hdev)
+{
+	hid_hw_stop(hdev);
+	kfree(hid_get_drvdata(hdev));
+}
+
+static const struct hid_device_id stantum_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STANTUM, USB_DEVICE_ID_MTP) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, stantum_devices);
+
+static const struct hid_usage_id stantum_grabbed_usages[] = {
+	{ HID_ANY_ID, HID_ANY_ID, HID_ANY_ID },
+	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1}
+};
+
+static struct hid_driver stantum_driver = {
+	.name = "stantum",
+	.id_table = stantum_devices,
+	.probe = stantum_probe,
+	.remove = stantum_remove,
+	.input_mapping = stantum_input_mapping,
+	.input_mapped = stantum_input_mapped,
+	.usage_table = stantum_grabbed_usages,
+	.event = stantum_event,
+};
+
+static int stantum_init(void)
+{
+	return hid_register_driver(&stantum_driver);
+}
+
+static void stantum_exit(void)
+{
+	hid_unregister_driver(&stantum_driver);
+}
+
+module_init(stantum_init);
+module_exit(stantum_exit);
+
diff -uprN a/drivers/hid/Kconfig b/drivers/hid/Kconfig
--- a/drivers/hid/Kconfig	2009-12-08 22:32:05.000000000 +0100
+++ b/drivers/hid/Kconfig	2009-12-08 22:34:42.000000000 +0100
@@ -241,6 +241,13 @@ config HID_SONY
 	---help---
 	Support for Sony PS3 controller.
 
+config HID_STANTUM
+	tristate "Stantum" if EMBEDDED
+	depends on USB_HID
+	default !EMBEDDED
+	---help---
+	Support for Stantum multitouch panel.
+
 config HID_SUNPLUS
 	tristate "Sunplus" if EMBEDDED
 	depends on USB_HID
diff -uprN a/drivers/hid/Makefile b/drivers/hid/Makefile
--- a/drivers/hid/Makefile	2009-12-08 22:32:01.000000000 +0100
+++ b/drivers/hid/Makefile	2009-12-08 22:35:20.000000000 +0100
@@ -39,6 +39,7 @@ obj-$(CONFIG_HID_PETALYNX)	+= hid-petaly
 obj-$(CONFIG_HID_SAMSUNG)	+= hid-samsung.o
 obj-$(CONFIG_HID_SMARTJOYPLUS)	+= hid-sjoy.o
 obj-$(CONFIG_HID_SONY)		+= hid-sony.o
+obj-$(CONFIG_HID_STANTUM)	+= hid-stantum.o
 obj-$(CONFIG_HID_SUNPLUS)	+= hid-sunplus.o
 obj-$(CONFIG_HID_GREENASIA)	+= hid-gaff.o
 obj-$(CONFIG_HID_THRUSTMASTER)	+= hid-tmff.o
