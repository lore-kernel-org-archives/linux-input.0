From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v3 3/3] HID: wacom: Report input events for each finger on generic devices
Date: Wed, 10 Dec 2014 16:26:04 -0800
Message-ID: <1418257564-5561-1-git-send-email-killertofu@gmail.com>
References: <CAN+gG=Fw0BvNZ8DQtGtuCer42D0wzBzE0NX4rAe+54b94=X7RQ@mail.gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:38427 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933257AbaLKA0o (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Dec 2014 19:26:44 -0500
Received: by mail-pa0-f49.google.com with SMTP id eu11so3802324pac.8
        for <linux-input@vger.kernel.org>; Wed, 10 Dec 2014 16:26:44 -0800 (PST)
In-Reply-To: <CAN+gG=Fw0BvNZ8DQtGtuCer42D0wzBzE0NX4rAe+54b94=X7RQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>

The existing generic touch code only reports events after reading an
entire HID report, which practically means that only data about the last
contact in a report will ever be provided to userspace. This patch uses
a trick from hid-multitouch.c to discover what type of field is at the
end of each contact; when such a field is encountered all the stored
contact data will be reported.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
Changes from v2:
 * No longer removing 'touch_max' variables to make changes clearer
 * Renamed 'wacom_wac_finger_touches' to 'wacom_wac_finger_count_touches'
 * Removed call to 'wacom_wac_finger_slot' in 'wacom_wac_finger_report' 
   since it is already called for the single-touch case within 
   'wacom_wac_finger_event'.

 drivers/hid/wacom_wac.c | 86 +++++++++++++++++++++++++++++++++----------------
 drivers/hid/wacom_wac.h |  1 +
 2 files changed, 59 insertions(+), 28 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 064fd6c..26f27bd 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1381,10 +1381,12 @@ static void wacom_wac_finger_usage_mapping(struct hid_device *hdev,
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	struct wacom_features *features = &wacom_wac->features;
 	unsigned touch_max = wacom_wac->features.touch_max;
 
 	switch (usage->hid) {
 	case HID_GD_X:
+		features->last_slot_field = usage->hid;
 		if (touch_max == 1)
 			wacom_map_usage(wacom, usage, field, EV_ABS, ABS_X, 4);
 		else
@@ -1392,6 +1394,7 @@ static void wacom_wac_finger_usage_mapping(struct hid_device *hdev,
 					ABS_MT_POSITION_X, 4);
 		break;
 	case HID_GD_Y:
+		features->last_slot_field = usage->hid;
 		if (touch_max == 1)
 			wacom_map_usage(wacom, usage, field, EV_ABS, ABS_Y, 4);
 		else
@@ -1399,17 +1402,48 @@ static void wacom_wac_finger_usage_mapping(struct hid_device *hdev,
 					ABS_MT_POSITION_Y, 4);
 		break;
 	case HID_DG_CONTACTID:
+		features->last_slot_field = usage->hid;
 		break;
 	case HID_DG_INRANGE:
+		features->last_slot_field = usage->hid;
 		break;
 	case HID_DG_INVERT:
+		features->last_slot_field = usage->hid;
 		break;
 	case HID_DG_TIPSWITCH:
+		features->last_slot_field = usage->hid;
 		wacom_map_usage(wacom, usage, field, EV_KEY, BTN_TOUCH, 0);
 		break;
 	}
 }
 
+static void wacom_wac_finger_slot(struct wacom_wac *wacom_wac,
+		struct input_dev *input)
+{
+	struct hid_data *hid_data = &wacom_wac->hid_data;
+	bool mt = wacom_wac->features.touch_max > 1;
+	bool prox = hid_data->tipswitch &&
+		    !wacom_wac->shared->stylus_in_proximity;
+
+	if (mt) {
+		int slot;
+
+		slot = input_mt_get_slot_by_key(input, hid_data->id);
+		input_mt_slot(input, slot);
+		input_mt_report_slot_state(input, MT_TOOL_FINGER, prox);
+	}
+	else {
+		input_report_key(input, BTN_TOUCH, prox);
+	}
+
+	if (prox) {
+		input_report_abs(input, mt ? ABS_MT_POSITION_X : ABS_X,
+				 hid_data->x);
+		input_report_abs(input, mt ? ABS_MT_POSITION_Y : ABS_Y,
+				 hid_data->y);
+	}
+}
+
 static int wacom_wac_finger_event(struct hid_device *hdev,
 		struct hid_field *field, struct hid_usage *usage, __s32 value)
 {
@@ -1432,36 +1466,35 @@ static int wacom_wac_finger_event(struct hid_device *hdev,
 	}
 
 
+	if (usage->usage_index + 1 == field->report_count) {
+		if (usage->hid == wacom_wac->features.last_slot_field)
+			wacom_wac_finger_slot(wacom_wac, wacom_wac->input);
+	}
+
 	return 0;
 }
 
-static void wacom_wac_finger_mt_report(struct wacom_wac *wacom_wac,
-		struct input_dev *input, bool touch)
+static int wacom_wac_finger_count_touches(struct hid_device *hdev)
 {
-	int slot;
-	struct hid_data *hid_data = &wacom_wac->hid_data;
+	struct wacom *wacom = hid_get_drvdata(hdev);
+	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	struct input_dev *input = wacom_wac->input;
+	unsigned touch_max = wacom_wac->features.touch_max;
+	int count = 0;
+	int i;
 
-	slot = input_mt_get_slot_by_key(input, hid_data->id);
+	if (touch_max == 1)
+		return wacom_wac->hid_data.tipswitch &&
+		       !wacom_wac->shared->stylus_in_proximity;
 
-	input_mt_slot(input, slot);
-	input_mt_report_slot_state(input, MT_TOOL_FINGER, touch);
-	if (touch) {
-		input_report_abs(input, ABS_MT_POSITION_X, hid_data->x);
-		input_report_abs(input, ABS_MT_POSITION_Y, hid_data->y);
+	for (i = 0; i < input->mt->num_slots; i++) {
+		struct input_mt_slot *ps = &input->mt->slots[i];
+		int id = input_mt_get_value(ps, ABS_MT_TRACKING_ID);
+		if (id >= 0)
+			count++;
 	}
-	input_mt_sync_frame(input);
-}
-
-static void wacom_wac_finger_single_touch_report(struct wacom_wac *wacom_wac,
-		struct input_dev *input, bool touch)
-{
-	struct hid_data *hid_data = &wacom_wac->hid_data;
 
-	if (touch) {
-		input_report_abs(input, ABS_X, hid_data->x);
-		input_report_abs(input, ABS_Y, hid_data->y);
-	}
-	input_report_key(input, BTN_TOUCH, touch);
+	return count;
 }
 
 static void wacom_wac_finger_report(struct hid_device *hdev,
@@ -1470,18 +1503,15 @@ static void wacom_wac_finger_report(struct hid_device *hdev,
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
 	struct input_dev *input = wacom_wac->input;
-	bool touch = wacom_wac->hid_data.tipswitch &&
-		     !wacom_wac->shared->stylus_in_proximity;
 	unsigned touch_max = wacom_wac->features.touch_max;
 
 	if (touch_max > 1)
-		wacom_wac_finger_mt_report(wacom_wac, input, touch);
-	else
-		wacom_wac_finger_single_touch_report(wacom_wac, input, touch);
+		input_mt_sync_frame(input);
+
 	input_sync(input);
 
 	/* keep touch state for pen event */
-	wacom_wac->shared->touch_down = touch;
+	wacom_wac->shared->touch_down = wacom_wac_finger_count_touches(hdev);
 }
 
 #define WACOM_PEN_FIELD(f)	(((f)->logical == HID_DG_STYLUS) || \
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 5384043..bfad815 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -145,6 +145,7 @@ struct wacom_features {
 	int pktlen;
 	bool check_for_hid_type;
 	int hid_type;
+	int last_slot_field;
 };
 
 struct wacom_shared {
-- 
2.1.3

