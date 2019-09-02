From: Sebastian Parschauer <s.parschauer@gmx.de>
Subject: [PATCH] HID: Add quirk for HP X500 PIXART OEM mouse
Date: Mon,  2 Sep 2019 12:39:30 +0200
Message-ID: <20190902103930.9004-1-s.parschauer@gmx.de>
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Sebastian Parschauer <s.parschauer@gmx.de>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The PixArt OEM mice are known for disconnecting every minute in
runlevel 1 or 3 if they are not always polled. So add quirk
ALWAYS_POLL for this one as well.

Ville Viinikka (viinikv) reported and tested the quirk.
Reference: https://github.com/sriemer/fix-linux-mouse issue 15

Signed-off-by: Sebastian Parschauer <s.parschauer@gmx.de>
CC: stable@vger.kernel.org # v4.16+
=2D--
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0a00be19f7a0..e4d51ce20a6a 100644
=2D-- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -568,6 +568,7 @@
 #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0B4A	0x0b4a
 #define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE		0x134a
 #define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_094A	0x094a
+#define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_0941	0x0941
 #define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_0641	0x0641

 #define USB_VENDOR_ID_HUION		0x256c
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 166f41f3173b..c50bcd967d99 100644
=2D-- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -92,6 +92,7 @@ static const struct hid_device_id hid_quirks[] =3D {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OP=
TICAL_MOUSE_0B4A), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTI=
CAL_MOUSE), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTI=
CAL_MOUSE_094A), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTI=
CAL_MOUSE_0941), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTI=
CAL_MOUSE_0641), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_IDEACOM, USB_DEVICE_ID_IDEACOM_IDC6680), =
HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_INNOMEDIA, USB_DEVICE_ID_INNEX_GENESIS_AT=
ARI), HID_QUIRK_MULTI_INPUT },
=2D-
2.16.4
