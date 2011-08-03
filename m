From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@gmail.com>
Subject: PATCH v2 [1/6] HID: lg4ff - Move handling of Logitech wheels to lg4ff driver
Date: Wed, 03 Aug 2011 16:57:48 +0200
Message-ID: <3640475.po0nMniALh@qosmio-x300>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33926 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205Ab1HCO56 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Aug 2011 10:57:58 -0400
Received: by fxh19 with SMTP id 19so736510fxh.19
        for <linux-input@vger.kernel.org>; Wed, 03 Aug 2011 07:57:57 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, simon@mungewell.org

Removed UTF-8 characters from the active code.

Signed-off-by: Michal Mal=FD <madcatxster@gmail.com>

---
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index db63ccf..ea2c338 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -436,6 +436,7 @@
 #define USB_DEVICE_ID_LOGITECH_MOMO_WHEEL	0xc295
 #define USB_DEVICE_ID_LOGITECH_DFP_WHEEL	0xc298
 #define USB_DEVICE_ID_LOGITECH_G25_WHEEL	0xc299
+#define USB_DEVICE_ID_LOGITECH_DFGT_WHEEL	0xc29a
 #define USB_DEVICE_ID_LOGITECH_G27_WHEEL	0xc29b
 #define USB_DEVICE_ID_LOGITECH_WII_WHEEL	0xc29c
 #define USB_DEVICE_ID_LOGITECH_ELITE_KBD	0xc30a
diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index a7f916e..e0ae4a0 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -363,7 +363,7 @@ static int lg_probe(struct hid_device *hdev, const =
struct hid_device_id *id)
 		goto err_free;
 	}
=20
-	if (quirks & (LG_FF | LG_FF2 | LG_FF3))
+	if (quirks & (LG_FF | LG_FF2 | LG_FF3 | LG_FF4))
 		connect_mask &=3D ~HID_CONNECT_FF;
=20
 	ret =3D hid_hw_start(hdev, connect_mask);
@@ -372,7 +372,8 @@ static int lg_probe(struct hid_device *hdev, const =
struct hid_device_id *id)
 		goto err_free;
 	}
=20
-	if (quirks & LG_FF4) {
+	/* Setup wireless link with Logitech Wii wheel */
+	if(hdev->product =3D=3D USB_DEVICE_ID_LOGITECH_WII_WHEEL) {
 		unsigned char buf[] =3D { 0x00, 0xAF,  0x01, 0x00, 0x00, 0x00, 0x00,=
 0x00, 0x00 };
=20
 		ret =3D hdev->hid_output_raw_report(hdev, buf, sizeof(buf), HID_FEAT=
URE_REPORT);
@@ -431,7 +432,7 @@ static const struct hid_device_id lg_devices[] =3D =
{
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_EXTRE=
ME_3D),
 		.driver_data =3D LG_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WHEEL=
),
-		.driver_data =3D LG_NOGET | LG_FF },
+		.driver_data =3D LG_NOGET | LG_FF4 },
=20
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBL=
EPAD_CORD),
 		.driver_data =3D LG_FF2 },
@@ -444,15 +445,17 @@ static const struct hid_device_id lg_devices[] =3D=
 {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_FORCE=
3D_PRO),
 		.driver_data =3D LG_FF },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOMO_=
WHEEL),
-		.driver_data =3D LG_FF },
+		.driver_data =3D LG_FF4 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOMO_=
WHEEL2),
-		.driver_data =3D LG_FF },
+		.driver_data =3D LG_FF4 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G25_W=
HEEL),
-		.driver_data =3D LG_FF },
+		.driver_data =3D LG_FF4 },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_DFGT_=
WHEEL),
+		.driver_data =3D LG_FF4 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G27_W=
HEEL),
-		.driver_data =3D LG_FF },
+		.driver_data =3D LG_FF4 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_DFP_W=
HEEL),
-		.driver_data =3D LG_NOGET | LG_FF },
+		.driver_data =3D LG_NOGET | LG_FF4 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WII_W=
HEEL),
 		.driver_data =3D LG_FF4 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WINGM=
AN_FFG ),
diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index fa550c8..6b357ac 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -29,17 +29,32 @@
=20
 #include "usbhid/usbhid.h"
 #include "hid-lg.h"
