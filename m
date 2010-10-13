From: chatty@lii-enac.fr (Stephane Chatty)
Subject: [PATCH 2/4] hid-multitouch: migrated support for Cando panels
Date: Thu, 14 Oct 2010 00:32:26 +0200
Message-ID: <20101013223226.44EF49522C@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:41595 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab0JMWke (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 18:40:34 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: rydberg@euromail.se, dmitry.torokhov@gmail.com, jkosina@suse.cz, linux-input@vger.kernel.org
Cc: chatty@enac.fr

Migrated support for Cando dual-touch panels to the new HID multitouch driver.

Signed-off-by: Stephane Chatty <chatty@enac.fr>

diff -rupN b/drivers/hid/hid-cando.c c/drivers/hid/hid-cando.c
--- b/drivers/hid/hid-cando.c	2010-07-05 05:22:50.000000000 +0200
+++ c/drivers/hid/hid-cando.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,272 +0,0 @@
-/*
- *  HID driver for Cando dual-touch panels
- *
- *  Copyright (c) 2010 Stephane Chatty <chatty@enac.fr>
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
-
-MODULE_AUTHOR("Stephane Chatty <chatty@enac.fr>");
-MODULE_DESCRIPTION("Cando dual-touch panel");
-MODULE_LICENSE("GPL");
-
-#include "hid-ids.h"
-
-struct cando_data {
-	__u16 x, y;
-	__u8 id;
-	__s8 oldest;		/* id of the oldest finger in previous frame */
-	bool valid;		/* valid finger data, or just placeholder? */
-	bool first;		/* is this the first finger in this frame? */
-	__s8 firstid;		/* id of the first finger in the frame */
-	__u16 firstx, firsty;	/* (x, y) of the first finger in the frame */
-};
-
-static int cando_input_mapping(struct hid_device *hdev, struct hid_input *hi,
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
-		case HID_DG_TIPSWITCH:
-		case HID_DG_CONTACTMAX:
-			return -1;
-		case HID_DG_INRANGE:
-			/* touchscreen emulation */
-			hid_map_usage(hi, usage, bit, max, EV_KEY, BTN_TOUCH);
-			return 1;
-		case HID_DG_CONTACTID:
-			hid_map_usage(hi, usage, bit, max,
-					EV_ABS, ABS_MT_TRACKING_ID);
-			return 1;
-		}
-		return 0;
-	}
-
-	return 0;
-}
-
-static int cando_input_mapped(struct hid_device *hdev, struct hid_input *hi,
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
-static void cando_filter_event(struct cando_data *td, struct input_dev *input)
-{
-	td->first = !td->first; /* touchscreen emulation */
-
-	if (!td->valid) {
-		/*
-		 * touchscreen emulation: if this is the second finger and
-		 * the first was valid, the first was the oldest; if the
-		 * first was not valid and there was a valid finger in the
-		 * previous frame, this is a release.
-		 */
-		if (td->first) {
-			td->firstid = -1;
-		} else if (td->firstid >= 0) {
-			input_event(input, EV_ABS, ABS_X, td->firstx);
-			input_event(input, EV_ABS, ABS_Y, td->firsty);
-			td->oldest = td->firstid;
-		} else if (td->oldest >= 0) {
-			input_event(input, EV_KEY, BTN_TOUCH, 0);
-			td->oldest = -1;
-		}
-
-		return;
-	}
-	
-	input_event(input, EV_ABS, ABS_MT_TRACKING_ID, td->id);
-	input_event(input, EV_ABS, ABS_MT_POSITION_X, td->x);
-	input_event(input, EV_ABS, ABS_MT_POSITION_Y, td->y);
-
-	input_mt_sync(input);
-
-	/*
-	 * touchscreen emulation: if there was no touching finger previously,
-	 * emit touch event
-	 */
-	if (td->oldest < 0) {
-		input_event(input, EV_KEY, BTN_TOUCH, 1);
-		td->oldest = td->id;
-	}
-
-	/*
-	 * touchscreen emulation: if this is the first finger, wait for the
-	 * second; the oldest is then the second if it was the oldest already
-	 * or if there was no first, the first otherwise.
-	 */
-	if (td->first) {
-		td->firstx = td->x;
-		td->firsty = td->y;
-		td->firstid = td->id;
-	} else {
-		int x, y, oldest;
-		if (td->id == td->oldest || td->firstid < 0) {
-			x = td->x;
-			y = td->y;
-			oldest = td->id;
-		} else {
-			x = td->firstx;
-			y = td->firsty;
-			oldest = td->firstid;
-		}
-		input_event(input, EV_ABS, ABS_X, x);
-		input_event(input, EV_ABS, ABS_Y, y);
-		td->oldest = oldest;
-	}
-}
-
-
-static int cando_event(struct hid_device *hid, struct hid_field *field,
-				struct hid_usage *usage, __s32 value)
-{
-	struct cando_data *td = hid_get_drvdata(hid);
-
-	if (hid->claimed & HID_CLAIMED_INPUT) {
-		struct input_dev *input = field->hidinput->input;
-
-		switch (usage->hid) {
-		case HID_DG_INRANGE:
-			td->valid = value;
-			break;
-		case HID_DG_CONTACTID:
-			td->id = value;
-			break;
-		case HID_GD_X:
-			td->x = value;
-			break;
-		case HID_GD_Y:
-			td->y = value;
-			cando_filter_event(td, input);
-			break;
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
-static int cando_probe(struct hid_device *hdev, const struct hid_device_id *id)
-{
-	int ret;
-	struct cando_data *td;
-
-	td = kmalloc(sizeof(struct cando_data), GFP_KERNEL);
-	if (!td) {
-		dev_err(&hdev->dev, "cannot allocate Cando Touch data\n");
-		return -ENOMEM;
-	}
-	hid_set_drvdata(hdev, td);
-	td->first = false;
-	td->oldest = -1;
-	td->valid = false;
-
-	ret = hid_parse(hdev);
-	if (!ret)
-		ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
-
-	if (ret)
-		kfree(td);
-
-	return ret;
-}
-
-static void cando_remove(struct hid_device *hdev)
-{
-	hid_hw_stop(hdev);
-	kfree(hid_get_drvdata(hdev));
-	hid_set_drvdata(hdev, NULL);
-}
-
-static const struct hid_device_id cando_devices[] = {
-	{ HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
-			USB_DEVICE_ID_CANDO_MULTI_TOUCH) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
-			USB_DEVICE_ID_CANDO_MULTI_TOUCH_11_6) },
-	{ }
-};
-MODULE_DEVICE_TABLE(hid, cando_devices);
-
-static const struct hid_usage_id cando_grabbed_usages[] = {
-	{ HID_ANY_ID, HID_ANY_ID, HID_ANY_ID },
-	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1}
-};
-
-static struct hid_driver cando_driver = {
-	.name = "cando-touch",
-	.id_table = cando_devices,
-	.probe = cando_probe,
-	.remove = cando_remove,
-	.input_mapping = cando_input_mapping,
-	.input_mapped = cando_input_mapped,
-	.usage_table = cando_grabbed_usages,
-	.event = cando_event,
-};
-
-static int __init cando_init(void)
-{
-	return hid_register_driver(&cando_driver);
-}
-
-static void __exit cando_exit(void)
-{
-	hid_unregister_driver(&cando_driver);
-}
-
-module_init(cando_init);
-module_exit(cando_exit);
-
diff -rupN b/drivers/hid/hid-multitouch.c c/drivers/hid/hid-multitouch.c
--- b/drivers/hid/hid-multitouch.c	2010-10-14 01:30:59.009937031 +0200
+++ c/drivers/hid/hid-multitouch.c	2010-10-14 01:31:48.572936984 +0200
@@ -56,6 +56,7 @@ struct mt_class {
 
 /* classes of device behavior */
 #define DUAL1 0
+#define DUAL2 1
 
 /* contact data that only some devices report */
 #define PRESSURE 	(1 << 0)
@@ -71,8 +72,15 @@ static int slot_from_contactid(struct mt
 	return td->curcontactid;
 }
 
+static int slot_from_contactnumber(struct mt_device *td)
+{
+	return td->curcontact;
+}
+
+
 struct mt_class mt_classes[] = {
 	/* DUAL1 */		{ slot_from_contactid, 2, -1 },
+	/* DUAL2 */		{ slot_from_contactnumber, 2, -1 },
 };
 
 
@@ -363,6 +371,14 @@ static const struct hid_device_id mt_dev
 		HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
 			USB_DEVICE_ID_CANDO_PIXCIR_MULTI_TOUCH) },
 
