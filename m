From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/2] HID: wacom: rely on actual touch down count to decide touch_down
Date: Fri, 20 Feb 2015 14:27:30 -0800
Message-ID: <1424471250-4708-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:38179 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754759AbbBTW1l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Feb 2015 17:27:41 -0500
Received: by padbj1 with SMTP id bj1so11262782pad.5
        for <linux-input@vger.kernel.org>; Fri, 20 Feb 2015 14:27:40 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

touch_down is a flag to indicate if there are touches on tablet
or not. Since one set of touch events may be posted over more
than one data packet/touch frame, and pen may come in proximity
while touch events are partially sent, counting all touch events
for the set reflects the actual status of touch_down.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/hid/wacom_wac.c | 75 ++++++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 32 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 69827c9..cf76741 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1046,27 +1046,28 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
 	struct input_dev *input = wacom->input;
 	unsigned char *data = wacom->data;
 	int i;
-	int current_num_contacts = 0;
+	int current_num_contacts = data[61];
 	int contacts_to_send = 0;
 	int num_contacts_left = 4; /* maximum contacts per packet */
 	int byte_per_packet = WACOM_BYTES_PER_24HDT_PACKET;
 	int y_offset = 2;
+	static int contact_with_no_pen_down_count = 0;
 
 	if (wacom->features.type == WACOM_27QHDT) {
 		current_num_contacts = data[63];
 		num_contacts_left = 10;
 		byte_per_packet = WACOM_BYTES_PER_QHDTHID_PACKET;
 		y_offset = 0;
-	} else {
-		current_num_contacts = data[61];
 	}
 
 	/*
 	 * First packet resets the counter since only the first
 	 * packet in series will have non-zero current_num_contacts.
 	 */
-	if (current_num_contacts)
+	if (current_num_contacts) {
 		wacom->num_contacts_left = current_num_contacts;
+		contact_with_no_pen_down_count = 0;
+	}
 
 	contacts_to_send = min(num_contacts_left, wacom->num_contacts_left);
 
@@ -1099,15 +1100,16 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
 				input_report_abs(input, ABS_MT_WIDTH_MINOR, min(w, h));
 				input_report_abs(input, ABS_MT_ORIENTATION, w > h);
 			}
+			contact_with_no_pen_down_count++;
 		}
 	}
 	input_mt_report_pointer_emulation(input, true);
 
 	wacom->num_contacts_left -= contacts_to_send;
-	if (wacom->num_contacts_left <= 0)
+	if (wacom->num_contacts_left <= 0) {
 		wacom->num_contacts_left = 0;
-
-	wacom->shared->touch_down = (wacom->num_contacts_left > 0);
+		wacom->shared->touch_down = (contact_with_no_pen_down_count > 0);
+	}
 	return 1;
 }
 
@@ -1119,6 +1121,7 @@ static int wacom_mt_touch(struct wacom_wac *wacom)
 	int current_num_contacts = data[2];
 	int contacts_to_send = 0;
 	int x_offset = 0;
+	static int contact_with_no_pen_down_count = 0;
 
 	/* MTTPC does not support Height and Width */
 	if (wacom->features.type == MTTPC || wacom->features.type == MTTPC_B)
@@ -1128,8 +1131,10 @@ static int wacom_mt_touch(struct wacom_wac *wacom)
 	 * First packet resets the counter since only the first
 	 * packet in series will have non-zero current_num_contacts.
 	 */
-	if (current_num_contacts)
+	if (current_num_contacts) {
 		wacom->num_contacts_left = current_num_contacts;
+		contact_with_no_pen_down_count = 0;
+	}
 
 	/* There are at most 5 contacts per packet */
 	contacts_to_send = min(5, wacom->num_contacts_left);
@@ -1150,15 +1155,16 @@ static int wacom_mt_touch(struct wacom_wac *wacom)
 			int y = get_unaligned_le16(&data[offset + x_offset + 9]);
 			input_report_abs(input, ABS_MT_POSITION_X, x);
 			input_report_abs(input, ABS_MT_POSITION_Y, y);
+			contact_with_no_pen_down_count++;
 		}
 	}
 	input_mt_report_pointer_emulation(input, true);
 
 	wacom->num_contacts_left -= contacts_to_send;
-	if (wacom->num_contacts_left < 0)
+	if (wacom->num_contacts_left <= 0) {
 		wacom->num_contacts_left = 0;
-
-	wacom->shared->touch_down = (wacom->num_contacts_left > 0);
+		wacom->shared->touch_down = (contact_with_no_pen_down_count > 0);
+	}
 	return 1;
 }
 
