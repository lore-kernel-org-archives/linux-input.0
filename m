From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3] [input-hid] Add hid-egalax driver to the unified
 hid-multitouch framework.
Date: Wed, 9 Mar 2011 09:24:55 +0100
Message-ID: <20110309082455.GA3166@polaris.bitmath.org>
References: <1299417912.9645.495.camel@itzy>
 <AANLkTimkYHPvn0PqcVyJv1rPTn3F7F8p3+3Y0-4F=MwW@mail.gmail.com>
 <1299564524.2306.18.camel@itzy>
 <20110308080414.GA2888@polaris.bitmath.org>
 <AANLkTimT9q8mo3uW0P7T0B=D4kkE83OB9ycgdJ_muZ2W@mail.gmail.com>
 <20110308091434.GA3282@polaris.bitmath.org>
 <AANLkTiko_mKgW6fXeAuBY4D5AT_9OHAJnk_mfQEPQVF9@mail.gmail.com>
 <20110308094630.GA3396@polaris.bitmath.org>
 <1299627518.2306.47.camel@itzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:42565 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753904Ab1CIIXQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Mar 2011 03:23:16 -0500
Content-Disposition: inline
In-Reply-To: <1299627518.2306.47.camel@itzy>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Nauber <richard.nauber@googlemail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>

Hi Richard,

> here is the third version of this patch, improved according to your suggestions. 
> 
> > What I meant is that (min_x < max_x) is the proper test.
> > 
> > > No need for a quirk that will be redundant with the hand-provided values.
> > 
> > Yes, but I think we might be better off using a quirk than a generic
> > way to replace the values provided by the hardware.
> 
> My personal opinion is that the override should be triggered by your
> (min_x < max_x) test, which is safe, because the (min_x == max_x) case
> makes no sense for a device and we are allowed to attach a special
> meaning to it. Additionally this enables us to conveniently extend the
> mechanism to more axis, whose could be individually enabled without a
> bloat of quirk defines.
> 
> So tell me what you think of this...

Having a mechanism to override device limits suggests this is
generally needed, which is not the case. Adding a specific quirk for
this specific hardware seems more appropriate. Also, it seems the
special behavior of the newer firmwares can be autodetected, so there
is no need for more than one class. I have added two patches below,
tested on a joojoo. Do you concur with the changes, and do they still
work for you?

Thanks,
Henrik

>From 67fd1e768341a8f67cd882b7603de62b5f250970 Mon Sep 17 00:00:00 2001
From: Henrik Rydberg <rydberg@euromail.se>
Date: Wed, 9 Mar 2011 06:35:25 +0100
Subject: [PATCH 1/2] HID: hid-multitouch: Send events per slot if CONTACTCOUNT is missing

The recent capacitive DWAV firmwares do not use the CONTACTCOUNT
field, and the touch frame boundary can therefore not be determined.
This patch makes the driver report the touch frame at each completed
slot instead.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hid/hid-multitouch.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 69f8744..4518006 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -364,8 +364,11 @@ static int mt_event(struct hid_device *hid, struct hid_field *field,
 			return 0;
 		}
 
-		if (usage->hid == td->last_slot_field)
+		if (usage->hid == td->last_slot_field) {
 			mt_complete_slot(td);
+			if (!td->last_field_index)
+				mt_emit_event(td, field->hidinput->input);
+		}
 
 		if (field->index == td->last_field_index
 			&& td->num_received >= td->num_expected)
-- 
1.7.4.1

>From cd625e954a7f9774ae8f84a9eb2315c6da8b387c Mon Sep 17 00:00:00 2001
From: Richard Nauber <richard.nauber@googlemail.com>
Date: Wed, 9 Mar 2011 06:20:57 +0100
Subject: [PATCH 2/2] HID: merge hid-egalax into hid-multitouch

This patch merges the hid-egalax driver into hid-multitouch.  There
are two types of devices support by the hid-egalax driver: resistive
and capacitive. Here, they are implicitly distinguished by the absence
of a HID_DG_CONTACTCOUNT field in the latter, so no special code path
needs to be introduced.

As a side effect, this patch fixes the broken suspend/resume behavior
in the old driver.