+#include "hid-ids.h"
=20
-struct lg4ff_device {
-	struct hid_report *report;
-};
-
-static const signed short ff4_wheel_ac[] =3D {
+static const signed short lg4ff_wheel_effects[] =3D {
 	FF_CONSTANT,
 	FF_AUTOCENTER,
 	-1
 };
=20
+struct lg4ff_wheel {
+	const __u32 product_id;
+	const signed short *ff_effects;
+	const __u16 min_range;
+	const __u16 max_range;
+};
+
+static const struct lg4ff_wheel lg4ff_devices[] =3D {
+	{USB_DEVICE_ID_LOGITECH_WHEEL,       lg4ff_wheel_effects, 40, 270},
+	{USB_DEVICE_ID_LOGITECH_MOMO_WHEEL,  lg4ff_wheel_effects, 40, 270},
+	{USB_DEVICE_ID_LOGITECH_DFP_WHEEL,   lg4ff_wheel_effects, 40, 900},
+	{USB_DEVICE_ID_LOGITECH_G25_WHEEL,   lg4ff_wheel_effects, 40, 900},
+	{USB_DEVICE_ID_LOGITECH_DFGT_WHEEL,  lg4ff_wheel_effects, 40, 900},
+	{USB_DEVICE_ID_LOGITECH_G27_WHEEL,   lg4ff_wheel_effects, 40, 900},
+	{USB_DEVICE_ID_LOGITECH_MOMO_WHEEL2, lg4ff_wheel_effects, 40, 270},
+	{USB_DEVICE_ID_LOGITECH_WII_WHEEL,   lg4ff_wheel_effects, 40, 270}
+};
+
 static int hid_lg4ff_play(struct input_dev *dev, void *data,
 			 struct ff_effect *effect)
 {
@@ -55,13 +70,12 @@ static int hid_lg4ff_play(struct input_dev *dev, vo=
id *data,
 		x =3D effect->u.ramp.start_level + 0x80;	/* 0x80 is no force */
 		CLAMP(x);
 		report->field[0]->value[0] =3D 0x11;	/* Slot 1 */
-		report->field[0]->value[1] =3D 0x10;
+		report->field[0]->value[1] =3D 0x08;
 		report->field[0]->value[2] =3D x;
-		report->field[0]->value[3] =3D 0x00;
+		report->field[0]->value[3] =3D 0x80;
 		report->field[0]->value[4] =3D 0x00;
-		report->field[0]->value[5] =3D 0x08;
+		report->field[0]->value[5] =3D 0x00;
 		report->field[0]->value[6] =3D 0x00;
-		dbg_hid("Autocenter, x=3D0x%02X\n", x);
=20
 		usbhid_submit_report(hid, report, USB_DIR_OUT);
 		break;
@@ -74,15 +88,14 @@ static void hid_lg4ff_set_autocenter(struct input_d=
ev *dev, u16 magnitude)
 	struct hid_device *hid =3D input_get_drvdata(dev);
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
-	__s32 *value =3D report->field[0]->value;
=20
-	*value++ =3D 0xfe;
-	*value++ =3D 0x0d;
-	*value++ =3D 0x07;
-	*value++ =3D 0x07;
-	*value++ =3D (magnitude >> 8) & 0xff;
-	*value++ =3D 0x00;
-	*value =3D 0x00;
+	report->field[0]->value[0] =3D 0xfe;
+	report->field[0]->value[1] =3D 0x0d;
+	report->field[0]->value[2] =3D magnitude >> 13;
+	report->field[0]->value[3] =3D magnitude >> 13;
+	report->field[0]->value[4] =3D magnitude >> 8;
+	report->field[0]->value[5] =3D 0x00;
+	report->field[0]->value[6] =3D 0x00;
=20
 	usbhid_submit_report(hid, report, USB_DIR_OUT);
 }
@@ -95,9 +108,7 @@ int lg4ff_init(struct hid_device *hid)
 	struct input_dev *dev =3D hidinput->input;
 	struct hid_report *report;
 	struct hid_field *field;
-	const signed short *ff_bits =3D ff4_wheel_ac;
-	int error;
-	int i;
+	int error, i, j;
=20
 	/* Find the report to use */
 	if (list_empty(report_list)) {
@@ -117,9 +128,24 @@ int lg4ff_init(struct hid_device *hid)
 		hid_err(hid, "NULL field\n");
 		return -1;
 	}
+=09
+	/* Check what wheel has been connected */
+	for (i =3D 0; i < ARRAY_SIZE(lg4ff_devices); i++) {
+		if (hid->product =3D=3D lg4ff_devices[i].product_id) {
+			dbg_hid("Found compatible device, product ID %04X\n", lg4ff_devices=
[i].product_id);
+			break;
+		}
+	}
+
+	if (i =3D=3D ARRAY_SIZE(lg4ff_devices)) {
+		hid_err(hid, "Device is not supported by lg4ff driver. If you think =
it should be, consider reporting a bug to"
+			     "LKML, Simon Wood <simon@mungewell.org> or Michal Maly <madcat=
xster@gmail.com>\n");
+		return -1;
+	}
=20
-	for (i =3D 0; ff_bits[i] >=3D 0; i++)
-		set_bit(ff_bits[i], dev->ffbit);
+	/* Set supported force feedback capabilities */
+	for (j =3D 0; lg4ff_devices[i].ff_effects[j] >=3D 0; j++)
+		set_bit(lg4ff_devices[i].ff_effects[j], dev->ffbit);
=20
 	error =3D input_ff_create_memless(dev, NULL, hid_lg4ff_play);
=20
diff --git a/drivers/hid/hid-lgff.c b/drivers/hid/hid-lgff.c
index 088f850..27bc54f 100644
--- a/drivers/hid/hid-lgff.c
+++ b/drivers/hid/hid-lgff.c
@@ -58,12 +58,6 @@ static const signed short ff_joystick_ac[] =3D {
 	-1
 };
=20
-static const signed short ff_wheel[] =3D {
-	FF_CONSTANT,
-	FF_AUTOCENTER,
-	-1
-};
-
 static const struct dev_type devices[] =3D {
 	{ 0x046d, 0xc211, ff_rumble },
 	{ 0x046d, 0xc219, ff_rumble },
@@ -71,14 +65,7 @@ static const struct dev_type devices[] =3D {
 	{ 0x046d, 0xc286, ff_joystick_ac },
 	{ 0x046d, 0xc287, ff_joystick_ac },
 	{ 0x046d, 0xc293, ff_joystick },
-	{ 0x046d, 0xc294, ff_wheel },
-	{ 0x046d, 0xc298, ff_wheel },
-	{ 0x046d, 0xc299, ff_wheel },
-	{ 0x046d, 0xc29b, ff_wheel },
 	{ 0x046d, 0xc295, ff_joystick },
-	{ 0x046d, 0xc298, ff_wheel },
-	{ 0x046d, 0xc299, ff_wheel },
-	{ 0x046d, 0xca03, ff_wheel },
 };
=20
 static int hid_lgff_play(struct input_dev *dev, void *data, struct ff_=
effect *effect)

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