@@ -1196,29 +1202,25 @@ static int wacom_tpc_single_touch(struct wacom_wac *wacom, size_t len)
 {
 	unsigned char *data = wacom->data;
 	struct input_dev *input = wacom->input;
-	bool prox;
+	bool prox = !wacom->shared->stylus_in_proximity;
 	int x = 0, y = 0;
 
 	if (wacom->features.touch_max > 1 || len > WACOM_PKGLEN_TPC2FG)
 		return 0;
 
-	if (!wacom->shared->stylus_in_proximity) {
-		if (len == WACOM_PKGLEN_TPC1FG) {
-			prox = data[0] & 0x01;
-			x = get_unaligned_le16(&data[1]);
-			y = get_unaligned_le16(&data[3]);
-		} else if (len == WACOM_PKGLEN_TPC1FG_B) {
-			prox = data[2] & 0x01;
-			x = get_unaligned_le16(&data[3]);
-			y = get_unaligned_le16(&data[5]);
-		} else {
-			prox = data[1] & 0x01;
-			x = le16_to_cpup((__le16 *)&data[2]);
-			y = le16_to_cpup((__le16 *)&data[4]);
-		}
-	} else
-		/* force touch out when pen is in prox */
-		prox = 0;
+	if (len == WACOM_PKGLEN_TPC1FG) {
+		prox = prox && (data[0] & 0x01);
+		x = get_unaligned_le16(&data[1]);
+		y = get_unaligned_le16(&data[3]);
+	} else if (len == WACOM_PKGLEN_TPC1FG_B) {
+		prox = prox && (data[2] & 0x01);
+		x = get_unaligned_le16(&data[3]);
+		y = get_unaligned_le16(&data[5]);
+	} else {
+		prox = prox && (data[1] & 0x01);
+		x = le16_to_cpup((__le16 *)&data[2]);
+		y = le16_to_cpup((__le16 *)&data[4]);
+	}
 
 	if (prox) {
 		input_report_abs(input, ABS_X, x);
@@ -1616,6 +1618,7 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
 	struct input_dev *pad_input = wacom->pad_input;
 	unsigned char *data = wacom->data;
 	int i;
+	int contact_with_no_pen_down_count = 0;
 
 	if (data[0] != 0x02)
 	    return 0;
@@ -1643,6 +1646,7 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
 			}
 			input_report_abs(input, ABS_MT_POSITION_X, x);
 			input_report_abs(input, ABS_MT_POSITION_Y, y);
+			contact_with_no_pen_down_count++;
 		}
 	}
 
@@ -1652,11 +1656,12 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
 	input_report_key(pad_input, BTN_FORWARD, (data[1] & 0x04) != 0);
 	input_report_key(pad_input, BTN_BACK, (data[1] & 0x02) != 0);
 	input_report_key(pad_input, BTN_RIGHT, (data[1] & 0x01) != 0);
+	wacom->shared->touch_down = (contact_with_no_pen_down_count > 0);
 
 	return 1;
 }
 
-static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data)
+static int wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data, int last_touch_count)
 {
 	struct wacom_features *features = &wacom->features;
 	struct input_dev *input = wacom->input;
@@ -1664,7 +1669,7 @@ static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data)
 	int slot = input_mt_get_slot_by_key(input, data[0]);
 
 	if (slot < 0)
-		return;
+		return 0;
 
 	touch = touch && !wacom->shared->stylus_in_proximity;
 
@@ -1696,7 +1701,9 @@ static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data)
 		input_report_abs(input, ABS_MT_POSITION_Y, y);
 		input_report_abs(input, ABS_MT_TOUCH_MAJOR, width);
 		input_report_abs(input, ABS_MT_TOUCH_MINOR, height);
+		last_touch_count++;
 	}
+	return last_touch_count;
 }
 
 static void wacom_bpt3_button_msg(struct wacom_wac *wacom, unsigned char *data)
@@ -1721,6 +1728,7 @@ static int wacom_bpt3_touch(struct wacom_wac *wacom)
 	unsigned char *data = wacom->data;
 	int count = data[1] & 0x07;
 	int i;
+	int contact_with_no_pen_down_count = 0;
 
 	if (data[0] != 0x02)
 	    return 0;
@@ -1731,12 +1739,15 @@ static int wacom_bpt3_touch(struct wacom_wac *wacom)
 		int msg_id = data[offset];
 
 		if (msg_id >= 2 && msg_id <= 17)
-			wacom_bpt3_touch_msg(wacom, data + offset);
+			contact_with_no_pen_down_count = 
+			    wacom_bpt3_touch_msg(wacom, data + offset,
+						 contact_with_no_pen_down_count);
 		else if (msg_id == 128)
 			wacom_bpt3_button_msg(wacom, data + offset);
 
 	}
 	input_mt_report_pointer_emulation(input, true);
+	wacom->shared->touch_down = (contact_with_no_pen_down_count > 0);
 
 	return 1;
 }
-- 
1.9.1

