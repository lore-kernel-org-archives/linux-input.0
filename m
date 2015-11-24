From: =?UTF-8?q?Adrien=20Verg=C3=A9?= <adrienverge@gmail.com>
Subject: [PATCH v3 2/2] USB: quirks: Apply ALWAYS_POLL to all ELAN devices
Date: Tue, 24 Nov 2015 14:49:08 +0100
Message-ID: <1448372948-8861-3-git-send-email-adrienverge@gmail.com>
References: <1448165164-11398-1-git-send-email-adrienverge@gmail.com>
 <1448372948-8861-1-git-send-email-adrienverge@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448372948-8861-1-git-send-email-adrienverge@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Logan Gunthorpe <logang@deltatee.com>, Hans de Goede <hdegoede@redhat.com>, Vincent Palatin <vpalatin@chromium.org>, =?UTF-8?q?Adrien=20Verg=C3=A9?= <adrienverge@gmail.com>, Macpaul Lin <macpaul@gmail.com>, Adel Gadllah <adel.gadllah@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

All ELAN hid devices seem to require the ALWAYS_POLL quirk. Let's use
this quirk for all devices from this vendor, rather than maintaining a
list of all its known product IDs.

To achieve that, this patch introduces a new hid_vendor_blacklist[] tha=
t
is checked when the product ID is not found in hid_product_blacklist[].

Tested-by: Adrien Verg=C3=A9 <adrienverge@gmail.com>
Signed-off-by: Adrien Verg=C3=A9 <adrienverge@gmail.com>
---
 drivers/hid/hid-ids.h           |  5 -----
 drivers/hid/usbhid/hid-quirks.c | 43 +++++++++++++++++++++++++++------=
--------
 2 files changed, 29 insertions(+), 19 deletions(-)

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
index 94bb137..9550497 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -21,15 +21,29 @@
=20
 #include "../hid-ids.h"
=20
+struct hid_blacklist {
+	__u16 idVendor;
+	__u16 idProduct;
+	__u32 quirks;
+};
+
+/*
+ * Alphabetically sorted blacklist for vendor-global quirks. If a devi=
ce matches
+ * both this blacklist and the product one (below), the more specific =
one
+ * (product ID) prevails.
+ */
+
+static const struct hid_blacklist hid_vendor_blacklist[] =3D {
+	{ USB_VENDOR_ID_ELAN, 0, HID_QUIRK_ALWAYS_POLL },
+
+	{ 0, 0, 0 }
+};
+
 /*
  * Alphabetically sorted blacklist by quirk type.
  */
=20
-static const struct hid_blacklist {
-	__u16 idVendor;
-	__u16 idProduct;
-	__u32 quirks;
-} hid_blacklist[] =3D {
+static const struct hid_blacklist hid_product_blacklist[] =3D {
 	{ USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_GAMEPAD, HID_QUIRK_BAD=
PAD },
 	{ USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_PREDATOR, HID_QUIRK_BA=
DPAD },
 	{ USB_VENDOR_ID_ALPS, USB_DEVICE_ID_IBM_GAMEPAD, HID_QUIRK_BADPAD },
@@ -72,11 +86,6 @@ static const struct hid_blacklist {
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
 	{ USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_FORMOSA, USB_DEVICE_ID_FORMOSA_IR_RECEIVER, HID_QUIRK=
_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_FREESCALE, USB_DEVICE_ID_FREESCALE_MX28, HID_QUIRK_NO=
GET },
@@ -337,10 +346,16 @@ static const struct hid_blacklist *usbhid_exists_=
squirk(const u16 idVendor,
 	const struct hid_blacklist *bl_entry =3D NULL;
 	int n =3D 0;
=20
-	for (; hid_blacklist[n].idVendor; n++)
-		if (hid_blacklist[n].idVendor =3D=3D idVendor &&
-				hid_blacklist[n].idProduct =3D=3D idProduct)
-			bl_entry =3D &hid_blacklist[n];
+	for (; hid_product_blacklist[n].idVendor; n++)
+		if (hid_product_blacklist[n].idVendor =3D=3D idVendor &&
+				hid_product_blacklist[n].idProduct =3D=3D idProduct)
+			bl_entry =3D &hid_product_blacklist[n];
+
+	if (bl_entry =3D=3D NULL) {
+		for (n =3D 0; hid_vendor_blacklist[n].idVendor; n++)
+			if (hid_vendor_blacklist[n].idVendor =3D=3D idVendor)
+				bl_entry =3D &hid_vendor_blacklist[n];
+	}
=20
 	if (bl_entry !=3D NULL)
 		dbg_hid("Found squirk 0x%x for USB HID vendor 0x%hx prod 0x%hx\n",
--=20
2.4.3
