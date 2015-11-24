From: =?UTF-8?q?Adrien=20Verg=C3=A9?= <adrienverge@gmail.com>
Subject: [PATCH v4 2/2] USB: quirks: Apply ALWAYS_POLL to all ELAN devices
Date: Tue, 24 Nov 2015 16:02:05 +0100
Message-ID: <1448377325-4725-3-git-send-email-adrienverge@gmail.com>
References: <1448165164-11398-1-git-send-email-adrienverge@gmail.com>
 <1448377325-4725-1-git-send-email-adrienverge@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36642 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254AbbKXPCn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Nov 2015 10:02:43 -0500
In-Reply-To: <1448377325-4725-1-git-send-email-adrienverge@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Oliver Neukum <oneukum@suse.com>, Jiri Kosina <jikos@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Logan Gunthorpe <logang@deltatee.com>, Hans de Goede <hdegoede@redhat.com>, Vincent Palatin <vpalatin@chromium.org>, =?UTF-8?q?Adrien=20Verg=C3=A9?= <adrienverge@gmail.com>, Macpaul Lin <macpaul@gmail.com>, Adel Gadllah <adel.gadllah@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

All ELAN hid devices seem to require the ALWAYS_POLL quirk. Let's use
this quirk for all devices from this vendor, rather than maintaining a
list of all its known product IDs.

Tested-by: Adrien Verg=C3=A9 <adrienverge@gmail.com>
Signed-off-by: Adrien Verg=C3=A9 <adrienverge@gmail.com>
---
 drivers/hid/hid-ids.h           | 5 -----
 drivers/hid/usbhid/hid-quirks.c | 9 +++------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index ac1feea..3c7e0c3 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -316,11 +316,6 @@
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_A001	0xa001
=20
 #define USB_VENDOR_ID_ELAN		0x04f3
-#define USB_DEVICE_ID_ELAN_TOUCHSCREEN	0x0089
-#define USB_DEVICE_ID_ELAN_TOUCHSCREEN_009B	0x009b
-#define USB_DEVICE_ID_ELAN_TOUCHSCREEN_0103	0x0103
-#define USB_DEVICE_ID_ELAN_TOUCHSCREEN_010c	0x010c
-#define USB_DEVICE_ID_ELAN_TOUCHSCREEN_016F	0x016f
=20
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-q=
uirks.c
index 94bb137..b1af008 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -72,11 +72,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOU=
SE, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_WIIU, HID_QUIRK_=
MULTI_INPUT },
-	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN, HID_QUIRK_ALWAY=
S_POLL },
-	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_009B, HID_QUIRK_=
ALWAYS_POLL },
-	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_0103, HID_QUIRK_=
ALWAYS_POLL },
-	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_010c, HID_QUIRK_=
ALWAYS_POLL },
-	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_016F, HID_QUIRK_=
ALWAYS_POLL },
+	{ USB_VENDOR_ID_ELAN, HID_ANY_ID, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_FORMOSA, USB_DEVICE_ID_FORMOSA_IR_RECEIVER, HID_QUIRK=
_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_FREESCALE, USB_DEVICE_ID_FREESCALE_MX28, HID_QUIRK_NO=
GET },
@@ -339,7 +335,8 @@ static const struct hid_blacklist *usbhid_exists_sq=
uirk(const u16 idVendor,
=20
 	for (; hid_blacklist[n].idVendor; n++)
 		if (hid_blacklist[n].idVendor =3D=3D idVendor &&
-				hid_blacklist[n].idProduct =3D=3D idProduct)
+			(hid_blacklist[n].idProduct =3D=3D HID_ANY_ID ||
+				hid_blacklist[n].idProduct =3D=3D idProduct))
 			bl_entry =3D &hid_blacklist[n];
=20
 	if (bl_entry !=3D NULL)
--=20
2.4.3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
