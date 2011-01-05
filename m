From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: [RFC v2 04/10] hid-multitouch: migrated support for Cando panels
Date: Wed,  5 Jan 2011 18:27:42 +0100
Message-ID: <1294248468-19979-5-git-send-email-benjamin.tissoires@enac.fr>
References: <1294248468-19979-1-git-send-email-benjamin.tissoires@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:39258 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978Ab1AER1l (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Jan 2011 12:27:41 -0500
In-Reply-To: <1294248468-19979-1-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephane Chatty <chatty@enac.fr>, Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.orglinux
Cc: Benjamin Tissoires <benjamin.tissoires@enac.fr>

Migrated support for Cando dual-touch panels to the new HID multitouch =
driver.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Signed-off-by: St=C3=A9phane Chatty <chatty@enac.fr>
---
 drivers/hid/Kconfig          |    6 -
 drivers/hid/Makefile         |    1 -
 drivers/hid/hid-cando.c      |  274 ----------------------------------=
--------
 drivers/hid/hid-core.c       |    1 +
 drivers/hid/hid-multitouch.c |   15 +++
 5 files changed, 16 insertions(+), 281 deletions(-)
 delete mode 100644 drivers/hid/hid-cando.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 6519981..faf27c0 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -94,12 +94,6 @@ config HID_BELKIN
 	---help---
 	Support for Belkin Flip KVM and Wireless keyboard.
=20
-config HID_CANDO
-	tristate "Cando dual touch panel"
-	depends on USB_HID
-	---help---
-	Support for Cando dual touch panel.
-
 config HID_CHERRY
 	tristate "Cherry Cymotion keyboard" if EMBEDDED
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index ec991d4..1a0190d 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -30,7 +30,6 @@ obj-$(CONFIG_HID_A4TECH)	+=3D hid-a4tech.o
 obj-$(CONFIG_HID_ACRUX_FF)	+=3D hid-axff.o
 obj-$(CONFIG_HID_APPLE)		+=3D hid-apple.o
 obj-$(CONFIG_HID_BELKIN)	+=3D hid-belkin.o
-obj-$(CONFIG_HID_CANDO)		+=3D hid-cando.o
 obj-$(CONFIG_HID_CHERRY)	+=3D hid-cherry.o
 obj-$(CONFIG_HID_CHICONY)	+=3D hid-chicony.o
 obj-$(CONFIG_HID_CYPRESS)	+=3D hid-cypress.o
diff --git a/drivers/hid/hid-cando.c b/drivers/hid/hid-cando.c
deleted file mode 100644
index 5925bdc..0000000
--- a/drivers/hid/hid-cando.c
+++ /dev/null
@@ -1,274 +0,0 @@
-/*
- *  HID driver for Cando dual-touch panels
- *
- *  Copyright (c) 2010 Stephane Chatty <chatty@enac.fr>
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
-static int cando_input_mapping(struct hid_device *hdev, struct hid_inp=
ut *hi,
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
-static int cando_input_mapped(struct hid_device *hdev, struct hid_inpu=
t *hi,
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
-static void cando_filter_event(struct cando_data *td, struct input_dev=
 *input)
-{
-	td->first =3D !td->first; /* touchscreen emulation */
-
-	if (!td->valid) {
-		/*
-		 * touchscreen emulation: if this is the second finger and
-		 * the first was valid, the first was the oldest; if the
-		 * first was not valid and there was a valid finger in the
-		 * previous frame, this is a release.
-		 */
-		if (td->first) {
-			td->firstid =3D -1;
-		} else if (td->firstid >=3D 0) {
-			input_event(input, EV_ABS, ABS_X, td->firstx);
-			input_event(input, EV_ABS, ABS_Y, td->firsty);
-			td->oldest =3D td->firstid;
-		} else if (td->oldest >=3D 0) {
-			input_event(input, EV_KEY, BTN_TOUCH, 0);
-			td->oldest =3D -1;
-		}
-
-		return;
-	}
-=09
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
-		td->oldest =3D td->id;
-	}
-
-	/*
-	 * touchscreen emulation: if this is the first finger, wait for the
-	 * second; the oldest is then the second if it was the oldest already
-	 * or if there was no first, the first otherwise.
-	 */
-	if (td->first) {
-		td->firstx =3D td->x;
-		td->firsty =3D td->y;
-		td->firstid =3D td->id;
-	} else {
-		int x, y, oldest;
-		if (td->id =3D=3D td->oldest || td->firstid < 0) {
-			x =3D td->x;
-			y =3D td->y;
-			oldest =3D td->id;
-		} else {
-			x =3D td->firstx;
-			y =3D td->firsty;
-			oldest =3D td->firstid;
-		}
-		input_event(input, EV_ABS, ABS_X, x);
-		input_event(input, EV_ABS, ABS_Y, y);
-		td->oldest =3D oldest;
-	}
-}
-
-
-static int cando_event(struct hid_device *hid, struct hid_field *field=
,
-				struct hid_usage *usage, __s32 value)
-{
-	struct cando_data *td =3D hid_get_drvdata(hid);
-
-	if (hid->claimed & HID_CLAIMED_INPUT) {
-		struct input_dev *input =3D field->hidinput->input;
-
-		switch (usage->hid) {
-		case HID_DG_INRANGE:
-			td->valid =3D value;
-			break;
-		case HID_DG_CONTACTID:
-			td->id =3D value;
-			break;
-		case HID_GD_X:
-			td->x =3D value;
-			break;
-		case HID_GD_Y:
-			td->y =3D value;
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
-static int cando_probe(struct hid_device *hdev, const struct hid_devic=
e_id *id)
-{
-	int ret;
-	struct cando_data *td;
-
-	td =3D kmalloc(sizeof(struct cando_data), GFP_KERNEL);
-	if (!td) {
-		dev_err(&hdev->dev, "cannot allocate Cando Touch data\n");
-		return -ENOMEM;
-	}
-	hid_set_drvdata(hdev, td);
-	td->first =3D false;
-	td->oldest =3D -1;
-	td->valid =3D false;
-
-	ret =3D hid_parse(hdev);
-	if (!ret)
-		ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
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
-static const struct hid_device_id cando_devices[] =3D {
-	{ HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
-			USB_DEVICE_ID_CANDO_MULTI_TOUCH) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
-			USB_DEVICE_ID_CANDO_MULTI_TOUCH_11_6) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
-		USB_DEVICE_ID_CANDO_MULTI_TOUCH_15_6) },
-	{ }
-};
-MODULE_DEVICE_TABLE(hid, cando_devices);
-
-static const struct hid_usage_id cando_grabbed_usages[] =3D {
-	{ HID_ANY_ID, HID_ANY_ID, HID_ANY_ID },
-	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1}
-};
-
-static struct hid_driver cando_driver =3D {
-	.name =3D "cando-touch",
-	.id_table =3D cando_devices,
-	.probe =3D cando_probe,
-	.remove =3D cando_remove,
-	.input_mapping =3D cando_input_mapping,
-	.input_mapped =3D cando_input_mapped,
-	.usage_table =3D cando_grabbed_usages,
-	.event =3D cando_event,
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
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 2b4d9b9..9f1ab80 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1288,6 +1288,7 @@ static const struct hid_device_id hid_blacklist[]=
 =3D {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BTC, USB_DEVICE_ID_BTC_EMPREX_REMOTE_2=
) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CANDO, USB_DEVICE_ID_CANDO_PIXCIR_MULT=
I_TOUCH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CANDO, USB_DEVICE_ID_CANDO_MULTI_TOUCH=
) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CANDO, USB_DEVICE_ID_CANDO_MULTI_TOUCH=
_10_1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CANDO, USB_DEVICE_ID_CANDO_MULTI_TOUCH=
_11_6) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CANDO, USB_DEVICE_ID_CANDO_MULTI_TOUCH=
_15_6) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHERRY, USB_DEVICE_ID_CHERRY_CYMOTION)=
 },
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.=
c
index aea0e32..374389e 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -64,6 +64,7 @@ struct mt_class {
 /* classes of device behavior */
 #define MT_CLS_DEFAULT 0
 #define MT_CLS_DUAL1 1
+#define MT_CLS_DUAL2 2
=20
 /*
  * these device-dependent functions determine what slot corresponds
@@ -75,6 +76,11 @@ static int slot_is_contactid(struct mt_device *td)
 	return td->curdata.contactid;
 }
=20
+static int slot_is_contactnumber(struct mt_device *td)
+{
+	return td->num_received;
+}
+
 static int find_slot_from_contactid(struct mt_device *td)
 {
 	int i;
@@ -93,6 +99,7 @@ static int find_slot_from_contactid(struct mt_device =
*td)
 struct mt_class mt_classes[] =3D {
 	{ find_slot_from_contactid, 10 },     /* MT_CLS_DEFAULT */
 	{ slot_is_contactid, 2 },             /* MT_CLS_DUAL1 */
+	{ slot_is_contactnumber, 2 },         /* MT_CLS_DUAL2 */
 };
=20
 static void mt_feature_mapping(struct hid_device *hdev, struct hid_inp=
ut *hi,
@@ -396,6 +403,14 @@ static const struct hid_device_id mt_devices[] =3D=
 {
 		HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
 			USB_DEVICE_ID_CANDO_PIXCIR_MULTI_TOUCH) },
=20
+	/* Cando panels */
+	{ .driver_data =3D MT_CLS_DUAL2,
+		HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
+			USB_DEVICE_ID_CANDO_MULTI_TOUCH) },
+	{ .driver_data =3D MT_CLS_DUAL2,
+		HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
+			USB_DEVICE_ID_CANDO_MULTI_TOUCH_11_6) },
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
