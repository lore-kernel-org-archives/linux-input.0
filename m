From: Mazin Rezk <mnrzk@protonmail.com>
Subject: [PATCH v4 1/4] HID: logitech: Add MX Mice over Bluetooth
Date: Fri, 11 Oct 2019 00:57:01 +0000
Message-ID: <uBbIS3nFJ1jdYNLHcqjW5wxQAwmZv0kmYEoeoPrxNhfzi6cHwmCOY-ewdqe7S1hNEj-p4Hd9D0_Y3PymUTdh_6WFXuMmIYUkV2xaKCPMYz0=@protonmail.com>
Reply-To: Mazin Rezk <mnrzk@protonmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "jikos@kernel.org" <jikos@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>, "mnrzk@protonmail.com" <mnrzk@protonmail.com>
List-Id: linux-input@vger.kernel.org

On Saturday, October 5, 2019 9:04 PM, Mazin Rezk <mnrzk@protonmail.com> wro=
te:

> This patch adds support for several MX mice over Bluetooth. The device ID=
s
> have been copied from the libratbag device database and their features
> have been based on their DJ device counterparts.

No changes have been made to this patch in v4. However, it should be noted
that the only device that has been thoroughly tested in this patch is the
MX Master (b01e). Further testing for the other devices may be required.

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
