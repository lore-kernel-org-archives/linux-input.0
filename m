From: chatty@lii-enac.fr (Stephane Chatty)
Subject: [PATCH 4/4] hid-multitouch: migrated support for MosArt panels
Date: Thu, 14 Oct 2010 00:35:14 +0200
Message-ID: <20101013223514.E383A9522F@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:38105 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523Ab0JMWfQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 18:35:16 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: rydberg@euromail.se, dmitry.torokhov@gmail.com, jkosina@suse.cz, linux-input@vger.kernel.org
Cc: chatty@enac.fr

Migrated support for MosArt dual-touch panels to the unified driver.

Signed-off-by: Stephane Chatty <chatty@enac.fr>

diff -rupN d/drivers/hid/hid-mosart.c e/drivers/hid/hid-mosart.c
--- d/drivers/hid/hid-mosart.c	2010-07-05 05:22:50.000000000 +0200
+++ e/drivers/hid/hid-mosart.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,274 +0,0 @@
-/*
- *  HID driver for the multitouch panel on the ASUS EeePC T91MT
- *
- *  Copyright (c) 2009-2010 Stephane Chatty <chatty@enac.fr>
- *  Copyright (c) 2010 Teemu Tuominen <teemu.tuominen@cybercom.com>
- *
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
- */
-
-#include <linux/device.h>
-#include <linux/hid.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/usb.h>
-#include "usbhid/usbhid.h"
-
-MODULE_AUTHOR("Stephane Chatty <chatty@enac.fr>");
-MODULE_DESCRIPTION("MosArt dual-touch panel");
-MODULE_LICENSE("GPL");
-
-#include "hid-ids.h"
-
-struct mosart_data {
-	__u16 x, y;
-	__u8 id;
-	bool valid;		/* valid finger data, or just placeholder? */
-	bool first;		/* is this the first finger in this frame? */
-	bool activity_now;	/* at least one active finger in this frame? */
-	bool activity;		/* at least one active finger previously? */
-};
-
-static int mosart_input_mapping(struct hid_device *hdev, struct hid_input *hi,
-		struct hid_field *field, struct hid_usage *usage,
-		unsigned long **bit, int *max)
-{
-	switch (usage->hid & HID_USAGE_PAGE) {
-
-	case HID_UP_GENDESK:
-		switch (usage->hid) {
-		case HID_GD_X:
-			hid_map_usage(hi, usage, bit, max,
-					EV_ABS, ABS_MT_POSITION_X);
-			/* touchscreen emulation */
-			input_set_abs_params(hi->input, ABS_X,
-						field->logical_minimum,
-						field->logical_maximum, 0, 0);
-			return 1;
-		case HID_GD_Y:
-			hid_map_usage(hi, usage, bit, max,
-					EV_ABS, ABS_MT_POSITION_Y);
-			/* touchscreen emulation */
-			input_set_abs_params(hi->input, ABS_Y,
-						field->logical_minimum,
-						field->logical_maximum, 0, 0);
-			return 1;
-		}
-		return 0;
-
-	case HID_UP_DIGITIZER:
-		switch (usage->hid) {
-		case HID_DG_CONFIDENCE:
-		case HID_DG_TIPSWITCH:
-		case HID_DG_INPUTMODE:
-		case HID_DG_DEVICEINDEX:
-		case HID_DG_CONTACTCOUNT:
-		case HID_DG_CONTACTMAX:
-		case HID_DG_TIPPRESSURE:
-		case HID_DG_WIDTH:
-		case HID_DG_HEIGHT:
-			return -1;
-		case HID_DG_INRANGE:
-			/* touchscreen emulation */
-			hid_map_usage(hi, usage, bit, max, EV_KEY, BTN_TOUCH);
-			return 1;
-
-		case HID_DG_CONTACTID:
-			hid_map_usage(hi, usage, bit, max,
-					EV_ABS, ABS_MT_TRACKING_ID);
-			return 1;
-
-		}
-		return 0;
-
-	case 0xff000000:
-		/* ignore HID features */
-		return -1;
-	}
-
-	return 0;
-}
-
-static int mosart_input_mapped(struct hid_device *hdev, struct hid_input *hi,
-		struct hid_field *field, struct hid_usage *usage,
-		unsigned long **bit, int *max)
-{
-	if (usage->type == EV_KEY || usage->type == EV_ABS)
-		clear_bit(usage->code, *bit);
-
-	return 0;
-}
-
-/*
- * this function is called when a whole finger has been parsed,
- * so that it can decide what to send to the input layer.
- */
-static void mosart_filter_event(struct mosart_data *td, struct input_dev *input)
-{
-	td->first = !td->first; /* touchscreen emulation */
-
-	if (!td->valid) {
-		/*
-		 * touchscreen emulation: if no finger in this frame is valid
-		 * and there previously was finger activity, this is a release
-		 */ 
-		if (!td->first && !td->activity_now && td->activity) {
-			input_event(input, EV_KEY, BTN_TOUCH, 0);
-			td->activity = false;
-		}
-		return;
-	}
-
-	input_event(input, EV_ABS, ABS_MT_TRACKING_ID, td->id);
-	input_event(input, EV_ABS, ABS_MT_POSITION_X, td->x);
-	input_event(input, EV_ABS, ABS_MT_POSITION_Y, td->y);
-
-	input_mt_sync(input);
-	td->valid = false;
-
-	/* touchscreen emulation: if first active finger in this frame... */
-	if (!td->activity_now) {
-		/* if there was no previous activity, emit touch event */
-		if (!td->activity) {
-			input_event(input, EV_KEY, BTN_TOUCH, 1);
-			td->activity = true;
-		}
-		td->activity_now = true;
-		/* and in any case this is our preferred finger */
-		input_event(input, EV_ABS, ABS_X, td->x);
-		input_event(input, EV_ABS, ABS_Y, td->y);
-	}
-}
-
-
-static int mosart_event(struct hid_device *hid, struct hid_field *field,
-				struct hid_usage *usage, __s32 value)
-{
-	struct mosart_data *td = hid_get_drvdata(hid);
-
-	if (hid->claimed & HID_CLAIMED_INPUT) {
-		struct input_dev *input = field->hidinput->input;
-		switch (usage->hid) {
-		case HID_DG_INRANGE:
-			td->valid = !!value;
-			break;
-		case HID_GD_X:
-			td->x = value;
-			break;
-		case HID_GD_Y:
-			td->y = value;
-			mosart_filter_event(td, input);
-			break;
-		case HID_DG_CONTACTID:
-			td->id = value;
-			break;
-		case HID_DG_CONTACTCOUNT:
-			/* touch emulation: this is the last field in a frame */
-			td->first = false;
-			td->activity_now = false;
-			break;
-		case HID_DG_CONFIDENCE:
-		case HID_DG_TIPSWITCH:
-			/* avoid interference from generic hidinput handling */
-			break;
-
-		default:
-			/* fallback to the generic hidinput handling */
-			return 0;
-		}
-	}
-
-	/* we have handled the hidinput part, now remains hiddev */
-	if (hid->claimed & HID_CLAIMED_HIDDEV && hid->hiddev_hid_event)
-		hid->hiddev_hid_event(hid, field, usage, value);
-
-	return 1;
-}
-
-static int mosart_probe(struct hid_device *hdev, const struct hid_device_id *id)
-{
-	int ret;
-	struct mosart_data *td;
-
-
-	td = kmalloc(sizeof(struct mosart_data), GFP_KERNEL);
-	if (!td) {
-		dev_err(&hdev->dev, "cannot allocate MosArt data\n");
-		return -ENOMEM;
-	}
-	td->valid = false;
-	td->activity = false;
-	td->activity_now = false;
-	td->first = false;
-	hid_set_drvdata(hdev, td);
-
-	/* currently, it's better to have one evdev device only */
-#if 0
-	hdev->quirks |= HID_QUIRK_MULTI_INPUT;
-#endif
-
-	ret = hid_parse(hdev);
-	if (ret == 0)
-		ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
-
-	if (ret == 0) {
-		struct hid_report_enum *re = hdev->report_enum
-						+ HID_FEATURE_REPORT;
-		struct hid_report *r = re->report_id_hash[7];
-
-		r->field[0]->value[0] = 0x02;
-		usbhid_submit_report(hdev, r, USB_DIR_OUT);
-	} else 
-		kfree(td);
-
-	return ret;
-}
-
-static void mosart_remove(struct hid_device *hdev)
-{
-	hid_hw_stop(hdev);
-	kfree(hid_get_drvdata(hdev));
-	hid_set_drvdata(hdev, NULL);
-}
-
-static const struct hid_device_id mosart_devices[] = {
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUS, USB_DEVICE_ID_ASUS_T91MT) },
-	{ }
-};
-MODULE_DEVICE_TABLE(hid, mosart_devices);
-
-static const struct hid_usage_id mosart_grabbed_usages[] = {
-	{ HID_ANY_ID, HID_ANY_ID, HID_ANY_ID },
-	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1}
-};
-
-static struct hid_driver mosart_driver = {
-	.name = "mosart",
-	.id_table = mosart_devices,
-	.probe = mosart_probe,
-	.remove = mosart_remove,
-	.input_mapping = mosart_input_mapping,
-	.input_mapped = mosart_input_mapped,
-	.usage_table = mosart_grabbed_usages,
-	.event = mosart_event,
-};
-
-static int __init mosart_init(void)
-{
-	return hid_register_driver(&mosart_driver);
-}
-
-static void __exit mosart_exit(void)
-{
-	hid_unregister_driver(&mosart_driver);
-}
-
-module_init(mosart_init);
-module_exit(mosart_exit);
-
diff -rupN d/drivers/hid/hid-multitouch.c e/drivers/hid/hid-multitouch.c
--- d/drivers/hid/hid-multitouch.c	2010-10-14 01:32:30.914936993 +0200
+++ e/drivers/hid/hid-multitouch.c	2010-10-14 01:24:07.308936859 +0200
@@ -58,6 +58,7 @@ struct mt_class {
 #define DUAL1 0
 #define DUAL2 1
 #define CYPRESS 2
+#define MOSART 3
 
 /* contact data that only some devices report */
 #define PRESSURE 	(1 << 0)
@@ -87,10 +88,16 @@ static int cypress_compute_slot(struct m
 }
 
 
+static int mosart_compute_slot(struct mt_device *td)
+{
+	return td->curcontactid - 1;
+}
+
 struct mt_class mt_classes[] = {
 	/* DUAL1 */		{ slot_from_contactid, 2, -1 },
 	/* DUAL2 */		{ slot_from_contactnumber, 2, -1 },
 	/* CYPRESS */		{ cypress_compute_slot, 10, 3 },
+	/* MOSART */		{ mosart_compute_slot, 2, 7 },
 };
 
 
@@ -394,6 +401,14 @@ static const struct hid_device_id mt_dev
 		HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS,
 			USB_DEVICE_ID_CYPRESS_TRUETOUCH) },
 
