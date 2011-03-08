From: Richard Nauber <richard.nauber@googlemail.com>
Subject: [PATCH v2] [input-hid] Add hid-egalax driver to the unified
 hid-multitouch framework.
Date: Tue, 08 Mar 2011 07:08:44 +0100
Message-ID: <1299564524.2306.18.camel@itzy>
References: <1299417912.9645.495.camel@itzy>
	 <AANLkTimkYHPvn0PqcVyJv1rPTn3F7F8p3+3Y0-4F=MwW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60994 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841Ab1CHGI4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Mar 2011 01:08:56 -0500
Received: by bwz15 with SMTP id 15so4330075bwz.19
        for <linux-input@vger.kernel.org>; Mon, 07 Mar 2011 22:08:54 -0800 (PST)
In-Reply-To: <AANLkTimkYHPvn0PqcVyJv1rPTn3F7F8p3+3Y0-4F=MwW@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, =?ISO-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>

Hi Benjamin, Hendrick, Jiri and St=C3=A9phan,=20

I would like to give this patch another shot, after Benjamin reviewed i=
t (thanks for that!).
As he pointed out, testing for the capacitive kind of egalax devices is=
 needed. Maybe St=C3=A9phan,  =20
has the hardware and would be so kind to test it? I have tried it with =
my Samsung MB30 display
and it worked:=20
Bus 002 Device 002: ID 0eef:480e D-WAV Scientific Co., Ltd=20
(thats USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH3)

I am looking forward to your comments,
Richard


PS: The patch should apply to 2fa403e8b49 of Jiris for-next branch, alt=
hough I had to cheat=20
a little and rebase his tree to 2.6.38-rc7 because of some unrelated br=
eakage (ecryptfs).


---- snip ----


[PATCH] [input-hid] Add hid-egalax driver to the unified hid-multitouch=
 framework.

This patch merges the hid-egalax driver into hid-multitouch and
therefore adds two device classes (MT_CLS_EGALAX_CAPACITIVE/RESISTIVE).
It also gains the capability to work around broken hid reports by
overriding X/Y limits and emitting events for each finger
(MT_QUIRK_SEND_AT_EACH_REPORT). As a side effect, this patch
fixes the broken suspend/resume behavior with the old driver.

Signed-off-by: Richard Nauber <Richard.Nauber@gmail.com>
---
 drivers/hid/Kconfig          |    9 +-
 drivers/hid/Makefile         |    1 -
 drivers/hid/hid-egalax.c     |  279 ----------------------------------=
--------
 drivers/hid/hid-multitouch.c |   68 ++++++++++-
 4 files changed, 68 insertions(+), 289 deletions(-)
 delete mode 100644 drivers/hid/hid-egalax.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index b152c91..87f0b03 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -160,13 +160,6 @@ config HID_EMS_FF
 	Currently the following devices are known to be supported:
 	 - Trio Linker Plus II
=20
-config HID_EGALAX
-	tristate "eGalax multi-touch panel"
-	depends on USB_HID
-	---help---
-	Support for the eGalax dual-touch panels, including the
-	Joojoo and Wetab tablets.
-
 config HID_ELECOM
 	tristate "ELECOM BM084 bluetooth mouse"
 	depends on BT_HIDP
@@ -321,6 +314,8 @@ config HID_MULTITOUCH
 	  - IrTouch Infrared USB panels
 	  - Pixcir dual touch panels
 	  - 'Sensing Win7-TwoFinger' panel by GeneralTouch
+          - eGalax dual-touch panels, including the
+	    Joojoo and Wetab tablets
=20
 	  If unsure, say N.
=20
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 04496ab..1b6ddd3 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -36,7 +36,6 @@ obj-$(CONFIG_HID_CHICONY)	+=3D hid-chicony.o
 obj-$(CONFIG_HID_CYPRESS)	+=3D hid-cypress.o
 obj-$(CONFIG_HID_DRAGONRISE)	+=3D hid-drff.o
 obj-$(CONFIG_HID_EMS_FF)	+=3D hid-emsff.o
