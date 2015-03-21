From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH 07/12] HID: hid-lg4ff: Protect concurrent access to the output HID report values with a spinlock.
Date: Sat, 21 Mar 2015 12:47:37 +0100
Message-ID: <1426938462-884-8-git-send-email-madcatxster@devoid-pointer.net>
References: <1426938462-884-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426938462-884-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, elias.vds@gmail.com, simon@mungewell.org, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
List-Id: linux-input@vger.kernel.org

Since all functions that need to send some data to the device they
manage share the same HID report some synchronization is needed to
prevent sending bogus data to the device.

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/hid/hid-lg.c    |   4 +-
 drivers/hid/hid-lg4ff.c | 293 ++++++++++++++++++++++++++++++++++------=
--------
 2 files changed, 213 insertions(+), 84 deletions(-)

diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index c797781..c3981da 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -734,8 +734,8 @@ static void lg_remove(struct hid_device *hdev)
 	struct lg_drv_data *drv_data =3D hid_get_drvdata(hdev);
 	if (drv_data->quirks & LG_FF4)
 		lg4ff_deinit(hdev);
-
-	hid_hw_stop(hdev);
+	else
+		hid_hw_stop(hdev);
 	kfree(drv_data);
 }
=20
diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index a2f47ee..0bbdeea 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -71,7 +71,7 @@
 static void lg4ff_set_range_dfp(struct hid_device *hid, u16 range);
 static void lg4ff_set_range_g25(struct hid_device *hid, u16 range);
