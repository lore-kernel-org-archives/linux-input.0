From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@gmail.com>
Subject: [PATCH 1/4] HID: hid-lg4ff: Minor code cleanup to improve readability
Date: Mon, 24 Sep 2012 01:09:30 +0200
Message-ID: <1821076.VxISZdqPyn@qosmio-x300>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:52093 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754626Ab2IWXJj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Sep 2012 19:09:39 -0400
Received: by wibhq12 with SMTP id hq12so1135591wib.1
        for <linux-input@vger.kernel.org>; Sun, 23 Sep 2012 16:09:37 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, simon@mungewell.org

This patch replaces all occurrences of "report->field[0]->value[n]" wit=
h just "value[n]" to get rid of the lengthy trains we have now.

Signed-off-by: Michal Mal=FD <madcatxster@gmail.com>
---
=46rom bad52be1762f00ed4dbe7c5a21cbfe9d9d0f4428 Mon Sep 17 00:00:00 200=
1
=46rom: =3D?UTF-8?q?Michal=3D20Mal=3DC3=3DBD?=3D <madcatxster@gmail.com=
>
Date: Wed, 27 Jun 2012 12:09:33 +0200
Subject: [PATCH 1/4] Replace "report->field[0]->value[n]" with "value[n=
]" for
 better code readability.

---
 drivers/hid/hid-lg4ff.c | 121 +++++++++++++++++++++++++---------------=