+	/* Cando panels */
+	{ .driver_data = DUAL2,
+		HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
+			USB_DEVICE_ID_CANDO_MULTI_TOUCH) },
+	{ .driver_data = DUAL2,
+		HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
+			USB_DEVICE_ID_CANDO_MULTI_TOUCH_11_6) },
+
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, mt_devices);
diff -rupN b/drivers/hid/Kconfig c/drivers/hid/Kconfig
--- b/drivers/hid/Kconfig	2010-10-14 01:42:37.964936879 +0200
+++ c/drivers/hid/Kconfig	2010-10-14 01:43:46.000936910 +0200
@@ -94,12 +94,6 @@ config HID_BELKIN
 	---help---
 	Support for Belkin Flip KVM and Wireless keyboard.
 
-config HID_CANDO
-	tristate "Cando dual touch panel"
-	depends on USB_HID
-	---help---
-	Support for Cando dual touch panel.
-
 config HID_CHERRY
 	tristate "Cherry" if EMBEDDED
 	depends on USB_HID
diff -rupN b/drivers/hid/Makefile c/drivers/hid/Makefile
--- b/drivers/hid/Makefile	2010-10-14 01:40:25.571936977 +0200
+++ c/drivers/hid/Makefile	2010-10-14 01:43:35.807936552 +0200
@@ -27,7 +27,6 @@ obj-$(CONFIG_HID_A4TECH)	+= hid-a4tech.o
 obj-$(CONFIG_HID_ACRUX_FF)	+= hid-axff.o
 obj-$(CONFIG_HID_APPLE)		+= hid-apple.o
 obj-$(CONFIG_HID_BELKIN)	+= hid-belkin.o
-obj-$(CONFIG_HID_CANDO)		+= hid-cando.o
 obj-$(CONFIG_HID_CHERRY)	+= hid-cherry.o
 obj-$(CONFIG_HID_CHICONY)	+= hid-chicony.o
 obj-$(CONFIG_HID_CYPRESS)	+= hid-cypress.o