=20
-struct lg4ff_device_entry {
+struct lg4ff_wheel_data {
 	u32 product_id;
 	u16 range;
 	u16 min_range;
@@ -84,9 +84,15 @@ struct lg4ff_device_entry {
 	const char *real_tag;
 	const char *real_name;
 	u16 real_product_id;
+
 	void (*set_range)(struct hid_device *hid, u16 range);
 };
=20
+struct lg4ff_device_entry {
+	spinlock_t report_lock;
+	struct lg4ff_wheel_data wdata;
+};
+
 static const signed short lg4ff_wheel_effects[] =3D {
 	FF_CONSTANT,
 	FF_AUTOCENTER,
@@ -278,11 +284,11 @@ int lg4ff_adjust_input_event(struct hid_device *h=
id, struct hid_field *field,
 		return 0;
 	}
=20
-	switch (entry->product_id) {
+	switch (entry->wdata.product_id) {
 	case USB_DEVICE_ID_LOGITECH_DFP_WHEEL:
 		switch (usage->code) {
 		case ABS_X:
-			new_value =3D lg4ff_adjust_dfp_x_axis(value, entry->range);
+			new_value =3D lg4ff_adjust_dfp_x_axis(value, entry->wdata.range);
 			input_event(field->hidinput->input, usage->type, usage->code, new_v=
alue);
 			return 1;
 		default:
@@ -298,8 +304,23 @@ static int lg4ff_play(struct input_dev *dev, void =
*data, struct ff_effect *effec
 	struct hid_device *hid =3D input_get_drvdata(dev);
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
+	struct lg4ff_device_entry *entry;
+	struct lg_drv_data *drv_data;
 	s32 *value =3D report->field[0]->value;
 	int x;
+	unsigned long flags;
+
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
=20
 #define CLAMP(x) do { if (x < 0) x =3D 0; else if (x > 0xff) x =3D 0xf=
f; } while (0)
=20
@@ -308,6 +329,7 @@ static int lg4ff_play(struct input_dev *dev, void *=
data, struct ff_effect *effec
 		x =3D effect->u.ramp.start_level + 0x80;	/* 0x80 is no force */
 		CLAMP(x);
=20
+		spin_lock_irqsave(&entry->report_lock, flags);
 		if (x =3D=3D 0x80) {
 			/* De-activate force in slot-1*/
 			value[0] =3D 0x13;
@@ -319,6 +341,7 @@ static int lg4ff_play(struct input_dev *dev, void *=
data, struct ff_effect *effec
 			value[6] =3D 0x00;
=20
 			hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+			spin_unlock_irqrestore(&entry->report_lock, flags);
 			return 0;
 		}
=20
@@ -331,6 +354,7 @@ static int lg4ff_play(struct input_dev *dev, void *=
data, struct ff_effect *effec
 		value[6] =3D 0x00;
=20
 		hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+		spin_unlock_irqrestore(&entry->report_lock, flags);
 		break;
 	}
 	return 0;
@@ -343,10 +367,11 @@ static void lg4ff_set_autocenter_default(struct i=
nput_dev *dev, u16 magnitude)
 	struct hid_device *hid =3D input_get_drvdata(dev);
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
-	s32 *value =3D report->field[0]->value;
-	u32 expand_a, expand_b;
 	struct lg4ff_device_entry *entry;
 	struct lg_drv_data *drv_data;
+	s32 *value =3D report->field[0]->value;
+	u32 expand_a, expand_b;
+	unsigned long flags;
=20
 	drv_data =3D hid_get_drvdata(hid);
 	if (!drv_data) {
@@ -361,6 +386,7 @@ static void lg4ff_set_autocenter_default(struct inp=
ut_dev *dev, u16 magnitude)
 	}
=20
 	/* De-activate Auto-Center */
+	spin_lock_irqsave(&entry->report_lock, flags);
 	if (magnitude =3D=3D 0) {
 		value[0] =3D 0xf5;
 		value[1] =3D 0x00;
@@ -371,6 +397,7 @@ static void lg4ff_set_autocenter_default(struct inp=
ut_dev *dev, u16 magnitude)
 		value[6] =3D 0x00;
=20
 		hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+		spin_unlock_irqrestore(&entry->report_lock, flags);
 		return;
 	}
=20
@@ -383,7 +410,7 @@ static void lg4ff_set_autocenter_default(struct inp=
ut_dev *dev, u16 magnitude)
 	}
=20
 	/* Adjust for non-MOMO wheels */
-	switch (entry->product_id) {
+	switch (entry->wdata.product_id) {
 	case USB_DEVICE_ID_LOGITECH_MOMO_WHEEL:
 	case USB_DEVICE_ID_LOGITECH_MOMO_WHEEL2:
 		break;
@@ -412,6 +439,7 @@ static void lg4ff_set_autocenter_default(struct inp=
ut_dev *dev, u16 magnitude)
 	value[6] =3D 0x00;
=20
 	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+	spin_unlock_irqrestore(&entry->report_lock, flags);
 }
=20
 /* Sends autocentering command compatible with Formula Force EX */
@@ -420,9 +448,25 @@ static void lg4ff_set_autocenter_ffex(struct input=
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
@@ -432,6 +476,7 @@ static void lg4ff_set_autocenter_ffex(struct input_=
dev *dev, u16 magnitude)
 	value[6] =3D 0x00;
=20
 	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+	spin_unlock_irqrestore(&entry->report_lock, flags);
 }
=20
 /* Sends command to set range compatible with G25/G27/Driving Force GT=
 */
@@ -439,10 +484,25 @@ static void lg4ff_set_range_g25(struct hid_device=
 *hid, u16 range)
 {
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
+	struct lg4ff_device_entry *entry;
+	struct lg_drv_data *drv_data;
 	s32 *value =3D report->field[0]->value;
+	unsigned long flags;
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
 	dbg_hid("G25/G27/DFGT: setting range to %u\n", range);
=20
+	spin_lock_irqsave(&entry->report_lock, flags);
 	value[0] =3D 0xf8;
 	value[1] =3D 0x81;
 	value[2] =3D range & 0x00ff;
@@ -452,6 +512,7 @@ static void lg4ff_set_range_g25(struct hid_device *=
hid, u16 range)
 	value[6] =3D 0x00;
=20
 	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+	spin_unlock_irqrestore(&entry->report_lock, flags);
 }
=20
 /* Sends commands to set range compatible with Driving Force Pro wheel=
 */
@@ -459,11 +520,26 @@ static void lg4ff_set_range_dfp(struct hid_device=
 *hid, u16 range)
 {
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
+	struct lg4ff_device_entry *entry;
+	struct lg_drv_data *drv_data;
 	int start_left, start_right, full_range;
 	s32 *value =3D report->field[0]->value;
+	unsigned long flags;
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
 	dbg_hid("Driving Force Pro: setting range to %u\n", range);
=20
+	spin_lock_irqsave(&entry->report_lock, flags);
 	/* Prepare "coarse" limit command */
 	value[0] =3D 0xf8;
 	value[1] =3D 0x00;	/* Set later */
@@ -493,6 +569,7 @@ static void lg4ff_set_range_dfp(struct hid_device *=
hid, u16 range)
=20
 	if (range =3D=3D 200 || range =3D=3D 900) {	/* Do not apply any fine =
limit */
 		hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+		spin_unlock_irqrestore(&entry->report_lock, flags);
 		return;
 	}
=20
@@ -507,6 +584,7 @@ static void lg4ff_set_range_dfp(struct hid_device *=
hid, u16 range)
 	value[6] =3D 0xff;
=20
 	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+	spin_unlock_irqrestore(&entry->report_lock, flags);
 }
=20
 static const struct lg4ff_compat_mode_switch *lg4ff_get_mode_switch_co=
mmand(const u16 real_product_id, const u16 target_product_id)
@@ -570,9 +648,25 @@ static int lg4ff_switch_compatibility_mode(struct =
hid_device *hid, const struct
 {
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
+	struct lg4ff_device_entry *entry;
+	struct lg_drv_data *drv_data;
 	s32 *value =3D report->field[0]->value;
 	u8 i;
+	unsigned long flags;
+
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
=20
+	spin_lock_irqsave(&entry->report_lock, flags);
 	for (i =3D 0; i < s->cmd_count; i++) {
 		u8 j;
=20
@@ -581,6 +675,8 @@ static int lg4ff_switch_compatibility_mode(struct h=
id_device *hid, const struct
=20
 		hid_hw_request(hid, report, HID_REQ_SET_REPORT);
 	}
+	spin_unlock_irqrestore(&entry->report_lock, flags);
+
 	hid_hw_wait(hid);
 	return 0;
 }
@@ -605,23 +701,23 @@ static ssize_t lg4ff_alternate_modes_show(struct =
device *dev, struct device_attr
 		return 0;
 	}
=20
-	if (!entry->real_name) {
+	if (!entry->wdata.real_name) {
 		hid_err(hid, "NULL pointer to string\n");
 		return 0;
 	}
=20
 	for (i =3D 0; i < LG4FF_MODE_MAX_IDX; i++) {
-		if (entry->alternate_modes & BIT(i)) {
+		if (entry->wdata.alternate_modes & BIT(i)) {
 			/* Print tag and full name */
 			count +=3D scnprintf(buf + count, PAGE_SIZE - count, "%s: %s",
 					   lg4ff_alternate_modes[i].tag,
-					   !lg4ff_alternate_modes[i].product_id ? entry->real_name : lg4f=
f_alternate_modes[i].name);
+					   !lg4ff_alternate_modes[i].product_id ? entry->wdata.real_name =
: lg4ff_alternate_modes[i].name);
 			if (count >=3D PAGE_SIZE - 1)
 				return count;
=20
 			/* Mark the currently active mode with an asterisk */
-			if (lg4ff_alternate_modes[i].product_id =3D=3D entry->product_id ||
-			    (lg4ff_alternate_modes[i].product_id =3D=3D 0 && entry->product=
_id =3D=3D entry->real_product_id))
+			if (lg4ff_alternate_modes[i].product_id =3D=3D entry->wdata.product=
_id ||
+			    (lg4ff_alternate_modes[i].product_id =3D=3D 0 && entry->wdata.p=
roduct_id =3D=3D entry->wdata.real_product_id))
 				count +=3D scnprintf(buf + count, PAGE_SIZE - count, " *\n");
 			else
 				count +=3D scnprintf(buf + count, PAGE_SIZE - count, "\n");
@@ -674,10 +770,10 @@ static ssize_t lg4ff_alternate_modes_store(struct=
 device *dev, struct device_att
 		const u16 mode_product_id =3D lg4ff_alternate_modes[i].product_id;
 		const char *tag =3D lg4ff_alternate_modes[i].tag;
=20
-		if (entry->alternate_modes & BIT(i)) {
+		if (entry->wdata.alternate_modes & BIT(i)) {
 			if (!strcmp(tag, lbuf)) {
 				if (!mode_product_id)
-					target_product_id =3D entry->real_product_id;
+					target_product_id =3D entry->wdata.real_product_id;
 				else
 					target_product_id =3D mode_product_id;
 				break;
@@ -692,24 +788,24 @@ static ssize_t lg4ff_alternate_modes_store(struct=
 device *dev, struct device_att
 	}
 	kfree(lbuf); /* Not needed anymore */
=20
-	if (target_product_id =3D=3D entry->product_id) /* Nothing to do */
+	if (target_product_id =3D=3D entry->wdata.product_id) /* Nothing to d=
o */
 		return count;
=20
 	/* Automatic switching has to be disabled for the switch to DF-EX mod=
e to work correctly */
 	if (target_product_id =3D=3D USB_DEVICE_ID_LOGITECH_WHEEL && !lg4ff_n=
o_autoswitch) {
 		hid_info(hid, "\"%s\" cannot be switched to \"DF-EX\" mode. Load the=
 \"hid_logitech\" module with \"lg4ff_no_autoswitch=3D1\" parameter set=
 and try again\n",
-			 entry->real_name);
+			 entry->wdata.real_name);
 		return -EINVAL;
 	}
=20
 	/* Take care of hardware limitations */
-	if ((entry->real_product_id =3D=3D USB_DEVICE_ID_LOGITECH_DFP_WHEEL |=
| entry->real_product_id =3D=3D USB_DEVICE_ID_LOGITECH_G25_WHEEL) &&
-	    entry->product_id > target_product_id) {
-		hid_info(hid, "\"%s\" cannot be switched back into \"%s\" mode\n", e=
ntry->real_name, lg4ff_alternate_modes[i].name);
+	if ((entry->wdata.real_product_id =3D=3D USB_DEVICE_ID_LOGITECH_DFP_W=
HEEL || entry->wdata.real_product_id =3D=3D USB_DEVICE_ID_LOGITECH_G25_=
WHEEL) &&
+	    entry->wdata.product_id > target_product_id) {
+		hid_info(hid, "\"%s\" cannot be switched back into \"%s\" mode\n", e=
ntry->wdata.real_name, lg4ff_alternate_modes[i].name);
 		return -EINVAL;
 	}
=20
-	s =3D lg4ff_get_mode_switch_command(entry->real_product_id, target_pr=
oduct_id);
+	s =3D lg4ff_get_mode_switch_command(entry->wdata.real_product_id, tar=
get_product_id);
 	if (!s) {
 		hid_err(hid, "Invalid target product ID %X\n", target_product_id);
 		return -EINVAL;
@@ -741,7 +837,7 @@ static ssize_t lg4ff_range_show(struct device *dev,=
 struct device_attribute *att
 		return 0;
 	}
=20
-	count =3D scnprintf(buf, PAGE_SIZE, "%u\n", entry->range);
+	count =3D scnprintf(buf, PAGE_SIZE, "%u\n", entry->wdata.range);
 	return count;
 }
=20
@@ -768,13 +864,13 @@ static ssize_t lg4ff_range_store(struct device *d=
ev, struct device_attribute *at
 	}
=20
 	if (range =3D=3D 0)
-		range =3D entry->max_range;
+		range =3D entry->wdata.max_range;
=20
 	/* Check if the wheel supports range setting
 	 * and that the range is within limits for the wheel */
-	if (entry->set_range !=3D NULL && range >=3D entry->min_range && rang=
e <=3D entry->max_range) {
-		entry->set_range(hid, range);
-		entry->range =3D range;
+	if (entry->wdata.set_range && range >=3D entry->wdata.min_range && ra=
nge <=3D entry->wdata.max_range) {
+		entry->wdata.set_range(hid, range);
+		entry->wdata.range =3D range;
 	}
=20
 	return count;
@@ -800,12 +896,12 @@ static ssize_t lg4ff_real_id_show(struct device *=
dev, struct device_attribute *a
 		return 0;
 	}
=20
-	if (!entry->real_tag || !entry->real_name) {
+	if (!entry->wdata.real_tag || !entry->wdata.real_name) {
 		hid_err(hid, "NULL pointer to string\n");
 		return 0;
 	}
=20
-	count =3D scnprintf(buf, PAGE_SIZE, "%s: %s\n", entry->real_tag, entr=
y->real_name);
+	count =3D scnprintf(buf, PAGE_SIZE, "%s: %s\n", entry->wdata.real_tag=
, entry->wdata.real_name);
 	return count;
 }
=20
@@ -821,8 +917,24 @@ static void lg4ff_set_leds(struct hid_device *hid,=
 u8 leds)
 {
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
+	struct lg_drv_data *drv_data =3D hid_get_drvdata(hid);
+	struct lg4ff_device_entry *entry;
 	s32 *value =3D report->field[0]->value;
+	unsigned long flags;
+
+	drv_data =3D hid_get_drvdata(hid);
+	if (!drv_data) {
+		hid_err(hid, "Private driver data not found!\n");
+		return;
+	}
=20
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
@@ -831,6 +943,7 @@ static void lg4ff_set_leds(struct hid_device *hid, =
u8 leds)
 	value[5] =3D 0x00;
 	value[6] =3D 0x00;
 	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+	spin_unlock_irqrestore(&entry->report_lock, flags);
 }
=20
 static void lg4ff_led_set_brightness(struct led_classdev *led_cdev,
@@ -855,15 +968,15 @@ static void lg4ff_led_set_brightness(struct led_c=
lassdev *led_cdev,
 	}
=20
 	for (i =3D 0; i < 5; i++) {
-		if (led_cdev !=3D entry->led[i])
+		if (led_cdev !=3D entry->wdata.led[i])
 			continue;
-		state =3D (entry->led_state >> i) & 1;
+		state =3D (entry->wdata.led_state >> i) & 1;
 		if (value =3D=3D LED_OFF && state) {
-			entry->led_state &=3D ~(1 << i);
-			lg4ff_set_leds(hid, entry->led_state);
+			entry->wdata.led_state &=3D ~(1 << i);
+			lg4ff_set_leds(hid, entry->wdata.led_state);
 		} else if (value !=3D LED_OFF && !state) {
-			entry->led_state |=3D 1 << i;
-			lg4ff_set_leds(hid, entry->led_state);
+			entry->wdata.led_state |=3D 1 << i;
+			lg4ff_set_leds(hid, entry->wdata.led_state);
 		}
 		break;
 	}
@@ -890,8 +1003,8 @@ static enum led_brightness lg4ff_led_get_brightnes=
s(struct led_classdev *led_cde
 	}
=20
 	for (i =3D 0; i < 5; i++)
-		if (led_cdev =3D=3D entry->led[i]) {
-			value =3D (entry->led_state >> i) & 1;
+		if (led_cdev =3D=3D entry->wdata.led[i]) {
+			value =3D (entry->wdata.led_state >> i) & 1;
 			break;
 		}
=20
@@ -1002,6 +1115,17 @@ int lg4ff_init(struct hid_device *hid)
 	if (!hid_validate_values(hid, HID_OUTPUT_REPORT, 0, 0, 7))
 		return -1;
=20
+	drv_data =3D hid_get_drvdata(hid);
+	if (!drv_data) {
+		hid_err(hid, "Cannot add device, private driver data not allocated\n=
");
+		return -1;
+	}
+	entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+	spin_lock_init(&entry->report_lock);
+	drv_data->device_props =3D entry;
+
 	/* Check if a multimode wheel has been connected and
 	 * handle it appropriately */
 	mmode_ret =3D lg4ff_handle_multimode_wheel(hid, &real_product_id, bcd=
Device);
@@ -1011,6 +1135,11 @@ int lg4ff_init(struct hid_device *hid)
 	 */
 	if (mmode_ret =3D=3D LG4FF_MMODE_SWITCHED)
 		return 0;
+	else if (mmode_ret < 0) {
+		hid_err(hid, "Unable to switch device mode during initialization, er=
rno %d\n", mmode_ret);
+		error =3D mmode_ret;
+		goto err_init;
+	}
=20
 	/* Check what wheel has been connected */
 	for (i =3D 0; i < ARRAY_SIZE(lg4ff_devices); i++) {
@@ -1022,7 +1151,8 @@ int lg4ff_init(struct hid_device *hid)
=20
 	if (i =3D=3D ARRAY_SIZE(lg4ff_devices)) {
 		hid_err(hid, "This device is flagged to be handled by the lg4ff modu=
le but this module does not know how to handle it. Please report this a=
s a bug to LKML, Simon Wood <simon@mungewell.org> or Michal Maly <madca=
txster@devoid-pointer.net>\n");
-		return -1;
+		error =3D -1;
+		goto err_init;
 	}
=20
 	if (mmode_ret =3D=3D LG4FF_MMODE_IS_MULTIMODE) {
@@ -1033,7 +1163,8 @@ int lg4ff_init(struct hid_device *hid)
=20
 		if (mmode_idx =3D=3D ARRAY_SIZE(lg4ff_multimode_wheels)) {
 			hid_err(hid, "Device product ID %X is not listed as a multimode whe=
el", real_product_id);
-			return -1;
+			error =3D -1;
+			goto err_init;
 		}
 	}
=20
@@ -1044,33 +1175,18 @@ int lg4ff_init(struct hid_device *hid)
 	error =3D input_ff_create_memless(dev, NULL, lg4ff_play);
=20
 	if (error)
-		return error;
-
-	/* Get private driver data */
-	drv_data =3D hid_get_drvdata(hid);
-	if (!drv_data) {
-		hid_err(hid, "Cannot add device, private driver data not allocated\n=
");
-		return -1;
-	}
+		goto err_init;
=20
-	/* Initialize device properties */
-	entry =3D kzalloc(sizeof(struct lg4ff_device_entry), GFP_KERNEL);
-	if (!entry) {
-		hid_err(hid, "Cannot add device, insufficient memory to allocate dev=
ice properties.\n");
-		return -ENOMEM;
-	}
-	drv_data->device_props =3D entry;
-
-	entry->product_id =3D lg4ff_devices[i].product_id;
-	entry->real_product_id =3D real_product_id;
-	entry->min_range =3D lg4ff_devices[i].min_range;
-	entry->max_range =3D lg4ff_devices[i].max_range;
-	entry->set_range =3D lg4ff_devices[i].set_range;
+	entry->wdata.product_id =3D lg4ff_devices[i].product_id;
+	entry->wdata.real_product_id =3D real_product_id;
+	entry->wdata.min_range =3D lg4ff_devices[i].min_range;
+	entry->wdata.max_range =3D lg4ff_devices[i].max_range;
+	entry->wdata.set_range =3D lg4ff_devices[i].set_range;
 	if (mmode_ret =3D=3D LG4FF_MMODE_IS_MULTIMODE) {
 		BUG_ON(mmode_idx =3D=3D -1);
-		entry->alternate_modes =3D lg4ff_multimode_wheels[mmode_idx].alterna=
te_modes;
-		entry->real_tag =3D lg4ff_multimode_wheels[mmode_idx].real_tag;
-		entry->real_name =3D lg4ff_multimode_wheels[mmode_idx].real_name;
+		entry->wdata.alternate_modes =3D lg4ff_multimode_wheels[mmode_idx].a=
lternate_modes;
+		entry->wdata.real_tag =3D lg4ff_multimode_wheels[mmode_idx].real_tag=
;
+		entry->wdata.real_name =3D lg4ff_multimode_wheels[mmode_idx].real_na=
me;
 	}
=20
 	/* Check if autocentering is available and
@@ -1089,27 +1205,32 @@ int lg4ff_init(struct hid_device *hid)
 	/* Create sysfs interface */
 	error =3D device_create_file(&hid->dev, &dev_attr_range);
 	if (error)
-		return error;
+		goto err_init;
 	if (mmode_ret =3D=3D LG4FF_MMODE_IS_MULTIMODE) {
 		error =3D device_create_file(&hid->dev, &dev_attr_real_id);
-		if (error)
-			return error;
+		if (error) {
+			device_remove_file(&hid->dev, &dev_attr_range);
+			goto err_init;
+		}
 		error =3D device_create_file(&hid->dev, &dev_attr_alternate_modes);
-		if (error)
-			return error;
+		if (error) {
+			device_remove_file(&hid->dev, &dev_attr_real_id);
+			device_remove_file(&hid->dev, &dev_attr_range);
+			goto err_init;
+		}
 	}
 	dbg_hid("sysfs interface created\n");
=20
 	/* Set the maximum range to start with */
-	entry->range =3D entry->max_range;
-	if (entry->set_range !=3D NULL)
-		entry->set_range(hid, entry->range);
+	entry->wdata.range =3D entry->wdata.max_range;
+	if (entry->wdata.set_range)
+		entry->wdata.set_range(hid, entry->wdata.range);
=20
 #ifdef CONFIG_LEDS_CLASS
 	/* register led subsystem - G27 only */
-	entry->led_state =3D 0;
+	entry->wdata.led_state =3D 0;
 	for (j =3D 0; j < 5; j++)
-		entry->led[j] =3D NULL;
+		entry->wdata.led[j] =3D NULL;
=20
 	if (lg4ff_devices[i].product_id =3D=3D USB_DEVICE_ID_LOGITECH_G27_WHE=
EL) {
 		struct led_classdev *led;
@@ -1124,7 +1245,7 @@ int lg4ff_init(struct hid_device *hid)
 			led =3D kzalloc(sizeof(struct led_classdev)+name_sz, GFP_KERNEL);
 			if (!led) {
 				hid_err(hid, "can't allocate memory for LED %d\n", j);
-				goto err;
+				goto err_leds;
 			}
=20
 			name =3D (void *)(&led[1]);
@@ -1135,16 +1256,16 @@ int lg4ff_init(struct hid_device *hid)
 			led->brightness_get =3D lg4ff_led_get_brightness;
 			led->brightness_set =3D lg4ff_led_set_brightness;
=20
-			entry->led[j] =3D led;
+			entry->wdata.led[j] =3D led;
 			error =3D led_classdev_register(&hid->dev, led);
=20
 			if (error) {
 				hid_err(hid, "failed to register LED %d. Aborting.\n", j);
-err:
+err_leds:
 				/* Deregister LEDs (if any) */
 				for (j =3D 0; j < 5; j++) {
-					led =3D entry->led[j];
-					entry->led[j] =3D NULL;
+					led =3D entry->wdata.led[j];
+					entry->wdata.led[j] =3D NULL;
 					if (!led)
 						continue;
 					led_classdev_unregister(led);
@@ -1158,6 +1279,11 @@ out:
 #endif
 	hid_info(hid, "Force feedback support for Logitech Gaming Wheels\n");
 	return 0;
+
+err_init:
+	drv_data->device_props =3D NULL;
+	kfree(entry);
+	return error;
 }
=20
 int lg4ff_deinit(struct hid_device *hid)
@@ -1174,14 +1300,19 @@ int lg4ff_deinit(struct hid_device *hid)
 	if (!entry)
 		goto out; /* Nothing more to do */
=20
-	device_remove_file(&hid->dev, &dev_attr_range);
-
 	/* Multimode devices will have at least the "MODE_NATIVE" bit set */
-	if (entry->alternate_modes) {
+	if (entry->wdata.alternate_modes) {
 		device_remove_file(&hid->dev, &dev_attr_real_id);
 		device_remove_file(&hid->dev, &dev_attr_alternate_modes);
 	}
=20
+	device_remove_file(&hid->dev, &dev_attr_range);
+
+	/* Make sure that nothing will try to touch the device while it is
+	 * being removed */
+	hid_hw_stop(hid);
+	drv_data->device_props =3D NULL;
+
 #ifdef CONFIG_LEDS_CLASS
 	{
 		int j;
@@ -1190,8 +1321,8 @@ int lg4ff_deinit(struct hid_device *hid)
 		/* Deregister LEDs (if any) */
 		for (j =3D 0; j < 5; j++) {
=20
-			led =3D entry->led[j];
-			entry->led[j] =3D NULL;
+			led =3D entry->wdata.led[j];
+			entry->wdata.led[j] =3D NULL;
 			if (!led)
 				continue;
 			led_classdev_unregister(led);
@@ -1200,9 +1331,7 @@ int lg4ff_deinit(struct hid_device *hid)
 	}
 #endif
=20
-	/* Deallocate memory */
 	kfree(entry);
-
 out:
 	dbg_hid("Device successfully unregistered\n");
 	return 0;
--=20
2.3.3
