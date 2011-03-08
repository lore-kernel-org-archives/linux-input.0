From: Richard Nauber <richard.nauber@googlemail.com>
Subject: Re: [PATCH v3] [input-hid] Add hid-egalax driver to the unified
 hid-multitouch framework.
Date: Wed, 09 Mar 2011 00:38:38 +0100
Message-ID: <1299627518.2306.47.camel@itzy>
References: <1299417912.9645.495.camel@itzy>
	 <AANLkTimkYHPvn0PqcVyJv1rPTn3F7F8p3+3Y0-4F=MwW@mail.gmail.com>
	 <1299564524.2306.18.camel@itzy> <20110308080414.GA2888@polaris.bitmath.org>
	 <AANLkTimT9q8mo3uW0P7T0B=D4kkE83OB9ycgdJ_muZ2W@mail.gmail.com>
	 <20110308091434.GA3282@polaris.bitmath.org>
	 <AANLkTiko_mKgW6fXeAuBY4D5AT_9OHAJnk_mfQEPQVF9@mail.gmail.com>
	 <20110308094630.GA3396@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50522 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756078Ab1CHXit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Mar 2011 18:38:49 -0500
Received: by wya21 with SMTP id 21so482010wya.19
        for <linux-input@vger.kernel.org>; Tue, 08 Mar 2011 15:38:47 -0800 (PST)
In-Reply-To: <20110308094630.GA3396@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, =?ISO-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>

Hi Henrik :), Benjamin, Stephane and Jiri,

here is the third version of this patch, improved according to your suggestions. 

> What I meant is that (min_x < max_x) is the proper test.
> 
> > No need for a quirk that will be redundant with the hand-provided values.
> 
> Yes, but I think we might be better off using a quirk than a generic
> way to replace the values provided by the hardware.

My personal opinion is that the override should be triggered by your
(min_x < max_x) test, which is safe, because the (min_x == max_x) case
makes no sense for a device and we are allowed to attach a special
meaning to it. Additionally this enables us to conveniently extend the
mechanism to more axis, whose could be individually enabled without a
bloat of quirk defines.

So tell me what you think of this...

Thanks again for the review,
Richard 


----snip----

[PATCH] [input-hid] Add hid-egalax driver to the unified hid-multitouch framework.

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
 drivers/hid/hid-egalax.c     |  279 ------------------------------------------
 drivers/hid/hid-multitouch.c |   84 ++++++++++++-
 4 files changed, 84 insertions(+), 289 deletions(-)
 delete mode 100644 drivers/hid/hid-egalax.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 4b88bbe..3e25aa7 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -160,13 +160,6 @@ config HID_EMS_FF
 	Currently the following devices are known to be supported:
 	 - Trio Linker Plus II
 
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
 
 	  If unsure, say N.
 
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 04496ab..1b6ddd3 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -36,7 +36,6 @@ obj-$(CONFIG_HID_CHICONY)	+= hid-chicony.o
 obj-$(CONFIG_HID_CYPRESS)	+= hid-cypress.o
 obj-$(CONFIG_HID_DRAGONRISE)	+= hid-drff.o
 obj-$(CONFIG_HID_EMS_FF)	+= hid-emsff.o
