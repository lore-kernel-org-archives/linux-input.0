From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH 08/12] HID: hid-lg4ff: Store pointer to the output HID report struct in the device entry struct.
Date: Sat, 21 Mar 2015 12:47:38 +0100
Message-ID: <1426938462-884-9-git-send-email-madcatxster@devoid-pointer.net>
References: <1426938462-884-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.devoid-pointer.net ([31.31.77.140]:59568 "EHLO
	smtp.devoid-pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754AbbCULsY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Mar 2015 07:48:24 -0400
In-Reply-To: <1426938462-884-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, elias.vds@gmail.com, simon@mungewell.org, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>

This eliminates the need to look the HID report struct up every time it=
 is needed.

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/hid/hid-lg4ff.c | 67 +++++++++++++++++++++++------------------=
--------
 1 file changed, 32 insertions(+), 35 deletions(-)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 0bbdeea..fd6f140 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -90,6 +90,7 @@ struct lg4ff_wheel_data {
=20
 struct lg4ff_device_entry {
 	spinlock_t report_lock;
+	struct hid_report *report;
 	struct lg4ff_wheel_data wdata;
 };
=20
@@ -302,11 +303,9 @@ int lg4ff_adjust_input_event(struct hid_device *hi=
d, struct hid_field *field,
 static int lg4ff_play(struct input_dev *dev, void *data, struct ff_eff=
ect *effect)
 {
 	struct hid_device *hid =3D input_get_drvdata(dev);
-	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
-	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
 	struct lg4ff_device_entry *entry;
 	struct lg_drv_data *drv_data;
-	s32 *value =3D report->field[0]->value;
+	s32 *value;
 	int x;
 	unsigned long flags;
=20
@@ -321,6 +320,7 @@ static int lg4ff_play(struct input_dev *dev, void *=
data, struct ff_effect *effec
 		hid_err(hid, "Device properties not found!\n");
 		return -EINVAL;
 	}
+	value =3D entry->report->field[0]->value;
=20
 #define CLAMP(x) do { if (x < 0) x =3D 0; else if (x > 0xff) x =3D 0xf=
f; } while (0)
=20
@@ -340,7 +340,7 @@ static int lg4ff_play(struct input_dev *dev, void *=
data, struct ff_effect *effec
 			value[5] =3D 0x00;
 			value[6] =3D 0x00;
=20
-			hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+			hid_hw_request(hid, entry->report, HID_REQ_SET_REPORT);
 			spin_unlock_irqrestore(&entry->report_lock, flags);
 			return 0;
 		}
@@ -353,7 +353,7 @@ static int lg4ff_play(struct input_dev *dev, void *=
data, struct ff_effect *effec
 		value[5] =3D 0x00;
 		value[6] =3D 0x00;
=20
-		hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+		hid_hw_request(hid, entry->report, HID_REQ_SET_REPORT);
 		spin_unlock_irqrestore(&entry->report_lock, flags);
 		break;
 	}
@@ -365,11 +365,9 @@ static int lg4ff_play(struct input_dev *dev, void =
*data, struct ff_effect *effec
 static void lg4ff_set_autocenter_default(struct input_dev *dev, u16 ma=
gnitude)
 {
 	struct hid_device *hid =3D input_get_drvdata(dev);
-	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
-	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
 	struct lg4ff_device_entry *entry;
 	struct lg_drv_data *drv_data;
-	s32 *value =3D report->field[0]->value;
+	s32 *value;
 	u32 expand_a, expand_b;
 	unsigned long flags;
=20
@@ -384,6 +382,7 @@ static void lg4ff_set_autocenter_default(struct inp=
ut_dev *dev, u16 magnitude)
 		hid_err(hid, "Device properties not found!\n");
 		return;
 	}
+	value =3D entry->report->field[0]->value;
=20
 	/* De-activate Auto-Center */
 	spin_lock_irqsave(&entry->report_lock, flags);
@@ -396,7 +395,7 @@ static void lg4ff_set_autocenter_default(struct inp=
ut_dev *dev, u16 magnitude)
 		value[5] =3D 0x00;
 		value[6] =3D 0x00;
=20
-		hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+		hid_hw_request(hid, entry->report, HID_REQ_SET_REPORT);
 		spin_unlock_irqrestore(&entry->report_lock, flags);
 		return;
 	}
@@ -427,7 +426,7 @@ static void lg4ff_set_autocenter_default(struct inp=
ut_dev *dev, u16 magnitude)
 	value[5] =3D 0x00;
 	value[6] =3D 0x00;
=20
-	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+	hid_hw_request(hid, entry->report, HID_REQ_SET_REPORT);
=20
 	/* Activate Auto-Center */
 	value[0] =3D 0x14;
@@ -438,7 +437,7 @@ static void lg4ff_set_autocenter_default(struct inp=
ut_dev *dev, u16 magnitude)
 	value[5] =3D 0x00;
 	value[6] =3D 0x00;
=20
-	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+	hid_hw_request(hid, entry->report, HID_REQ_SET_REPORT);
 	spin_unlock_irqrestore(&entry->report_lock, flags);
 }
=20
@@ -446,12 +445,10 @@ static void lg4ff_set_autocenter_default(struct i=
nput_dev *dev, u16 magnitude)
 static void lg4ff_set_autocenter_ffex(struct input_dev *dev, u16 magni=
tude)
 {
 	struct hid_device *hid =3D input_get_drvdata(dev);
-	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
-	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
 	struct lg4ff_device_entry *entry;
 	struct lg_drv_data *drv_data;
 	unsigned long flags;
-	s32 *value =3D report->field[0]->value;
+	s32 *value;
 	magnitude =3D magnitude * 90 / 65535;
=20
 	drv_data =3D hid_get_drvdata(hid);
@@ -465,6 +462,7 @@ static void lg4ff_set_autocenter_ffex(struct input_=
dev *dev, u16 magnitude)
 		hid_err(hid, "Device properties not found!\n");
 		return;
 	}
+	value =3D entry->report->field[0]->value;
=20
 	spin_lock_irqsave(&entry->report_lock, flags);
 	value[0] =3D 0xfe;
@@ -475,18 +473,16 @@ static void lg4ff_set_autocenter_ffex(struct inpu=
t_dev *dev, u16 magnitude)
 	value[5] =3D 0x00;
 	value[6] =3D 0x00;
=20
-	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+	hid_hw_request(hid, entry->report, HID_REQ_SET_REPORT);
 	spin_unlock_irqrestore(&entry->report_lock, flags);
 }
=20
 /* Sends command to set range compatible with G25/G27/Driving Force GT=
 */
 static void lg4ff_set_range_g25(struct hid_device *hid, u16 range)
 {
-	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
-	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
 	struct lg4ff_device_entry *entry;
 	struct lg_drv_data *drv_data;
-	s32 *value =3D report->field[0]->value;
+	s32 *value;
 	unsigned long flags;
=20
 	drv_data =3D hid_get_drvdata(hid);
@@ -500,6 +496,7 @@ static void lg4ff_set_range_g25(struct hid_device *=
hid, u16 range)
 		hid_err(hid, "Device properties not found!\n");
 		return;
 	}
+	value =3D entry->report->field[0]->value;
 	dbg_hid("G25/G27/DFGT: setting range to %u\n", range);
=20
 	spin_lock_irqsave(&entry->report_lock, flags);
@@ -511,19 +508,17 @@ static void lg4ff_set_range_g25(struct hid_device=
 *hid, u16 range)
 	value[5] =3D 0x00;
 	value[6] =3D 0x00;
=20
-	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+	hid_hw_request(hid, entry->report, HID_REQ_SET_REPORT);
 	spin_unlock_irqrestore(&entry->report_lock, flags);
 }
