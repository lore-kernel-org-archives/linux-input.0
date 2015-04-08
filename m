From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH v2 02/15] HID: hid-lg4ff: (Cleanup) Remove "hid_" prefix from some functions' names.
Date: Wed,  8 Apr 2015 22:56:40 +0200
Message-ID: <1428526613-24239-3-git-send-email-madcatxster@devoid-pointer.net>
References: <1428526613-24239-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from transparentnimenzy.cz ([31.31.77.140]:32993 "EHLO
	smtp.devoid-pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753278AbbDHU50 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Apr 2015 16:57:26 -0400
In-Reply-To: <1428526613-24239-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.or, elias.vds@gmail.com, simon@mungewell.org, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>

Remove "hid_" prefix from some functions' names. All internal functions
of hid-lg4ff should be prefixed with just "lg4ff_"

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/hid/hid-lg4ff.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 70e5ae6..9a0c0e5 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -68,8 +68,8 @@
 #define LG4FF_FFEX_REV_MAJ 0x21
 #define LG4FF_FFEX_REV_MIN 0x00
=20
-static void hid_lg4ff_set_range_dfp(struct hid_device *hid, u16 range)=
;
-static void hid_lg4ff_set_range_g25(struct hid_device *hid, u16 range)=
;
+static void lg4ff_set_range_dfp(struct hid_device *hid, u16 range);
+static void lg4ff_set_range_g25(struct hid_device *hid, u16 range);
=20
 struct lg4ff_device_entry {
 	u32 product_id;
@@ -134,10 +134,10 @@ struct lg4ff_alternate_mode {
 static const struct lg4ff_wheel lg4ff_devices[] =3D {
 	{USB_DEVICE_ID_LOGITECH_WHEEL,       lg4ff_wheel_effects, 40, 270, NU=
LL},
 	{USB_DEVICE_ID_LOGITECH_MOMO_WHEEL,  lg4ff_wheel_effects, 40, 270, NU=
LL},
-	{USB_DEVICE_ID_LOGITECH_DFP_WHEEL,   lg4ff_wheel_effects, 40, 900, hi=
d_lg4ff_set_range_dfp},
-	{USB_DEVICE_ID_LOGITECH_G25_WHEEL,   lg4ff_wheel_effects, 40, 900, hi=
d_lg4ff_set_range_g25},
-	{USB_DEVICE_ID_LOGITECH_DFGT_WHEEL,  lg4ff_wheel_effects, 40, 900, hi=
d_lg4ff_set_range_g25},
-	{USB_DEVICE_ID_LOGITECH_G27_WHEEL,   lg4ff_wheel_effects, 40, 900, hi=
d_lg4ff_set_range_g25},
+	{USB_DEVICE_ID_LOGITECH_DFP_WHEEL,   lg4ff_wheel_effects, 40, 900, lg=
4ff_set_range_dfp},
+	{USB_DEVICE_ID_LOGITECH_G25_WHEEL,   lg4ff_wheel_effects, 40, 900, lg=
4ff_set_range_g25},
+	{USB_DEVICE_ID_LOGITECH_DFGT_WHEEL,  lg4ff_wheel_effects, 40, 900, lg=
4ff_set_range_g25},
+	{USB_DEVICE_ID_LOGITECH_G27_WHEEL,   lg4ff_wheel_effects, 40, 900, lg=
4ff_set_range_g25},
 	{USB_DEVICE_ID_LOGITECH_MOMO_WHEEL2, lg4ff_wheel_effects, 40, 270, NU=
LL},
 	{USB_DEVICE_ID_LOGITECH_WII_WHEEL,   lg4ff_wheel_effects, 40, 270, NU=
LL}
 };
@@ -294,7 +294,7 @@ int lg4ff_adjust_input_event(struct hid_device *hid=
, struct hid_field *field,
 	}
 }
=20
-static int hid_lg4ff_play(struct input_dev *dev, void *data, struct ff=
_effect *effect)
+static int lg4ff_play(struct input_dev *dev, void *data, struct ff_eff=
ect *effect)
 {
 	struct hid_device *hid =3D input_get_drvdata(dev);
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
@@ -339,7 +339,7 @@ static int hid_lg4ff_play(struct input_dev *dev, vo=
id *data, struct ff_effect *e
=20
 /* Sends default autocentering command compatible with
  * all wheels except Formula Force EX */
-static void hid_lg4ff_set_autocenter_default(struct input_dev *dev, u1=
6 magnitude)
+static void lg4ff_set_autocenter_default(struct input_dev *dev, u16 ma=
gnitude)
 {
 	struct hid_device *hid =3D input_get_drvdata(dev);
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
@@ -416,7 +416,7 @@ static void hid_lg4ff_set_autocenter_default(struct=
 input_dev *dev, u16 magnitud
 }
=20
 /* Sends autocentering command compatible with Formula Force EX */
-static void hid_lg4ff_set_autocenter_ffex(struct input_dev *dev, u16 m=
agnitude)
+static void lg4ff_set_autocenter_ffex(struct input_dev *dev, u16 magni=
tude)
 {
 	struct hid_device *hid =3D input_get_drvdata(dev);
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
@@ -436,7 +436,7 @@ static void hid_lg4ff_set_autocenter_ffex(struct in=
put_dev *dev, u16 magnitude)
 }
=20
 /* Sends command to set range compatible with G25/G27/Driving Force GT=
 */
-static void hid_lg4ff_set_range_g25(struct hid_device *hid, u16 range)
+static void lg4ff_set_range_g25(struct hid_device *hid, u16 range)
 {
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
@@ -456,7 +456,7 @@ static void hid_lg4ff_set_range_g25(struct hid_devi=
ce *hid, u16 range)
 }
=20
 /* Sends commands to set range compatible with Driving Force Pro wheel=
 */
-static void hid_lg4ff_set_range_dfp(struct hid_device *hid, u16 range)
+static void lg4ff_set_range_dfp(struct hid_device *hid, u16 range)
 {
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
@@ -1043,7 +1043,7 @@ int lg4ff_init(struct hid_device *hid)
 	for (j =3D 0; lg4ff_devices[i].ff_effects[j] >=3D 0; j++)
 		set_bit(lg4ff_devices[i].ff_effects[j], dev->ffbit);
=20
-	error =3D input_ff_create_memless(dev, NULL, hid_lg4ff_play);
+	error =3D input_ff_create_memless(dev, NULL, lg4ff_play);
=20
 	if (error)
 		return error;
@@ -1081,9 +1081,9 @@ int lg4ff_init(struct hid_device *hid)
 		/* Formula Force EX expects different autocentering command */
 		if ((bcdDevice >> 8) =3D=3D LG4FF_FFEX_REV_MAJ &&
 		    (bcdDevice & 0xff) =3D=3D LG4FF_FFEX_REV_MIN)
-			dev->ff->set_autocenter =3D hid_lg4ff_set_autocenter_ffex;
+			dev->ff->set_autocenter =3D lg4ff_set_autocenter_ffex;
 		else
-			dev->ff->set_autocenter =3D hid_lg4ff_set_autocenter_default;
+			dev->ff->set_autocenter =3D lg4ff_set_autocenter_default;
=20
 		dev->ff->set_autocenter(dev, 0);
 	}
--=20
2.3.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