-obj-$(CONFIG_HID_EGALAX)	+= hid-egalax.o
 obj-$(CONFIG_HID_ELECOM)	+= hid-elecom.o
 obj-$(CONFIG_HID_EZKEY)		+= hid-ezkey.o
 obj-$(CONFIG_HID_GYRATION)	+= hid-gyration.o
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
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
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
-	int fmin = field->logical_minimum;
-	int fmax = field->logical_maximum;
-	int fuzz = snratio ? (fmax - fmin) / snratio : 0;
-	input_set_abs_params(input, code, fmin, fmax, fuzz, 0);
-}
-
-static int egalax_input_mapping(struct hid_device *hdev, struct hid_input *hi,
-		struct hid_field *field, struct hid_usage *usage,
-		unsigned long **bit, int *max)
-{
-	struct input_dev *input = hi->input;
-
-	switch (usage->hid & HID_USAGE_PAGE) {
-
-	case HID_UP_GENDESK:
-		switch (usage->hid) {
-		case HID_GD_X:
-			field->logical_maximum = 32760;
-			hid_map_usage(hi, usage, bit, max,
-					EV_ABS, ABS_MT_POSITION_X);
-			set_abs(input, ABS_MT_POSITION_X, field, SN_MOVE);
-			/* touchscreen emulation */
-			set_abs(input, ABS_X, field, SN_MOVE);
-			return 1;
-		case HID_GD_Y:
-			field->logical_maximum = 32760;
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
-			field->logical_minimum = 0;
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
-static int egalax_input_mapped(struct hid_device *hdev, struct hid_input *hi,
-		struct hid_field *field, struct hid_usage *usage,
-		unsigned long **bit, int *max)
-{
-	/* tell hid-input to skip setup of these event types */
-	if (usage->type == EV_KEY || usage->type == EV_ABS)
-		set_bit(usage->type, hi->input->evbit);
-	return -1;
-}
-
-/*
- * this function is called when a whole finger has been parsed,
- * so that it can decide what to send to the input layer.
- */
-static void egalax_filter_event(struct egalax_data *td, struct input_dev *input)
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
-static int egalax_event(struct hid_device *hid, struct hid_field *field,
-				struct hid_usage *usage, __s32 value)
-{
-	struct egalax_data *td = hid_get_drvdata(hid);
-
-	/* Note, eGalax has two product lines: the first is resistive and
-	 * uses a standard parallel multitouch protocol (product ID ==
-	 * 48xx).  The second is capacitive and uses an unusual "serial"
-	 * protocol with a different message for each multitouch finger
-	 * (product ID == 72xx).
-	 */
-	if (hid->claimed & HID_CLAIMED_INPUT) {
-		struct input_dev *input = field->hidinput->input;
-
-		switch (usage->hid) {
-		case HID_DG_INRANGE:
-			td->valid = value;
-			break;
-		case HID_DG_CONFIDENCE:
-			/* avoid interference from generic hidinput handling */
-			break;
-		case HID_DG_TIPSWITCH:
-			td->touch = value;
-			break;
-		case HID_DG_TIPPRESSURE:
-			td->z = value;
-			break;
-		case HID_DG_CONTACTID:
-			td->slot = clamp_val(value, 0, MAX_SLOTS - 1);
-			break;
-		case HID_GD_X:
-			td->x = value;
-			break;
-		case HID_GD_Y:
-			td->y = value;
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
-static int egalax_probe(struct hid_device *hdev, const struct hid_device_id *id)
-{
-	int ret;
-	struct egalax_data *td;
-	struct hid_report *report;
-
-	td = kzalloc(sizeof(struct egalax_data), GFP_KERNEL);
-	if (!td) {
-		hid_err(hdev, "cannot allocate eGalax data\n");
-		return -ENOMEM;
-	}
-	hid_set_drvdata(hdev, td);
-
-	ret = hid_parse(hdev);
-	if (ret)
-		goto end;
-
-	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
-	if (ret)
-		goto end;
-
-	report = hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[5]; 
-	if (report) {
-		report->field[0]->value[0] = 2;
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
-static const struct hid_device_id egalax_devices[] = {
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
-static const struct hid_usage_id egalax_grabbed_usages[] = {
-	{ HID_ANY_ID, HID_ANY_ID, HID_ANY_ID },
-	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1}
-};
-
-static struct hid_driver egalax_driver = {
-	.name = "egalax-touch",
-	.id_table = egalax_devices,
-	.probe = egalax_probe,
-	.remove = egalax_remove,
-	.input_mapping = egalax_input_mapping,
-	.input_mapped = egalax_input_mapped,
-	.usage_table = egalax_grabbed_usages,
-	.event = egalax_event,
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
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 65e7f20..55a39ee 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -5,6 +5,12 @@
  *  Copyright (c) 2010-2011 Benjamin Tissoires <benjamin.tissoires@gmail.com>
  *  Copyright (c) 2010-2011 Ecole Nationale de l'Aviation Civile, France
  *
+ *  This code is partly based on hid-egalax.c:
+ *
+ *  Copyright (c) 2010 Stephane Chatty <chatty@enac.fr>
+ *  Copyright (c) 2010 Henrik Rydberg <rydberg@euromail.se>
+ *  Copyright (c) 2010 Canonical, Ltd.
+ *
  */
 
 /*
@@ -37,6 +43,7 @@ MODULE_LICENSE("GPL");
 #define MT_QUIRK_SLOT_IS_CONTACTNUMBER	(1 << 3)
 #define MT_QUIRK_VALID_IS_INRANGE	(1 << 4)
 #define MT_QUIRK_VALID_IS_CONFIDENCE	(1 << 5)
+#define MT_QUIRK_SEND_AT_EACH_REPORT	(1 << 6)
 
 struct mt_slot {
 	__s32 x, y, p, w, h;
@@ -62,7 +69,14 @@ struct mt_class {
 	__s32 quirks;
 	__s32 sn_move;	/* Signal/noise ratio for move events */
 	__s32 sn_pressure;	/* Signal/noise ratio for pressure events */
+	struct { /* correct the reported ranges for specified axis */
+		 __s32 min_x;
+		 __s32 max_x;
+		 __s32 min_y;
+		 __s32 max_y;
+	} axis;
 	__u8 maxcontacts;
+
 };
 
 /* classes of device behavior */
@@ -70,6 +84,8 @@ struct mt_class {
 #define MT_CLS_DUAL_INRANGE_CONTACTID		2
 #define MT_CLS_DUAL_INRANGE_CONTACTNUMBER	3
 #define MT_CLS_CYPRESS				4
+#define MT_CLS_EGALAX_CAPACITIVE		5
+#define MT_CLS_EGALAX_RESISTIVE			6
 
 /*
  * these device-dependent functions determine what slot corresponds
@@ -119,7 +135,33 @@ struct mt_class mt_classes[] = {
 		.quirks = MT_QUIRK_NOT_SEEN_MEANS_UP |
 			MT_QUIRK_CYPRESS,
 		.maxcontacts = 10 },
-
+	{ .name = MT_CLS_EGALAX_CAPACITIVE,
+		.quirks =  MT_QUIRK_SLOT_IS_CONTACTID |
+			MT_QUIRK_VALID_IS_INRANGE,
+		.maxcontacts = 2,
+		.sn_move = 4096,
+		.sn_pressure = 32,
+		.axis = {
+			.min_x = 0,
+			.max_x = 32760,
+			.min_y = 0,
+			.max_y = 32760
+		},
+	},
+	{ .name = MT_CLS_EGALAX_RESISTIVE,
+		.quirks =  MT_QUIRK_SLOT_IS_CONTACTID |
+			MT_QUIRK_VALID_IS_INRANGE |
+			MT_QUIRK_SEND_AT_EACH_REPORT,
+		.maxcontacts = 2,
+		.sn_move = 4096,
+		.sn_pressure = 32,
+		.axis = {
+			.min_x = 0,
+			.max_x = 32760,
+			.min_y = 0,
+			.max_y = 32760
+		},
+	},
 	{ }
 };
 
@@ -152,6 +194,12 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	case HID_UP_GENDESK:
 		switch (usage->hid) {
 		case HID_GD_X:
+			/* fix up the reported X limits if necessary*/
+			if (cls->axis.min_x < cls->axis.max_x) {
+				field->logical_minimum = cls->axis.min_x;
+				field->logical_maximum = cls->axis.max_x;
+			}
+
 			hid_map_usage(hi, usage, bit, max,
 					EV_ABS, ABS_MT_POSITION_X);
 			set_abs(hi->input, ABS_MT_POSITION_X, field,
@@ -161,6 +209,11 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 			td->last_slot_field = usage->hid;
 			return 1;
 		case HID_GD_Y:
+			/* fix up the reported Y limits if nessecary*/
+			if (cls->axis.min_y < cls->axis.max_y) {
+				field->logical_minimum = cls->axis.min_y;
+				field->logical_maximum = cls->axis.max_y;
+			}
 			hid_map_usage(hi, usage, bit, max,
 					EV_ABS, ABS_MT_POSITION_Y);
 			set_abs(hi->input, ABS_MT_POSITION_Y, field,
@@ -204,6 +257,10 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 			td->last_slot_field = usage->hid;
 			return 1;
 		case HID_DG_TIPPRESSURE:
+			/* fix up the pressure range for some devices
+			with broken report */
+			field->logical_minimum = 0;
+
 			hid_map_usage(hi, usage, bit, max,
 					EV_ABS, ABS_MT_PRESSURE);
 			set_abs(hi->input, ABS_MT_PRESSURE, field,
@@ -367,8 +424,12 @@ static int mt_event(struct hid_device *hid, struct hid_field *field,
 		if (usage->hid == td->last_slot_field)
 			mt_complete_slot(td);
 
-		if (field->index == td->last_field_index
+		if ((field->index == td->last_field_index
 			&& td->num_received >= td->num_expected)
+			|| ((quirks & MT_QUIRK_SEND_AT_EACH_REPORT)
+				&& (usage->hid == td->last_slot_field)))
+			/* emit an event for every finger to work around
+			a corrupt last_field_index in the hid report*/
 			mt_emit_event(td, field->hidinput->input);
 
 	}
@@ -484,6 +545,25 @@ static const struct hid_device_id mt_devices[] = {
 		HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
 			USB_DEVICE_ID_CANDO_PIXCIR_MULTI_TOUCH) },
 
+	/* Resistive eGalax devices */
+	{  .driver_data = MT_CLS_EGALAX_RESISTIVE,
+		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH) },
+	{  .driver_data = MT_CLS_EGALAX_RESISTIVE,
+		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH3) },
+
+	/* Capacitive eGalax devices */
+	{  .driver_data = MT_CLS_EGALAX_CAPACITIVE,
+		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH1) },
+	{  .driver_data = MT_CLS_EGALAX_CAPACITIVE,
+		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH2) },
+	{  .driver_data = MT_CLS_EGALAX_CAPACITIVE,
+		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH4) },
+
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, mt_devices);
-- 
1.7.1


