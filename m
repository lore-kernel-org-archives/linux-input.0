From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: [patch] HID: add support for another version of 0e8f:0003 device
 in hid-pl
Date: Fri, 27 Feb 2009 23:47:00 +0200
Message-ID: <49A85F54.5090005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:60336 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759689AbZB0VrM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2009 16:47:12 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Pantelis Koukousoulas <pktoss@gmail.com>

Add support for another version of 0e8f:0003 device into hid-pl driver.
This device has the values in separate fields and resembles devices
handled by hid-zpff.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>
Tested-by: Pantelis Koukousoulas <pktoss@gmail.com>

--- linux-2629-pidff/drivers/hid/hid-pl.c.old	2009-02-13 03:47:15.00000=
0000 +0200
+++ linux-2629-pidff/drivers/hid/hid-pl.c	2009-02-27 21:40:58.000000000=
 +0200
@@ -9,9 +9,12 @@
  *   - contains two reports, one for each port (HID_QUIRK_MULTI_INPUT)
  *
  *  0e8f:0003 "GreenAsia Inc.    USB Joystick     "
- *   - tested with K??ng Gaming gamepad
+ *   - tested with K=C3=B6nig Gaming gamepad
  *
- *  Copyright (c) 2007 Anssi Hannula <anssi.hannula@gmail.com>
+ *  0e8f:0003 "GASIA USB Gamepad"
+ *   - another version of the K=C3=B6nig gamepad
+ *
+ *  Copyright (c) 2007, 2009 Anssi Hannula <anssi.hannula@gmail.com>
  */
=20
 /*
@@ -46,6 +49,8 @@
=20
 struct plff_device {
 	struct hid_report *report;
+	s32 *strong;
+	s32 *weak;
 };
=20
 static int hid_plff_play(struct input_dev *dev, void *data,
@@ -62,8 +67,8 @@ static int hid_plff_play(struct input_de
 	left =3D left * 0x7f / 0xffff;
 	right =3D right * 0x7f / 0xffff;
=20
-	plff->report->field[0]->value[2] =3D left;
-	plff->report->field[0]->value[3] =3D right;
+	*plff->strong =3D left;
+	*plff->weak =3D right;
 	debug("running with 0x%02x 0x%02x", left, right);
 	usbhid_submit_report(hid, plff->report, USB_DIR_OUT);
=20
@@ -80,6 +85,8 @@ static int plff_init(struct hid_device *
 	struct list_head *report_ptr =3D report_list;
 	struct input_dev *dev;
 	int error;
+	s32 *strong;
+	s32 *weak;
=20
 	/* The device contains one output report per physical device, all
 	   containing 1 field, which contains 4 ff00.0002 usages and 4 16bit
@@ -87,7 +94,12 @@ static int plff_init(struct hid_device *
=20
 	   The input reports also contain a field which contains
 	   8 ff00.0001 usages and 8 boolean values. Their meaning is
-	   currently unknown. */
+	   currently unknown.
+	  =20
+	   A version of the 0e8f:0003 exists that has all the values in
+	   separate fields and misses the extra input field, thus resembling
+	   Zeroplus (hid-zpff) devices.
+	*/
=20
 	if (list_empty(report_list)) {
 		dev_err(&hid->dev, "no output reports found\n");
@@ -110,8 +122,21 @@ static int plff_init(struct hid_device *
 			return -ENODEV;
 		}
=20
-		if (report->field[0]->report_count < 4) {
-			dev_err(&hid->dev, "not enough values in the field\n");
+		if (report->field[0]->report_count >=3D 4) {
+			report->field[0]->value[0] =3D 0x00;
+			report->field[0]->value[1] =3D 0x00;
+			strong =3D &report->field[0]->value[2];
+			weak =3D &report->field[0]->value[3];
+			debug("detected single-field device");
+		} else if (report->maxfield >=3D 4 && report->field[0]->maxusage =3D=
=3D 1 &&
+				report->field[0]->usage[0].hid =3D=3D (HID_UP_LED | 0x43)) {
+			report->field[0]->value[0] =3D 0x00;
+			report->field[1]->value[0] =3D 0x00;
+			strong =3D &report->field[2]->value[0];
+			weak =3D &report->field[3]->value[0];
+			debug("detected 4-field device");
+		} else {
+			dev_err(&hid->dev, "not enough fields or values\n");
 			return -ENODEV;
 		}
=20
@@ -130,10 +155,11 @@ static int plff_init(struct hid_device *
 		}
=20
 		plff->report =3D report;
-		plff->report->field[0]->value[0] =3D 0x00;
-		plff->report->field[0]->value[1] =3D 0x00;
-		plff->report->field[0]->value[2] =3D 0x00;
-		plff->report->field[0]->value[3] =3D 0x00;
+		plff->strong =3D strong;
+		plff->weak =3D weak;
+
+		*strong =3D 0x00;
+		*weak =3D 0x00;
 		usbhid_submit_report(hid, plff->report, USB_DIR_OUT);
 	}
=20
@@ -180,7 +206,7 @@ static const struct hid_device_id pl_dev
 		.driver_data =3D 1 }, /* Twin USB Joystick */
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMERON, USB_DEVICE_ID_GAMERON_DUAL_PC=
S_ADAPTOR),
 		.driver_data =3D 1 }, /* Twin USB Joystick */
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GREENASIA, 0x0003), }, /* GreenAsia In=
c. USB Joystick */
+	{ HID_USB_DEVICE(USB_VENDOR_ID_GREENASIA, 0x0003), },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, pl_devices);


--=20
Anssi Hannula

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