-obj-$(CONFIG_HID_EGALAX)	+=3D hid-egalax.o
 obj-$(CONFIG_HID_ELECOM)	+=3D hid-elecom.o
 obj-$(CONFIG_HID_EZKEY)		+=3D hid-ezkey.o
 obj-$(CONFIG_HID_GYRATION)	+=3D hid-gyration.o
diff --git a/drivers/hid/hid-egalax.c b/drivers/hid/hid-egalax.c
deleted file mode 100644
index 03bee19..0000000
--- a/drivers/hid/hid-egalax.c
+++ /dev/null
@@ -1,279 +0,0 @@
-/*
- *  HID driver for eGalax dual-touch panels
- *
- *  Copyright (c) 2010 Stephane Chatty <chatty@enac.fr>
- *  Copyright (c) 2010 Henrik Rydberg <rydberg@euromail.se>
- *  Copyright (c) 2010 Canonical, Ltd.
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
-#include <linux/usb.h>
-#include <linux/input/mt.h>
-#include <linux/slab.h>
-#include "usbhid/usbhid.h"
-
-MODULE_AUTHOR("Stephane Chatty <chatty@enac.fr>");
-MODULE_DESCRIPTION("eGalax dual-touch panel");
-MODULE_LICENSE("GPL");
-
-#include "hid-ids.h"
-
-#define MAX_SLOTS		2
-
-/* estimated signal-to-noise ratios */
-#define SN_MOVE			4096
-#define SN_PRESSURE		32
-
-struct egalax_data {
-	int valid;
-	int slot;
-	int touch;
-	int x, y, z;
-};
-
-static void set_abs(struct input_dev *input, unsigned int code,
-		    struct hid_field *field, int snratio)
-{
-	int fmin =3D field->logical_minimum;
-	int fmax =3D field->logical_maximum;
-	int fuzz =3D snratio ? (fmax - fmin) / snratio : 0;
-	input_set_abs_params(input, code, fmin, fmax, fuzz, 0);
-}
-
-static int egalax_input_mapping(struct hid_device *hdev, struct hid_in=
put *hi,
-		struct hid_field *field, struct hid_usage *usage,
-		unsigned long **bit, int *max)
-{
-	struct input_dev *input =3D hi->input;
-
-	switch (usage->hid & HID_USAGE_PAGE) {
-
-	case HID_UP_GENDESK:
-		switch (usage->hid) {
-		case HID_GD_X:
-			field->logical_maximum =3D 32760;
-			hid_map_usage(hi, usage, bit, max,
-					EV_ABS, ABS_MT_POSITION_X);
-			set_abs(input, ABS_MT_POSITION_X, field, SN_MOVE);
-			/* touchscreen emulation */
-			set_abs(input, ABS_X, field, SN_MOVE);
-			return 1;
-		case HID_GD_Y:
-			field->logical_maximum =3D 32760;
-			hid_map_usage(hi, usage, bit, max,
-					EV_ABS, ABS_MT_POSITION_Y);
-			set_abs(input, ABS_MT_POSITION_Y, field, SN_MOVE);
-			/* touchscreen emulation */
-			set_abs(input, ABS_Y, field, SN_MOVE);
-			return 1;
-		}
-		return 0;
-
-	case HID_UP_DIGITIZER:
-		switch (usage->hid) {
-		case HID_DG_TIPSWITCH:
-			/* touchscreen emulation */
-			hid_map_usage(hi, usage, bit, max, EV_KEY, BTN_TOUCH);
-			input_set_capability(input, EV_KEY, BTN_TOUCH);
-			return 1;
-		case HID_DG_INRANGE:
-		case HID_DG_CONFIDENCE:
-		case HID_DG_CONTACTCOUNT:
-		case HID_DG_CONTACTMAX:
-			return -1;
-		case HID_DG_CONTACTID:
-			input_mt_init_slots(input, MAX_SLOTS);
-			return 1;
-		case HID_DG_TIPPRESSURE:
-			field->logical_minimum =3D 0;
-			hid_map_usage(hi, usage, bit, max,
-					EV_ABS, ABS_MT_PRESSURE);
-			set_abs(input, ABS_MT_PRESSURE, field, SN_PRESSURE);
-			/* touchscreen emulation */
-			set_abs(input, ABS_PRESSURE, field, SN_PRESSURE);
-			return 1;
-		}
-		return 0;
-	}
-
-	/* ignore others (from other reports we won't get anyway) */
-	return -1;
-}
-
-static int egalax_input_mapped(struct hid_device *hdev, struct hid_inp=
ut *hi,
-		struct hid_field *field, struct hid_usage *usage,
-		unsigned long **bit, int *max)
-{
-	/* tell hid-input to skip setup of these event types */
-	if (usage->type =3D=3D EV_KEY || usage->type =3D=3D EV_ABS)
-		set_bit(usage->type, hi->input->evbit);
-	return -1;
-}
-
-/*
- * this function is called when a whole finger has been parsed,
- * so that it can decide what to send to the input layer.
- */
-static void egalax_filter_event(struct egalax_data *td, struct input_d=
ev *input)
-{
-	input_mt_slot(input, td->slot);
-	input_mt_report_slot_state(input, MT_TOOL_FINGER, td->touch);
-	if (td->touch) {
-		input_event(input, EV_ABS, ABS_MT_POSITION_X, td->x);
-		input_event(input, EV_ABS, ABS_MT_POSITION_Y, td->y);
-		input_event(input, EV_ABS, ABS_MT_PRESSURE, td->z);
-	}
-	input_mt_report_pointer_emulation(input, true);
-}
-
-static int egalax_event(struct hid_device *hid, struct hid_field *fiel=
d,
-				struct hid_usage *usage, __s32 value)
-{
-	struct egalax_data *td =3D hid_get_drvdata(hid);
-
-	/* Note, eGalax has two product lines: the first is resistive and
-	 * uses a standard parallel multitouch protocol (product ID =3D=3D
-	 * 48xx).  The second is capacitive and uses an unusual "serial"
-	 * protocol with a different message for each multitouch finger
-	 * (product ID =3D=3D 72xx).
-	 */
-	if (hid->claimed & HID_CLAIMED_INPUT) {
-		struct input_dev *input =3D field->hidinput->input;
-
-		switch (usage->hid) {
-		case HID_DG_INRANGE:
-			td->valid =3D value;
-			break;
-		case HID_DG_CONFIDENCE:
-			/* avoid interference from generic hidinput handling */
-			break;
-		case HID_DG_TIPSWITCH:
-			td->touch =3D value;
-			break;
-		case HID_DG_TIPPRESSURE:
-			td->z =3D value;
-			break;
-		case HID_DG_CONTACTID:
-			td->slot =3D clamp_val(value, 0, MAX_SLOTS - 1);
-			break;
-		case HID_GD_X:
-			td->x =3D value;
-			break;
-		case HID_GD_Y:
-			td->y =3D value;
-			/* this is the last field in a finger */
-			if (td->valid)
-				egalax_filter_event(td, input);
-			break;
-		case HID_DG_CONTACTCOUNT:
-			/* touch emulation: this is the last field in a frame */
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
-static int egalax_probe(struct hid_device *hdev, const struct hid_devi=
ce_id *id)
-{
-	int ret;
-	struct egalax_data *td;
-	struct hid_report *report;
-
-	td =3D kzalloc(sizeof(struct egalax_data), GFP_KERNEL);
-	if (!td) {
-		hid_err(hdev, "cannot allocate eGalax data\n");
-		return -ENOMEM;
-	}
-	hid_set_drvdata(hdev, td);
-
-	ret =3D hid_parse(hdev);
-	if (ret)
-		goto end;
-
-	ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
-	if (ret)
-		goto end;
-
-	report =3D hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[5];=20
-	if (report) {
-		report->field[0]->value[0] =3D 2;
-		usbhid_submit_report(hdev, report, USB_DIR_OUT);
-	}
-
-end:
-	if (ret)
-		kfree(td);
-
-	return ret;
-}
-
-static void egalax_remove(struct hid_device *hdev)
-{
-	hid_hw_stop(hdev);
-	kfree(hid_get_drvdata(hdev));
-	hid_set_drvdata(hdev, NULL);
-}
-
-static const struct hid_device_id egalax_devices[] =3D {
-	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
-			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
-			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH1) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
-			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH2) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
-			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH3) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
-			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH4) },
-	{ }
-};
-MODULE_DEVICE_TABLE(hid, egalax_devices);
-
-static const struct hid_usage_id egalax_grabbed_usages[] =3D {
-	{ HID_ANY_ID, HID_ANY_ID, HID_ANY_ID },
-	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1}
-};
-
-static struct hid_driver egalax_driver =3D {
-	.name =3D "egalax-touch",
-	.id_table =3D egalax_devices,
-	.probe =3D egalax_probe,
-	.remove =3D egalax_remove,
-	.input_mapping =3D egalax_input_mapping,
-	.input_mapped =3D egalax_input_mapped,
-	.usage_table =3D egalax_grabbed_usages,
-	.event =3D egalax_event,
-};
-
-static int __init egalax_init(void)
-{
-	return hid_register_driver(&egalax_driver);
-}
-
-static void __exit egalax_exit(void)
-{
-	hid_unregister_driver(&egalax_driver);
-}
-
-module_init(egalax_init);
-module_exit(egalax_exit);
-
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.=
c
index 65e7f20..a00f3d8 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -37,6 +37,7 @@ MODULE_LICENSE("GPL");
 #define MT_QUIRK_SLOT_IS_CONTACTNUMBER	(1 << 3)
 #define MT_QUIRK_VALID_IS_INRANGE	(1 << 4)
 #define MT_QUIRK_VALID_IS_CONFIDENCE	(1 << 5)
