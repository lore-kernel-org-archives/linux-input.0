From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: [RFC v2 07/10] hid-multitouch: migrated support for MosArt panels
Date: Wed,  5 Jan 2011 18:27:45 +0100
Message-ID: <1294248468-19979-8-git-send-email-benjamin.tissoires@enac.fr>
References: <1294248468-19979-1-git-send-email-benjamin.tissoires@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:39298 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab1AER2G (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Jan 2011 12:28:06 -0500
In-Reply-To: <1294248468-19979-1-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephane Chatty <chatty@enac.fr>, Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.orglinux
Cc: Benjamin Tissoires <benjamin.tissoires@enac.fr>

Migrated support for MosArt dual-touch panels to the unified driver.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Signed-off-by: St=C3=A9phane Chatty <chatty@enac.fr>
---
 drivers/hid/Kconfig          |    6 -
 drivers/hid/Makefile         |    1 -
 drivers/hid/hid-mosart.c     |  275 ----------------------------------=
--------
 drivers/hid/hid-multitouch.c |   15 +++
 4 files changed, 15 insertions(+), 282 deletions(-)
 delete mode 100644 drivers/hid/hid-mosart.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index faf27c0..74c6bf5 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -266,12 +266,6 @@ config HID_MICROSOFT
 	---help---
 	Support for Microsoft devices that are not fully compliant with HID s=
tandard.
=20
-config HID_MOSART
-	tristate "MosArt dual-touch panels"
-	depends on USB_HID
-	---help---
-	Support for MosArt dual-touch panels.
-
 config HID_MONTEREY
 	tristate "Monterey Genius KB29E keyboard" if EMBEDDED
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 1a0190d..28144cb 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -44,7 +44,6 @@ obj-$(CONFIG_HID_LOGITECH)	+=3D hid-logitech.o
 obj-$(CONFIG_HID_MAGICMOUSE)    +=3D hid-magicmouse.o
 obj-$(CONFIG_HID_MICROSOFT)	+=3D hid-microsoft.o
 obj-$(CONFIG_HID_MONTEREY)	+=3D hid-monterey.o
-obj-$(CONFIG_HID_MOSART)	+=3D hid-mosart.o
 obj-$(CONFIG_HID_MULTITOUCH)	+=3D hid-multitouch.o
 obj-$(CONFIG_HID_NTRIG)		+=3D hid-ntrig.o
 obj-$(CONFIG_HID_ORTEK)		+=3D hid-ortek.o
diff --git a/drivers/hid/hid-mosart.c b/drivers/hid/hid-mosart.c
deleted file mode 100644
index ac5421d..0000000
--- a/drivers/hid/hid-mosart.c
+++ /dev/null
@@ -1,275 +0,0 @@
-/*
- *  HID driver for the multitouch panel on the ASUS EeePC T91MT
- *
- *  Copyright (c) 2009-2010 Stephane Chatty <chatty@enac.fr>
- *  Copyright (c) 2010 Teemu Tuominen <teemu.tuominen@cybercom.com>
- *
- */
-
-/*
- * This program is free software; you can redistribute it and/or modif=
y it
- * under the terms of the GNU General Public License as published by t=
he Free
- * Software Foundation; either version 2 of the License, or (at your o=
ption)
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
-static int mosart_input_mapping(struct hid_device *hdev, struct hid_in=
put *hi,
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
-static int mosart_input_mapped(struct hid_device *hdev, struct hid_inp=
ut *hi,
-		struct hid_field *field, struct hid_usage *usage,
-		unsigned long **bit, int *max)
-{
-	if (usage->type =3D=3D EV_KEY || usage->type =3D=3D EV_ABS)
-		clear_bit(usage->code, *bit);
-
-	return 0;
-}
-
-/*
- * this function is called when a whole finger has been parsed,
- * so that it can decide what to send to the input layer.
- */
-static void mosart_filter_event(struct mosart_data *td, struct input_d=
ev *input)
-{
-	td->first =3D !td->first; /* touchscreen emulation */
-
-	if (!td->valid) {
-		/*
-		 * touchscreen emulation: if no finger in this frame is valid
-		 * and there previously was finger activity, this is a release
-		 */=20
-		if (!td->first && !td->activity_now && td->activity) {
-			input_event(input, EV_KEY, BTN_TOUCH, 0);
-			td->activity =3D false;
-		}
-		return;
-	}
-
-	input_event(input, EV_ABS, ABS_MT_TRACKING_ID, td->id);
-	input_event(input, EV_ABS, ABS_MT_POSITION_X, td->x);
-	input_event(input, EV_ABS, ABS_MT_POSITION_Y, td->y);
-
-	input_mt_sync(input);
-	td->valid =3D false;
-
-	/* touchscreen emulation: if first active finger in this frame... */
-	if (!td->activity_now) {
-		/* if there was no previous activity, emit touch event */
-		if (!td->activity) {
-			input_event(input, EV_KEY, BTN_TOUCH, 1);
-			td->activity =3D true;
-		}
-		td->activity_now =3D true;
-		/* and in any case this is our preferred finger */
-		input_event(input, EV_ABS, ABS_X, td->x);
-		input_event(input, EV_ABS, ABS_Y, td->y);
-	}
-}
-
-
-static int mosart_event(struct hid_device *hid, struct hid_field *fiel=
d,
-				struct hid_usage *usage, __s32 value)
-{
-	struct mosart_data *td =3D hid_get_drvdata(hid);
-
-	if (hid->claimed & HID_CLAIMED_INPUT) {
-		struct input_dev *input =3D field->hidinput->input;
-		switch (usage->hid) {
-		case HID_DG_INRANGE:
-			td->valid =3D !!value;
-			break;
-		case HID_GD_X:
-			td->x =3D value;
-			break;
-		case HID_GD_Y:
-			td->y =3D value;
-			mosart_filter_event(td, input);
-			break;
-		case HID_DG_CONTACTID:
-			td->id =3D value;
-			break;
-		case HID_DG_CONTACTCOUNT:
-			/* touch emulation: this is the last field in a frame */
-			td->first =3D false;
-			td->activity_now =3D false;
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
-static int mosart_probe(struct hid_device *hdev, const struct hid_devi=
ce_id *id)
-{
-	int ret;
-	struct mosart_data *td;
-
-
-	td =3D kmalloc(sizeof(struct mosart_data), GFP_KERNEL);
-	if (!td) {
-		dev_err(&hdev->dev, "cannot allocate MosArt data\n");
-		return -ENOMEM;
-	}
-	td->valid =3D false;
-	td->activity =3D false;
-	td->activity_now =3D false;
-	td->first =3D false;
-	hid_set_drvdata(hdev, td);
-
-	/* currently, it's better to have one evdev device only */
-#if 0
-	hdev->quirks |=3D HID_QUIRK_MULTI_INPUT;
-#endif
-
-	ret =3D hid_parse(hdev);
-	if (ret =3D=3D 0)
-		ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
-
-	if (ret =3D=3D 0) {
-		struct hid_report_enum *re =3D hdev->report_enum
-						+ HID_FEATURE_REPORT;
-		struct hid_report *r =3D re->report_id_hash[7];
-
-		r->field[0]->value[0] =3D 0x02;
-		usbhid_submit_report(hdev, r, USB_DIR_OUT);
-	} else=20
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
-static const struct hid_device_id mosart_devices[] =3D {
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUS, USB_DEVICE_ID_ASUS_T91MT) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUS, USB_DEVICE_ID_ASUSTEK_MULTITOUCH=
_YFO) },
-	{ }
-};
-MODULE_DEVICE_TABLE(hid, mosart_devices);
-
-static const struct hid_usage_id mosart_grabbed_usages[] =3D {
-	{ HID_ANY_ID, HID_ANY_ID, HID_ANY_ID },
-	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1}
-};
-
-static struct hid_driver mosart_driver =3D {
-	.name =3D "mosart",
-	.id_table =3D mosart_devices,
-	.probe =3D mosart_probe,
-	.remove =3D mosart_remove,
-	.input_mapping =3D mosart_input_mapping,
-	.input_mapped =3D mosart_input_mapped,
-	.usage_table =3D mosart_grabbed_usages,
-	.event =3D mosart_event,
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
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.=
c
index f9d537e..d3574ab 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -66,6 +66,7 @@ struct mt_class {
 #define MT_CLS_DUAL1 1
 #define MT_CLS_DUAL2 2
 #define MT_CLS_CYPRESS 3
+#define MT_CLS_MOSART 4
=20
 /*
  * these device-dependent functions determine what slot corresponds
@@ -90,6 +91,11 @@ static int cypress_compute_slot(struct mt_device *td=
)
 		return -1;
 }
=20
+static int slot_is_contactid_minus_one(struct mt_device *td)
+{
+	return td->curdata.contactid - 1;
+}
+
 static int find_slot_from_contactid(struct mt_device *td)
 {
 	int i;
@@ -110,6 +116,7 @@ struct mt_class mt_classes[] =3D {
 	{ slot_is_contactid, 2 },             /* MT_CLS_DUAL1 */
 	{ slot_is_contactnumber, 2 },         /* MT_CLS_DUAL2 */
 	{ cypress_compute_slot, 10 },         /* MT_CLS_CYPRESS */
+	{ slot_is_contactid_minus_one, 2 },   /* MT_CLS_MOSART */
 };
=20
 static void mt_feature_mapping(struct hid_device *hdev, struct hid_inp=
ut *hi,
@@ -429,6 +436,14 @@ static const struct hid_device_id mt_devices[] =3D=
 {
 		HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS,
 			USB_DEVICE_ID_CYPRESS_TRUETOUCH) },
=20
+	/* MosArt panels */
+	{ .driver_data =3D MT_CLS_MOSART,
+		HID_USB_DEVICE(USB_VENDOR_ID_ASUS,
+			USB_DEVICE_ID_ASUS_T91MT)},
+	{ .driver_data =3D MT_CLS_MOSART,
+		HID_USB_DEVICE(USB_VENDOR_ID_ASUS,
+			USB_DEVICE_ID_ASUSTEK_MULTITOUCH_YFO) },
+
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, mt_devices);
--=20
1.7.3.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
