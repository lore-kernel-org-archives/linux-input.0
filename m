From: Piotr Sawuk <piotr5@users.sf.net>
Subject: [Patch v2] hid: enhance hid-saitek for use with R.A.T.5 and similar
Date: Thu, 28 Jan 2016 00:18:29 +0100
Message-ID: <56A95045.3080107@users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from grace.univie.ac.at ([131.130.3.115]:50277 "EHLO
	grace.univie.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755242AbcA0XSp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jan 2016 18:18:45 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org

added support for my pid so I can test the changes:
3 events were mapped to one, this allows discerning which is which.
on my mouse there is a button with a 3 colour-led.
I can now determine in user-space which colour is visible.
this patch replaces my previous ones.
if you use an older kernel than Dec 28th 2015, use previous patch!

Signed-off-by: Piotr Sawuk <piotr5@users.sf.net>
---
add support for mad catz r.a.t.5
add a file in sysfs called "mode" exposing the integer of that name.
diff -rup linux-4.2.6-gentoo/drivers/hid/hid-core.c linux-4.2.6-gentoo-=
rat5/drivers/hid/hid-core.c
--- linux-4.2.6-gentoo/drivers/hid/hid-core.c	2015-08-30 20:34:09.00000=
0000 +0200
+++ linux-4.2.6-gentoo-rat5/drivers/hid/hid-core.c	2016-01-27 22:38:19.=
133124625 +0100
@@ -1958,6 +1958,7 @@ static const struct hid_device_id hid_ha
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7_OLD)=
 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_MMO7) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_RAT5) }=
,
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_RAT9) }=
,
 #endif
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMO=
TE) },
diff -rup linux-4.2.6-gentoo/drivers/hid/hid-ids.h linux-4.2.6-gentoo-r=
at5/drivers/hid/hid-ids.h
--- linux-4.2.6-gentoo/drivers/hid/hid-ids.h	2015-08-30 20:34:09.000000=
000 +0200
+++ linux-4.2.6-gentoo-rat5/drivers/hid/hid-ids.h	2015-12-29 18:47:36.7=
56225217 +0100
@@ -634,6 +634,7 @@
=20
 #define USB_VENDOR_ID_MADCATZ		0x0738
 #define USB_DEVICE_ID_MADCATZ_BEATPAD	0x4540
+#define USB_DEVICE_ID_MADCATZ_RAT5	0x1705
 #define USB_DEVICE_ID_MADCATZ_RAT9	0x1709
=20
 #define USB_VENDOR_ID_MCC		0x09db
diff -rup linux-4.2.6-gentoo/drivers/hid/hid-saitek.c linux-4.2.6-gento=
o-rat5/drivers/hid/hid-saitek.c
--- linux-4.2.6-gentoo/drivers/hid/hid-saitek.c	2015-08-30 20:34:09.000=
000000 +0200
+++ linux-4.2.6-gentoo-rat5/drivers/hid/hid-saitek.c	2016-01-27 22:36:3=
5.475950332 +0100
@@ -7,10 +7,11 @@
  *  (This module is based on "hid-ortek".)
  *  Copyright (c) 2012 Andreas H=C3=BCbner
  *
- *  R.A.T.7, R.A.T.9, M.M.O.7 (USB gaming mice):
+ *  R.A.T.5, R.A.T.7, R.A.T.9, M.M.O.7 (USB gaming mice):
  *  Fixes the mode button which cycles through three constantly presse=
d
  *  buttons. All three press events are mapped to one button and the
  *  missing release event is generated immediately.
+ *  Original press event is available in "mode" file on sysfs.
  *
  */
=20
@@ -37,6 +38,40 @@ struct saitek_sc {
 	int mode;
 };
=20
+static ssize_t show_mode(struct device *dev,
+		struct device_attribute *attr,
+		char *mode_buf);
+
+/* world-readable since errors are caught and no usb-interaction neede=
d. */
+DEVICE_ATTR(mode,0444,show_mode,NULL);
+
+static ssize_t show_mode(struct device *dev,
+		struct device_attribute *attr,
+		char *mode_buf)
+{
+	struct saitek_sc *ssc;
+	struct hid_device *hdev;
+
+	/* error-messages in sysfs file since it's non-critical. */
+	if (dev =3D=3D NULL) {
+		return snprintf(mode_buf, PAGE_SIZE, "No parent.\n");
+	}
+
+	hdev =3D to_hid_device(dev);
+	ssc =3D hid_get_drvdata(hdev);
+	if (ssc =3D=3D NULL) {
+		return snprintf(mode_buf, PAGE_SIZE, "No data.\n");
+	}
+
+	/* actual output is number >=3D1. 0 or above text for error: */
+	return snprintf(mode_buf, PAGE_SIZE, "%i\n", ssc->mode + 1);
+}
+
+static void saitek_remove(struct hid_device *hdev)
+{
+	device_remove_file(&hdev->dev, &dev_attr_mode);
+}
+
 static int saitek_probe(struct hid_device *hdev,
 		const struct hid_device_id *id)
 {
@@ -61,9 +96,15 @@ static int saitek_probe(struct hid_devic
 		return ret;
 	}
=20
+	ret =3D device_create_file(&hdev->dev, &dev_attr_mode);
+	if (ret) {
+		hid_warn(hdev, "Couldn't create mode file in sysfs.\n");
+	}
+
 	ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");
+		saitek_remove(hdev);
 		return ret;
 	}
=20
@@ -181,6 +222,8 @@ static const struct hid_device_id saitek
 		.driver_data =3D SAITEK_RELEASE_MODE_RAT7 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7),
 		.driver_data =3D SAITEK_RELEASE_MODE_RAT7 },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_RAT5),
+		.driver_data =3D SAITEK_RELEASE_MODE_RAT7 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_RAT9),
 		.driver_data =3D SAITEK_RELEASE_MODE_RAT7 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_MMO7),
@@ -197,6 +240,7 @@ static struct hid_driver saitek_driver =3D
 	.report_fixup =3D saitek_report_fixup,
 	.raw_event =3D saitek_raw_event,
 	.event =3D saitek_event,
+	.remove =3D saitek_remove,
 };
 module_hid_driver(saitek_driver);
=20
diff -rup linux-4.2.6-gentoo/drivers/hid/Kconfig linux-4.2.6-gentoo-rat=
5/drivers/hid/Kconfig
--- linux-4.2.6-gentoo/drivers/hid/Kconfig	2015-08-30 20:34:09.00000000=
0 +0200
+++ linux-4.2.6-gentoo-rat5/drivers/hid/Kconfig	2015-12-30 12:14:49.228=
404039 +0100
@@ -665,6 +665,7 @@ config HID_SAITEK
=20
 	Supported devices:
 	- PS1000 Dual Analog Pad
+	- R.A.T.5 Gaming Mouse
 	- R.A.T.9 Gaming Mouse
 	- R.A.T.7 Gaming Mouse
 	- M.M.O.7 Gaming Mouse
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
