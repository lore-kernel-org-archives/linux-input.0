From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/3] HID: wacom: use wacom_wac_finger_count_touches to set touch_down
Date: Fri, 20 Mar 2015 14:57:21 -0700
Message-ID: <1426888641-8695-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34641 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045AbbCTV5Y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Mar 2015 17:57:24 -0400
Received: by pdbni2 with SMTP id ni2so120343133pdb.1
        for <linux-input@vger.kernel.org>; Fri, 20 Mar 2015 14:57:23 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: benjamin.tissoires@gmail.com, jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

Counting number of touching fingers by wacom_wac_finger_count_touches
so we don't have to count them inside individual routines.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/hid/wacom_wac.c | 84 +++++++++++++++++++------------------------------
 1 file changed, 33 insertions(+), 51 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 3b01dc9..60d9ccb 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1038,6 +1038,28 @@ static int wacom_intuos_bt_irq(struct wacom_wac *wacom, size_t len)
 	return 0;
 }
 
+static int wacom_wac_finger_count_touches(struct wacom_wac *wacom)
+{
+	struct input_dev *input = wacom->input;
+	unsigned touch_max = wacom->features.touch_max;
+	int count = 0;
+	int i;
+
+	/* non-HID_GENERIC single touch input doesn't call this routine */
+	if ((touch_max == 1) && (wacom->features.type == HID_GENERIC))
+		return wacom->hid_data.tipswitch &&
+		       !wacom->shared->stylus_in_proximity;
+
+	for (i = 0; i < input->mt->num_slots; i++) {
+		struct input_mt_slot *ps = &input->mt->slots[i];
+		int id = input_mt_get_value(ps, ABS_MT_TRACKING_ID);
+		if (id >= 0)
+			count++;
+	}
+
+	return count;
+}
+
 static int wacom_24hdt_irq(struct wacom_wac *wacom)
 {
 	struct input_dev *input = wacom->input;
@@ -1048,7 +1070,6 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
 	int num_contacts_left = 4; /* maximum contacts per packet */
 	int byte_per_packet = WACOM_BYTES_PER_24HDT_PACKET;
 	int y_offset = 2;
-	static int contact_with_no_pen_down_count = 0;
 
 	if (wacom->features.type == WACOM_27QHDT) {
 		current_num_contacts = data[63];
@@ -1061,10 +1082,8 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
 	 * First packet resets the counter since only the first
 	 * packet in series will have non-zero current_num_contacts.
 	 */
-	if (current_num_contacts) {
+	if (current_num_contacts)
 		wacom->num_contacts_left = current_num_contacts;
-		contact_with_no_pen_down_count = 0;
-	}
 
 	contacts_to_send = min(num_contacts_left, wacom->num_contacts_left);
 
@@ -1097,7 +1116,6 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
 				input_report_abs(input, ABS_MT_WIDTH_MINOR, min(w, h));
 				input_report_abs(input, ABS_MT_ORIENTATION, w > h);
 			}
-			contact_with_no_pen_down_count++;
 		}
 	}
 	input_mt_report_pointer_emulation(input, true);
@@ -1105,7 +1123,7 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
 	wacom->num_contacts_left -= contacts_to_send;
 	if (wacom->num_contacts_left <= 0) {
 		wacom->num_contacts_left = 0;
-		wacom->shared->touch_down = (contact_with_no_pen_down_count > 0);
+		wacom->shared->touch_down = wacom_wac_finger_count_touches(wacom);
 	}
 	return 1;
 }
@@ -1118,7 +1136,6 @@ static int wacom_mt_touch(struct wacom_wac *wacom)
 	int current_num_contacts = data[2];
 	int contacts_to_send = 0;
 	int x_offset = 0;
-	static int contact_with_no_pen_down_count = 0;
 
 	/* MTTPC does not support Height and Width */
 	if (wacom->features.type == MTTPC || wacom->features.type == MTTPC_B)
@@ -1128,10 +1145,8 @@ static int wacom_mt_touch(struct wacom_wac *wacom)
 	 * First packet resets the counter since only the first
 	 * packet in series will have non-zero current_num_contacts.
 	 */
-	if (current_num_contacts) {
+	if (current_num_contacts)
 		wacom->num_contacts_left = current_num_contacts;
-		contact_with_no_pen_down_count = 0;
-	}
 
 	/* There are at most 5 contacts per packet */
 	contacts_to_send = min(5, wacom->num_contacts_left);
@@ -1152,7 +1167,6 @@ static int wacom_mt_touch(struct wacom_wac *wacom)
 			int y = get_unaligned_le16(&data[offset + x_offset + 9]);
 			input_report_abs(input, ABS_MT_POSITION_X, x);
 			input_report_abs(input, ABS_MT_POSITION_Y, y);
-			contact_with_no_pen_down_count++;
 		}
 	}
 	input_mt_report_pointer_emulation(input, true);
@@ -1160,7 +1174,7 @@ static int wacom_mt_touch(struct wacom_wac *wacom)
 	wacom->num_contacts_left -= contacts_to_send;
 	if (wacom->num_contacts_left <= 0) {
 		wacom->num_contacts_left = 0;
-		wacom->shared->touch_down = (contact_with_no_pen_down_count > 0);
+		wacom->shared->touch_down = wacom_wac_finger_count_touches(wacom);
 	}
 	return 1;
 }
