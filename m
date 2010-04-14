From: chatty@lii-enac.fr (Stephane Chatty)
Subject: [PATCH] Added support for the Cando dual touch panel
Date: Wed, 14 Apr 2010 21:03:41 +0200
Message-ID: <20100414190341.25BD8951EF@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:49369 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab0DNTDm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Apr 2010 15:03:42 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, jkosina@suse.cz, linux-input@vger.kernel.org
Cc: priya.vijayan@intel.com, floe@butterbrot.org, chatty@enac.fr


Added support for the Cando dual touch panels, found in the Lenovo S10-3t.

Signed-off-by: Stephane Chatty <chatty@enac.fr>
Tested-by: Priya Vijayan <priya.vijayan@intel.com>
Tested-by: Florian Echtler <floe@butterbrot.org>

diff -rupN a/drivers/hid/hid-cando.c b/drivers/hid/hid-cando.c
--- a/drivers/hid/hid-cando.c	1970-01-01 01:00:00.000000000 +0100
+++ b/drivers/hid/hid-cando.c	2010-04-14 13:31:02.000000000 +0200
@@ -0,0 +1,267 @@
+/*
+ *  HID driver for Cando dual-touch panels
+ *
+ *  Copyright (c) 2010 Stephane Chatty <chatty@enac.fr>
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
+#include <linux/slab.h>
+
+MODULE_AUTHOR("Stephane Chatty <chatty@enac.fr>");
+MODULE_DESCRIPTION("Cando dual-touch panel");
+MODULE_LICENSE("GPL");
+
+#include "hid-ids.h"
+
+struct cando_data {
+	__u16 x, y;
+	__u8 id;
+	__s8 oldest;		/* id of the oldest finger in previous frame */
+	bool valid;		/* valid finger data, or just placeholder? */
+	bool first;		/* is this the first finger in this frame? */
+	__s8 firstid;		/* id of the first finger in the frame */
+	__u16 firstx, firsty;	/* (x, y) of the first finger in the frame */
+};
+
+static int cando_input_mapping(struct hid_device *hdev, struct hid_input *hi,
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
+		case HID_DG_TIPSWITCH:
+		case HID_DG_CONTACTMAX:
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
+	}
+
+	return 0;
+}
+
+static int cando_input_mapped(struct hid_device *hdev, struct hid_input *hi,
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
+static void cando_filter_event(struct cando_data *td, struct input_dev *input)
+{
+	td->first = !td->first; /* touchscreen emulation */
+
+	if (!td->valid) {
+		/*
+		 * touchscreen emulation: if this is the second finger and
+		 * the first was valid, the first was the oldest; if the
+		 * first was not valid and there was a valid finger in the
+		 * previous frame, this is a release.
+		 */
+		if (td->first) {
+			td->firstid = -1;
+		} else if (td->firstid >= 0) {
+			input_event(input, EV_ABS, ABS_X, td->firstx);
+			input_event(input, EV_ABS, ABS_Y, td->firsty);
+			td->oldest = td->firstid;
+		} else if (td->oldest >= 0) {
+			input_event(input, EV_KEY, BTN_TOUCH, 0);
+			td->oldest = -1;
+		}
+
+		return;
+	}
+	
+	input_event(input, EV_ABS, ABS_MT_TRACKING_ID, td->id);
+	input_event(input, EV_ABS, ABS_MT_POSITION_X, td->x);
+	input_event(input, EV_ABS, ABS_MT_POSITION_Y, td->y);
+
+	input_mt_sync(input);
+
+	/*
+	 * touchscreen emulation: if there was no touching finger previously,
+	 * emit touch event
+	 */
+	if (td->oldest < 0) {
+		input_event(input, EV_KEY, BTN_TOUCH, 1);
+		td->oldest = td->id;
+	}
+
+	/*
+	 * touchscreen emulation: if this is the first finger, wait for the
+	 * second; the oldest is then the second if it was the oldest already
+	 * or if there was no first, the first otherwise.
+	 */
+	if (td->first) {
+		td->firstx = td->x;
+		td->firsty = td->y;
+		td->firstid = td->id;
+	} else {
+		int x, y, oldest;
+		if (td->id == td->oldest || td->firstid < 0) {
+			x = td->x;
+			y = td->y;
+			oldest = td->id;
+		} else {
+			x = td->firstx;
+			y = td->firsty;
+			oldest = td->firstid;
+		}
+		input_event(input, EV_ABS, ABS_X, x);
+		input_event(input, EV_ABS, ABS_Y, y);
+		td->oldest = oldest;
+	}
+}
+
+
+static int cando_event(struct hid_device *hid, struct hid_field *field,
+				struct hid_usage *usage, __s32 value)
+{
+	struct cando_data *td = hid_get_drvdata(hid);
+
+	if (hid->claimed & HID_CLAIMED_INPUT) {
+		struct input_dev *input = field->hidinput->input;
+
+		switch (usage->hid) {
+		case HID_DG_INRANGE:
+			td->valid = value;
+			break;
+		case HID_DG_CONTACTID:
+			td->id = value;
+			break;
+		case HID_GD_X:
+			td->x = value;
+			break;
+		case HID_GD_Y:
+			td->y = value;
+			cando_filter_event(td, input);
+			break;
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
+static int cando_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	int ret;
+	struct cando_data *td;
+
+	td = kmalloc(sizeof(struct cando_data), GFP_KERNEL);
+	if (!td) {
+		dev_err(&hdev->dev, "cannot allocate Cando Touch data\n");
+		return -ENOMEM;
+	}
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
+static void cando_remove(struct hid_device *hdev)
+{
+	hid_hw_stop(hdev);
+	kfree(hid_get_drvdata(hdev));
+	hid_set_drvdata(hdev, NULL);
+}
+
+static const struct hid_device_id cando_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
+			USB_DEVICE_ID_CANDO_MULTI_TOUCH) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, cando_devices);
+
+static const struct hid_usage_id cando_grabbed_usages[] = {
+	{ HID_ANY_ID, HID_ANY_ID, HID_ANY_ID },
+	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1}
+};
+
+static struct hid_driver cando_driver = {
+	.name = "cando-touch",
+	.id_table = cando_devices,
+	.probe = cando_probe,
+	.remove = cando_remove,
+	.input_mapping = cando_input_mapping,
+	.input_mapped = cando_input_mapped,
+	.usage_table = cando_grabbed_usages,
+	.event = cando_event,
+};
+
+static int __init cando_init(void)
+{
+	return hid_register_driver(&cando_driver);
+}
+
+static void __exit cando_exit(void)
+{
+	hid_unregister_driver(&cando_driver);
+}
+
+module_init(cando_init);
+module_exit(cando_exit);
+
diff -rupN a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
--- a/drivers/hid/hid-core.c	2010-04-14 13:35:17.000000000 +0200
+++ b/drivers/hid/hid-core.c	2010-04-07 23:14:42.000000000 +0200
@@ -1295,6 +1295,7 @@ static const struct hid_device_id hid_bl
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BELKIN, USB_DEVICE_ID_FLIP_KVM) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CANDO, USB_DEVICE_ID_CANDO_MULTI_TOUCH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHERRY, USB_DEVICE_ID_CHERRY_CYMOTION) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_TACTICAL_PAD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_BARCODE_1) },
diff -rupN a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
--- a/drivers/hid/hid-ids.h	2010-04-14 13:35:09.000000000 +0200
+++ b/drivers/hid/hid-ids.h	2010-04-07 23:14:25.000000000 +0200
@@ -123,6 +123,9 @@
 #define USB_VENDOR_ID_BERKSHIRE		0x0c98
 #define USB_DEVICE_ID_BERKSHIRE_PCWD	0x1140
 
