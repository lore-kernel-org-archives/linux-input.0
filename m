From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH v2 10/15] HID: hid-lg4ff: Protect concurrent access to output HID report with a spinlock
Date: Wed,  8 Apr 2015 22:56:48 +0200
Message-ID: <1428526613-24239-11-git-send-email-madcatxster@devoid-pointer.net>
References: <1428526613-24239-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from prifuk.cz ([31.31.77.140]:33013 "EHLO smtp.devoid-pointer.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754750AbbDHU52 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 8 Apr 2015 16:57:28 -0400
In-Reply-To: <1428526613-24239-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.or, elias.vds@gmail.com, simon@mungewell.org, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>

Protect concurrent access to output HID report with a spinlock. The HID=
 report
structure used to submit commands to wheels is shared amongst all funct=
ions that
need to do so and some of these functions can be executed in parallel.
Additionally, lg4ff_play() can be called from interrupt context by ff-m=
emless
module. Locking is necessary to prevent sending bogus data to the wheel=
s.

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/hid/hid-lg4ff.c | 110 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 110 insertions(+)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 031b8ab..f7f4eb6 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -89,6 +89,7 @@ struct lg4ff_wheel_data {
 };
=20
 struct lg4ff_device_entry {
+	spinlock_t report_lock; /* Protect output HID report */
 	struct lg4ff_wheel_data wdata;
 };
=20
@@ -303,9 +304,24 @@ static int lg4ff_play(struct input_dev *dev, void =
*data, struct ff_effect *effec
 	struct hid_device *hid =3D input_get_drvdata(dev);
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
+	struct lg4ff_device_entry *entry;
+	struct lg_drv_data *drv_data;
+	unsigned long flags;
 	s32 *value =3D report->field[0]->value;
 	int x;
=20
+	drv_data =3D hid_get_drvdata(hid);
+	if (!drv_data) {
+		hid_err(hid, "Private driver data not found!\n");
+		return -EINVAL;
+	}
+
+	entry =3D drv_data->device_props;
+	if (!entry) {
+		hid_err(hid, "Device properties not found!\n");
+		return -EINVAL;
+	}
+
 #define CLAMP(x) do { if (x < 0) x =3D 0; else if (x > 0xff) x =3D 0xf=
f; } while (0)
=20
 	switch (effect->type) {
@@ -313,6 +329,7 @@ static int lg4ff_play(struct input_dev *dev, void *=
data, struct ff_effect *effec
 		x =3D effect->u.ramp.start_level + 0x80;	/* 0x80 is no force */
 		CLAMP(x);
=20
+		spin_lock_irqsave(&entry->report_lock, flags);
 		if (x =3D=3D 0x80) {
 			/* De-activate force in slot-1*/
 			value[0] =3D 0x13;
@@ -324,6 +341,7 @@ static int lg4ff_play(struct input_dev *dev, void *=
data, struct ff_effect *effec
 			value[6] =3D 0x00;
=20
 			hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+			spin_unlock_irqrestore(&entry->report_lock, flags);
 			return 0;
 		}
=20
@@ -336,6 +354,7 @@ static int lg4ff_play(struct input_dev *dev, void *=
data, struct ff_effect *effec
 		value[6] =3D 0x00;
=20
 		hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+		spin_unlock_irqrestore(&entry->report_lock, flags);
 		break;
 	}
 	return 0;
@@ -352,6 +371,7 @@ static void lg4ff_set_autocenter_default(struct inp=
ut_dev *dev, u16 magnitude)
 	u32 expand_a, expand_b;
 	struct lg4ff_device_entry *entry;
 	struct lg_drv_data *drv_data;
+	unsigned long flags;
=20
 	drv_data =3D hid_get_drvdata(hid);
 	if (!drv_data) {
@@ -366,6 +386,7 @@ static void lg4ff_set_autocenter_default(struct inp=
ut_dev *dev, u16 magnitude)
 	}
=20
 	/* De-activate Auto-Center */
+	spin_lock_irqsave(&entry->report_lock, flags);
 	if (magnitude =3D=3D 0) {
 		value[0] =3D 0xf5;
 		value[1] =3D 0x00;
@@ -376,6 +397,7 @@ static void lg4ff_set_autocenter_default(struct inp=
ut_dev *dev, u16 magnitude)
 		value[6] =3D 0x00;
=20
 		hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+		spin_unlock_irqrestore(&entry->report_lock, flags);
 		return;
 	}
=20
@@ -417,6 +439,7 @@ static void lg4ff_set_autocenter_default(struct inp=
ut_dev *dev, u16 magnitude)
 	value[6] =3D 0x00;
=20
 	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+	spin_unlock_irqrestore(&entry->report_lock, flags);
 }
=20
 /* Sends autocentering command compatible with Formula Force EX */
@@ -425,9 +448,25 @@ static void lg4ff_set_autocenter_ffex(struct input=
_dev *dev, u16 magnitude)
 	struct hid_device *hid =3D input_get_drvdata(dev);
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
+	struct lg4ff_device_entry *entry;
+	struct lg_drv_data *drv_data;
+	unsigned long flags;
 	s32 *value =3D report->field[0]->value;
 	magnitude =3D magnitude * 90 / 65535;
=20
+	drv_data =3D hid_get_drvdata(hid);
+	if (!drv_data) {
+		hid_err(hid, "Private driver data not found!\n");
+		return;
+	}
+
+	entry =3D drv_data->device_props;
+	if (!entry) {
+		hid_err(hid, "Device properties not found!\n");
+		return;
+	}
+
+	spin_lock_irqsave(&entry->report_lock, flags);
 	value[0] =3D 0xfe;
 	value[1] =3D 0x03;
 	value[2] =3D magnitude >> 14;
@@ -437,6 +476,7 @@ static void lg4ff_set_autocenter_ffex(struct input_=
dev *dev, u16 magnitude)
 	value[6] =3D 0x00;
=20
 	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+	spin_unlock_irqrestore(&entry->report_lock, flags);
 }
=20
 /* Sends command to set range compatible with G25/G27/Driving Force GT=
 */
@@ -444,10 +484,26 @@ static void lg4ff_set_range_g25(struct hid_device=
 *hid, u16 range)
 {
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
+	struct lg4ff_device_entry *entry;
+	struct lg_drv_data *drv_data;
+	unsigned long flags;
 	s32 *value =3D report->field[0]->value;
=20
+	drv_data =3D hid_get_drvdata(hid);
+	if (!drv_data) {
+		hid_err(hid, "Private driver data not found!\n");
+		return;
+	}
+
+	entry =3D drv_data->device_props;
+	if (!entry) {
+		hid_err(hid, "Device properties not found!\n");
+		return;
+	}
+
 	dbg_hid("G25/G27/DFGT: setting range to %u\n", range);
=20
+	spin_lock_irqsave(&entry->report_lock, flags);
 	value[0] =3D 0xf8;
 	value[1] =3D 0x81;
 	value[2] =3D range & 0x00ff;
@@ -457,6 +513,7 @@ static void lg4ff_set_range_g25(struct hid_device *=
hid, u16 range)
 	value[6] =3D 0x00;
=20
 	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+	spin_unlock_irqrestore(&entry->report_lock, flags);
 }
=20
 /* Sends commands to set range compatible with Driving Force Pro wheel=
 */
@@ -465,11 +522,27 @@ static void lg4ff_set_range_dfp(struct hid_device=
 *hid, u16 range)
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
 	int start_left, start_right, full_range;
+	struct lg4ff_device_entry *entry;
+	struct lg_drv_data *drv_data;
+	unsigned long flags;
 	s32 *value =3D report->field[0]->value;
=20
+	drv_data =3D hid_get_drvdata(hid);
+	if (!drv_data) {
+		hid_err(hid, "Private driver data not found!\n");
+		return;
+	}
+
+	entry =3D drv_data->device_props;
+	if (!entry) {
+		hid_err(hid, "Device properties not found!\n");
+		return;
+	}
+
 	dbg_hid("Driving Force Pro: setting range to %u\n", range);
=20
 	/* Prepare "coarse" limit command */
+	spin_lock_irqsave(&entry->report_lock, flags);
 	value[0] =3D 0xf8;
 	value[1] =3D 0x00;	/* Set later */
 	value[2] =3D 0x00;
@@ -498,6 +571,7 @@ static void lg4ff_set_range_dfp(struct hid_device *=
hid, u16 range)
=20
 	if (range =3D=3D 200 || range =3D=3D 900) {	/* Do not apply any fine =
limit */
 		hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+		spin_unlock_irqrestore(&entry->report_lock, flags);
 		return;
 	}
=20
@@ -512,6 +586,7 @@ static void lg4ff_set_range_dfp(struct hid_device *=
hid, u16 range)
 	value[6] =3D 0xff;
=20
 	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+	spin_unlock_irqrestore(&entry->report_lock, flags);
 }
=20
 static const struct lg4ff_compat_mode_switch *lg4ff_get_mode_switch_co=
mmand(const u16 real_product_id, const u16 target_product_id)
@@ -575,9 +650,25 @@ static int lg4ff_switch_compatibility_mode(struct =
hid_device *hid, const struct
 {
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
+	struct lg4ff_device_entry *entry;
+	struct lg_drv_data *drv_data;
+	unsigned long flags;
 	s32 *value =3D report->field[0]->value;
 	u8 i;
=20
+	drv_data =3D hid_get_drvdata(hid);
+	if (!drv_data) {
+		hid_err(hid, "Private driver data not found!\n");
+		return -EINVAL;
+	}
+
+	entry =3D drv_data->device_props;
+	if (!entry) {
+		hid_err(hid, "Device properties not found!\n");
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&entry->report_lock, flags);
 	for (i =3D 0; i < s->cmd_count; i++) {
 		u8 j;
=20
@@ -586,6 +677,7 @@ static int lg4ff_switch_compatibility_mode(struct h=
id_device *hid, const struct
=20
 		hid_hw_request(hid, report, HID_REQ_SET_REPORT);
 	}
+	spin_unlock_irqrestore(&entry->report_lock, flags);
 	hid_hw_wait(hid);
 	return 0;
 }
@@ -826,8 +918,24 @@ static void lg4ff_set_leds(struct hid_device *hid,=
 u8 leds)
 {
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
+	struct lg_drv_data *drv_data;
+	struct lg4ff_device_entry *entry;
+	unsigned long flags;
 	s32 *value =3D report->field[0]->value;
=20
+	drv_data =3D hid_get_drvdata(hid);
+	if (!drv_data) {
+		hid_err(hid, "Private driver data not found!\n");
+		return;
+	}
+
+	entry =3D drv_data->device_props;
+	if (!entry) {
+		hid_err(hid, "Device properties not found!\n");
+		return;
+	}
+
+	spin_lock_irqsave(&entry->report_lock, flags);
 	value[0] =3D 0xf8;
 	value[1] =3D 0x12;
 	value[2] =3D leds;
@@ -836,6 +944,7 @@ static void lg4ff_set_leds(struct hid_device *hid, =
u8 leds)
 	value[5] =3D 0x00;
 	value[6] =3D 0x00;
 	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+	spin_unlock_irqrestore(&entry->report_lock, flags);
 }
=20
 static void lg4ff_led_set_brightness(struct led_classdev *led_cdev,
@@ -1015,6 +1124,7 @@ int lg4ff_init(struct hid_device *hid)
 	entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
 		return -ENOMEM;
+	spin_lock_init(&entry->report_lock);
 	drv_data->device_props =3D entry;
=20
 	/* Check if a multimode wheel has been connected and
--=20
2.3.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
