From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: [RFC v2 09/10] hid-mulitouch: added support for the 'Sensing Win7-TwoFinger'
Date: Wed,  5 Jan 2011 18:27:47 +0100
Message-ID: <1294248468-19979-10-git-send-email-benjamin.tissoires@enac.fr>
References: <1294248468-19979-1-git-send-email-benjamin.tissoires@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:39303 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983Ab1AER2M (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Jan 2011 12:28:12 -0500
In-Reply-To: <1294248468-19979-1-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephane Chatty <chatty@enac.fr>, Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.orglinux
Cc: Benjamin Tissoires <benjamin.tissoires@enac.fr>

Added support for the 'Sensing Win7-TwoFinger' panel by GeneralTouch fo=
und on some tablets.

Because of conflicting VID/PID, this conflicts with previous support fo=
r some single-touch panels by GeneralTouch

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Signed-off-by: St=C3=A9phane Chatty <chatty@enac.fr>
---
 drivers/hid/hid-core.c       |    2 +-
 drivers/hid/hid-ids.h        |    1 +
 drivers/hid/hid-multitouch.c |    5 +++++
 3 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 1dcb4b0..addaaf5 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1310,6 +1310,7 @@ static const struct hid_device_id hid_blacklist[]=
 =3D {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_EZKEY, USB_DEVICE_ID_BTC_8193) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMERON, USB_DEVICE_ID_GAMERON_DUAL_PS=
X_ADAPTOR) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMERON, USB_DEVICE_ID_GAMERON_DUAL_PC=
S_ADAPTOR) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH, USB_DEVICE_ID_GENERAL_T=
OUCH_WIN7_TWOFINGERS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GREENASIA, 0x0003) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GREENASIA, 0x0012) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID_GYRATION_REMOT=
E) },
@@ -1613,7 +1614,6 @@ static const struct hid_device_id hid_ignore_list=
[] =3D {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSEN=
TIAL_REALITY_P5) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC5UH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC4UM) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH, 0x0001) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH, 0x0002) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH, 0x0003) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH, 0x0004) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index d8b0b3f..5cdbdb4 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -227,6 +227,7 @@
 #define USB_DEVICE_ID_GAMERON_DUAL_PCS_ADAPTOR	0x0002
=20
 #define USB_VENDOR_ID_GENERAL_TOUCH	0x0dfc
+#define USB_DEVICE_ID_GENERAL_TOUCH_WIN7_TWOFINGERS 0x0001
=20
 #define USB_VENDOR_ID_GLAB		0x06c2
 #define USB_DEVICE_ID_4_PHIDGETSERVO_30	0x0038
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.=
c
index f5fa2c6..deb996d 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -439,6 +439,11 @@ static const struct hid_device_id mt_devices[] =3D=
 {
 		HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
 			USB_DEVICE_ID_CANDO_MULTI_TOUCH_11_6) },
=20
+	/* GeneralTouch panel */
+	{ .driver_data =3D MT_CLS_DUAL2,
+		HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
+			USB_DEVICE_ID_GENERAL_TOUCH_WIN7_TWOFINGERS) },
+
 	/* Cypress panel */
 	{ .driver_data =3D MT_CLS_CYPRESS,
 		HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS,
--=20
1.7.3.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
