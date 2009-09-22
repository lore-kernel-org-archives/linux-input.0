From: Lamarque Vieira Souza <lamarque@gmail.com>
Subject: Re: Problem with Acer Bluetooth Optical Rechargeable Mouse
Date: Tue, 22 Sep 2009 13:19:44 -0300
Message-ID: <200909221319.45013.lamarque@gmail.com>
References: <200908062247.29254.lamarque@gmail.com> <200909152144.37847.lamarque@gmail.com> <alpine.LSU.2.00.0909221733290.10090@wotan.suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hkPuK7VpetiAEVk"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f199.google.com ([209.85.210.199]:35044 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698AbZIVQTr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Sep 2009 12:19:47 -0400
Received: by yxe37 with SMTP id 37so4402062yxe.33
        for <linux-input@vger.kernel.org>; Tue, 22 Sep 2009 09:19:51 -0700 (PDT)
In-Reply-To: <alpine.LSU.2.00.0909221733290.10090@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Andrew Morton <akpm@linux-foundation.org>

--Boundary-00=_hkPuK7VpetiAEVk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Em Ter=E7a-feira 22 Setembro 2009, Jiri Kosina escreveu:
> Hi,
>=20
> could you please resend your patch? It has either been lost somewhere on
> the way, or in the dark depths of my inbox, so I am not really sure which
> one you are referring to, sorry.

Marks Acer Bluetooth Optical Rechargeable Mouse from Ferrari 4005 notebook =
to=20
be ignored by hid core. This change makes hid core to use input session=20
instead of hid session with that mouse. With hid session the mouse cursor=20
moves too laggy, using input session corrects this problem.

Signed-off-by: Lamarque V. Souza <lamarque@gmail.com>

diff -Nru --show-c-function a/drivers/hid/hid-core.c b/drivers/hid/hid-core=
=2Ec
=2D-- a/drivers/hid/hid-core.c	2009-08-13 20:45:11.000000000 -0300
+++ b/drivers/hid/hid-core.c	2009-08-13 22:25:54.504677594 -0300
@@ -1636,6 +1636,7 @@ static const struct hid_device_id hid_ig
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_1_PHIDGETSERVO_20=
)=20
},
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_8_8_4_IF_KIT) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_YEALINK, USB_DEVICE_ID_YEALINK_P1K_P4K_B2K=
)=20
},
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_KYE, 0x0058) },
 	{ }
 };

--Boundary-00=_hkPuK7VpetiAEVk
Content-Type: text/x-patch;
  charset="utf-8";
  name="bluetooth-fix-for-acer-bluetooth-optical-rechargeable-mouse.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bluetooth-fix-for-acer-bluetooth-optical-rechargeable-mouse.patch"

diff -Nru --show-c-function a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
--- a/drivers/hid/hid-core.c	2009-08-13 20:45:11.000000000 -0300
+++ b/drivers/hid/hid-core.c	2009-08-13 22:25:54.504677594 -0300
@@ -1636,6 +1636,7 @@ static const struct hid_device_id hid_ig
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_1_PHIDGETSERVO_20) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_8_8_4_IF_KIT) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_YEALINK, USB_DEVICE_ID_YEALINK_P1K_P4K_B2K) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_KYE, 0x0058) },
 	{ }
 };
 

--Boundary-00=_hkPuK7VpetiAEVk--