=20
 /* Sends commands to set range compatible with Driving Force Pro wheel=
 */
 static void lg4ff_set_range_dfp(struct hid_device *hid, u16 range)
 {
-	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
-	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
 	struct lg4ff_device_entry *entry;
 	struct lg_drv_data *drv_data;
 	int start_left, start_right, full_range;
-	s32 *value =3D report->field[0]->value;
+	s32 *value;
 	unsigned long flags;
=20
 	drv_data =3D hid_get_drvdata(hid);
@@ -537,6 +532,7 @@ static void lg4ff_set_range_dfp(struct hid_device *=
hid, u16 range)
 		hid_err(hid, "Device properties not found!\n");
 		return;
 	}
+	value =3D entry->report->field[0]->value;
 	dbg_hid("Driving Force Pro: setting range to %u\n", range);
=20
 	spin_lock_irqsave(&entry->report_lock, flags);
@@ -550,13 +546,13 @@ static void lg4ff_set_range_dfp(struct hid_device=
 *hid, u16 range)
 	value[6] =3D 0x00;
=20
 	if (range > 200) {
-		report->field[0]->value[1] =3D 0x03;
+		value[1] =3D 0x03;
 		full_range =3D 900;
 	} else {
-		report->field[0]->value[1] =3D 0x02;
+		value[1] =3D 0x02;
 		full_range =3D 200;
 	}
-	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+	hid_hw_request(hid, entry->report, HID_REQ_SET_REPORT);
=20
 	/* Prepare "fine" limit command */
 	value[0] =3D 0x81;
