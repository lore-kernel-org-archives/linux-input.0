From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@gmail.com>
Subject: [PATCH 4/4] HID: lg4ff: Minor coding style fixes in lg4ff and hid-lg
Date: Mon, 24 Sep 2012 01:13:17 +0200
Message-ID: <4804940.l8EpFgnjXr@qosmio-x300>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:62512 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754591Ab2IWXNV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Sep 2012 19:13:21 -0400
Received: by wgbdr13 with SMTP id dr13so3149869wgb.1
        for <linux-input@vger.kernel.org>; Sun, 23 Sep 2012 16:13:20 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, simon@mungewell.org

=46ixes a couple of minor coding style issues.

Signed-off-by: Michal Mal=FD <madcatxster@gmail.com>
---
=46rom eaa8ca4efae69e2510fbdffcd758cd3b88daf8a2 Mon Sep 17 00:00:00 200=
1
=46rom: =3D?UTF-8?q?Michal=3D20Mal=3DC3=3DBD?=3D <madcatxster@gmail.com=
>
Date: Mon, 24 Sep 2012 00:18:24 +0200
Subject: [PATCH 4/4] Various minor coding style fixes.

---
 drivers/hid/hid-lg.c    | 6 +++---
 drivers/hid/hid-lg4ff.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index 760b30b..afc4de3 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -361,7 +361,7 @@ static int lg_probe(struct hid_device *hdev, const =
struct=20
hid_device_id *id)
 		return -ENOMEM;
 	}
 	drv_data->quirks =3D id->driver_data;
-=09
+
 	hid_set_drvdata(hdev, (void *)drv_data);
=20
 	if (drv_data->quirks & LG_NOGET)
@@ -383,7 +383,7 @@ static int lg_probe(struct hid_device *hdev, const =
struct=20
hid_device_id *id)
 	}
=20
 	/* Setup wireless link with Logitech Wii wheel */
-	if(hdev->product =3D=3D USB_DEVICE_ID_LOGITECH_WII_WHEEL) {
+	if (hdev->product =3D=3D USB_DEVICE_ID_LOGITECH_WII_WHEEL) {
 		unsigned char buf[] =3D { 0x00, 0xAF,  0x01, 0x00, 0x00, 0x00, 0x00,=
=20
0x00, 0x00 };
=20
 		ret =3D hdev->hid_output_raw_report(hdev, buf, sizeof(buf),=20
HID_FEATURE_REPORT);
@@ -479,7 +479,7 @@ static const struct hid_device_id lg_devices[] =3D =
{
 		.driver_data =3D LG_NOGET | LG_FF4 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,=20
USB_DEVICE_ID_LOGITECH_WII_WHEEL),
 		.driver_data =3D LG_FF4 },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,=20
USB_DEVICE_ID_LOGITECH_WINGMAN_FFG ),
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,=20
USB_DEVICE_ID_LOGITECH_WINGMAN_FFG),
 		.driver_data =3D LG_FF },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,=20
USB_DEVICE_ID_LOGITECH_RUMBLEPAD2),
 		.driver_data =3D LG_FF2 },
diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 7007a12..9f5b2c5 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -193,7 +193,7 @@ static int hid_lg4ff_play(struct input_dev *dev, vo=
id=20
*data, struct ff_effect *e
 	__s32 *value =3D report->field[0]->value;
 	int x;
=20
-#define CLAMP(x) if (x < 0) x =3D 0; if (x > 0xff) x =3D 0xff
+#define CLAMP(x) do { if (x < 0) x =3D 0; else if (x > 0xff) x =3D 0xf=
f; } while=20
(0)
=20
 	switch (effect->type) {
 	case FF_CONSTANT:
@@ -285,7 +285,7 @@ static void hid_lg4ff_set_range_dfp(struct hid_devi=
ce=20
*hid, __u16 range)
=20
 	/* Prepare "coarse" limit command */
 	value[0] =3D 0xf8;
-	value[1] =3D 0x00; 	/* Set later */
+	value[1] =3D 0x00;	/* Set later */
 	value[2] =3D 0x00;
 	value[3] =3D 0x00;
 	value[4] =3D 0x00;
--=20
1.7.12.1
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
