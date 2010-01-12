From: chatty@lii-enac.fr (Stephane Chatty)
Subject: Re: [PATCH] Support for Acer T230H multitouch
Date: Tue, 12 Jan 2010 23:39:36 +0100
Message-ID: <20100112223936.238A2951A0@smtp.lii-enac.fr>
References: <alpine.LNX.2.00.1001121545040.30977@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:45153 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887Ab0ALWji (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jan 2010 17:39:38 -0500
In-Reply-To: <alpine.LNX.2.00.1001121545040.30977@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, chatty@enac.fr
Cc: linux-input@vger.kernel.org, jerom3@free.fr, dmitry.torokhov@gmail.com, berthiec@gmail.com

Added support for the Quanta Optical Touch dual-touch panel,
present in the Acer T230H monitor, HP L2105tm, and Packard-Bell Video 200t.

Signed-off-by: Stephane Chatty <chatty@enac.fr>
Tested-by: Jerome Vidal <jerom3@free.fr>
Tested-by: Cedric Berthier <berthiec@gmail.com>
Acked-by: Dmitry Torokhov <dtor@mail.ru>

diff -rupN a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
--- a/drivers/hid/hid-core.c	2010-01-10 20:40:31.000000000 +0100
+++ b/drivers/hid/hid-core.c	2010-01-12 23:21:22.000000000 +0100
@@ -1306,6 +1306,7 @@ static const struct hid_device_id hid_bl
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MONTEREY, USB_DEVICE_ID_GENIUS_KB29E) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_TOUCH_SCREEN) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PETALYNX, USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE) },
diff -rupN a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
--- a/drivers/hid/hid-ids.h	2010-01-10 20:44:34.000000000 +0100
+++ b/drivers/hid/hid-ids.h	2010-01-12 23:22:11.000000000 +0100
@@ -370,6 +370,9 @@
 #define USB_VENDOR_ID_SAITEK		0x06a3
 #define USB_DEVICE_ID_SAITEK_RUMBLEPAD	0xff17
 
+#define USB_VENDOR_ID_QUANTA		0x0408
+#define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH	0x3000
+
 #define USB_VENDOR_ID_SAMSUNG		0x0419
 #define USB_DEVICE_ID_SAMSUNG_IR_REMOTE	0x0001
 
diff -rupN a/drivers/hid/hid-quanta.c b/drivers/hid/hid-quanta.c
--- a/drivers/hid/hid-quanta.c	1970-01-01 01:00:00.000000000 +0100
+++ b/drivers/hid/hid-quanta.c	2010-01-12 10:39:26.000000000 +0100
@@ -0,0 +1,259 @@
+/*
+ *  HID driver for Quanta Optical Touch dual-touch panels
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
+MODULE_DESCRIPTION("Quanta dual-touch panel");
+MODULE_LICENSE("GPL");
+
+#include "hid-ids.h"
+
+struct quanta_data {
+	__u16 x, y;
+	__u8 id;
+	bool valid;		/* valid finger data, or just placeholder? */
+	bool first;		/* is this the first finger in this frame? */
+	bool activity_now;	/* at least one active finger in this frame? */
+	bool activity;		/* at least one active finger previously? */
+};
+
+static int quanta_input_mapping(struct hid_device *hdev, struct hid_input *hi,
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
+static int quanta_input_mapped(struct hid_device *hdev, struct hid_input *hi,
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
+static void quanta_filter_event(struct quanta_data *td, struct input_dev *input)
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
+static int quanta_event(struct hid_device *hid, struct hid_field *field,
+				struct hid_usage *usage, __s32 value)
+{
+	struct quanta_data *td = hid_get_drvdata(hid);
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
+			quanta_filter_event(td, input);
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
+static int quanta_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	int ret;
+	struct quanta_data *td;
+
+	td = kmalloc(sizeof(struct quanta_data), GFP_KERNEL);
+	if (!td) {
+		dev_err(&hdev->dev, "cannot allocate Quanta Touch data\n");
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
+static void quanta_remove(struct hid_device *hdev)
+{
+	hid_hw_stop(hdev);
+	kfree(hid_get_drvdata(hdev));
+	hid_set_drvdata(hdev, NULL);
+}
+
+static const struct hid_device_id quanta_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA,
+			USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, quanta_devices);
+
+static const struct hid_usage_id quanta_grabbed_usages[] = {
+	{ HID_ANY_ID, HID_ANY_ID, HID_ANY_ID },
+	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1}
+};
+
+static struct hid_driver quanta_driver = {
+	.name = "quanta-touch",
+	.id_table = quanta_devices,
+	.probe = quanta_probe,
+	.remove = quanta_remove,
+	.input_mapping = quanta_input_mapping,
+	.input_mapped = quanta_input_mapped,
+	.usage_table = quanta_grabbed_usages,
+	.event = quanta_event,
+};
+
+static int __init quanta_init(void)
+{
+	return hid_register_driver(&quanta_driver);
+}
+
+static void __exit quanta_exit(void)
+{
+	hid_unregister_driver(&quanta_driver);
+}
+
+module_init(quanta_init);
+module_exit(quanta_exit);
+
diff -rupN a/drivers/hid/Kconfig b/drivers/hid/Kconfig
--- a/drivers/hid/Kconfig	2010-01-10 19:51:37.000000000 +0100
+++ b/drivers/hid/Kconfig	2010-01-12 23:25:34.000000000 +0100
@@ -247,6 +247,12 @@ config HID_PETALYNX
 	---help---
 	Support for Petalynx Maxter remote control.
 
+config HID_QUANTA
+	tristate "Quanta Optical Touch"
+	depends on USB_HID
+	---help---
+	Support for Quanta Optical Touch dual-touch panels.
+
 config HID_SAMSUNG
 	tristate "Samsung" if EMBEDDED
 	depends on USB_HID
diff -rupN a/drivers/hid/Makefile b/drivers/hid/Makefile
--- a/drivers/hid/Makefile	2010-01-10 19:52:41.000000000 +0100
+++ b/drivers/hid/Makefile	2010-01-12 10:45:55.000000000 +0100
@@ -32,6 +32,7 @@ obj-$(CONFIG_HID_LOGITECH)	+= hid-logite
 obj-$(CONFIG_HID_MICROSOFT)	+= hid-microsoft.o
 obj-$(CONFIG_HID_MONTEREY)	+= hid-monterey.o
 obj-$(CONFIG_HID_NTRIG)		+= hid-ntrig.o
+obj-$(CONFIG_HID_QUANTA)	+= hid-quanta.o
 obj-$(CONFIG_HID_PANTHERLORD)	+= hid-pl.o
 obj-$(CONFIG_HID_PETALYNX)	+= hid-petalynx.o
 obj-$(CONFIG_HID_SAMSUNG)	+= hid-samsung.o
