From: Mazin Rezk <mnrzk@protonmail.com>
Subject: [PATCH v3 1/4] HID: logitech: Add MX Mice over Bluetooth
Date: Sun, 06 Oct 2019 01:04:01 +0000
Message-ID: <l7xYjnA9EGfZe03FsrFhnH2aMq8qS8plWhHVvOtY_l4ShZ1NV6HA6hn9aI-jAzbLYUGFCIQCIKkx9z42Uoj4-AZDwBfRcAecYIn-0ZA5upE=@protonmail.com>
Reply-To: Mazin Rezk <mnrzk@protonmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "jikos@kernel.org" <jikos@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lains@archlinux.org" <lains@archlinux.org>, "mnrzk@protonmail.com" <mnrzk@protonmail.com>
List-Id: linux-input@vger.kernel.org

This patch adds support for several MX mice over Bluetooth. The device IDs
have been copied from the libratbag device database and their features
have been based on their DJ device counterparts.

Signed-off-by: Mazin Rezk <mnrzk@protonmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hi=
dpp.c
index 0179f7ed77e5..85fd0c17cc2f 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3773,6 +3773,24 @@ static const struct hid_device_id hidpp_devices[] =
=3D {
 =09{ /* MX5500 keyboard over Bluetooth */
 =09  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb30b),
 =09  .driver_data =3D HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS },
+=09{ /* MX Anywhere 2 mouse over Bluetooth */
+=09  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb013),
+=09  .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+=09{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb018),
+=09  .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+=09{ /* MX Anywhere 2S mouse over Bluetooth */
+=09  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01a),
+=09  .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+=09{ /* MX Master mouse over Bluetooth */
+=09  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb012),
+=09  .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+=09{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb017),
+=09  .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+=09{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01e),
+=09  .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+=09{ /* MX Master 2S mouse over Bluetooth */
+=09  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb019),
+=09  .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
 =09{}
 };

--
2.23.0
