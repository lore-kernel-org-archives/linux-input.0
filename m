From: Mazin Rezk <mnrzk@protonmail.com>
Subject: [PATCH v6 2/2] HID: logitech: Support WirelessDeviceStatus connect events
Date: Mon, 14 Oct 2019 18:36:16 +0000
Message-ID: <_1Ewv9AvBhbWTNcFOkmvCyjVph73eQIz23Plyv5ffgaWWHnmPBTbSIJhs47AnYatJsmDWu4JlMjcsKE8Cf31lvmwQipYEu47YglNfroyJtM=@protonmail.com>
Reply-To: Mazin Rezk <mnrzk@protonmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "jikos@kernel.org" <jikos@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>, "mnrzk@protonmail.com" <mnrzk@protonmail.com>
List-Id: linux-input@vger.kernel.org

This patch allows WirelessDeviceStatus (0x1d4b) events to be detected as
connection events in the hid-logitech-hidpp module.

Devices with HIDPP_QUIRK_WIRELESS_DEVICE_STATUS use WirelessDeviceStatus
instead of traditional connect events. Since all Bluetooth LE devices seem
to act this way, HIDPP_QUIRK_CLASS_BLUETOOTH_LE aliases this quirk.

Signed-off-by: Mazin Rezk <mnrzk@protonmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 42 ++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hi=
dpp.c
index 997b1056850a..9b3df57ca857 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -60,6 +60,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_QUIRK_CLASS_K750=09=09=09BIT(4)

 /* bits 2..15 are reserved for classes */
+#define HIDPP_QUIRK_WIRELESS_DEVICE_STATUS=09BIT(19)
 #define HIDPP_QUIRK_MISSING_SHORT_REPORTS=09BIT(20)
 /* #define HIDPP_QUIRK_CONNECT_EVENTS=09=09BIT(21) disabled */
 #define HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS=09BIT(22)
@@ -82,7 +83,8 @@ MODULE_PARM_DESC(disable_tap_to_click,
 =09=09=09=09=09 HIDPP_QUIRK_HI_RES_SCROLL_X2120 | \
 =09=09=09=09=09 HIDPP_QUIRK_HI_RES_SCROLL_X2121)

-#define HIDPP_QUIRK_CLASS_BLUETOOTH_LE=09HIDPP_QUIRK_MISSING_SHORT_REPORTS
+#define HIDPP_QUIRK_CLASS_BLUETOOTH_LE=09(HIDPP_QUIRK_MISSING_SHORT_REPORT=
S | \
+=09=09=09=09=09 HIDPP_QUIRK_WIRELESS_DEVICE_STATUS)

 #define HIDPP_QUIRK_DELAYED_INIT=09=09HIDPP_QUIRK_NO_HIDINPUT

@@ -189,6 +191,8 @@ struct hidpp_device {

 =09struct hidpp_battery battery;
 =09struct hidpp_scroll_counter vertical_wheel_counter;
+
+=09u8 wireless_feature_index;
 };

 /* HID++ 1.0 error codes */
@@ -402,10 +406,14 @@ static inline bool hidpp_match_error(struct hidpp_rep=
ort *question,
 =09    (answer->fap.params[0] =3D=3D question->fap.funcindex_clientid);
 }

-static inline bool hidpp_report_is_connect_event(struct hidpp_report *repo=
rt)
+static inline bool hidpp_report_is_connect_event(struct hidpp_device *hidp=
p,
+=09=09=09=09=09=09 struct hidpp_report *report)
 {
-=09return (report->report_id =3D=3D REPORT_ID_HIDPP_SHORT) &&
-=09=09(report->rap.sub_id =3D=3D 0x41);
+=09return ((hidpp->quirks & HIDPP_QUIRK_WIRELESS_DEVICE_STATUS) &&
+=09=09(report->fap.feature_index =3D=3D hidpp->wireless_feature_index)) ||
+=09      (((report->report_id =3D=3D REPORT_ID_HIDPP_SHORT) ||
+=09=09(hidpp->quirks & HIDPP_QUIRK_MISSING_SHORT_REPORTS)) &&
+=09=09(report->rap.sub_id =3D=3D 0x41));
 }

 /**
@@ -1282,6 +1290,24 @@ static int hidpp_battery_get_property(struct power_s=
upply *psy,
 =09return ret;
 }

+/* -----------------------------------------------------------------------=
--- */
+/* 0x1d4b: Wireless device status                                         =
    */
+/* -----------------------------------------------------------------------=
--- */
+#define HIDPP_PAGE_WIRELESS_DEVICE_STATUS=09=09=090x1d4b
+
+static int hidpp_set_wireless_feature_index(struct hidpp_device *hidpp)
+{
+=09u8 feature_type;
+=09int ret;
+
+=09ret =3D hidpp_root_get_feature(hidpp,
+=09=09=09=09     HIDPP_PAGE_WIRELESS_DEVICE_STATUS,
+=09=09=09=09     &hidpp->wireless_feature_index,
+=09=09=09=09     &feature_type);
+
+=09return ret;
+}
+
 /* -----------------------------------------------------------------------=
--- */
 /* 0x2120: Hi-resolution scrolling                                        =
    */
 /* -----------------------------------------------------------------------=
--- */
@@ -3077,7 +3103,7 @@ static int hidpp_raw_hidpp_event(struct hidpp_device =
*hidpp, u8 *data,
 =09=09}
 =09}

-=09if (unlikely(hidpp_report_is_connect_event(report))) {
+=09if (unlikely(hidpp_report_is_connect_event(hidpp, report))) {
 =09=09atomic_set(&hidpp->connected,
 =09=09=09=09!(report->rap.params[0] & (1 << 6)));
 =09=09if (schedule_work(&hidpp->work) =3D=3D 0)
@@ -3624,6 +3650,12 @@ static int hidpp_probe(struct hid_device *hdev, cons=
t struct hid_device_id *id)
 =09=09hidpp_overwrite_name(hdev);
 =09}

+=09if (connected && (hidpp->quirks & HIDPP_QUIRK_WIRELESS_DEVICE_STATUS)) =
{
+=09=09ret =3D hidpp_set_wireless_feature_index(hidpp);
+=09=09if (ret)
+=09=09=09goto hid_hw_init_fail;
+=09}
+
 =09if (connected && (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)) {
 =09=09ret =3D wtp_get_config(hidpp);
 =09=09if (ret)
--
2.23.0
