From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: [RFC v2 10/10] hid-multitouch: migrated support for Stantum panels
Date: Wed,  5 Jan 2011 18:27:48 +0100
Message-ID: <1294248468-19979-11-git-send-email-benjamin.tissoires@enac.fr>
References: <1294248468-19979-1-git-send-email-benjamin.tissoires@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:39304 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab1AER2N (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Jan 2011 12:28:13 -0500
In-Reply-To: <1294248468-19979-1-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephane Chatty <chatty@enac.fr>, Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.orglinux
Cc: Benjamin Tissoires <benjamin.tissoires@enac.fr>

Migrated support for Stantum panels to the unified driver.
(Requires patch named "hid: set HID_MAX_FIELDS at 128")

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Signed-off-by: St=C3=A9phane Chatty <chatty@enac.fr>
---
 drivers/hid/Kconfig          |    6 -
 drivers/hid/Makefile         |    1 -
 drivers/hid/hid-multitouch.c |   35 +++++-
 drivers/hid/hid-stantum.c    |  286 ----------------------------------=
--------
 4 files changed, 33 insertions(+), 295 deletions(-)
 delete mode 100644 drivers/hid/hid-stantum.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 989444f..8024a28 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -404,12 +404,6 @@ config HID_SONY
 	---help---
 	Support for Sony PS3 controller.
=20
-config HID_STANTUM
-	tristate "Stantum multitouch panel"
-	depends on USB_HID
-	---help---
-	Support for Stantum multitouch panel.
-
 config HID_SUNPLUS
 	tristate "Sunplus wireless desktop"
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index f8b4d95..f0484f5 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -57,7 +57,6 @@ obj-$(CONFIG_HID_ROCCAT_PYRA)	+=3D hid-roccat-pyra.o
 obj-$(CONFIG_HID_SAMSUNG)	+=3D hid-samsung.o
 obj-$(CONFIG_HID_SMARTJOYPLUS)	+=3D hid-sjoy.o
 obj-$(CONFIG_HID_SONY)		+=3D hid-sony.o
-obj-$(CONFIG_HID_STANTUM)	+=3D hid-stantum.o
 obj-$(CONFIG_HID_SUNPLUS)	+=3D hid-sunplus.o
 obj-$(CONFIG_HID_GREENASIA)	+=3D hid-gaff.o
 obj-$(CONFIG_HID_THRUSTMASTER)	+=3D hid-tmff.o
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.=
c
index deb996d..dc74d04 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -31,7 +31,7 @@ MODULE_LICENSE("GPL");
=20
=20
 struct mt_slot {
-	__s32 x, y, p;
+	__s32 x, y, p, w, h;
 	__s32 contactid;	/* the device ContactID assigned to this slot */
 	__u16 trkid;	/* the tracking ID that was assigned to this slot */
 	bool valid;	/* did we just get valid contact data for this slot? */
@@ -39,7 +39,7 @@ struct mt_slot {
 };
=20
 struct mt_buffer {
-	__s32 x, y, p;
+	__s32 x, y, p, w, h;
 	__s32 contactid;	/* the device ContactID assigned to this slot */
 };
=20
@@ -181,6 +181,18 @@ static int mt_input_mapping(struct hid_device *hde=
v, struct hid_input *hi,
 						td->mtclass->maxcontacts);
 			td->last_slot_field =3D usage->hid;
 			return 1;
+		case HID_DG_WIDTH:
+			hid_map_usage(hi, usage, bit, max,
+					EV_ABS, ABS_MT_TOUCH_MAJOR);
+			td->last_slot_field =3D usage->hid;
+			return 1;
+		case HID_DG_HEIGHT:
+			hid_map_usage(hi, usage, bit, max,
+					EV_ABS, ABS_MT_TOUCH_MINOR);
+			input_set_abs_params(hi->input, ABS_MT_ORIENTATION,
+					1, 1, 0, 0);
+			td->last_slot_field =3D usage->hid;
+			return 1;
 		case HID_DG_TIPPRESSURE:
 			hid_map_usage(hi, usage, bit, max,
 					EV_ABS, ABS_MT_PRESSURE);
@@ -266,6 +278,8 @@ static void mt_emit_event(struct mt_device *td, str=
uct input_dev *input)
 		input_event(input, EV_ABS, ABS_MT_POSITION_X, s->x);
 		input_event(input, EV_ABS, ABS_MT_POSITION_Y, s->y);
 		input_event(input, EV_ABS, ABS_MT_PRESSURE, s->p);
+		input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, s->w);
+		input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, s->h);
 		s->prev_valid =3D true;
 		s->valid =3D false;
