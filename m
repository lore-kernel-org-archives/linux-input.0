From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH 01/12] HID: hid-lg4ff: (Cleanup) Remove double underscore prefix from numeric types.
Date: Sat, 21 Mar 2015 12:47:31 +0100
Message-ID: <1426938462-884-2-git-send-email-madcatxster@devoid-pointer.net>
References: <1426938462-884-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devoid-pointer.net ([31.31.77.140]:59544 "EHLO
	smtp.devoid-pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbbCULsV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Mar 2015 07:48:21 -0400
In-Reply-To: <1426938462-884-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, elias.vds@gmail.com, simon@mungewell.org, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>

This code will never be used outside the kernel so the prefixes are
unnecessary.

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/hid/hid-lg4ff.c | 52 ++++++++++++++++++++++++-----------------=
--------
 drivers/hid/hid-lg4ff.h |  4 ++--
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 1232210..70e5ae6 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -72,12 +72,12 @@ static void hid_lg4ff_set_range_dfp(struct hid_devi=
ce *hid, u16 range);
 static void hid_lg4ff_set_range_g25(struct hid_device *hid, u16 range)=
;
=20
 struct lg4ff_device_entry {
-	__u32 product_id;
-	__u16 range;
-	__u16 min_range;
-	__u16 max_range;
+	u32 product_id;
+	u16 range;
+	u16 min_range;
+	u16 max_range;
 #ifdef CONFIG_LEDS_CLASS
-	__u8  led_state;
+	u8  led_state;
 	struct led_classdev *led[5];
 #endif
 	u32 alternate_modes;
@@ -95,16 +95,16 @@ static const signed short lg4ff_wheel_effects[] =3D=
 {
 };
=20
 struct lg4ff_wheel {
-	const __u32 product_id;
+	const u32 product_id;
 	const signed short *ff_effects;
-	const __u16 min_range;
-	const __u16 max_range;
+	const u16 min_range;
+	const u16 max_range;
 	void (*set_range)(struct hid_device *hid, u16 range);
 };
=20
 struct lg4ff_compat_mode_switch {
-	const __u8 cmd_count;	/* Number of commands to send */
-	const __u8 cmd[];
+	const u8 cmd_count;	/* Number of commands to send */
+	const u8 cmd[];
 };
=20
 struct lg4ff_wheel_ident_info {
@@ -245,10 +245,10 @@ static const struct lg4ff_compat_mode_switch lg4f=
f_mode_switch_ext16_g25 =3D {
 };
=20
 /* Recalculates X axis value accordingly to currently selected range *=
/
-static __s32 lg4ff_adjust_dfp_x_axis(__s32 value, __u16 range)
+static s32 lg4ff_adjust_dfp_x_axis(s32 value, u16 range)
 {
-	__u16 max_range;
-	__s32 new_value;
+	u16 max_range;
+	s32 new_value;
=20
 	if (range =3D=3D 900)
 		return value;
@@ -269,10 +269,10 @@ static __s32 lg4ff_adjust_dfp_x_axis(__s32 value,=
 __u16 range)
 }
=20
 int lg4ff_adjust_input_event(struct hid_device *hid, struct hid_field =
*field,
-			     struct hid_usage *usage, __s32 value, struct lg_drv_data *drv_=
data)
+			     struct hid_usage *usage, s32 value, struct lg_drv_data *drv_da=
ta)
 {
 	struct lg4ff_device_entry *entry =3D drv_data->device_props;
-	__s32 new_value =3D 0;
+	s32 new_value =3D 0;
=20
 	if (!entry) {
 		hid_err(hid, "Device properties not found");
@@ -299,7 +299,7 @@ static int hid_lg4ff_play(struct input_dev *dev, vo=
id *data, struct ff_effect *e
 	struct hid_device *hid =3D input_get_drvdata(dev);
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
-	__s32 *value =3D report->field[0]->value;
+	s32 *value =3D report->field[0]->value;
 	int x;
=20
 #define CLAMP(x) do { if (x < 0) x =3D 0; else if (x > 0xff) x =3D 0xf=
f; } while (0)
@@ -344,8 +344,8 @@ static void hid_lg4ff_set_autocenter_default(struct=
 input_dev *dev, u16 magnitud
 	struct hid_device *hid =3D input_get_drvdata(dev);
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
-	__s32 *value =3D report->field[0]->value;
-	__u32 expand_a, expand_b;
+	s32 *value =3D report->field[0]->value;
+	u32 expand_a, expand_b;
 	struct lg4ff_device_entry *entry;
 	struct lg_drv_data *drv_data;
=20
@@ -421,7 +421,7 @@ static void hid_lg4ff_set_autocenter_ffex(struct in=
put_dev *dev, u16 magnitude)
 	struct hid_device *hid =3D input_get_drvdata(dev);
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
-	__s32 *value =3D report->field[0]->value;
+	s32 *value =3D report->field[0]->value;
 	magnitude =3D magnitude * 90 / 65535;
=20
 	value[0] =3D 0xfe;
@@ -440,7 +440,7 @@ static void hid_lg4ff_set_range_g25(struct hid_devi=
ce *hid, u16 range)
 {
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
-	__s32 *value =3D report->field[0]->value;
+	s32 *value =3D report->field[0]->value;
=20
 	dbg_hid("G25/G27/DFGT: setting range to %u\n", range);
=20
@@ -456,12 +456,12 @@ static void hid_lg4ff_set_range_g25(struct hid_de=
vice *hid, u16 range)
 }
=20
 /* Sends commands to set range compatible with Driving Force Pro wheel=
 */
-static void hid_lg4ff_set_range_dfp(struct hid_device *hid, __u16 rang=
e)
+static void hid_lg4ff_set_range_dfp(struct hid_device *hid, u16 range)
 {
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
 	int start_left, start_right, full_range;
-	__s32 *value =3D report->field[0]->value;
+	s32 *value =3D report->field[0]->value;
=20
 	dbg_hid("Driving Force Pro: setting range to %u\n", range);
=20
@@ -571,7 +571,7 @@ static int lg4ff_switch_compatibility_mode(struct h=
id_device *hid, const struct
 {
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
-	__s32 *value =3D report->field[0]->value;
+	s32 *value =3D report->field[0]->value;
 	u8 i;
=20
 	for (i =3D 0; i < s->cmd_count; i++) {
@@ -754,7 +754,7 @@ static ssize_t range_store(struct device *dev, stru=
ct device_attribute *attr,
 	struct hid_device *hid =3D to_hid_device(dev);
 	struct lg4ff_device_entry *entry;
 	struct lg_drv_data *drv_data;
-	__u16 range =3D simple_strtoul(buf, NULL, 10);
+	u16 range =3D simple_strtoul(buf, NULL, 10);
=20
 	drv_data =3D hid_get_drvdata(hid);
 	if (!drv_data) {
@@ -818,11 +818,11 @@ static ssize_t lg4ff_real_id_store(struct device =
*dev, struct device_attribute *
 static DEVICE_ATTR(real_id, S_IRUGO, lg4ff_real_id_show, lg4ff_real_id=
_store);
=20
 #ifdef CONFIG_LEDS_CLASS
-static void lg4ff_set_leds(struct hid_device *hid, __u8 leds)
+static void lg4ff_set_leds(struct hid_device *hid, u8 leds)
 {
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
-	__s32 *value =3D report->field[0]->value;
+	s32 *value =3D report->field[0]->value;
=20
 	value[0] =3D 0xf8;
 	value[1] =3D 0x12;
diff --git a/drivers/hid/hid-lg4ff.h b/drivers/hid/hid-lg4ff.h
index 5b6a508..66201af 100644
--- a/drivers/hid/hid-lg4ff.h
+++ b/drivers/hid/hid-lg4ff.h
@@ -5,12 +5,12 @@
 extern int lg4ff_no_autoswitch; /* From hid-lg.c */
=20
 int lg4ff_adjust_input_event(struct hid_device *hid, struct hid_field =
*field,
-			     struct hid_usage *usage, __s32 value, struct lg_drv_data *drv_=
data);
+			     struct hid_usage *usage, s32 value, struct lg_drv_data *drv_da=
ta);
 int lg4ff_init(struct hid_device *hdev);
 int lg4ff_deinit(struct hid_device *hdev);
 #else
 static inline int lg4ff_adjust_input_event(struct hid_device *hid, str=
uct hid_field *field,
-					   struct hid_usage *usage, __s32 value, struct lg_drv_data *drv_=
data) { return 0; }
+					   struct hid_usage *usage, s32 value, struct lg_drv_data *drv_da=
ta) { return 0; }
 static inline int lg4ff_init(struct hid_device *hdev) { return -1; }
 static inline int lg4ff_deinit(struct hid_device *hdev) { return -1; }
 #endif
--=20
2.3.3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