@@ -1169,7 +1183,6 @@ static int wacom_tpc_mt_touch(struct wacom_wac *wacom)
 {
 	struct input_dev *input = wacom->input;
 	unsigned char *data = wacom->data;
-	int contact_with_no_pen_down_count = 0;
 	int i;
 
 	for (i = 0; i < 2; i++) {
@@ -1184,13 +1197,12 @@ static int wacom_tpc_mt_touch(struct wacom_wac *wacom)
 
 			input_report_abs(input, ABS_MT_POSITION_X, x);
 			input_report_abs(input, ABS_MT_POSITION_Y, y);
-			contact_with_no_pen_down_count++;
 		}
 	}
 	input_mt_report_pointer_emulation(input, true);
 
 	/* keep touch state for pen event */
-	wacom->shared->touch_down = (contact_with_no_pen_down_count > 0);
+	wacom->shared->touch_down = wacom_wac_finger_count_touches(wacom);
 
 	return 1;
 }
@@ -1518,29 +1530,6 @@ static int wacom_wac_finger_event(struct hid_device *hdev,
 	return 0;
 }
 
-static int wacom_wac_finger_count_touches(struct hid_device *hdev)
-{
-	struct wacom *wacom = hid_get_drvdata(hdev);
-	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
-	struct input_dev *input = wacom_wac->input;
-	unsigned touch_max = wacom_wac->features.touch_max;
-	int count = 0;
-	int i;
-
-	if (touch_max == 1)
-		return wacom_wac->hid_data.tipswitch &&
-		       !wacom_wac->shared->stylus_in_proximity;
-
-	for (i = 0; i < input->mt->num_slots; i++) {
-		struct input_mt_slot *ps = &input->mt->slots[i];
-		int id = input_mt_get_value(ps, ABS_MT_TRACKING_ID);
-		if (id >= 0)
-			count++;
-	}
-
-	return count;
-}
-
 static void wacom_wac_finger_report(struct hid_device *hdev,
 		struct hid_report *report)
 {
@@ -1555,7 +1544,7 @@ static void wacom_wac_finger_report(struct hid_device *hdev,
 	input_sync(input);
 
 	/* keep touch state for pen event */
-	wacom_wac->shared->touch_down = wacom_wac_finger_count_touches(hdev);
+	wacom_wac->shared->touch_down = wacom_wac_finger_count_touches(wacom_wac);
 }
 
 void wacom_wac_usage_mapping(struct hid_device *hdev,
@@ -1615,7 +1604,6 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
 	struct input_dev *pad_input = wacom->pad_input;
 	unsigned char *data = wacom->data;
 	int i;
-	int contact_with_no_pen_down_count = 0;
 
 	if (data[0] != 0x02)
 	    return 0;
@@ -1643,7 +1631,6 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
 			}
 			input_report_abs(input, ABS_MT_POSITION_X, x);
 			input_report_abs(input, ABS_MT_POSITION_Y, y);
-			contact_with_no_pen_down_count++;
 		}
 	}
 
@@ -1653,12 +1640,12 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
 	input_report_key(pad_input, BTN_FORWARD, (data[1] & 0x04) != 0);
 	input_report_key(pad_input, BTN_BACK, (data[1] & 0x02) != 0);
 	input_report_key(pad_input, BTN_RIGHT, (data[1] & 0x01) != 0);
-	wacom->shared->touch_down = (contact_with_no_pen_down_count > 0);
+	wacom->shared->touch_down = wacom_wac_finger_count_touches(wacom);
 
 	return 1;
 }
 
-static int wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data, int last_touch_count)
+static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data)
 {
 	struct wacom_features *features = &wacom->features;
 	struct input_dev *input = wacom->input;
@@ -1666,7 +1653,7 @@ static int wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data, in
 	int slot = input_mt_get_slot_by_key(input, data[0]);
 
 	if (slot < 0)
-		return 0;
+		return;
 
 	touch = touch && !wacom->shared->stylus_in_proximity;
 
@@ -1698,9 +1685,7 @@ static int wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data, in
 		input_report_abs(input, ABS_MT_POSITION_Y, y);
 		input_report_abs(input, ABS_MT_TOUCH_MAJOR, width);
 		input_report_abs(input, ABS_MT_TOUCH_MINOR, height);
-		last_touch_count++;
 	}
-	return last_touch_count;
 }
 
 static void wacom_bpt3_button_msg(struct wacom_wac *wacom, unsigned char *data)
@@ -1725,7 +1710,6 @@ static int wacom_bpt3_touch(struct wacom_wac *wacom)
 	unsigned char *data = wacom->data;
 	int count = data[1] & 0x07;
 	int i;
-	int contact_with_no_pen_down_count = 0;
 
 	if (data[0] != 0x02)
 	    return 0;
@@ -1736,15 +1720,13 @@ static int wacom_bpt3_touch(struct wacom_wac *wacom)
 		int msg_id = data[offset];
 
 		if (msg_id >= 2 && msg_id <= 17)
-			contact_with_no_pen_down_count = 
-			    wacom_bpt3_touch_msg(wacom, data + offset,
-						 contact_with_no_pen_down_count);
+			wacom_bpt3_touch_msg(wacom, data + offset);
 		else if (msg_id == 128)
 			wacom_bpt3_button_msg(wacom, data + offset);
 
 	}
 	input_mt_report_pointer_emulation(input, true);
-	wacom->shared->touch_down = (contact_with_no_pen_down_count > 0);
+	wacom->shared->touch_down = wacom_wac_finger_count_touches(wacom);
 
 	return 1;
 }
-- 
1.9.1

