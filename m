From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/2] input: wacom - use new input-mt routines
Date: Tue,  4 Dec 2012 18:44:14 -0800
Message-ID: <1354675454-32465-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:62879 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978Ab2LECoV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Dec 2012 21:44:21 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so3217841pad.19
        for <linux-input@vger.kernel.org>; Tue, 04 Dec 2012 18:44:20 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: rydberg@euromail.se, Ping Cheng <pingc@wacom.com>

This patch brings wacom driver in-sync with input-mt changes
made in release 3.7.

Signed-off-by: Ping Cheng <pingc@wacom.com>
Reviewed-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/input/tablet/wacom_wac.c |   82 ++++++++++----------------------------
 drivers/input/tablet/wacom_wac.h |    1 -
 2 files changed, 22 insertions(+), 61 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 097b559..a318bf4 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -785,25 +785,6 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 	return 1;
 }
 
-static int find_slot_from_contactid(struct wacom_wac *wacom, int contactid)
-{
-	int touch_max = wacom->features.touch_max;
-	int i;
-
-	if (!wacom->slots)
-		return -1;
-
-	for (i = 0; i < touch_max; ++i) {
-		if (wacom->slots[i] == contactid)
-			return i;
-	}
-	for (i = 0; i < touch_max; ++i) {
-		if (wacom->slots[i] == -1)
-			return i;
-	}
-	return -1;
-}
-
 static int int_dist(int x1, int y1, int x2, int y2)
 {
 	int x = x2 - x1;
@@ -833,8 +814,7 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
 	for (i = 0; i < contacts_to_send; i++) {
 		int offset = (WACOM_BYTES_PER_24HDT_PACKET * i) + 1;
 		bool touch = data[offset] & 0x1 && !wacom->shared->stylus_in_proximity;
-		int id = data[offset + 1];
-		int slot = find_slot_from_contactid(wacom, id);
+		int slot = input_mt_get_slot_by_key(input, data[offset + 1]);
 
 		if (slot < 0)
 			continue;
@@ -856,9 +836,7 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
 			input_report_abs(input, ABS_MT_WIDTH_MINOR, min(w, h));
 			input_report_abs(input, ABS_MT_ORIENTATION, w > h);
 		}
-		wacom->slots[slot] = touch ? id : -1;
 	}
-
 	input_mt_report_pointer_emulation(input, true);
 
 	wacom->num_contacts_left -= contacts_to_send;
@@ -895,7 +873,7 @@ static int wacom_mt_touch(struct wacom_wac *wacom)
 		int offset = (WACOM_BYTES_PER_MT_PACKET + x_offset) * i + 3;
 		bool touch = data[offset] & 0x1;
 		int id = le16_to_cpup((__le16 *)&data[offset + 1]);
-		int slot = find_slot_from_contactid(wacom, id);
+		int slot = input_mt_get_slot_by_key(input, id);
 
 		if (slot < 0)
 			continue;
@@ -908,9 +886,7 @@ static int wacom_mt_touch(struct wacom_wac *wacom)
 			input_report_abs(input, ABS_MT_POSITION_X, x);
 			input_report_abs(input, ABS_MT_POSITION_Y, y);
 		}
-		wacom->slots[slot] = touch ? id : -1;
 	}
-
 	input_mt_report_pointer_emulation(input, true);
 
 	wacom->num_contacts_left -= contacts_to_send;
@@ -942,12 +918,11 @@ static int wacom_tpc_mt_touch(struct wacom_wac *wacom)
 			contact_with_no_pen_down_count++;
 		}
 	}
+	input_mt_report_pointer_emulation(input, true);
 
 	/* keep touch state for pen event */
 	wacom->shared->touch_down = (contact_with_no_pen_down_count > 0);
 
-	input_mt_report_pointer_emulation(input, true);
-
 	return 1;
 }
 
