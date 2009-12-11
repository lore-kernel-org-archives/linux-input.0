From: chatty@lii-enac.fr (Stephane Chatty)
Subject: [PATCH] Support for 3M multitouch panel
Date: Fri, 11 Dec 2009 11:12:58 +0100
Message-ID: <20091211101258.CD35D951F5@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:60496 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756317AbZLKKMz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Dec 2009 05:12:55 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dsuljic@mmm.com

Added support for 3M multitouch panel.

Signed-off-by: Stephane Chatty <chatty@enac.fr>


diff -rupN a/drivers/hid/hid-3m-pct.c b/drivers/hid/hid-3m-pct.c
--- a/drivers/hid/hid-3m-pct.c	1970-01-01 01:00:00.000000000 +0100
+++ b/drivers/hid/hid-3m-pct.c	2009-12-11 10:58:01.000000000 +0100
@@ -0,0 +1,292 @@
+/*
+ *  HID driver for 3M multitouch panel
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
+#include <linux/usb.h>
+
+MODULE_VERSION("0.2");
+MODULE_AUTHOR("Stephane Chatty <chatty@enac.fr>");
+MODULE_DESCRIPTION("3M PCT multitouch panels");
+MODULE_LICENSE("GPL");
+
+#include "hid-ids.h"
+
+static int emulate_touchscreen = 1;
+module_param_named(emulate_touchscreen, emulate_touchscreen, int, 0600);
+MODULE_PARM_DESC(emulate_touchscreen,
+		"Touchscreen emulation on 3M multitouch panel (0=off, 1=on)");
+
+struct mmm_finger {
+	__s32 x, y;
+	__u8 rank;
+	int touch:1, valid:1;
+};
+struct mmm_data {
+	struct mmm_finger f[10];
+	__u8 curid, num;
+	int touch:1, valid:1;
+};
+
+static int mmm_input_mapping(struct hid_device *hdev, struct hid_input *hi,
+		struct hid_field *field, struct hid_usage *usage,
+		unsigned long **bit, int *max)
+{
+	switch (usage->hid & HID_USAGE_PAGE) {
+
+	case HID_UP_BUTTON:
+		return -1;
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
+		/* we do not want to map these: no input-oriented meaning */
+		case 0x14:
+		case 0x23:
+		case HID_DG_INPUTMODE:
+		case HID_DG_DEVICEINDEX:
+		case HID_DG_CONTACTCOUNT:
+		case HID_DG_CONTACTMAX:
+		case HID_DG_INRANGE:
+		case HID_DG_CONFIDENCE:
+			return -1;
+		case HID_DG_TIPSWITCH:
+			if (emulate_touchscreen) {
+				hid_map_usage(hi, usage, bit, max,
+					EV_KEY, BTN_TOUCH);
+				return 1;
+			} else
+				return -1;
+		case HID_DG_CONTACTID:
+			hid_map_usage(hi, usage, bit, max,
+					EV_ABS, ABS_MT_TRACKING_ID);
+			return 1;
+		}
+		/* let hid-input decide for the others */
+		return 0;
+
+	case 0xff000000:
+		/* we do not want to map these: no input-oriented meaning */
+		return -1;
+	}
+
+	return 0;
+}
+
+static int mmm_input_mapped(struct hid_device *hdev, struct hid_input *hi,
+		struct hid_field *field, struct hid_usage *usage,
+		unsigned long **bit, int *max)
+{
+	if (usage->type == EV_KEY || usage->type == EV_ABS)
+		clear_bit(usage->code, *bit);
+
+	return 0;
+}
+
+/*
+ * this function is called when a whole packet has been received and process,
+ * so that it can decide what to send to the input layer.
+ */
+static void mmm_filter_event (struct mmm_data *md, struct input_dev *input)
+{
+	struct mmm_finger *oldest = 0;
+	int pressed = 0, released = 0;
+	int i;
+	for (i = 0; i < 10; ++i) {
+		struct mmm_finger *f = &md->f[i];
+		if (!f->valid) {
+			/* ignore placeholder data */
+		} else if (f->touch) {
+			input_event(input, EV_ABS, ABS_MT_TRACKING_ID, i);
+			input_event(input, EV_ABS, ABS_MT_POSITION_X, f->x);
+			input_event(input, EV_ABS, ABS_MT_POSITION_Y, f->y);
+			input_mt_sync(input);
+			/*
+			 * maintain age rank of this finger for our single
+			 * touch emulation.
+			 */
+			if (f->rank == 0) {
+				f->rank = ++(md->num);
+				if (f->rank == 1)
+					pressed = 1;
+			}
+			if (f->rank == 1)
+				oldest = f;
+		} else {
+			/*
+			 * maintain age rank of other fingers for our single
+			 * touch emulation.
+			 */
+			int j;
+			for (j = 0; j < 10; ++j) {
+				struct mmm_finger *g = &md->f[j];
+				if (g->rank > f->rank) {
+					g->rank--;
+					if (g->rank == 1)
+						oldest = g;
+				}
+			}
+			f->rank = 0;
+			--(md->num);
+			if (md->num == 0)
+				released = 1;
+		}
+		f->valid = 0;
+	}
+
+	if (emulate_touchscreen) {
+		if (oldest) {
+			if (pressed)
+				input_event(input, EV_KEY, BTN_TOUCH, 1);
+			input_event(input, EV_ABS, ABS_X, oldest->x);
+			input_event(input, EV_ABS, ABS_Y, oldest->y);
+		} else if (released) {
+			input_event(input, EV_KEY, BTN_TOUCH, 0);
+		}
+	}
+}
+
+/*
+ * this function is called upon all reports
+ * so that we can accumulate contact point information,
+ * and call input_mt_sync after each point.
+ */
+static int mmm_event (struct hid_device *hid, struct hid_field *field,
+		                        struct hid_usage *usage, __s32 value)
+{
+	struct mmm_data *md = hid_get_drvdata(hid);
+        /* Strangely, this function can be called before
+	 * field->hidinput is initialized! */
+
+        if (hid->claimed & HID_CLAIMED_INPUT) {
+		struct input_dev *input = field->hidinput->input;
+		switch (usage->hid) {
+		case HID_DG_TIPSWITCH:
+			md->touch = value;
+			break;
+		case HID_DG_CONFIDENCE:
+			md->valid = value;
+			break;
+		case HID_DG_CONTACTID:
+			if (md->valid) {
+				md->curid = value;
+				md->f[value].touch = md->touch;
+				md->f[value].valid = 1;
+			}
+			break;
+		case HID_GD_X:
+			if (md->valid)
+				md->f[md->curid].x = value;
+			break;
+		case HID_GD_Y:
+			if (md->valid)
+				md->f[md->curid].y = value;
+			break;
+		case HID_DG_CONTACTCOUNT:
+			mmm_filter_event (md, input);
+			break;
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
+static int mmm_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	int ret;
+	struct mmm_data *md;
+
+	md = kzalloc(sizeof(struct mmm_data), GFP_KERNEL);
+	if (!md) {
+		dev_err(&hdev->dev, "cannot allocate 3M data\n");
+		return -ENOMEM;
+	}
+	hid_set_drvdata(hdev, md);
+
+	ret = hid_parse(hdev);
+	if (!ret)
+		ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+
+	if (ret)
+		kfree (md);
+	return ret;
+}
+
+static void mmm_remove(struct hid_device *hdev)
+{
+	hid_hw_stop(hdev);
+	kfree(hid_get_drvdata(hdev));
+}
+
+static const struct hid_device_id mmm_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_3M, USB_DEVICE_ID_3M1968) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, mmm_devices);
+
+static const struct hid_usage_id mmm_grabbed_usages[] = {
+	{ HID_ANY_ID, HID_ANY_ID, HID_ANY_ID },
+	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1}
+};
+
+static struct hid_driver mmm_driver = {
+	.name = "3m-pct",
+	.id_table = mmm_devices,
+	.probe = mmm_probe,
+	.remove = mmm_remove,
+	.input_mapping = mmm_input_mapping,
+	.input_mapped = mmm_input_mapped,
+	.usage_table = mmm_grabbed_usages,
+	.event = mmm_event,
+};
+
+static int mmm_init(void)
+{
+	return hid_register_driver(&mmm_driver);
+}
+
+static void mmm_exit(void)
+{
+	hid_unregister_driver(&mmm_driver);
+}
+
+module_init(mmm_init);
+module_exit(mmm_exit);
+MODULE_LICENSE("GPL");
+
diff -rupN a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
--- a/drivers/hid/hid-core.c	2009-12-03 04:51:21.000000000 +0100
+++ b/drivers/hid/hid-core.c	2009-12-11 10:57:43.000000000 +0100
@@ -1250,6 +1250,7 @@ EXPORT_SYMBOL_GPL(hid_disconnect);
 
 /* a list of devices for which there is a specialized driver on HID bus */
 static const struct hid_device_id hid_blacklist[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_3M, USB_DEVICE_ID_3M1968) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_WCP32PU) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_X5_005D) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ATV_IRCONTROL) },
