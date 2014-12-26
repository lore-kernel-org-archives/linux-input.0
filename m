From: =?UTF-8?q?Giedrius=20Statkevi=C4=8Dius?=
	<giedrius.statkevicius@gmail.com>
Subject: [PATCH] hid: Add a new id 0x501a for Genius MousePen i608X
Date: Sat, 27 Dec 2014 00:28:30 +0200
Message-ID: <1419632910-12773-1-git-send-email-giedrius.statkevicius@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:47849 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbaLZWaJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Dec 2014 17:30:09 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, =?UTF-8?q?Giedrius=20Statkevi=C4=8Dius?= <giedrius.statkevicius@gmail.com>

New Genius MousePen i608X devices have a new id 0x501a instead of the
old 0x5011 so add a new #define with "_2" appended and change required
places.

The remaining two checkpatch warnings about line length
being over 80 characters are present in the original files too and this
patch was made in the same style (no line break).

Just adding a new id and changing the required places should make the
new device work without any issues according to the bug report in the
following url.

This patch was made according to and fixes:
https://bugzilla.kernel.org/show_bug.cgi?id=3D67111

Signed-off-by: Giedrius Statkevi=C4=8Dius <giedrius.statkevicius@gmail.=
com>
---
Only compile tested as I don't have this hardware to test it.

 drivers/hid/hid-core.c          | 1 +
 drivers/hid/hid-ids.h           | 1 +
 drivers/hid/hid-kye.c           | 4 ++++
 drivers/hid/usbhid/hid-quirks.c | 1 +
 4 files changed, 7 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index f2a4879..5f49a11 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1821,6 +1821,7 @@ static const struct hid_device_id hid_have_specia=
l_driver[] =3D {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_ERGO_525V) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_I405X) =
},
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X)=
 },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X_=
2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M610X) =
},
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LABTEC, USB_DEVICE_ID_LABTEC_WIRELESS_=
KEYBOARD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LCPOWER, USB_DEVICE_ID_LCPOWER_LC1000 =
) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index ac20ba0..a96bb03 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -531,6 +531,7 @@
 #define USB_DEVICE_ID_KYE_GPEN_560	0x5003
 #define USB_DEVICE_ID_KYE_EASYPEN_I405X	0x5010
 #define USB_DEVICE_ID_KYE_MOUSEPEN_I608X	0x5011
+#define USB_DEVICE_ID_KYE_MOUSEPEN_I608X_2	0x501a
 #define USB_DEVICE_ID_KYE_EASYPEN_M610X	0x5013
=20
 #define USB_VENDOR_ID_LABTEC		0x1020
diff --git a/drivers/hid/hid-kye.c b/drivers/hid/hid-kye.c
index b92bf01..158fcf5 100644
--- a/drivers/hid/hid-kye.c
+++ b/drivers/hid/hid-kye.c
@@ -323,6 +323,7 @@ static __u8 *kye_report_fixup(struct hid_device *hd=
ev, __u8 *rdesc,
 		}
 		break;
 	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X:
+	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X_2:
 		if (*rsize =3D=3D MOUSEPEN_I608X_RDESC_ORIG_SIZE) {
 			rdesc =3D mousepen_i608x_rdesc_fixed;
 			*rsize =3D sizeof(mousepen_i608x_rdesc_fixed);
@@ -415,6 +416,7 @@ static int kye_probe(struct hid_device *hdev, const=
 struct hid_device_id *id)
 	switch (id->product) {
 	case USB_DEVICE_ID_KYE_EASYPEN_I405X:
 	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X:
+	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X_2:
 	case USB_DEVICE_ID_KYE_EASYPEN_M610X:
 		ret =3D kye_tablet_enable(hdev);
 		if (ret) {
@@ -446,6 +448,8 @@ static const struct hid_device_id kye_devices[] =3D=
 {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
 				USB_DEVICE_ID_KYE_MOUSEPEN_I608X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
+				USB_DEVICE_ID_KYE_MOUSEPEN_I608X_2) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
 				USB_DEVICE_ID_KYE_EASYPEN_M610X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
 				USB_DEVICE_ID_GENIUS_GILA_GAMING_MOUSE) },
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-q=
uirks.c
index dc89be9..b27b3d3 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -124,6 +124,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_WIRELESS, HID_QUIRK_MU=
LTI_INPUT },
 	{ USB_VENDOR_ID_SIGMA_MICRO, USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD, HID_=
QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X, HID_QUIRK_MULT=
I_INPUT },
+	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X_2, HID_QUIRK_MU=
LTI_INPUT },
 	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M610X, HID_QUIRK_MULTI=
_INPUT },
 	{ USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_DUOSENSE, HID_QUIRK_NO_INI=
T_REPORTS },
 	{ USB_VENDOR_ID_SEMICO, USB_DEVICE_ID_SEMICO_USB_KEYKOARD, HID_QUIRK_=
NO_INIT_REPORTS },
--=20
2.2.1
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
