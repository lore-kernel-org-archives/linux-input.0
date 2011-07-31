From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@gmail.com>
Subject: PATCH [4/6] HID: lg4ff - Add autocentering command accepted by Formula Force EX
Date: Sun, 31 Jul 2011 03:12:18 +0200
Message-ID: <2586452.9LP0aaYiSl@qosmio-x300>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50687 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab1GaBMW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Jul 2011 21:12:22 -0400
Received: by fxh19 with SMTP id 19so3414933fxh.19
        for <linux-input@vger.kernel.org>; Sat, 30 Jul 2011 18:12:21 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, simon@mungewell.org

According to our USB traffic sniffs the Logitech driver for Windows sen=
ds Formula Force EX wheel a different command to set the=20
autocenering force. FFEX will accept the standard command used by the r=
est of the wheels, but it won't set the centering force=20
properly.

Signed-off-by: Michal Mal=FD <madcatxster@gmail.com>
---
diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 1ee78d3..1ca121e 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -157,7 +157,9 @@ static int hid_lg4ff_play(struct input_dev *dev, vo=
id *data, struct ff_effect *e
 	return 0;
 }
=20
-static void hid_lg4ff_set_autocenter(struct input_dev *dev, u16 magnit=
ude)
+/* Sends default autocentering command compatible with
+ * all wheels except Formula Force EX */
+static void hid_lg4ff_set_autocenter_default(struct input_dev *dev, u1=
6 magnitude)
 {
 	struct hid_device *hid =3D input_get_drvdata(dev);
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
@@ -174,6 +176,26 @@ static void hid_lg4ff_set_autocenter(struct input_=
dev *dev, u16 magnitude)
 	usbhid_submit_report(hid, report, USB_DIR_OUT);
 }
=20
+/* Sends autocentering command compatible with Formula Force EX */
+static void hid_lg4ff_set_autocenter_ffex(struct input_dev *dev, u16 m=
agnitude)
+{
+	struct hid_device *hid =3D input_get_drvdata(dev);
+	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
+	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
+	magnitude =3D magnitude * 90 / 65535;
+=09
+
+	report->field[0]->value[0] =3D 0xfe;
+	report->field[0]->value[1] =3D 0x03;
+	report->field[0]->value[2] =3D magnitude >> 14;
+	report->field[0]->value[3] =3D magnitude >> 14;
+	report->field[0]->value[4] =3D magnitude;
+	report->field[0]->value[5] =3D 0x00;
+	report->field[0]->value[6] =3D 0x00;
+
+	usbhid_submit_report(hid, report, USB_DIR_OUT);
+}
+
 /* Sends command to set range compatible with G25/G27/Driving Force GT=
 */
 static void hid_lg4ff_set_range_g25(struct hid_device *hid, u16 range)
 {
@@ -390,8 +412,16 @@ int lg4ff_init(struct hid_device *hid)
 	if (error)
 		return error;
=20
-	if (test_bit(FF_AUTOCENTER, dev->ffbit))
-		dev->ff->set_autocenter =3D hid_lg4ff_set_autocenter;
+	/* Check if autocentering is available and
+	 * set the centering force to zero by default */
+	if (test_bit(FF_AUTOCENTER, dev->ffbit)) {
+		if(rev_maj =3D=3D FFEX_REV_MAJ && rev_min =3D=3D FFEX_REV_MIN)	/* Fo=
rmula Force EX expects different autocentering=20
command */
+			dev->ff->set_autocenter =3D hid_lg4ff_set_autocenter_ffex;
+		else
+			dev->ff->set_autocenter =3D hid_lg4ff_set_autocenter_default;
+
+		dev->ff->set_autocenter(dev, 0);
+	}
=20
 		/* Initialize device_list if this is the first device to handle by l=
g4ff */
 	if (!list_inited) {

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