[rydberg@euromail.se: minor fixups]
Not-yet-Signed-off-by: Richard Nauber <Richard.Nauber@gmail.com>
Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hid/Kconfig          |    9 +-
 drivers/hid/Makefile         |    1 -
 drivers/hid/hid-egalax.c     |  279 ------------------------------------------
 drivers/hid/hid-multitouch.c |   43 +++++++
 4 files changed, 45 insertions(+), 287 deletions(-)
 delete mode 100644 drivers/hid/hid-egalax.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index a0b117d..b4b8b21 100644
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
@@ -307,6 +300,8 @@ config HID_MULTITOUCH
 	  - IrTouch Infrared USB panels
 	  - Pixcir dual touch panels
 	  - 'Sensing Win7-TwoFinger' panel by GeneralTouch
+          - eGalax dual-touch panels, including the
+	    Joojoo and Wetab tablets
 
 	  If unsure, say N.
 
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 6efc2a0..29e9898 100644
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
index 4518006..c2e79dc 100644
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
+#define MT_QUIRK_EGALAX_XYZ_FIXUP	(1 << 6)
 
 struct mt_slot {
 	__s32 x, y, p, w, h;
@@ -70,6 +77,7 @@ struct mt_class {
 #define MT_CLS_DUAL_INRANGE_CONTACTID		2
 #define MT_CLS_DUAL_INRANGE_CONTACTNUMBER	3
 #define MT_CLS_CYPRESS				4
+#define MT_CLS_EGALAX				5
 
 /*
  * these device-dependent functions determine what slot corresponds
@@ -120,6 +128,14 @@ struct mt_class mt_classes[] = {
 			MT_QUIRK_CYPRESS,
 		.maxcontacts = 10 },
 
+	{ .name = MT_CLS_EGALAX,
+		.quirks =  MT_QUIRK_SLOT_IS_CONTACTID |
+			MT_QUIRK_VALID_IS_INRANGE |
+			MT_QUIRK_EGALAX_XYZ_FIXUP
+		.maxcontacts = 2,
+		.sn_move = 4096,
+		.sn_pressure = 32,
+	},
 	{ }
 };
 
@@ -147,11 +163,15 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
 	struct mt_class *cls = td->mtclass;
+	__s32 quirks = cls->quirks;
+
 	switch (usage->hid & HID_USAGE_PAGE) {
 
 	case HID_UP_GENDESK:
 		switch (usage->hid) {
 		case HID_GD_X:
+			if (quirks & MT_QUIRK_EGALAX_XYZ_FIXUP)
+				field->logical_maximum = 32760;
 			hid_map_usage(hi, usage, bit, max,
 					EV_ABS, ABS_MT_POSITION_X);
 			set_abs(hi->input, ABS_MT_POSITION_X, field,
@@ -161,6 +181,8 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 			td->last_slot_field = usage->hid;
 			return 1;
 		case HID_GD_Y:
+			if (quirks & MT_QUIRK_EGALAX_XYZ_FIXUP)
+				field->logical_maximum = 32760;
 			hid_map_usage(hi, usage, bit, max,
 					EV_ABS, ABS_MT_POSITION_Y);
 			set_abs(hi->input, ABS_MT_POSITION_Y, field,
@@ -204,6 +226,8 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 			td->last_slot_field = usage->hid;
 			return 1;
 		case HID_DG_TIPPRESSURE:
+			if (quirks & MT_QUIRK_EGALAX_XYZ_FIXUP)
+				field->logical_minimum = 0;
 			hid_map_usage(hi, usage, bit, max,
 					EV_ABS, ABS_MT_PRESSURE);
 			set_abs(hi->input, ABS_MT_PRESSURE, field,
@@ -487,6 +511,25 @@ static const struct hid_device_id mt_devices[] = {
 		HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
 			USB_DEVICE_ID_CANDO_PIXCIR_MULTI_TOUCH) },
 
+	/* Resistive eGalax devices */
+	{  .driver_data = MT_CLS_EGALAX,
+		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH) },
+	{  .driver_data = MT_CLS_EGALAX,
+		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH3) },
+
+	/* Capacitive eGalax devices */
+	{  .driver_data = MT_CLS_EGALAX,
+		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH1) },
+	{  .driver_data = MT_CLS_EGALAX,
+		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH2) },
+	{  .driver_data = MT_CLS_EGALAX,
+		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH4) },
+
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, mt_devices);
-- 
1.7.4.1

