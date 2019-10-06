From: Mazin Rezk <mnrzk@protonmail.com>
Subject: [PATCH v3 4/4] HID: logitech: Support WirelessDeviceStatus connect events
Date: Sun, 06 Oct 2019 01:05:08 +0000
Message-ID: <Zn73qAH6QAj1V0kjJQsq_8VUdDBHRfbRuKJLA-kH_jm63uZw_tbLjaG5QJOI7VAfy6GB74L6bnb7Faiwy49JSjIEfV6f-_KwWYbjQtog8mU=@protonmail.com>
Reply-To: Mazin Rezk <mnrzk@protonmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "jikos@kernel.org" <jikos@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lains@archlinux.org" <lains@archlinux.org>, "mnrzk@protonmail.com" <mnrzk@protonmail.com>
List-Id: linux-input@vger.kernel.org

This patch makes WirelessDeviceStatus (0x1d4b) events get detected as
connection events on devices with HIDPP_QUIRK_WIRELESS_DEVICE_STATUS.

This quirk is currently an alias for HIDPP_QUIRK_CLASS_BLUETOOTH since
the added Bluetooth devices do not support regular connect events.

Signed-off-by: Mazin Rezk <mnrzk@protonmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hi=
dpp.c
index 64ac94c581aa..4a6e41c2c9fc 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -84,6 +84,7 @@ MODULE_PARM_DESC(disable_tap_to_click,

 /* Just an alias for now, may possibly be a catch-all in the future */
 #define HIDPP_QUIRK_MISSING_SHORT_REPORTS=09HIDPP_QUIRK_CLASS_BLUETOOTH
+#define HIDPP_QUIRK_WIRELESS_DEVICE_STATUS=09HIDPP_QUIRK_CLASS_BLUETOOTH

 #define HIDPP_QUIRK_DELAYED_INIT=09=09HIDPP_QUIRK_NO_HIDINPUT

@@ -406,9 +407,22 @@ static inline bool hidpp_match_error(struct hidpp_repo=
rt *question,
 =09    (answer->fap.params[0] =3D=3D question->fap.funcindex_clientid);
 }

-static inline bool hidpp_report_is_connect_event(struct hidpp_report *repo=
rt)
+#define HIDPP_PAGE_WIRELESS_DEVICE_STATUS=09=090x1d4b
+
+static inline bool hidpp_report_is_connect_event(struct hidpp_device *hidp=
p,
+=09=09=09=09=09=09 struct hidpp_report *report)
 {
-=09return (report->report_id =3D=3D REPORT_ID_HIDPP_SHORT) &&
+=09if (hidpp->quirks & HIDPP_QUIRK_WIRELESS_DEVICE_STATUS) {
+=09=09/* If feature is invalid, skip array check */
+=09=09if (report->fap.feature_index > hidpp->feature_count)
+=09=09=09return false;
+
+=09=09return (hidpp->features[report->fap.feature_index] =3D=3D
+=09=09=09 HIDPP_PAGE_WIRELESS_DEVICE_STATUS);
+=09}
+
+=09return ((report->report_id =3D=3D REPORT_ID_HIDPP_SHORT) ||
+=09=09(hidpp->quirks & HIDPP_QUIRK_MISSING_SHORT_REPORTS)) &&
 =09=09(report->rap.sub_id =3D=3D 0x41);
 }

@@ -3159,7 +3173,7 @@ static int hidpp_raw_hidpp_event(struct hidpp_device =
*hidpp, u8 *data,
 =09=09}
 =09}

-=09if (unlikely(hidpp_report_is_connect_event(report))) {
+=09if (unlikely(hidpp_report_is_connect_event(hidpp, report))) {
 =09=09atomic_set(&hidpp->connected,
 =09=09=09=09!(report->rap.params[0] & (1 << 6)));
 =09=09if (schedule_work(&hidpp->work) =3D=3D 0)
--
2.23.0
