From: Mazin Rezk <mnrzk@protonmail.com>
Subject: [PATCH v4 2/4] HID: logitech: Support HID++ devices without short reports
Date: Fri, 11 Oct 2019 00:57:15 +0000
Message-ID: <qPLpNssAeDjlNqTurULLEjShNNHh8DtKSdK-hP2cuq217O3Pc6ZodDDwqqOk8QERJM-jbTqs4Q_iPOcdXCQta_mYX9vgmDK0tDmWmCFRrHo=@protonmail.com>
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

> This patch allows the hid-logitech-hidpp module to support devices that d=
o
> not have support for Short HID++ reports. So far, it seems that Bluetooth
> HID++ 2.0 devices are missing short reports.

> This has been tested and confirmed with the MX Master and MX Master 2S an=
d
> is therefore likely the case with the other Bluetooth devices.

No changes have been made to this patch in v4.

Signed-off-by: Mazin Rezk <mnrzk@protonmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 37 ++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hi=
dpp.c
index 85fd0c17cc2f..a0efa8a43213 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -71,6 +71,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_QUIRK_HIDPP_WHEELS=09=09BIT(29)
 #define HIDPP_QUIRK_HIDPP_EXTRA_MOUSE_BTNS=09BIT(30)
 #define HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS=09BIT(31)
+#define HIDPP_QUIRK_CLASS_BLUETOOTH=09=09BIT(5)

 /* These are just aliases for now */
 #define HIDPP_QUIRK_KBD_SCROLL_WHEEL HIDPP_QUIRK_HIDPP_WHEELS
@@ -81,6 +82,9 @@ MODULE_PARM_DESC(disable_tap_to_click,
 =09=09=09=09=09 HIDPP_QUIRK_HI_RES_SCROLL_X2120 | \
 =09=09=09=09=09 HIDPP_QUIRK_HI_RES_SCROLL_X2121)

+/* Just an alias for now, may possibly be a catch-all in the future */
+#define HIDPP_QUIRK_MISSING_SHORT_REPORTS=09HIDPP_QUIRK_CLASS_BLUETOOTH
+
 #define HIDPP_QUIRK_DELAYED_INIT=09=09HIDPP_QUIRK_NO_HIDINPUT

 #define HIDPP_CAPABILITY_HIDPP10_BATTERY=09BIT(0)
@@ -340,6 +344,12 @@ static int hidpp_send_rap_command_sync(struct hidpp_de=
vice *hidpp_dev,
 =09struct hidpp_report *message;
 =09int ret, max_count;

+=09/* Force long reports on devices that do not support short reports */
+=09if (hidpp_dev->quirks & HIDPP_QUIRK_MISSING_SHORT_REPORTS &&
+=09    report_id =3D=3D REPORT_ID_HIDPP_SHORT)
+=09=09report_id =3D REPORT_ID_HIDPP_LONG;
+
+
 =09switch (report_id) {
 =09case REPORT_ID_HIDPP_SHORT:
 =09=09max_count =3D HIDPP_REPORT_SHORT_LENGTH - 4;
@@ -3482,6 +3492,12 @@ static bool hidpp_validate_report(struct hid_device =
*hdev, int id,

 static bool hidpp_validate_device(struct hid_device *hdev)
 {
+=09struct hidpp_device *hidpp =3D hid_get_drvdata(hdev);
+=09/* Skip the short report check if the device does not support it */
+=09if (hidpp->quirks & HIDPP_QUIRK_MISSING_SHORT_REPORTS)
+=09=09return hidpp_validate_report(hdev, REPORT_ID_HIDPP_LONG,
+=09=09=09=09=09     HIDPP_REPORT_LONG_LENGTH, false);
+
 =09return hidpp_validate_report(hdev, REPORT_ID_HIDPP_SHORT,
 =09=09=09=09     HIDPP_REPORT_SHORT_LENGTH, false) &&
 =09       hidpp_validate_report(hdev, REPORT_ID_HIDPP_LONG,
@@ -3775,22 +3791,29 @@ static const struct hid_device_id hidpp_devices[] =
=3D {
 =09  .driver_data =3D HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS },
 =09{ /* MX Anywhere 2 mouse over Bluetooth */
 =09  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb013),
-=09  .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+=09  .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 |
+=09=09=09 HIDPP_QUIRK_CLASS_BLUETOOTH },
 =09{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb018),
-=09  .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+=09  .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 |
+=09=09=09 HIDPP_QUIRK_CLASS_BLUETOOTH },
 =09{ /* MX Anywhere 2S mouse over Bluetooth */
 =09  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01a),
-=09  .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+=09  .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 |
+=09=09=09 HIDPP_QUIRK_CLASS_BLUETOOTH },
 =09{ /* MX Master mouse over Bluetooth */
 =09  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb012),
-=09  .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+=09  .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 |
+=09=09=09 HIDPP_QUIRK_CLASS_BLUETOOTH },
 =09{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb017),
-=09  .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+=09  .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 |
+=09=09=09 HIDPP_QUIRK_CLASS_BLUETOOTH },
 =09{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01e),
-=09  .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+=09  .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 |
+=09=09=09 HIDPP_QUIRK_CLASS_BLUETOOTH },
 =09{ /* MX Master 2S mouse over Bluetooth */
 =09  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb019),
-=09  .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+=09  .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 |
+=09=09=09 HIDPP_QUIRK_CLASS_BLUETOOTH },
 =09{}
 };

--
2.23.0