=20
@@ -304,6 +318,12 @@ static int mt_event(struct hid_device *hid, struct=
 hid_field *field,
 		case HID_GD_Y:
 			td->curdata.y =3D value;
 			break;
+		case HID_DG_WIDTH:
+			td->curdata.w =3D value;
+			break;
+		case HID_DG_HEIGHT:
+			td->curdata.h =3D value;
+			break;
 		case HID_DG_CONTACTCOUNT:
 			/*
 			 * We must not overwrite the previous value (some
@@ -457,6 +477,17 @@ static const struct hid_device_id mt_devices[] =3D=
 {
 		HID_USB_DEVICE(USB_VENDOR_ID_ASUS,
 			USB_DEVICE_ID_ASUSTEK_MULTITOUCH_YFO) },
=20
+	/* Stantum panels */
+	{ .driver_data =3D MT_CLS_DEFAULT,
+		HID_USB_DEVICE(USB_VENDOR_ID_STANTUM,
+			USB_DEVICE_ID_MTP)},
+	{ .driver_data =3D MT_CLS_DEFAULT,
+		HID_USB_DEVICE(USB_VENDOR_ID_STANTUM,
+			USB_DEVICE_ID_MTP_STM)},
+	{ .driver_data =3D MT_CLS_DEFAULT,
+		HID_USB_DEVICE(USB_VENDOR_ID_STANTUM,
+			USB_DEVICE_ID_MTP_SITRONIX)},
+
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, mt_devices);
diff --git a/drivers/hid/hid-stantum.c b/drivers/hid/hid-stantum.c
deleted file mode 100644
index 3171be2..0000000
--- a/drivers/hid/hid-stantum.c
+++ /dev/null
@@ -1,286 +0,0 @@
-/*
- *  HID driver for Stantum multitouch panels
- *
- *  Copyright (c) 2009 Stephane Chatty <chatty@enac.fr>
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
-
-MODULE_AUTHOR("Stephane Chatty <chatty@enac.fr>");
-MODULE_DESCRIPTION("Stantum HID multitouch panels");
-MODULE_LICENSE("GPL");
-
-#include "hid-ids.h"
-
-struct stantum_data {
-	__s32 x, y, z, w, h;	/* x, y, pressure, width, height */
-	__u16 id;		/* touch id */
-	bool valid;		/* valid finger data, or just placeholder? */
-	bool first;		/* first finger in the HID packet? */
-	bool activity;		/* at least one active finger so far? */
-};
-
-static int stantum_input_mapping(struct hid_device *hdev, struct hid_i=
nput *hi,
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
-		case HID_DG_INRANGE:
-		case HID_DG_CONFIDENCE:
-		case HID_DG_INPUTMODE:
-		case HID_DG_DEVICEINDEX:
-		case HID_DG_CONTACTCOUNT:
-		case HID_DG_CONTACTMAX:
-			return -1;
-
-		case HID_DG_TIPSWITCH:
-			/* touchscreen emulation */
-			hid_map_usage(hi, usage, bit, max, EV_KEY, BTN_TOUCH);
-			return 1;
-
-		case HID_DG_WIDTH:
-			hid_map_usage(hi, usage, bit, max,
-					EV_ABS, ABS_MT_TOUCH_MAJOR);
-			return 1;
-		case HID_DG_HEIGHT:
-			hid_map_usage(hi, usage, bit, max,
-					EV_ABS, ABS_MT_TOUCH_MINOR);
-			input_set_abs_params(hi->input, ABS_MT_ORIENTATION,
-					1, 1, 0, 0);
-			return 1;
-		case HID_DG_TIPPRESSURE:
-			hid_map_usage(hi, usage, bit, max,
-					EV_ABS, ABS_MT_PRESSURE);
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
-		/* no input-oriented meaning */
-		return -1;
-	}
-
-	return 0;
-}
-
-static int stantum_input_mapped(struct hid_device *hdev, struct hid_in=
put *hi,
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
-static void stantum_filter_event(struct stantum_data *sd,
-					struct input_dev *input)
-{
-	bool wide;
-
-	if (!sd->valid) {
-		/*
-		 * touchscreen emulation: if the first finger is not valid and
-		 * there previously was finger activity, this is a release
-		 */
-		if (sd->first && sd->activity) {
-			input_event(input, EV_KEY, BTN_TOUCH, 0);
-			sd->activity =3D false;
-		}
-		return;
-	}
-
-	input_event(input, EV_ABS, ABS_MT_TRACKING_ID, sd->id);
-	input_event(input, EV_ABS, ABS_MT_POSITION_X, sd->x);
-	input_event(input, EV_ABS, ABS_MT_POSITION_Y, sd->y);
-
-	wide =3D (sd->w > sd->h);
-	input_event(input, EV_ABS, ABS_MT_ORIENTATION, wide);
-	input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, wide ? sd->w : sd->h);
-	input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, wide ? sd->h : sd->w);
-
-	input_event(input, EV_ABS, ABS_MT_PRESSURE, sd->z);
-
-	input_mt_sync(input);
-	sd->valid =3D false;
-
-	/* touchscreen emulation */
-	if (sd->first) {
-		if (!sd->activity) {
-			input_event(input, EV_KEY, BTN_TOUCH, 1);
-			sd->activity =3D true;
-		}
-		input_event(input, EV_ABS, ABS_X, sd->x);
-		input_event(input, EV_ABS, ABS_Y, sd->y);
-	}
-	sd->first =3D false;
-}
-
-
-static int stantum_event(struct hid_device *hid, struct hid_field *fie=
ld,
-				struct hid_usage *usage, __s32 value)
-{
-	struct stantum_data *sd =3D hid_get_drvdata(hid);
-
-	if (hid->claimed & HID_CLAIMED_INPUT) {
-		struct input_dev *input =3D field->hidinput->input;
-
-		switch (usage->hid) {
-		case HID_DG_INRANGE:
-			/* this is the last field in a finger */
-			stantum_filter_event(sd, input);
-			break;
-		case HID_DG_WIDTH:
-			sd->w =3D value;
-			break;
-		case HID_DG_HEIGHT:
-			sd->h =3D value;
-			break;
-		case HID_GD_X:
-			sd->x =3D value;
-			break;
-		case HID_GD_Y:
-			sd->y =3D value;
-			break;
-		case HID_DG_TIPPRESSURE:
-			sd->z =3D value;
-			break;
-		case HID_DG_CONTACTID:
-			sd->id =3D value;
-			break;
-		case HID_DG_CONFIDENCE:
-			sd->valid =3D !!value;
-			break;
-		case 0xff000002:
-			/* this comes only before the first finger */
-			sd->first =3D true;
-			break;
-
-		default:
-			/* ignore the others */
-			return 1;
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
-static int stantum_probe(struct hid_device *hdev,
-				const struct hid_device_id *id)
-{
-	int ret;
-	struct stantum_data *sd;
-
-	sd =3D kmalloc(sizeof(struct stantum_data), GFP_KERNEL);
-	if (!sd) {
-		dev_err(&hdev->dev, "cannot allocate Stantum data\n");
-		return -ENOMEM;
-	}
-	sd->valid =3D false;
-	sd->first =3D false;
-	sd->activity =3D false;
-	hid_set_drvdata(hdev, sd);
-
-	ret =3D hid_parse(hdev);
-	if (!ret)
-		ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
-
-	if (ret)
-		kfree(sd);
-
-	return ret;
-}
-
-static void stantum_remove(struct hid_device *hdev)
-{
-	hid_hw_stop(hdev);
-	kfree(hid_get_drvdata(hdev));
-	hid_set_drvdata(hdev, NULL);
-}
-
-static const struct hid_device_id stantum_devices[] =3D {
-	{ HID_USB_DEVICE(USB_VENDOR_ID_STANTUM, USB_DEVICE_ID_MTP) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_STANTUM_STM, USB_DEVICE_ID_MTP_STM) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_STANTUM_SITRONIX, USB_DEVICE_ID_MTP_SI=
TRONIX) },
-	{ }
-};
-MODULE_DEVICE_TABLE(hid, stantum_devices);
-
-static const struct hid_usage_id stantum_grabbed_usages[] =3D {
-	{ HID_ANY_ID, HID_ANY_ID, HID_ANY_ID },
-	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1}
-};
-
-static struct hid_driver stantum_driver =3D {
-	.name =3D "stantum",
-	.id_table =3D stantum_devices,
-	.probe =3D stantum_probe,
-	.remove =3D stantum_remove,
-	.input_mapping =3D stantum_input_mapping,
-	.input_mapped =3D stantum_input_mapped,
-	.usage_table =3D stantum_grabbed_usages,
-	.event =3D stantum_event,
-};
-
-static int __init stantum_init(void)
-{
-	return hid_register_driver(&stantum_driver);
-}
-
-static void __exit stantum_exit(void)
-{
-	hid_unregister_driver(&stantum_driver);
-}
-
-module_init(stantum_init);
-module_exit(stantum_exit);
-
--=20
1.7.3.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
