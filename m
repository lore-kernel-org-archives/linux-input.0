From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@gmail.com>
Subject: [PATCH] Fix autocentering command in hid-lgff driver
Date: Tue, 14 Jun 2011 22:42:30 +0200
Message-ID: <2502891.N5kVV5at6b@qosmio-x300>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54602 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840Ab1FNUma convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2011 16:42:30 -0400
Received: by fxm17 with SMTP id 17so3979624fxm.19
        for <linux-input@vger.kernel.org>; Tue, 14 Jun 2011 13:42:29 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org

Hello,

this patch fixes two issues with autocentering in lgff driver. Current =
implementation incorrectly assumes that the saturation force is always =
0x80 which is=20
inconsistent with behavior of the official driver. It also makes it imp=
ossible to disable autocentering on some wheels - at least Logitech For=
mula Force RX is=20
the case. Values of stiffness coefficient were also calculated incorrec=
tly. Formula used in this patch appears to generate the same commands a=
s the official=20
Logitech drivers. The patch also fixes two minor coding style issues.

Regards, Michal.


Signed-off-by: Michal Mal=FD <madcatxster@gmail.com>
---
 drivers/hid/hid-lgff.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-lgff.c b/drivers/hid/hid-lgff.c
index 088f850..3d30a8e 100644
--- a/drivers/hid/hid-lgff.c
+++ b/drivers/hid/hid-lgff.c
@@ -129,18 +129,24 @@ static void hid_lgff_set_autocenter(struct input_=
dev *dev, u16 magnitude)
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
 	__s32 *value =3D report->field[0]->value;
-	magnitude =3D (magnitude >> 12) & 0xf;
+	u8 saturation_force =3D magnitude >> 8;
+	u8 stiffness_coeff;
+	if (magnitude <=3D 32768)
+		stiffness_coeff =3D saturation_force / 10;
+	else
+		stiffness_coeff =3D (saturation_force / 62) + 11;
+
 	*value++ =3D 0xfe;
 	*value++ =3D 0x0d;
-	*value++ =3D magnitude;   /* clockwise strength */
-	*value++ =3D magnitude;   /* counter-clockwise strength */
-	*value++ =3D 0x80;
+	*value++ =3D stiffness_coeff;   /* clockwise strength */
+	*value++ =3D stiffness_coeff;   /* counter-clockwise strength */
+	*value++ =3D saturation_force;
 	*value++ =3D 0x00;
 	*value =3D 0x00;
 	usbhid_submit_report(hid, report, USB_DIR_OUT);
 }
=20
-int lgff_init(struct hid_device* hid)
+int lgff_init(struct hid_device *hid)
 {
 	struct hid_input *hidinput =3D list_entry(hid->inputs.next, struct hi=
d_input, list);
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
@@ -180,7 +186,7 @@ int lgff_init(struct hid_device* hid)
 	if (error)
 		return error;
=20
-	if ( test_bit(FF_AUTOCENTER, dev->ffbit) )
+	if (test_bit(FF_AUTOCENTER, dev->ffbit))
 		dev->ff->set_autocenter =3D hid_lgff_set_autocenter;
=20
 	pr_info("Force feedback for Logitech force feedback devices by Johann=
 Deneux <johann.deneux@it.uu.se>\n");
--=20
1.7.5.4


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
