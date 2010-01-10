From: chatty@lii-enac.fr (Stephane Chatty)
Subject: [PATCH] Support for Acer T230H multitouch panel
Date: Sun, 10 Jan 2010 20:58:05 +0100
Message-ID: <20100110195805.D573F951DC@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:54868 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535Ab0AJT6I (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Jan 2010 14:58:08 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chatty@enac.fr, jkosina@suse.cz, linux-input@vger.kernel.org
Cc: berthiec@gmail.com, jerom3@free.fr, dmitry.torokhov@gmail.com

Added support for the Acer T230H multitouch panel.

Signed-off-by: Stephane Chatty <chatty@enac.fr>
Tested-by: Jerome Vidal <jerom3@free.fr>
Tested-by: Cedric Berthier <berthiec@gmail.com>

diff -rupN a/drivers/hid/hid-acer.c b/drivers/hid/hid-acer.c
--- a/drivers/hid/hid-acer.c	1970-01-01 01:00:00.000000000 +0100
+++ b/drivers/hid/hid-acer.c	2010-01-10 19:22:38.000000000 +0100
@@ -0,0 +1,258 @@
+/*
+ *  HID driver for ACER T230H panels
+ *
+ *  Copyright (c) 2009-2010 Stephane Chatty <chatty@enac.fr>
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
+MODULE_VERSION("1.00");
+MODULE_AUTHOR("Stephane Chatty <chatty@enac.fr>");
+MODULE_DESCRIPTION("ACER T230H multitouch panels");
+MODULE_LICENSE("GPL");
+
+#include "hid-ids.h"
+
+struct t230h_data {
+	__u16 x, y;
+	__u8 id;
+	bool valid;		/* valid finger data, or just placeholder? */
+	bool first;		/* is this the first finger in this frame? */
+	bool activity_now;	/* at least one active finger in this frame? */
+	bool activity;		/* at least one active finger previously? */
+};
+
+static int t230h_input_mapping(struct hid_device *hdev, struct hid_input *hi,
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
+			/* touchscreen emulation */
+			input_set_abs_params(hi->input, ABS_X,
+						field->logical_minimum,
+						field->logical_maximum, 0, 0);
+			return 1;
+		case HID_GD_Y:
+			hid_map_usage(hi, usage, bit, max,
+					EV_ABS, ABS_MT_POSITION_Y);
+			/* touchscreen emulation */
+			input_set_abs_params(hi->input, ABS_Y,
+						field->logical_minimum,
+						field->logical_maximum, 0, 0);
+			return 1;
+		}
+		return 0;
+
+	case HID_UP_DIGITIZER:
+		switch (usage->hid) {
+		case HID_DG_CONFIDENCE:
+		case HID_DG_TIPSWITCH:
+		case HID_DG_INPUTMODE:
+		case HID_DG_DEVICEINDEX:
+		case HID_DG_CONTACTCOUNT:
+		case HID_DG_CONTACTMAX:
+		case HID_DG_TIPPRESSURE:
+		case HID_DG_WIDTH:
+		case HID_DG_HEIGHT:
+			return -1;
+		case HID_DG_INRANGE:
+			/* touchscreen emulation */
+			hid_map_usage(hi, usage, bit, max, EV_KEY, BTN_TOUCH);
+			return 1;
+		case HID_DG_CONTACTID:
+			hid_map_usage(hi, usage, bit, max,
+					EV_ABS, ABS_MT_TRACKING_ID);
+			return 1;
+		}
+		return 0;
+
+	case 0xff000000:
+		/* ignore vendor-specific features */
+		return -1;
+	}
+
+	return 0;
+}
+
+static int t230h_input_mapped(struct hid_device *hdev, struct hid_input *hi,
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
+ * this function is called when a whole finger has been parsed,
+ * so that it can decide what to send to the input layer.
+ */
+static void t230h_filter_event(struct t230h_data *td, struct input_dev *input)
+{
+	
+	td->first = !td->first; /* touchscreen emulation */
+
+	if (!td->valid) {
+		/*
+		 * touchscreen emulation: if no finger in this frame is valid
+		 * and there previously was finger activity, this is a release
+		 */ 
+		if (!td->first && !td->activity_now && td->activity) {
+			input_event(input, EV_KEY, BTN_TOUCH, 0);
+			td->activity = false;
+		}
+		return;
+	}
+
+	input_event(input, EV_ABS, ABS_MT_TRACKING_ID, td->id);
+	input_event(input, EV_ABS, ABS_MT_POSITION_X, td->x);
+	input_event(input, EV_ABS, ABS_MT_POSITION_Y, td->y);
+
+	input_mt_sync(input);
+	td->valid = false;
+
+	/* touchscreen emulation: if first active finger in this frame... */
+	if (!td->activity_now) {
+		/* if there was no previous activity, emit touch event */
+		if (!td->activity) {
+			input_event(input, EV_KEY, BTN_TOUCH, 1);
+			td->activity = true;
+		}
+		td->activity_now = true;
+		/* and in any case this is our preferred finger */
+		input_event(input, EV_ABS, ABS_X, td->x);
+		input_event(input, EV_ABS, ABS_Y, td->y);
+	}
+}
+
+
+static int t230h_event(struct hid_device *hid, struct hid_field *field,
+				struct hid_usage *usage, __s32 value)
+{
+	struct t230h_data *td = hid_get_drvdata(hid);
+
+	if (hid->claimed & HID_CLAIMED_INPUT) {
+		struct input_dev *input = field->hidinput->input;
+
+		switch (usage->hid) {
+		case HID_DG_INRANGE:
+			td->valid = !!value;
+			break;
+		case HID_GD_X:
+			td->x = value;
+			break;
+		case HID_GD_Y:
+			td->y = value;
+			t230h_filter_event(td, input);
+			break;
+		case HID_DG_CONTACTID:
+			td->id = value;
+			break;
+		case HID_DG_CONTACTCOUNT:
+			/* touch emulation: this is the last field in a frame */
+			td->first = false;
+			td->activity_now = false;
+			break;
+		case HID_DG_CONFIDENCE:
+		case HID_DG_TIPSWITCH:
+			/* avoid interference from generic hidinput handling */
+			break;
+
+		default:
+			/* fallback to the generic hidinput handling */
+			return 0;
+		}
+	}
+
+	/* we have handled the hidinput part, now remains hiddev */
+	if (hid->claimed & HID_CLAIMED_HIDDEV && hid->hiddev_hid_event)
+		hid->hiddev_hid_event(hid, field, usage, value);
+
+	return 1;
+}
+
+static int t230h_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	int ret;
+	struct t230h_data *td;
+
+	td = kmalloc(sizeof(struct t230h_data), GFP_KERNEL);
+	if (!td) {
+		dev_err(&hdev->dev, "cannot allocate T230H data\n");
+		return -ENOMEM;
+	}
+	td->valid = false;
+	td->activity = false;
+	td->activity_now = false;
+	td->first = false;
+	hid_set_drvdata(hdev, td);
+
+	ret = hid_parse(hdev);
+	if (!ret)
+		ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+
+	if (ret)
+		kfree(td);
+
+	return ret;
+}
+
+static void t230h_remove(struct hid_device *hdev)
+{
+	hid_hw_stop(hdev);
+	kfree(hid_get_drvdata(hdev));
+	hid_set_drvdata(hdev, NULL);
+}
+
+static const struct hid_device_id t230h_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ACER, USB_DEVICE_ID_ACER_T230H) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, t230h_devices);
+
+static const struct hid_usage_id t230h_grabbed_usages[] = {
+	{ HID_ANY_ID, HID_ANY_ID, HID_ANY_ID },
+	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1}
+};
+
+static struct hid_driver t230h_driver = {
+	.name = "t230h",
+	.id_table = t230h_devices,
+	.probe = t230h_probe,
+	.remove = t230h_remove,
+	.input_mapping = t230h_input_mapping,
+	.input_mapped = t230h_input_mapped,
+	.usage_table = t230h_grabbed_usages,
+	.event = t230h_event,
+};
+
+static int __init t230h_init(void)
+{
+	return hid_register_driver(&t230h_driver);
+}
+
+static void __exit t230h_exit(void)
+{
+	hid_unregister_driver(&t230h_driver);
+}
+
+module_init(t230h_init);
+module_exit(t230h_exit);
+
diff -rupN a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
--- a/drivers/hid/hid-core.c	2010-01-10 20:40:31.000000000 +0100
+++ b/drivers/hid/hid-core.c	2010-01-10 20:42:13.000000000 +0100
@@ -1225,6 +1225,7 @@ static const struct hid_device_id hid_bl
 	{ HID_USB_DEVICE(USB_VENDOR_ID_3M, USB_DEVICE_ID_3M1968) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_WCP32PU) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_X5_005D) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ACER, USB_DEVICE_ID_ACER_T230H) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ATV_IRCONTROL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL4) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MIGHTYMOUSE) },
