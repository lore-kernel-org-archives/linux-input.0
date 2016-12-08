From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 4/4] HID: wacom: generic: Don't sync input on empty input packets
Date: Wed,  7 Dec 2016 16:19:29 -0800
Message-ID: <1481156369-5403-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36714 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932661AbcLHATr (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Dec 2016 19:19:47 -0500
Received: by mail-pf0-f195.google.com with SMTP id c4so21254286pfb.3
        for <linux-input@vger.kernel.org>; Wed, 07 Dec 2016 16:19:47 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, benjamin.tissoires@redhat.com, Ping Cheng <pingc@wacom.com>, Ping Cheng <ping.cheng@wacom.com>

post input_sync only when there are input events posted

Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
---
 drivers/hid/wacom_wac.c | 86 +++++++++++++++++++++++++++++++++----------------
 drivers/hid/wacom_wac.h |  1 +
 2 files changed, 60 insertions(+), 27 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 7a748a7..411ba2c 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1591,18 +1591,13 @@ static void wacom_wac_pad_usage_mapping(struct hid_device *hdev,
 	}
 }
 
-static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field,
+static void wacom_wac_pad_battery_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
-	struct input_dev *input = wacom_wac->pad_input;
 	unsigned equivalent_usage = wacom_equivalent_usage(usage->hid);
 
-	if (wacom_equivalent_usage(field->physical) == HID_DG_TABLETFUNCTIONKEY) {
-		wacom_wac->hid_data.inrange_state |= value;
-	}
-
 	switch (equivalent_usage) {
 	case WACOM_HID_WD_BATTERY_LEVEL:
 		wacom_wac->hid_data.battery_capacity = value;
@@ -1614,11 +1609,29 @@ static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field
 		wacom_wac->hid_data.ps_connected = value;
 		wacom_wac->hid_data.bat_connected = 1;
 		break;
+	}
+}
+
+static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field,
+		struct hid_usage *usage, __s32 value)
+{
+	struct wacom *wacom = hid_get_drvdata(hdev);
+	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	struct input_dev *input = wacom_wac->pad_input;
+	struct wacom_features *features = &wacom_wac->features;
+	unsigned equivalent_usage = wacom_equivalent_usage(usage->hid);
+
+	wacom_wac_pad_battery_event(hdev, field, usage, value);
+	if (wacom_equivalent_usage(field->physical) == HID_DG_TABLETFUNCTIONKEY) {
+		wacom_wac->hid_data.inrange_state |= value;
+	}
 
+	switch (equivalent_usage) {
 	case WACOM_HID_WD_TOUCHRINGSTATUS:
 		break;
 
 	default:
+		features->input_event_flag = true;
 		input_event(input, usage->type, usage->code, value);
 		break;
 	}
@@ -1633,6 +1646,25 @@ static void wacom_wac_pad_pre_report(struct hid_device *hdev,
 	wacom_wac->hid_data.inrange_state = 0;
 }
 
+static void wacom_wac_pad_battery_report(struct hid_device *hdev,
+ 		struct hid_report *report)
+ {
+ 	struct wacom *wacom = hid_get_drvdata(hdev);
+ 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+ 	struct wacom_features *features = &wacom_wac->features;
+
+	if (features->quirks & WACOM_QUIRK_BATTERY) {
+		int capacity = wacom_wac->hid_data.battery_capacity;
+		bool charging = wacom_wac->hid_data.bat_charging;
+		bool connected = wacom_wac->hid_data.bat_connected;
+		bool powered = wacom_wac->hid_data.ps_connected;
+
+		wacom_notify_battery(wacom_wac, capacity, charging,
+				     connected, powered);
+	}
+
+}
+
 static void wacom_wac_pad_report(struct hid_device *hdev,
 		struct hid_report *report)
 {
@@ -1642,24 +1674,18 @@ static void wacom_wac_pad_report(struct hid_device *hdev,
 	struct input_dev *input = wacom_wac->pad_input;
 	bool active = wacom_wac->hid_data.inrange_state != 0;
 
-	/*
-	 * don't report prox for events like accelerometer
-	 * or battery status
-	 */
-	if (wacom_equivalent_usage(report->field[0]->physical) == HID_DG_TABLETFUNCTIONKEY)
-		input_event(input, EV_ABS, ABS_MISC, active ? PAD_DEVICE_ID : 0);
-
-	if (features->quirks & WACOM_QUIRK_BATTERY) {
-		int capacity = wacom_wac->hid_data.battery_capacity;
-		bool charging = wacom_wac->hid_data.bat_charging;
-		bool connected = wacom_wac->hid_data.bat_connected;
-		bool powered = wacom_wac->hid_data.ps_connected;
+	wacom_wac_pad_battery_report(hdev, report);
 
-		wacom_notify_battery(wacom_wac, capacity, charging,
-				     connected, powered);
+	/* report prox for expresskey events */
+	if (wacom_equivalent_usage(report->field[0]->physical) == HID_DG_TABLETFUNCTIONKEY) {
+		features->input_event_flag = true;
+		input_event(input, EV_ABS, ABS_MISC, active ? PAD_DEVICE_ID : 0);
 	}
 
-	input_sync(input);
+	if (features->input_event_flag) {
+		features->input_event_flag = false;
+		input_sync(input);
+	}
 }
 
 static void wacom_wac_pen_usage_mapping(struct hid_device *hdev,
@@ -2118,9 +2144,12 @@ void wacom_wac_event(struct hid_device *hdev, struct hid_field *field,
 	if (wacom->wacom_wac.features.type != HID_GENERIC)
 		return;
 
-	if (WACOM_PAD_FIELD(field) && wacom->wacom_wac.pad_input)
-		wacom_wac_pad_event(hdev, field, usage, value);
-	else if (WACOM_PEN_FIELD(field) && wacom->wacom_wac.pen_input)
+	if (WACOM_PAD_FIELD(field)) {
+		if (wacom->wacom_wac.pad_input)
+			wacom_wac_pad_event(hdev, field, usage, value);
+		else
+			wacom_wac_pad_battery_event(hdev, field, usage, value);
+	} else if (WACOM_PEN_FIELD(field) && wacom->wacom_wac.pen_input)
 		wacom_wac_pen_event(hdev, field, usage, value);
 	else if (WACOM_FINGER_FIELD(field) && wacom->wacom_wac.touch_input)
 		wacom_wac_finger_event(hdev, field, usage, value);
@@ -2163,9 +2192,12 @@ void wacom_wac_report(struct hid_device *hdev, struct hid_report *report)
 
 	wacom_report_events(hdev, report);
 
-	if (WACOM_PAD_FIELD(field) && wacom->wacom_wac.pad_input)
-		return wacom_wac_pad_report(hdev, report);
-	else if (WACOM_PEN_FIELD(field) && wacom->wacom_wac.pen_input)
+	if (WACOM_PAD_FIELD(field)) {
+		if (wacom->wacom_wac.pad_input)
+			return wacom_wac_pad_report(hdev, report);
+		else
+			return wacom_wac_pad_battery_report(hdev, report);
+	} else if (WACOM_PEN_FIELD(field) && wacom->wacom_wac.pen_input)
 		return wacom_wac_pen_report(hdev, report);
 	else if (WACOM_FINGER_FIELD(field) && wacom->wacom_wac.touch_input)
 		return wacom_wac_finger_report(hdev, report);
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index a54a301..fb0e50a 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -232,6 +232,7 @@ struct wacom_features {
 	int pktlen;
 	bool check_for_hid_type;
 	int hid_type;
+	bool input_event_flag;
 };
 
 struct wacom_shared {
-- 
2.7.4