--------
 1 file changed, 64 insertions(+), 57 deletions(-)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index f3390ee..c40e957 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -134,6 +134,7 @@ static int hid_lg4ff_play(struct input_dev *dev, vo=
id *data, struct ff_effect *e
 	struct hid_device *hid =3D input_get_drvdata(dev);
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
+	__s32 *value =3D report->field[0]->value;
 	int x;
=20
 #define CLAMP(x) if (x < 0) x =3D 0; if (x > 0xff) x =3D 0xff
@@ -142,13 +143,13 @@ static int hid_lg4ff_play(struct input_dev *dev, =
void *data, struct ff_effect *e
 	case FF_CONSTANT:
 		x =3D effect->u.ramp.start_level + 0x80;	/* 0x80 is no force */
 		CLAMP(x);
-		report->field[0]->value[0] =3D 0x11;	/* Slot 1 */
-		report->field[0]->value[1] =3D 0x08;
-		report->field[0]->value[2] =3D x;
-		report->field[0]->value[3] =3D 0x80;
-		report->field[0]->value[4] =3D 0x00;
-		report->field[0]->value[5] =3D 0x00;
-		report->field[0]->value[6] =3D 0x00;
+		value[0] =3D 0x11;	/* Slot 1 */
+		value[1] =3D 0x08;
+		value[2] =3D x;
+		value[3] =3D 0x80;
+		value[4] =3D 0x00;
+		value[5] =3D 0x00;
+		value[6] =3D 0x00;
=20
 		usbhid_submit_report(hid, report, USB_DIR_OUT);
 		break;
@@ -163,14 +164,15 @@ static void hid_lg4ff_set_autocenter_default(stru=
ct input_dev *dev, u16 magnitud
 	struct hid_device *hid =3D input_get_drvdata(dev);
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
+	__s32 *value =3D report->field[0]->value;
=20
-	report->field[0]->value[0] =3D 0xfe;
-	report->field[0]->value[1] =3D 0x0d;
-	report->field[0]->value[2] =3D magnitude >> 13;
-	report->field[0]->value[3] =3D magnitude >> 13;
-	report->field[0]->value[4] =3D magnitude >> 8;
-	report->field[0]->value[5] =3D 0x00;
-	report->field[0]->value[6] =3D 0x00;
+	value[0] =3D 0xfe;
+	value[1] =3D 0x0d;
+	value[2] =3D magnitude >> 13;
+	value[3] =3D magnitude >> 13;
+	value[4] =3D magnitude >> 8;
+	value[5] =3D 0x00;
+	value[6] =3D 0x00;
=20
 	usbhid_submit_report(hid, report, USB_DIR_OUT);
 }
@@ -181,16 +183,16 @@ static void hid_lg4ff_set_autocenter_ffex(struct =
input_dev *dev, u16 magnitude)
 	struct hid_device *hid =3D input_get_drvdata(dev);
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
+	__s32 *value =3D report->field[0]->value;
 	magnitude =3D magnitude * 90 / 65535;
-=09
=20
-	report->field[0]->value[0] =3D 0xfe;
-	report->field[0]->value[1] =3D 0x03;
-	report->field[0]->value[2] =3D magnitude >> 14;
-	report->field[0]->value[3] =3D magnitude >> 14;
-	report->field[0]->value[4] =3D magnitude;
-	report->field[0]->value[5] =3D 0x00;
-	report->field[0]->value[6] =3D 0x00;
+	value[0] =3D 0xfe;
+	value[1] =3D 0x03;
+	value[2] =3D magnitude >> 14;
+	value[3] =3D magnitude >> 14;
+	value[4] =3D magnitude;
+	value[5] =3D 0x00;
+	value[6] =3D 0x00;
=20
 	usbhid_submit_report(hid, report, USB_DIR_OUT);
 }
@@ -200,15 +202,17 @@ static void hid_lg4ff_set_range_g25(struct hid_de=
vice *hid, u16 range)
 {
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
+	__s32 *value =3D report->field[0]->value;
+
 	dbg_hid("G25/G27/DFGT: setting range to %u\n", range);
=20
-	report->field[0]->value[0] =3D 0xf8;
-	report->field[0]->value[1] =3D 0x81;
-	report->field[0]->value[2] =3D range & 0x00ff;
-	report->field[0]->value[3] =3D (range & 0xff00) >> 8;
-	report->field[0]->value[4] =3D 0x00;
-	report->field[0]->value[5] =3D 0x00;
-	report->field[0]->value[6] =3D 0x00;
+	value[0] =3D 0xf8;
+	value[1] =3D 0x81;
+	value[2] =3D range & 0x00ff;
+	value[3] =3D (range & 0xff00) >> 8;
+	value[4] =3D 0x00;
+	value[5] =3D 0x00;
+	value[6] =3D 0x00;
=20
 	usbhid_submit_report(hid, report, USB_DIR_OUT);
 }
@@ -219,16 +223,18 @@ static void hid_lg4ff_set_range_dfp(struct hid_de=
vice *hid, __u16 range)
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
 	int start_left, start_right, full_range;
+	__s32 *value =3D report->field[0]->value;
+
 	dbg_hid("Driving Force Pro: setting range to %u\n", range);
=20
 	/* Prepare "coarse" limit command */
-	report->field[0]->value[0] =3D 0xf8;
-	report->field[0]->value[1] =3D 0x00; 	/* Set later */
-	report->field[0]->value[2] =3D 0x00;
-	report->field[0]->value[3] =3D 0x00;
-	report->field[0]->value[4] =3D 0x00;
-	report->field[0]->value[5] =3D 0x00;
-	report->field[0]->value[6] =3D 0x00;
+	value[0] =3D 0xf8;
+	value[1] =3D 0x00; 	/* Set later */
+	value[2] =3D 0x00;
+	value[3] =3D 0x00;
+	value[4] =3D 0x00;
+	value[5] =3D 0x00;
+	value[6] =3D 0x00;
=20
 	if (range > 200) {
 		report->field[0]->value[1] =3D 0x03;
@@ -240,13 +246,13 @@ static void hid_lg4ff_set_range_dfp(struct hid_de=
vice *hid, __u16 range)
 	usbhid_submit_report(hid, report, USB_DIR_OUT);
=20
 	/* Prepare "fine" limit command */
-	report->field[0]->value[0] =3D 0x81;
-	report->field[0]->value[1] =3D 0x0b;
-	report->field[0]->value[2] =3D 0x00;
-	report->field[0]->value[3] =3D 0x00;
-	report->field[0]->value[4] =3D 0x00;
-	report->field[0]->value[5] =3D 0x00;
-	report->field[0]->value[6] =3D 0x00;
+	value[0] =3D 0x81;
+	value[1] =3D 0x0b;
+	value[2] =3D 0x00;
+	value[3] =3D 0x00;
+	value[4] =3D 0x00;
+	value[5] =3D 0x00;
+	value[6] =3D 0x00;
=20
 	if (range =3D=3D 200 || range =3D=3D 900) {	/* Do not apply any fine =
limit */
 		usbhid_submit_report(hid, report, USB_DIR_OUT);
@@ -257,11 +263,11 @@ static void hid_lg4ff_set_range_dfp(struct hid_de=
vice *hid, __u16 range)
 	start_left =3D (((full_range - range + 1) * 2047) / full_range);
 	start_right =3D 0xfff - start_left;
=20
-	report->field[0]->value[2] =3D start_left >> 4;
-	report->field[0]->value[3] =3D start_right >> 4;
-	report->field[0]->value[4] =3D 0xff;
-	report->field[0]->value[5] =3D (start_right & 0xe) << 4 | (start_left=
 & 0xe);
-	report->field[0]->value[6] =3D 0xff;
+	value[2] =3D start_left >> 4;
+	value[3] =3D start_right >> 4;
+	value[4] =3D 0xff;
+	value[5] =3D (start_right & 0xe) << 4 | (start_left & 0xe);
+	value[6] =3D 0xff;
=20
 	usbhid_submit_report(hid, report, USB_DIR_OUT);
 }
@@ -344,14 +350,15 @@ static void lg4ff_set_leds(struct hid_device *hid=
, __u8 leds)
 {
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
-
-	report->field[0]->value[0] =3D 0xf8;
-	report->field[0]->value[1] =3D 0x12;
-	report->field[0]->value[2] =3D leds;
-	report->field[0]->value[3] =3D 0x00;
-	report->field[0]->value[4] =3D 0x00;
-	report->field[0]->value[5] =3D 0x00;
-	report->field[0]->value[6] =3D 0x00;
+	__s32 *value =3D report->field[0]->value;
+
+	value[0] =3D 0xf8;
+	value[1] =3D 0x12;
+	value[2] =3D leds;
+	value[3] =3D 0x00;
+	value[4] =3D 0x00;
+	value[5] =3D 0x00;
+	value[6] =3D 0x00;
 	usbhid_submit_report(hid, report, USB_DIR_OUT);
 }
=20
@@ -501,7 +508,7 @@ int lg4ff_init(struct hid_device *hid)
 	/* Check if autocentering is available and
 	 * set the centering force to zero by default */
 	if (test_bit(FF_AUTOCENTER, dev->ffbit)) {
-		if(rev_maj =3D=3D FFEX_REV_MAJ && rev_min =3D=3D FFEX_REV_MIN)	/* Fo=
rmula Force EX expects different autocentering command */
+		if (rev_maj =3D=3D FFEX_REV_MAJ && rev_min =3D=3D FFEX_REV_MIN)	/* F=
ormula Force EX expects different autocentering command */
 			dev->ff->set_autocenter =3D hid_lg4ff_set_autocenter_ffex;
 		else
 			dev->ff->set_autocenter =3D hid_lg4ff_set_autocenter_default;
--=20
1.7.12.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