+#define MT_QUIRK_SEND_AT_EACH_REPORT	(1 << 6)
=20
 struct mt_slot {
 	__s32 x, y, p, w, h;
@@ -63,6 +64,9 @@ struct mt_class {
 	__s32 sn_move;	/* Signal/noise ratio for move events */
 	__s32 sn_pressure;	/* Signal/noise ratio for pressure events */
 	__u8 maxcontacts;
+	__u8 override_logical_limits;  /* correct the reported X/Y range */
+	__u32 logical_min[2];
+	__u32 logical_max[2];
 };
=20
 /* classes of device behavior */
@@ -70,6 +74,8 @@ struct mt_class {
 #define MT_CLS_DUAL_INRANGE_CONTACTID		2
 #define MT_CLS_DUAL_INRANGE_CONTACTNUMBER	3
 #define MT_CLS_CYPRESS				4
+#define MT_CLS_EGALAX_CAPACITIVE		5
+#define MT_CLS_EGALAX_RESISTIVE			6
=20
 /*
  * these device-dependent functions determine what slot corresponds
@@ -119,7 +125,25 @@ struct mt_class mt_classes[] =3D {
 		.quirks =3D MT_QUIRK_NOT_SEEN_MEANS_UP |
 			MT_QUIRK_CYPRESS,
 		.maxcontacts =3D 10 },
-
+	{ .name =3D MT_CLS_EGALAX_CAPACITIVE,
+		.quirks =3D  MT_QUIRK_SLOT_IS_CONTACTID |
+			MT_QUIRK_VALID_IS_INRANGE,
+		.maxcontacts =3D 2,
+		.sn_move =3D 4096,
+		.sn_pressure =3D 32,
+		.override_logical_limits =3D 1,
+		.logical_min =3D { 0, 0 },
+		.logical_max =3D { 32760, 32760 } },
+	{ .name =3D MT_CLS_EGALAX_RESISTIVE,
+		.quirks =3D  MT_QUIRK_SLOT_IS_CONTACTID |
+			MT_QUIRK_VALID_IS_INRANGE |
+			MT_QUIRK_SEND_AT_EACH_REPORT,
+		.maxcontacts =3D 2,
+		.sn_move =3D 4096,
+		.sn_pressure =3D 32,
+		.override_logical_limits =3D 1,
+		.logical_min =3D { 0, 0 },
+		.logical_max =3D { 32760, 32760 } },
 	{ }
 };
=20
@@ -147,11 +171,19 @@ static int mt_input_mapping(struct hid_device *hd=
ev, struct hid_input *hi,
 {
 	struct mt_device *td =3D hid_get_drvdata(hdev);
 	struct mt_class *cls =3D td->mtclass;
+
 	switch (usage->hid & HID_USAGE_PAGE) {
=20
 	case HID_UP_GENDESK:
+
 		switch (usage->hid) {
 		case HID_GD_X:
+			/* fix up the reported X limits if necessary*/
+			if (cls->override_logical_limits) {
+				field->logical_minimum =3D cls->logical_min[0];
+				field->logical_maximum =3D cls->logical_max[0];
+			}
+
 			hid_map_usage(hi, usage, bit, max,
 					EV_ABS, ABS_MT_POSITION_X);
 			set_abs(hi->input, ABS_MT_POSITION_X, field,
@@ -161,6 +193,11 @@ static int mt_input_mapping(struct hid_device *hde=
v, struct hid_input *hi,
 			td->last_slot_field =3D usage->hid;
 			return 1;
 		case HID_GD_Y:
+			/* fix up the reported Y limits if nessecary*/
+			if (cls->override_logical_limits) {
+				field->logical_minimum =3D cls->logical_min[1];
+				field->logical_maximum =3D cls->logical_max[1];
+			}
 			hid_map_usage(hi, usage, bit, max,
 					EV_ABS, ABS_MT_POSITION_Y);
 			set_abs(hi->input, ABS_MT_POSITION_Y, field,
@@ -204,6 +241,10 @@ static int mt_input_mapping(struct hid_device *hde=
v, struct hid_input *hi,
 			td->last_slot_field =3D usage->hid;
 			return 1;
 		case HID_DG_TIPPRESSURE:
+			/* fix up the pressure range for some devices
+			with broken report */
+			field->logical_minimum =3D 0;
+
 			hid_map_usage(hi, usage, bit, max,
 					EV_ABS, ABS_MT_PRESSURE);
 			set_abs(hi->input, ABS_MT_PRESSURE, field,
@@ -367,8 +408,12 @@ static int mt_event(struct hid_device *hid, struct=
 hid_field *field,
 		if (usage->hid =3D=3D td->last_slot_field)
 			mt_complete_slot(td);
=20
-		if (field->index =3D=3D td->last_field_index
+		if ((field->index =3D=3D td->last_field_index
 			&& td->num_received >=3D td->num_expected)
+			|| ((quirks & MT_QUIRK_SEND_AT_EACH_REPORT)
+				&& (usage->hid =3D=3D td->last_slot_field)))
+			/* emit an event for every finger to work around
+			a corrupt last_field_index in the hid report*/
 			mt_emit_event(td, field->hidinput->input);
=20
 	}
@@ -484,6 +529,25 @@ static const struct hid_device_id mt_devices[] =3D=
 {
 		HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
 			USB_DEVICE_ID_CANDO_PIXCIR_MULTI_TOUCH) },
=20
+	/* Resistive eGalax devices */
+	{  .driver_data =3D MT_CLS_EGALAX_RESISTIVE,
+		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH) },
+	{  .driver_data =3D MT_CLS_EGALAX_RESISTIVE,
+		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH3) },
+
+	/* Capacitive eGalax devices */
+	{  .driver_data =3D MT_CLS_EGALAX_CAPACITIVE,
+		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH1) },
+	{  .driver_data =3D MT_CLS_EGALAX_CAPACITIVE,
+		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH2) },
+	{  .driver_data =3D MT_CLS_EGALAX_CAPACITIVE,
+		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH4) },
+
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, mt_devices);
--=20
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