+	/* MosArt panels */
+	{ .driver_data = MOSART,
+		HID_USB_DEVICE(USB_VENDOR_ID_ASUS,
+			USB_DEVICE_ID_ASUS_T91MT)},
+	{ .driver_data = MOSART,
+		HID_USB_DEVICE(USB_VENDOR_ID_ASUS,
+			USB_DEVICE_ID_ASUSTEK_MULTITOUCH_YFO) },
+
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, mt_devices);
diff -rupN d/drivers/hid/Kconfig e/drivers/hid/Kconfig
--- d/drivers/hid/Kconfig	2010-10-14 01:43:46.000936910 +0200
+++ e/drivers/hid/Kconfig	2010-10-14 01:45:46.356936861 +0200
@@ -245,12 +245,6 @@ config HID_MICROSOFT
 	---help---
 	Support for Microsoft devices that are not fully compliant with HID standard.
 
-config HID_MOSART
-	tristate "MosArt"
-	depends on USB_HID
-	---help---
-	Support for MosArt dual-touch panels.
-
 config HID_MONTEREY
 	tristate "Monterey" if EMBEDDED
 	depends on USB_HID
diff -rupN d/drivers/hid/Makefile e/drivers/hid/Makefile
--- d/drivers/hid/Makefile	2010-10-14 01:43:35.807936552 +0200
+++ e/drivers/hid/Makefile	2010-10-14 01:45:36.731936963 +0200
@@ -41,7 +41,6 @@ obj-$(CONFIG_HID_LOGITECH)	+= hid-logite
 obj-$(CONFIG_HID_MAGICMOUSE)    += hid-magicmouse.o
 obj-$(CONFIG_HID_MICROSOFT)	+= hid-microsoft.o
 obj-$(CONFIG_HID_MONTEREY)	+= hid-monterey.o
-obj-$(CONFIG_HID_MOSART)	+= hid-mosart.o
 obj-$(CONFIG_HID_MULTITOUCH)	+= hid-multitouch.o
 obj-$(CONFIG_HID_NTRIG)		+= hid-ntrig.o
 obj-$(CONFIG_HID_ORTEK)		+= hid-ortek.o
