From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v2 3/3] HID: wacom: Report input events for each finger on generic devices
Date: Fri,  5 Dec 2014 13:37:33 -0800
Message-ID: <1417815453-10618-2-git-send-email-killertofu@gmail.com>
References: <1417815453-10618-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:39626 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbaLEVhl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Dec 2014 16:37:41 -0500
Received: by mail-pd0-f176.google.com with SMTP id y10so1435072pdj.21
        for <linux-input@vger.kernel.org>; Fri, 05 Dec 2014 13:37:40 -0800 (PST)
In-Reply-To: <1417815453-10618-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, pinglinux@gmail.com, Jason Gerecke <killertofu@gmail.com>

The existing generic touch code only reports events after reading an
entire HID report, which practically means that only data about the last
contact in a report will ever be provided to userspace. This patch uses
a trick from hid-multitouch.c to discover what type of field is at the
end of each contact; when such a field is encountered all the stored
contact data will be reported.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
Changes from v1:
 * Patch renamed from "HID: wacom: Report input events immediately upon receipt"
 * Instead of reporting on-reciept, events are bundled and sent at the end of each contact
 * Adds code to discover 'last_slot_field' based on hid-multitouch.c implementation

 drivers/hid/wacom_wac.c | 94 ++++++++++++++++++++++++++++++++-----------------
 drivers/hid/wacom_wac.h |  1 +
 2 files changed, 63 insertions(+), 32 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index c33f889..75fc16e 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1381,35 +1381,68 @@ static void wacom_wac_finger_usage_mapping(struct hid_device *hdev,
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
-	unsigned touch_max = wacom_wac->features.touch_max;
+	struct wacom_features *features = &wacom_wac->features;
 
 	switch (usage->hid) {
 	case HID_GD_X:
-		if (touch_max == 1)
+		features->last_slot_field = usage->hid;
+		if (features->touch_max == 1)
 			wacom_map_usage(wacom, usage, field, EV_ABS, ABS_X, 4);
 		else
 			wacom_map_usage(wacom, usage, field, EV_ABS,
 					ABS_MT_POSITION_X, 4);
 		break;
 	case HID_GD_Y:
-		if (touch_max == 1)
+		features->last_slot_field = usage->hid;
+		if (features->touch_max == 1)
 			wacom_map_usage(wacom, usage, field, EV_ABS, ABS_Y, 4);
 		else
 			wacom_map_usage(wacom, usage, field, EV_ABS,
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
@@ -1432,36 +1465,35 @@ static int wacom_wac_finger_event(struct hid_device *hdev,
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
+static int wacom_wac_finger_touches(struct hid_device *hdev)
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
@@ -1470,18 +1502,16 @@ static void wacom_wac_finger_report(struct hid_device *hdev,
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
 	struct input_dev *input = wacom_wac->input;
-	bool touch = wacom_wac->hid_data.tipswitch &&
-		     !wacom_wac->shared->stylus_in_proximity;
-	unsigned touch_max = wacom_wac->features.touch_max;
 
-	if (touch_max > 1)
-		wacom_wac_finger_mt_report(wacom_wac, input, touch);
+	if (wacom_wac->features.touch_max > 1)
+		input_mt_sync_frame(input);
 	else
-		wacom_wac_finger_single_touch_report(wacom_wac, input, touch);
+		wacom_wac_finger_slot(wacom_wac, input);
+
 	input_sync(input);
 
 	/* keep touch state for pen event */
-	wacom_wac->shared->touch_down = touch;
+	wacom_wac->shared->touch_down = wacom_wac_finger_touches(hdev);
 }
 
 #define WACOM_PEN_FIELD(f)	(((f)->logical == HID_DG_STYLUS) || \
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 128cbb3..6e256206 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -144,6 +144,7 @@ struct wacom_features {
 	int pktlen;
 	bool check_for_hid_type;
 	int hid_type;
+	int last_slot_field;
 };
 
 struct wacom_shared {
-- 
2.1.3

