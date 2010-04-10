From: chatty@lii-enac.fr (Stephane Chatty)
Subject: [PATCH] Support for the eGalax dual-touch panel
Date: Sat, 10 Apr 2010 16:43:08 +0200
Message-ID: <20100410144308.9ABEE951F6@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:35327 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594Ab0DJOnL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Apr 2010 10:43:11 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, jkosina@suse.cz, linux-input@vger.kernel.org
Cc: linux@philmerk.de, chatty@enac.fr


Added support for the eGalax dual-touch panel, found on the Asus EeePC T101MT

Signed-off-by: Stephane Chatty <chatty@enac.fr>
Tested-by: Philipp Merkel <linux@philmerk.de>

diff -rupN a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
--- a/drivers/hid/hid-core.c	2010-04-10 17:33:43.000000000 +0200
+++ b/drivers/hid/hid-core.c	2010-04-07 00:02:12.000000000 +0200
@@ -1280,6 +1280,7 @@ static const struct hid_device_id hid_bl
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_BARCODE_2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_MOUSE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, 0x0006) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_EZKEY, USB_DEVICE_ID_BTC_8193) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMERON, USB_DEVICE_ID_GAMERON_DUAL_PSX_ADAPTOR) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMERON, USB_DEVICE_ID_GAMERON_DUAL_PCS_ADAPTOR) },
diff -rupN a/drivers/hid/hid-egalax.c b/drivers/hid/hid-egalax.c
--- a/drivers/hid/hid-egalax.c	1970-01-01 01:00:00.000000000 +0100
+++ b/drivers/hid/hid-egalax.c	2010-04-10 17:31:47.000000000 +0200
@@ -0,0 +1,280 @@
+/*
+ *  HID driver for eGalax dual-touch panels
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
+#include <linux/usb.h>
+#include "usbhid/usbhid.h"
+
+MODULE_AUTHOR("Stephane Chatty <chatty@enac.fr>");
+MODULE_DESCRIPTION("eGalax dual-touch panel");
+MODULE_LICENSE("GPL");
+
+#include "hid-ids.h"
+
+struct egalax_data {
+	__u16 x, y, z;
+	__u8 id;
+	bool first;		/* is this the first finger in the frame? */
+	bool valid;		/* valid finger data, or just placeholder? */
+	bool activity;		/* at least one active finger previously? */
+	__u16 lastx, lasty;	/* latest valid (x, y) in the frame */
+};
+
+static int egalax_input_mapping(struct hid_device *hdev, struct hid_input *hi,
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
+			/* touchscreen emulation */
+			hid_map_usage(hi, usage, bit, max, EV_KEY, BTN_TOUCH);
+			return 1;
+		case HID_DG_INRANGE:
+		case HID_DG_CONFIDENCE:
+		case HID_DG_CONTACTCOUNT:
+		case HID_DG_CONTACTMAX:
+			return -1;
+		case HID_DG_CONTACTID:
+			hid_map_usage(hi, usage, bit, max,
+					EV_ABS, ABS_MT_TRACKING_ID);
+			return 1;
+		case HID_DG_TIPPRESSURE:
+			hid_map_usage(hi, usage, bit, max,
+					EV_ABS, ABS_MT_PRESSURE);
+			return 1;
+		}
+		return 0;
+	}
+
+	/* ignore others (from other reports we won't get anyway) */
+	return -1;
+}
+
+static int egalax_input_mapped(struct hid_device *hdev, struct hid_input *hi,
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
+static void egalax_filter_event(struct egalax_data *td, struct input_dev *input)
+{
+	td->first = !td->first; /* touchscreen emulation */
+
+	if (td->valid) {
+		/* emit multitouch events */
+		input_event(input, EV_ABS, ABS_MT_TRACKING_ID, td->id);
+		input_event(input, EV_ABS, ABS_MT_POSITION_X, td->x);
+		input_event(input, EV_ABS, ABS_MT_POSITION_Y, td->y);
+		input_event(input, EV_ABS, ABS_MT_PRESSURE, td->z);
+
+		input_mt_sync(input);
+
+		/*
+		 * touchscreen emulation: store (x, y) as
+		 * the last valid values in this frame
+		 */
+		td->lastx = td->x;
+		td->lasty = td->y;
+	}
+
+	/*
+	 * touchscreen emulation: if this is the second finger and at least
+	 * one in this frame is valid, the latest valid in the frame is
+	 * the oldest on the panel, the one we want for single touch
+	 */
+	if (!td->first && td->activity) {
+		input_event(input, EV_ABS, ABS_X, td->lastx);
+		input_event(input, EV_ABS, ABS_Y, td->lasty);
+	}
+
+	if (!td->valid) {
+		/*
+		 * touchscreen emulation: if the first finger is invalid
+		 * and there previously was finger activity, this is a release
+		 */ 
+		if (td->first && td->activity) {
+			input_event(input, EV_KEY, BTN_TOUCH, 0);
+			td->activity = false;
+		}
+		return;
+	}
+
+
+	/* touchscreen emulation: if no previous activity, emit touch event */
+	if (!td->activity) {
+		input_event(input, EV_KEY, BTN_TOUCH, 1);
+		td->activity = true;
+	}
+}
+
+
+static int egalax_event(struct hid_device *hid, struct hid_field *field,
+				struct hid_usage *usage, __s32 value)
+{
+	struct egalax_data *td = hid_get_drvdata(hid);
+
+	if (hid->claimed & HID_CLAIMED_INPUT) {
+		struct input_dev *input = field->hidinput->input;
+
+		switch (usage->hid) {
+		case HID_DG_INRANGE:
+		case HID_DG_CONFIDENCE:
+			/* avoid interference from generic hidinput handling */
+			break;
+		case HID_DG_TIPSWITCH:
+			td->valid = value;
+			break;
+		case HID_DG_TIPPRESSURE:
+			td->z = value;
+			break;
+		case HID_DG_CONTACTID:
+			td->id = value;
+			break;
+		case HID_GD_X:
+			td->x = value;
+			break;
+		case HID_GD_Y:
+			td->y = value;
+			/* this is the last field in a finger */
+			egalax_filter_event(td, input);
+			break;
+		case HID_DG_CONTACTCOUNT:
+			/* touch emulation: this is the last field in a frame */
+			td->first = false;
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
+static int egalax_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	int ret;
+	struct egalax_data *td;
+	struct hid_report *report;
+
+	td = kmalloc(sizeof(struct egalax_data), GFP_KERNEL);
+	if (!td) {
+		dev_err(&hdev->dev, "cannot allocate eGalax data\n");
+		return -ENOMEM;
+	}
+	hid_set_drvdata(hdev, td);
+
+	ret = hid_parse(hdev);
+	if (ret)
+		goto end;
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret)
+		goto end;
+
+	report = hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[5]; 
+	if (report) {
+		report->field[0]->value[0] = 2;
+		usbhid_submit_report(hdev, report, USB_DIR_OUT);
+	}
+
+end:
+	if (ret)
+		kfree(td);
+
+	return ret;
+}
+
+static void egalax_remove(struct hid_device *hdev)
+{
+	hid_hw_stop(hdev);
+	kfree(hid_get_drvdata(hdev));
+	hid_set_drvdata(hdev, NULL);
+}
+
+static const struct hid_device_id egalax_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, egalax_devices);
+
+static const struct hid_usage_id egalax_grabbed_usages[] = {
+	{ HID_ANY_ID, HID_ANY_ID, HID_ANY_ID },
+	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1}
+};
+
+static struct hid_driver egalax_driver = {
+	.name = "egalax-touch",
+	.id_table = egalax_devices,
+	.probe = egalax_probe,
+	.remove = egalax_remove,
+	.input_mapping = egalax_input_mapping,
+	.input_mapped = egalax_input_mapped,
+	.usage_table = egalax_grabbed_usages,
+	.event = egalax_event,
+};
+
+static int __init egalax_init(void)
+{
+	return hid_register_driver(&egalax_driver);
+}
+
+static void __exit egalax_exit(void)
+{
+	hid_unregister_driver(&egalax_driver);
+}
+
+module_init(egalax_init);
+module_exit(egalax_exit);
+
diff -rupN a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
--- a/drivers/hid/hid-ids.h	2010-04-10 17:33:34.000000000 +0200
+++ b/drivers/hid/hid-ids.h	2010-04-07 00:02:12.000000000 +0200
@@ -164,6 +164,9 @@
 
 #define USB_VENDOR_ID_DRAGONRISE	0x0079
 