@@ -1104,12 +1079,15 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
 static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data)
 {
 	struct input_dev *input = wacom->input;
-	int slot_id = data[0] - 2;  /* data[0] is between 2 and 17 */
 	bool touch = data[1] & 0x80;
+	int slot = input_mt_get_slot_by_key(input, data[0]);
+
+	if (slot < 0)
+		return;
 
 	touch = touch && !wacom->shared->stylus_in_proximity;
 
-	input_mt_slot(input, slot_id);
+	input_mt_slot(input, slot);
 	input_mt_report_slot_state(input, MT_TOOL_FINGER, touch);
 
 	if (touch) {
@@ -1162,7 +1140,6 @@ static int wacom_bpt3_touch(struct wacom_wac *wacom)
 			wacom_bpt3_button_msg(wacom, data + offset);
 
 	}
-
 	input_mt_report_pointer_emulation(input, true);
 
 	input_sync(input);
@@ -1639,17 +1616,11 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 		} else if (features->device_type == BTN_TOOL_FINGER) {
 			__clear_bit(ABS_MISC, input_dev->absbit);
 
-			__set_bit(BTN_TOOL_FINGER, input_dev->keybit);
-			__set_bit(BTN_TOOL_DOUBLETAP, input_dev->keybit);
-			__set_bit(BTN_TOOL_TRIPLETAP, input_dev->keybit);
-			__set_bit(BTN_TOOL_QUADTAP, input_dev->keybit);
-
-			input_mt_init_slots(input_dev, features->touch_max, 0);
-
 			input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
 			                     0, features->x_max, 0, 0);
 			input_set_abs_params(input_dev, ABS_MT_TOUCH_MINOR,
 			                     0, features->y_max, 0, 0);
+			input_mt_init_slots(input_dev, features->touch_max, INPUT_MT_POINTER);
 		}
 		break;
 
@@ -1680,21 +1651,14 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 
 	case MTSCREEN:
 	case MTTPC:
-		if (features->device_type == BTN_TOOL_FINGER) {
-			wacom_wac->slots = kmalloc(features->touch_max *
-							sizeof(int),
-						   GFP_KERNEL);
-			if (!wacom_wac->slots)
-				return -ENOMEM;
-
-			for (i = 0; i < features->touch_max; i++)
-				wacom_wac->slots[i] = -1;
-		}
-		/* fall through */
-
 	case TABLETPC2FG:
 		if (features->device_type == BTN_TOOL_FINGER) {
-			input_mt_init_slots(input_dev, features->touch_max, 0);
+			unsigned int flags = INPUT_MT_DIRECT;
+
+			if (wacom_wac->features.type == TABLETPC2FG)
+				flags = 0;
+
+			input_mt_init_slots(input_dev, features->touch_max, flags);
 		}
 		/* fall through */
 
@@ -1737,28 +1701,26 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 
 		if (features->device_type == BTN_TOOL_FINGER) {
+			unsigned int flags = INPUT_MT_POINTER;
+
 			__set_bit(BTN_LEFT, input_dev->keybit);
 			__set_bit(BTN_FORWARD, input_dev->keybit);
 			__set_bit(BTN_BACK, input_dev->keybit);
 			__set_bit(BTN_RIGHT, input_dev->keybit);
 
-			__set_bit(BTN_TOOL_FINGER, input_dev->keybit);
-			__set_bit(BTN_TOOL_DOUBLETAP, input_dev->keybit);
-			input_mt_init_slots(input_dev, features->touch_max, 0);
-
 			if (features->pktlen == WACOM_PKGLEN_BBTOUCH3) {
-				__set_bit(BTN_TOOL_TRIPLETAP,
-					  input_dev->keybit);
-				__set_bit(BTN_TOOL_QUADTAP,
-					  input_dev->keybit);
-
 				input_set_abs_params(input_dev,
 						     ABS_MT_TOUCH_MAJOR,
 						     0, features->x_max, 0, 0);
 				input_set_abs_params(input_dev,
 						     ABS_MT_TOUCH_MINOR,
 						     0, features->y_max, 0, 0);
+			} else {
+				__set_bit(BTN_TOOL_FINGER, input_dev->keybit);
+				__set_bit(BTN_TOOL_DOUBLETAP, input_dev->keybit);
+				flags = 0;
 			}
+			input_mt_init_slots(input_dev, features->touch_max, flags);
 		} else if (features->device_type == BTN_TOOL_PEN) {
 			__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
 			__set_bit(BTN_TOOL_PEN, input_dev->keybit);
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index 9396d77..06410fe 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -135,7 +135,6 @@ struct wacom_wac {
 	int pid;
 	int battery_capacity;
 	int num_contacts_left;
-	int *slots;
 };
 
 #endif
-- 
1.7.10.4