+#define USB_VENDOR_ID_CANDO		0x2087
+#define USB_DEVICE_ID_CANDO_MULTI_TOUCH 0x0a01
+
 #define USB_VENDOR_ID_CH		0x068e
 #define USB_DEVICE_ID_CH_PRO_PEDALS	0x00f2
 #define USB_DEVICE_ID_CH_COMBATSTICK	0x00f4
diff -rupN a/drivers/hid/Kconfig b/drivers/hid/Kconfig
--- a/drivers/hid/Kconfig	2010-04-14 13:34:46.000000000 +0200
+++ b/drivers/hid/Kconfig	2010-04-14 13:34:08.000000000 +0200
@@ -86,6 +86,12 @@ config HID_BELKIN
 	---help---
 	Support for Belkin Flip KVM and Wireless keyboard.
 
+config HID_CANDO
+	tristate "Cando dual touch panel"
+	depends on USB_HID
+	---help---
+	Support for Cando dual touch panel.
+
 config HID_CHERRY
 	tristate "Cherry" if EMBEDDED
 	depends on USB_HID
diff -rupN a/drivers/hid/Makefile b/drivers/hid/Makefile
--- a/drivers/hid/Makefile	2010-04-14 13:34:37.000000000 +0200
+++ b/drivers/hid/Makefile	2010-04-14 13:33:16.000000000 +0200
@@ -26,6 +26,7 @@ obj-$(CONFIG_HID_3M_PCT)	+= hid-3m-pct.o
 obj-$(CONFIG_HID_A4TECH)	+= hid-a4tech.o
 obj-$(CONFIG_HID_APPLE)		+= hid-apple.o
 obj-$(CONFIG_HID_BELKIN)	+= hid-belkin.o
+obj-$(CONFIG_HID_CANDO)		+= hid-cando.o
 obj-$(CONFIG_HID_CHERRY)	+= hid-cherry.o
 obj-$(CONFIG_HID_CHICONY)	+= hid-chicony.o
 obj-$(CONFIG_HID_CYPRESS)	+= hid-cypress.o
