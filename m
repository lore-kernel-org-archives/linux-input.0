From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@gmail.com>
Subject: [v3 2/6] HID: lg4ff - Add support for native mode switching
Date: Thu, 04 Aug 2011 16:18:11 +0200
Message-ID: <1521462.PNjbShY6SO@qosmio-x300>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37961 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510Ab1HDOSO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Aug 2011 10:18:14 -0400
Received: by fxh19 with SMTP id 19so1794529fxh.19
        for <linux-input@vger.kernel.org>; Thu, 04 Aug 2011 07:18:13 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, simon@mungewell.org

(Hopefully) fixed wordwrapping

Signed-off-by: Michal Mal=FD <madcatxster@gmail.com>

---
diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 6b357ac..acef0cf 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -31,6 +31,17 @@
 #include "hid-lg.h"
 #include "hid-ids.h"
=20
+#define DFGT_REV_MAJ 0x13
+#define DFGT_REV_MIN 0x22
+#define DFP_REV_MAJ 0x11
+#define DFP_REV_MIN 0x06
+#define FFEX_REV_MAJ 0x21
+#define FFEX_REV_MIN 0x00
+#define G25_REV_MAJ 0x12
+#define G25_REV_MIN 0x22
+#define G27_REV_MAJ 0x12
+#define G27_REV_MIN 0x38
+
 static const signed short lg4ff_wheel_effects[] =3D {
 	FF_CONSTANT,
 	FF_AUTOCENTER,
@@ -55,6 +66,46 @@ static const struct lg4ff_wheel lg4ff_devices[] =3D =
{
 	{USB_DEVICE_ID_LOGITECH_WII_WHEEL,   lg4ff_wheel_effects, 40, 270}
 };
=20
+struct lg4ff_native_cmd {
+	const __u8 cmd_num;	/* Number of commands to send */
+	const __u8 cmd[];
+};
+
+struct lg4ff_usb_revision {
+	const __u16 rev_maj;
+	const __u16 rev_min;
+	const struct lg4ff_native_cmd *command;
+};
+
+static const struct lg4ff_native_cmd native_dfp =3D {
+	1,
+	{0xf8, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00}
+};
+
+static const struct lg4ff_native_cmd native_dfgt =3D {
+	2,
+	{0xf8, 0x0a, 0x00, 0x00, 0x00, 0x00, 0x00,	/* 1st command */
+	 0xf8, 0x09, 0x03, 0x01, 0x00, 0x00, 0x00}	/* 2nd command */
+};
+
+static const struct lg4ff_native_cmd native_g25 =3D {
+	1,
+	{0xf8, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00}
+};
+
+static const struct lg4ff_native_cmd native_g27 =3D {
+	2,
+	{0xf8, 0x0a, 0x00, 0x00, 0x00, 0x00, 0x00,	/* 1st command */
+	 0xf8, 0x09, 0x04, 0x01, 0x00, 0x00, 0x00}	/* 2nd command */
+};
+
+static const struct lg4ff_usb_revision lg4ff_revs[] =3D {
+	{DFGT_REV_MAJ, DFGT_REV_MIN, &native_dfgt},	/* Driving Force GT */
+	{DFP_REV_MAJ,  DFP_REV_MIN,  &native_dfp},	/* Driving Force Pro */
+	{G25_REV_MAJ,  G25_REV_MIN,  &native_g25},	/* G25 */
+	{G27_REV_MAJ,  G27_REV_MIN,  &native_g27},	/* G27 */
+};
+
 static int hid_lg4ff_play(struct input_dev *dev, void *data,
 			 struct ff_effect *effect)
 {
@@ -100,6 +151,20 @@ static void hid_lg4ff_set_autocenter(struct input_=
dev *dev, u16 magnitude)
 	usbhid_submit_report(hid, report, USB_DIR_OUT);
 }
=20
+static void hid_lg4ff_switch_native(struct hid_device *hid, const stru=
ct lg4ff_native_cmd *cmd)
+{
+	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
+	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
+	__u8 i, j;
+
+	j =3D 0;
+	while (j < 7*cmd->cmd_num) {
+		for (i =3D 0; i < 7; i++)
+			report->field[0]->value[i] =3D cmd->cmd[j++];
+
+		usbhid_submit_report(hid, report, USB_DIR_OUT);
+	}
+}
=20
 int lg4ff_init(struct hid_device *hid)
 {
@@ -108,7 +173,9 @@ int lg4ff_init(struct hid_device *hid)
 	struct input_dev *dev =3D hidinput->input;
 	struct hid_report *report;
 	struct hid_field *field;
+	struct usb_device_descriptor *udesc =3D 0;
 	int error, i, j;
+	__u16 bcdDevice, rev_maj, rev_min;
=20
 	/* Find the report to use */
 	if (list_empty(report_list)) {
@@ -143,6 +210,28 @@ int lg4ff_init(struct hid_device *hid)
 		return -1;
 	}
=20
+	/* Attempt to switch wheel to native mode when applicable */
+	udesc =3D &(hid_to_usb_dev(hid)->descriptor);
+	if (!udesc) {
+		hid_err(hid, "NULL USB device descriptor\n");
+		return -1;
+	}
+	bcdDevice =3D le16_to_cpu(udesc->bcdDevice);
+	rev_maj =3D bcdDevice >> 8;
+	rev_min =3D bcdDevice & 0xff;
+
+	if (lg4ff_devices[i].product_id =3D=3D USB_DEVICE_ID_LOGITECH_WHEEL) =
{
+		dbg_hid("Generic wheel detected, can it do native?\n");
+		dbg_hid("USB revision: %2x.%02x\n", rev_maj, rev_min);
+
+		for (j =3D 0; j < ARRAY_SIZE(lg4ff_revs); j++) {
+			if (lg4ff_revs[j].rev_maj =3D=3D rev_maj && lg4ff_revs[j].rev_min =3D=
=3D rev_min) {
+				hid_lg4ff_switch_native(hid, lg4ff_revs[j].command);
+				hid_info(hid, "Switched to native mode\n");
+			}
+		}
+	}
+
 	/* Set supported force feedback capabilities */
 	for (j =3D 0; lg4ff_devices[i].ff_effects[j] >=3D 0; j++)
 		set_bit(lg4ff_devices[i].ff_effects[j], dev->ffbit);

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