@@ -568,7 +564,7 @@ static void lg4ff_set_range_dfp(struct hid_device *=
hid, u16 range)
 	value[6] =3D 0x00;
=20
 	if (range =3D=3D 200 || range =3D=3D 900) {	/* Do not apply any fine =
limit */
-		hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+		hid_hw_request(hid, entry->report, HID_REQ_SET_REPORT);
 		spin_unlock_irqrestore(&entry->report_lock, flags);
 		return;
 	}
@@ -583,7 +579,7 @@ static void lg4ff_set_range_dfp(struct hid_device *=
hid, u16 range)
 	value[5] =3D (start_right & 0xe) << 4 | (start_left & 0xe);
 	value[6] =3D 0xff;
=20
-	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+	hid_hw_request(hid, entry->report, HID_REQ_SET_REPORT);
 	spin_unlock_irqrestore(&entry->report_lock, flags);
 }
=20
@@ -646,11 +642,9 @@ static const struct lg4ff_compat_mode_switch *lg4f=
f_get_mode_switch_command(cons
=20
 static int lg4ff_switch_compatibility_mode(struct hid_device *hid, con=
st struct lg4ff_compat_mode_switch *s)
 {
-	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
-	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
 	struct lg4ff_device_entry *entry;
 	struct lg_drv_data *drv_data;
-	s32 *value =3D report->field[0]->value;
+	s32 *value;
 	u8 i;
 	unsigned long flags;
=20
@@ -665,6 +659,7 @@ static int lg4ff_switch_compatibility_mode(struct h=
id_device *hid, const struct
 		hid_err(hid, "Device properties not found!\n");
 		return -EINVAL;
 	}
+	value =3D entry->report->field[0]->value;
=20
 	spin_lock_irqsave(&entry->report_lock, flags);
 	for (i =3D 0; i < s->cmd_count; i++) {
@@ -673,7 +668,7 @@ static int lg4ff_switch_compatibility_mode(struct h=
id_device *hid, const struct
 		for (j =3D 0; j < 7; j++)
 			value[j] =3D s->cmd[j + (7*i)];
=20
-		hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+		hid_hw_request(hid, entry->report, HID_REQ_SET_REPORT);
 	}
 	spin_unlock_irqrestore(&entry->report_lock, flags);
=20
@@ -915,11 +910,9 @@ static DEVICE_ATTR(real_id, S_IRUGO, lg4ff_real_id=
_show, lg4ff_real_id_store);
 #ifdef CONFIG_LEDS_CLASS
 static void lg4ff_set_leds(struct hid_device *hid, u8 leds)
 {
-	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
-	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
 	struct lg_drv_data *drv_data =3D hid_get_drvdata(hid);
 	struct lg4ff_device_entry *entry;
-	s32 *value =3D report->field[0]->value;
+	s32 *value;
 	unsigned long flags;
=20
 	drv_data =3D hid_get_drvdata(hid);
@@ -933,6 +926,7 @@ static void lg4ff_set_leds(struct hid_device *hid, =
u8 leds)
 		hid_err(hid, "Device properties not found!\n");
 		return;
 	}
+	value =3D entry->report->field[0]->value;
=20
 	spin_lock_irqsave(&entry->report_lock, flags);
 	value[0] =3D 0xf8;
@@ -942,7 +936,7 @@ static void lg4ff_set_leds(struct hid_device *hid, =
u8 leds)
 	value[4] =3D 0x00;
 	value[5] =3D 0x00;
 	value[6] =3D 0x00;
-	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+	hid_hw_request(hid, entry->report, HID_REQ_SET_REPORT);
 	spin_unlock_irqrestore(&entry->report_lock, flags);
 }
=20
@@ -1103,6 +1097,8 @@ int lg4ff_init(struct hid_device *hid)
 {
 	struct hid_input *hidinput =3D list_entry(hid->inputs.next, struct hi=
d_input, list);
 	struct input_dev *dev =3D hidinput->input;
+	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
+	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
 	const struct usb_device_descriptor *udesc =3D &(hid_to_usb_dev(hid)->=
descriptor);
 	const u16 bcdDevice =3D le16_to_cpu(udesc->bcdDevice);
 	struct lg4ff_device_entry *entry;
@@ -1124,6 +1120,7 @@ int lg4ff_init(struct hid_device *hid)
 	if (!entry)
 		return -ENOMEM;
 	spin_lock_init(&entry->report_lock);
+	entry->report =3D report;
 	drv_data->device_props =3D entry;
=20
 	/* Check if a multimode wheel has been connected and
--=20
2.3.3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