diff -rupN a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
--- a/drivers/hid/hid-ids.h	2010-01-10 20:44:34.000000000 +0100
+++ b/drivers/hid/hid-ids.h	2010-01-10 20:32:16.000000000 +0100
@@ -33,6 +33,9 @@
 #define USB_DEVICE_ID_ACECAD_FLAIR	0x0004
 #define USB_DEVICE_ID_ACECAD_302	0x0008
 
+#define USB_VENDOR_ID_ACER		0x0408
+#define USB_DEVICE_ID_ACER_T230H	0x3000
+
 #define USB_VENDOR_ID_ADS_TECH 		0x06e1
 #define USB_DEVICE_ID_ADS_TECH_RADIO_SI470X	0xa155
 
diff -rupN a/drivers/hid/Kconfig b/drivers/hid/Kconfig
--- a/drivers/hid/Kconfig	2010-01-10 19:51:37.000000000 +0100
+++ b/drivers/hid/Kconfig	2010-01-10 19:51:07.000000000 +0100
@@ -83,6 +83,12 @@ config HID_A4TECH
 	---help---
 	Support for A4 tech X5 and WOP-35 / Trust 450L mice.
 
+config HID_ACER
+	tristate "ACER T230H" if EMBEDDED
+	depends on USB_HID
+	---help---
+	Support for ACER T230H multitouch panel.
+
 config HID_APPLE
 	tristate "Apple" if EMBEDDED
 	depends on (USB_HID || BT_HIDP)
diff -rupN a/drivers/hid/Makefile b/drivers/hid/Makefile
--- a/drivers/hid/Makefile	2010-01-10 19:52:41.000000000 +0100
+++ b/drivers/hid/Makefile	2010-01-10 19:52:23.000000000 +0100
@@ -18,6 +18,7 @@ endif
 
 obj-$(CONFIG_HID_3M_PCT)	+= hid-3m-pct.o
 obj-$(CONFIG_HID_A4TECH)	+= hid-a4tech.o
+obj-$(CONFIG_HID_ACER)		+= hid-acer.o
 obj-$(CONFIG_HID_APPLE)		+= hid-apple.o
 obj-$(CONFIG_HID_BELKIN)	+= hid-belkin.o
 obj-$(CONFIG_HID_CHERRY)	+= hid-cherry.o
