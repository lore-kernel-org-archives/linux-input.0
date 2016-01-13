From: =?iso-8859-1?Q?Ren=E9_Rebe?= <rene@exactcode.com>
Subject: [PATCH] support for Microsoft Type Cover 4
Date: Wed, 13 Jan 2016 18:06:27 +0100
Message-ID: <C2BB3A59-C842-49A7-BA73-1FCC11A1817C@exactcode.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx.exactcode.de ([144.76.154.42]:44852 "EHLO mx.exactcode.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753835AbcAMRG0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2016 12:06:26 -0500
Received: from ip5b403229.dynamic.kabel-deutschland.de ([91.64.50.41] helo=exactcode.com)
	by mx.exactcode.de with esmtp (Exim 4.82)
	(envelope-from <rene@exactcode.com>)
	id 1aJOsN-0004q9-IA
	for linux-input@vger.kernel.org; Wed, 13 Jan 2016 17:06:27 +0000
Received: from retina ([192.168.2.174])
	by exactcode.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.54)
	id 1aJOsg-0004WD-4s
	for linux-input@vger.kernel.org; Wed, 13 Jan 2016 17:06:46 +0000
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi there,

add USB product id for MS Type Cover 4, too.

Signed-off-by: Ren=E9 Rebe <rene@exactcode.com>

--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -727,6 +727,7 @@ static void hid_scan_collection(struct hid_parser *=
parser, unsigned type)
	    (hid->product =3D=3D USB_DEVICE_ID_MS_TYPE_COVER_PRO_3 ||
	     hid->product =3D=3D USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP ||
	     hid->product =3D=3D USB_DEVICE_ID_MS_TYPE_COVER_3 ||
+	     hid->product =3D=3D USB_DEVICE_ID_MS_TYPE_COVER_PRO_4 ||
	     hid->product =3D=3D USB_DEVICE_ID_MS_POWER_COVER) &&
	    hid->group =3D=3D HID_GROUP_MULTITOUCH)
		hid->group =3D HID_GROUP_GENERIC;
@@ -1930,6 +1931,7 @@ static const struct hid_device_id hid_have_specia=
l_driver[] =3D {
	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_=
PRO_3) },
	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_=
PRO_3_JP) },
	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_=
3) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER=
_PRO_4) },
	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER=
) },
	{ HID_USB_DEVICE(USB_VENDOR_ID_MONTEREY, USB_DEVICE_ID_GENIUS_KB29E) }=
,
	{ HID_USB_DEVICE(USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL=
) },
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -681,6 +681,7 @@
#define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3    0x07dc
#define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP 0x07dd
#define USB_DEVICE_ID_MS_TYPE_COVER_3    0x07de
+#define USB_DEVICE_ID_MS_TYPE_COVER_PRO_4    0x07e8
#define USB_DEVICE_ID_MS_POWER_COVER     0x07da

#define USB_VENDOR_ID_MOJO		0x8282
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -282,6 +282,8 @@ static const struct hid_device_id ms_devices[] =3D =
{
		.driver_data =3D MS_HIDINPUT },
	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_=
3),
		.driver_data =3D MS_HIDINPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER=
_PRO_4),
+		.driver_data =3D MS_HIDINPUT },
	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER=
),
		.driver_data =3D MS_HIDINPUT },

--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -93,6 +93,7 @@ static const struct hid_blacklist {
	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3, HID_QUIR=
K_NO_INIT_REPORTS },
	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP, HID_Q=
UIRK_NO_INIT_REPORTS },
	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3, HID_QUIRK_NO=
_INIT_REPORTS },
+	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4, HID_QUI=
RK_NO_INIT_REPORTS },
	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER, HID_QUIRK_NO_=
INIT_REPORTS },
	{ USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL, HID_QUIRK_NO_=
INIT_REPORTS },
	{ USB_VENDOR_ID_NEXIO, USB_DEVICE_ID_NEXIO_MULTITOUCH_PTI0750, HID_QUI=
RK_NO_INIT_REPORTS },

--=20
ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
http://exactcode.com | http://exactscan.com | http://ocrkit.com | http:=
//t2-project.org | http://rene.rebe.de

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
