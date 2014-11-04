From: Ville Aakko <ville.aakko@gmail.com>
Subject: [PATCH 1/1] hid-saitek: Quirk for Saitek R.A.T.7 works with R.A.T.9 too
Date: Tue, 4 Nov 2014 20:49:18 +0200
Message-ID: <47D536B5-26CC-4088-B321-30DABDD06A02@gmail.com>
References: <CAEP-KKshiXPfDhHPE7uatU70wfiOM-xMbFS2+6VxBbFM-LMfjw@mail.gmail.com> <5458256A.5030404@braincalibration.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:54847 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbaKDStY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Nov 2014 13:49:24 -0500
Received: by mail-la0-f46.google.com with SMTP id hs14so1441265lab.19
        for <linux-input@vger.kernel.org>; Tue, 04 Nov 2014 10:49:22 -0800 (PST)
In-Reply-To: <5458256A.5030404@braincalibration.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Harald Brinkmann <hbrinkmann@braincalibration.de>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, trivial@kernel.org

=46rom: Ville Aakko <ville.aakko@gmail.com>

I have tested HID quirk for Saitek R.A.T.7 with my R.A.T. 9. It works f=
ine for me. Attached patch makes the necessary changes to use the quirk=
 on the R.A.T.9 too, and necessary Kconfig changes too.

I have stylized the Kconfig option name to include Mad Catz in the opti=
on name, as (at least some of) the devices are marketed under Mad Catz =
brand.

Signed-off-by: Ville Aakko <ville.aakko@gmail.com>
---
Hi, another try on sending the patch! (the patch follows in body, with =
intact whitespace I hope:)=20

No one else has tested this, but it seems quite trivial to me. (origina=
l commit 37c492c8f6a99870551fe2964b2dfce5d9e87375; " HID: quirk for Sai=
tek RAT7 and MMO7 mices' mode button =94).

As for the company name, Saitek is a subsidiary of Mad Catz (see http:/=
/en.wikipedia.org/wiki/Saitek). The mice are marketed under Mad Catz br=
and, but there may be historical reasons (unclear to me) why the module=
 is called hid-saitek, however.

Cheers!

diff -uprN linux-3.17.2/drivers/hid/Kconfig linux-3.17.2-rat9/drivers/h=
id/Kconfig
--- linux-3.17.2/drivers/hid/Kconfig	2014-10-30 18:43:25.000000000 +020=
0
+++ linux-3.17.2-rat9/drivers/hid/Kconfig	2014-11-04 20:23:58.165740493=
 +0200
@@ -618,7 +618,7 @@ config HID_ROCCAT
 	support for its special functionalities.

 config HID_SAITEK
-	tristate "Saitek non-fully HID-compliant devices"
+	tristate "Saitek (Mad Catz) non-fully HID-compliant devices"
 	depends on HID
 	---help---
 	Support for Saitek devices that are not fully compliant with the
@@ -626,6 +626,7 @@ config HID_SAITEK

 	Supported devices:
 	- PS1000 Dual Analog Pad
+	- R.A.T.9 Gaming Mouse
 	- R.A.T.7 Gaming Mouse
 	- M.M.O.7 Gaming Mouse

diff -uprN linux-3.17.2/drivers/hid/hid-core.c linux-3.17.2-rat9/driver=
s/hid/hid-core.c
--- linux-3.17.2/drivers/hid/hid-core.c	2014-10-30 18:43:25.000000000 +=
0200
+++ linux-3.17.2-rat9/drivers/hid/hid-core.c	2014-11-04 20:20:21.765611=
510 +0200
@@ -1904,6 +1904,7 @@ static const struct hid_device_id hid_ha
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_PS1000) }=
,
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_MMO7) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_RAT9) }=
,
 #endif
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMO=
TE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_WIRELES=
S_KBD_MOUSE) },
diff -uprN linux-3.17.2/drivers/hid/hid-ids.h linux-3.17.2-rat9/drivers=
/hid/hid-ids.h
--- linux-3.17.2/drivers/hid/hid-ids.h	2014-10-30 18:43:25.000000000 +0=
200
+++ linux-3.17.2-rat9/drivers/hid/hid-ids.h	2014-11-04 20:20:21.7656115=
10 +0200
@@ -613,6 +613,7 @@

 #define USB_VENDOR_ID_MADCATZ		0x0738
 #define USB_DEVICE_ID_MADCATZ_BEATPAD	0x4540
+#define USB_DEVICE_ID_MADCATZ_RAT9	0x1709

 #define USB_VENDOR_ID_MCC		0x09db
 #define USB_DEVICE_ID_MCC_PMD1024LS	0x0076
diff -uprN linux-3.17.2/drivers/hid/hid-saitek.c linux-3.17.2-rat9/driv=
ers/hid/hid-saitek.c
--- linux-3.17.2/drivers/hid/hid-saitek.c	2014-10-30 18:43:25.000000000=
 +0200
+++ linux-3.17.2-rat9/drivers/hid/hid-saitek.c	2014-11-04 20:27:10.9661=
64105 +0200
@@ -7,7 +7,7 @@
  *  (This module is based on "hid-ortek".)
  *  Copyright (c) 2012 Andreas H=FCbner
  *
- *  R.A.T.7, M.M.O.7 (USB gaming mice):
+ *  R.A.T.7, R.A.T.9, M.M.O.7 (USB gaming mice):
  *  Fixes the mode button which cycles through three constantly presse=
d
  *  buttons. All three press events are mapped to one button and the
  *  missing release event is generated immediately.
@@ -179,6 +179,8 @@ static const struct hid_device_id saitek
 		.driver_data =3D SAITEK_FIX_PS1000 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7),
 		.driver_data =3D SAITEK_RELEASE_MODE_RAT7 },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_RAT9),
+		.driver_data =3D SAITEK_RELEASE_MODE_RAT7 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_MMO7),
 		.driver_data =3D SAITEK_RELEASE_MODE_MMO7 },
 	{ }
---


Harald Brinkmann <hbrinkmann@braincalibration.de> kirjoitti 4.11.2014 k=
ello 3.01:

> On 11/02/2014 03:37 PM, Ville Aakko wrote:
>> p.s. I have never submitted patches, I apologize if I have done some=
thing in a=20
>> wrong way! Should I have added / updated the description in the comm=
ents?
>=20
> I think you should update linux/drivers/hid/Kconfig and add the R.A.T=
=2E9
> to the list of supported devices in the HID_SAITEK section.
>=20
> --=20
> Cheers,
> Harald

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