diff -rupN a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
--- a/drivers/hid/hid-ids.h	2009-12-03 04:51:21.000000000 +0100
+++ b/drivers/hid/hid-ids.h	2009-12-11 10:56:54.000000000 +0100
@@ -18,6 +18,9 @@
 #ifndef HID_IDS_H_FILE
 #define HID_IDS_H_FILE
 
+#define USB_VENDOR_ID_3M		0x0596
+#define USB_DEVICE_ID_3M1968		0x0500
+
 #define USB_VENDOR_ID_A4TECH		0x09da
 #define USB_DEVICE_ID_A4TECH_WCP32PU	0x0006
 #define USB_DEVICE_ID_A4TECH_X5_005D	0x000a
diff -rupN a/drivers/hid/Kconfig b/drivers/hid/Kconfig
--- a/drivers/hid/Kconfig	2009-12-03 04:51:21.000000000 +0100
+++ b/drivers/hid/Kconfig	2009-12-11 10:59:07.000000000 +0100
@@ -55,6 +55,13 @@ source "drivers/hid/usbhid/Kconfig"
 menu "Special HID drivers"
 	depends on HID
 
+config HID_3M_PCT
+	tristate "3M PCT" if EMBEDDED
+	depends on USB_HID
+	default !EMBEDDED
+	---help---
+	Support for 3M PCT touch screens.
+
 config HID_A4TECH
 	tristate "A4 tech" if EMBEDDED
 	depends on USB_HID
diff -rupN a/drivers/hid/Makefile b/drivers/hid/Makefile
--- a/drivers/hid/Makefile	2009-12-03 04:51:21.000000000 +0100
+++ b/drivers/hid/Makefile	2009-12-11 10:59:29.000000000 +0100
@@ -19,6 +19,7 @@ ifdef CONFIG_LOGIRUMBLEPAD2_FF
 	hid-logitech-objs	+= hid-lg2ff.o
 endif
 
+obj-$(CONFIG_HID_3M_PCT)	+= hid-3m-pct.o
 obj-$(CONFIG_HID_A4TECH)	+= hid-a4tech.o
 obj-$(CONFIG_HID_APPLE)		+= hid-apple.o
 obj-$(CONFIG_HID_BELKIN)	+= hid-belkin.o