+#define USB_VENDOR_ID_DWAV		0x0eef
+#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH	0x480d
+
 #define USB_VENDOR_ID_ELO		0x04E7
 #define USB_DEVICE_ID_ELO_TS2700	0x0020
 
diff -rupN a/drivers/hid/Kconfig b/drivers/hid/Kconfig
--- a/drivers/hid/Kconfig	2010-04-10 17:29:33.000000000 +0200
+++ b/drivers/hid/Kconfig	2010-04-07 00:02:12.000000000 +0200
@@ -144,6 +144,12 @@ config DRAGONRISE_FF
 	Say Y here if you want to enable force feedback support for DragonRise Inc.
 	game controllers.
 
+config HID_EGALAX
+	tristate "eGalax multi-touch panel"
+	depends on USB_HID
+	---help---
+	Support for the eGalax dual-touch panel
+
 config HID_EZKEY
 	tristate "Ezkey" if EMBEDDED
 	depends on USB_HID
diff -rupN a/drivers/hid/Makefile b/drivers/hid/Makefile
--- a/drivers/hid/Makefile	2010-04-10 17:33:14.000000000 +0200
+++ b/drivers/hid/Makefile	2010-04-10 17:30:32.000000000 +0200
@@ -23,6 +23,7 @@ obj-$(CONFIG_HID_CHERRY)	+= hid-cherry.o
 obj-$(CONFIG_HID_CHICONY)	+= hid-chicony.o
 obj-$(CONFIG_HID_CYPRESS)	+= hid-cypress.o
 obj-$(CONFIG_HID_DRAGONRISE)	+= hid-drff.o
+obj-$(CONFIG_HID_EGALAX)	+= hid-egalax.o
 obj-$(CONFIG_HID_EZKEY)		+= hid-ezkey.o
 obj-$(CONFIG_HID_GYRATION)	+= hid-gyration.o
 obj-$(CONFIG_HID_KENSINGTON)	+= hid-kensington.o
