From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 5/5] HID: wacom: generic: Refactor generic battery handling
Date: Fri, 28 Apr 2017 09:25:34 -0700
Message-ID: <20170428162534.3051-5-killertofu@gmail.com>
References: <20170428162534.3051-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35613 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S638193AbdD1Q0A (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 28 Apr 2017 12:26:00 -0400
Received: by mail-qk0-f195.google.com with SMTP id a19so9613268qkg.2
        for <linux-input@vger.kernel.org>; Fri, 28 Apr 2017 09:26:00 -0700 (PDT)
In-Reply-To: <20170428162534.3051-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Generic battery handling code is spread between the pen and pad codepaths
since battery usages may appear in reports for either. This makes it
difficult to concisely see the logic involved. Since battery data is
not treated like other data (i.e., we report it through the power_supply
subsystem rather than through the input subsystem), it makes reasonable
sense to split the functionality out into its own functions.

This commit has the generic battery handling duplicate the same pattern
that is used by the pen, pad, and touch interfaces. A "mapping" function
is provided to set up the battery, an "event" function is provided to
update the battery data, and a "report" function is provided to notify
the power_supply subsystem after all the data has been read. We look at
the usage itself rather than its collection to determine if one of the
battery functions should handle it. Additionally, we unconditionally
call the "report" function since there is no particularly good way to
know if a report contained a battery usage; 'wacom_notify_battery()'
will filter out any duplicate updates, however.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 162 +++++++++++++++++++++++++++---------------------
 drivers/hid/wacom_wac.h |   4 ++
 2 files changed, 95 insertions(+), 71 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 755712871e45..a36932f8ad2b 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1702,20 +1702,92 @@ static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
 	}
 }
 
-static void wacom_wac_pad_usage_mapping(struct hid_device *hdev,
+static void wacom_wac_battery_usage_mapping(struct hid_device *hdev,
 		struct hid_field *field, struct hid_usage *usage)
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
 	struct wacom_features *features = &wacom_wac->features;
-	struct input_dev *input = wacom_wac->pad_input;
 	unsigned equivalent_usage = wacom_equivalent_usage(usage->hid);
 
 	switch (equivalent_usage) {
+	case HID_DG_BATTERYSTRENGTH:
 	case WACOM_HID_WD_BATTERY_LEVEL:
 	case WACOM_HID_WD_BATTERY_CHARGING:
 		features->quirks |= WACOM_QUIRK_BATTERY;
 		break;
+	}
+}
+
+static void wacom_wac_battery_event(struct hid_device *hdev, struct hid_field *field,
+		struct hid_usage *usage, __s32 value)
+{
+	struct wacom *wacom = hid_get_drvdata(hdev);
+	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	unsigned equivalent_usage = wacom_equivalent_usage(usage->hid);
+
+	switch (equivalent_usage) {
+	case HID_DG_BATTERYSTRENGTH:
+		if (value == 0) {
+			wacom_wac->hid_data.bat_status = POWER_SUPPLY_STATUS_UNKNOWN;
+		}
+		else {
+			value = value * 100 / (field->logical_maximum - field->logical_minimum);
+			wacom_wac->hid_data.battery_capacity = value;
+			wacom_wac->hid_data.bat_connected = 1;
+			wacom_wac->hid_data.bat_status = WACOM_POWER_SUPPLY_STATUS_AUTO;
+		}
+		break;
+	case WACOM_HID_WD_BATTERY_LEVEL:
+		value = value * 100 / (field->logical_maximum - field->logical_minimum);
+		wacom_wac->hid_data.battery_capacity = value;
+		wacom_wac->hid_data.bat_connected = 1;
+		wacom_wac->hid_data.bat_status = WACOM_POWER_SUPPLY_STATUS_AUTO;
+		break;
+	case WACOM_HID_WD_BATTERY_CHARGING:
+		wacom_wac->hid_data.bat_charging = value;
+		wacom_wac->hid_data.ps_connected = value;
+		wacom_wac->hid_data.bat_connected = 1;
+		wacom_wac->hid_data.bat_status = WACOM_POWER_SUPPLY_STATUS_AUTO;
+		break;
+	}
+}
+
+static void wacom_wac_battery_pre_report(struct hid_device *hdev,
+		struct hid_report *report)
+{
+	return;
+}
+
+static void wacom_wac_battery_report(struct hid_device *hdev,
+		struct hid_report *report)
+{
+	struct wacom *wacom = hid_get_drvdata(hdev);
+	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	struct wacom_features *features = &wacom_wac->features;
+
+	if (features->quirks & WACOM_QUIRK_BATTERY) {
+		int status = wacom_wac->hid_data.bat_status;
+		int capacity = wacom_wac->hid_data.battery_capacity;
+		bool charging = wacom_wac->hid_data.bat_charging;
+		bool connected = wacom_wac->hid_data.bat_connected;
+		bool powered = wacom_wac->hid_data.ps_connected;
+
+		wacom_notify_battery(wacom_wac, status, capacity, charging,
+				     connected, powered);
+	}
+}
+
+static void wacom_wac_pad_usage_mapping(struct hid_device *hdev,
+		struct hid_field *field, struct hid_usage *usage)
+{
+	struct wacom *wacom = hid_get_drvdata(hdev);
+	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	struct wacom_features *features = &wacom_wac->features;
+	struct input_dev *input = wacom_wac->pad_input;
+	unsigned equivalent_usage = wacom_equivalent_usage(usage->hid);
+
+	switch (equivalent_usage) {
 	case WACOM_HID_WD_ACCELEROMETER_X:
 		__set_bit(INPUT_PROP_ACCELEROMETER, input->propbit);
 		wacom_map_usage(input, usage, field, EV_ABS, ABS_X, 0);
@@ -1809,29 +1881,6 @@ static void wacom_wac_pad_usage_mapping(struct hid_device *hdev,
 	}
 }
 
-static void wacom_wac_pad_battery_event(struct hid_device *hdev, struct hid_field *field,
-		struct hid_usage *usage, __s32 value)
-{
-	struct wacom *wacom = hid_get_drvdata(hdev);
-	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
-	unsigned equivalent_usage = wacom_equivalent_usage(usage->hid);
-
-	switch (equivalent_usage) {
-	case WACOM_HID_WD_BATTERY_LEVEL:
-		value = value * 100 / (field->logical_maximum - field->logical_minimum);
-		wacom_wac->hid_data.battery_capacity = value;
-		wacom_wac->hid_data.bat_connected = 1;
-		wacom_wac->hid_data.bat_status = WACOM_POWER_SUPPLY_STATUS_AUTO;
-		break;
-
-	case WACOM_HID_WD_BATTERY_CHARGING:
-		wacom_wac->hid_data.bat_charging = value;
-		wacom_wac->hid_data.ps_connected = value;
-		wacom_wac->hid_data.bat_connected = 1;
-		break;
-	}
-}
-
 static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
@@ -1905,25 +1954,6 @@ static void wacom_wac_pad_pre_report(struct hid_device *hdev,
 	wacom_wac->hid_data.inrange_state = 0;
 }
 
-static void wacom_wac_pad_battery_report(struct hid_device *hdev,
-		struct hid_report *report)
-{
-	struct wacom *wacom = hid_get_drvdata(hdev);
-	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
-	struct wacom_features *features = &wacom_wac->features;
-
-	if (features->quirks & WACOM_QUIRK_BATTERY) {
-		int status = wacom_wac->hid_data.bat_status;
-		int capacity = wacom_wac->hid_data.battery_capacity;
-		bool charging = wacom_wac->hid_data.bat_charging;
-		bool connected = wacom_wac->hid_data.bat_connected;
-		bool powered = wacom_wac->hid_data.ps_connected;
-
-		wacom_notify_battery(wacom_wac, status, capacity,
-				     charging, connected, powered);
-	}
-}
-
 static void wacom_wac_pad_report(struct hid_device *hdev,
 		struct hid_report *report)
 {
@@ -1969,9 +1999,6 @@ static void wacom_wac_pen_usage_mapping(struct hid_device *hdev,
 	case HID_DG_INRANGE:
 		wacom_map_usage(input, usage, field, EV_KEY, BTN_TOOL_PEN, 0);
 		break;
-	case HID_DG_BATTERYSTRENGTH:
-		features->quirks |= WACOM_QUIRK_BATTERY;
-		break;
 	case HID_DG_INVERT:
 		wacom_map_usage(input, usage, field, EV_KEY,
 				BTN_TOOL_RUBBER, 0);
@@ -2042,17 +2069,6 @@ static void wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field
 		if (!(features->quirks & WACOM_QUIRK_SENSE))
 			wacom_wac->hid_data.sense_state = value;
 		return;
-	case HID_DG_BATTERYSTRENGTH:
-		if (value == 0) {
-			wacom_wac->hid_data.bat_status = POWER_SUPPLY_STATUS_UNKNOWN;
-		}
-		else {
-			value = value * 100 / (field->logical_maximum - field->logical_minimum);
-			wacom_wac->hid_data.battery_capacity = value;
-			wacom_wac->hid_data.bat_connected = 1;
-			wacom_wac->hid_data.bat_status = WACOM_POWER_SUPPLY_STATUS_AUTO;
-		}
-		break;
 	case HID_DG_INVERT:
 		wacom_wac->hid_data.invert_state = value;
 		return;
@@ -2188,8 +2204,6 @@ static void wacom_wac_pen_report(struct hid_device *hdev,
 		input_sync(input);
 	}
 
-	wacom_wac_pad_battery_report(hdev, report);
-
 	if (!prox) {
 		wacom_wac->tool[0] = 0;
 		wacom_wac->id[0] = 0;
@@ -2401,7 +2415,10 @@ void wacom_wac_usage_mapping(struct hid_device *hdev,
 	if (WACOM_DIRECT_DEVICE(field))
 		features->device_type |= WACOM_DEVICETYPE_DIRECT;
 
-	if (WACOM_PAD_FIELD(field))
+	/* usage tests must precede field tests */
+	if (WACOM_BATTERY_USAGE(usage))
+		wacom_wac_battery_usage_mapping(hdev, field, usage);
+	else if (WACOM_PAD_FIELD(field))
 		wacom_wac_pad_usage_mapping(hdev, field, usage);
 	else if (WACOM_PEN_FIELD(field))
 		wacom_wac_pen_usage_mapping(hdev, field, usage);
@@ -2420,11 +2437,12 @@ void wacom_wac_event(struct hid_device *hdev, struct hid_field *field,
 	if (value > field->logical_maximum || value < field->logical_minimum)
 		return;
 
-	if (WACOM_PAD_FIELD(field)) {
-		wacom_wac_pad_battery_event(hdev, field, usage, value);
-		if (wacom->wacom_wac.pad_input)
-			wacom_wac_pad_event(hdev, field, usage, value);
-	} else if (WACOM_PEN_FIELD(field) && wacom->wacom_wac.pen_input)
+	/* usage tests must precede field tests */
+	if (WACOM_BATTERY_USAGE(usage))
+		wacom_wac_battery_event(hdev, field, usage, value);
+	else if (WACOM_PAD_FIELD(field) && wacom->wacom_wac.pad_input)
+		wacom_wac_pad_event(hdev, field, usage, value);
+	else if (WACOM_PEN_FIELD(field) && wacom->wacom_wac.pen_input)
 		wacom_wac_pen_event(hdev, field, usage, value);
 	else if (WACOM_FINGER_FIELD(field) && wacom->wacom_wac.touch_input)
 		wacom_wac_finger_event(hdev, field, usage, value);
@@ -2458,6 +2476,8 @@ void wacom_wac_report(struct hid_device *hdev, struct hid_report *report)
 	if (wacom_wac->features.type != HID_GENERIC)
 		return;
 
+	wacom_wac_battery_pre_report(hdev, report);
+
 	if (WACOM_PAD_FIELD(field) && wacom->wacom_wac.pad_input)
 		wacom_wac_pad_pre_report(hdev, report);
 	else if (WACOM_PEN_FIELD(field) && wacom->wacom_wac.pen_input)
@@ -2477,11 +2497,11 @@ void wacom_wac_report(struct hid_device *hdev, struct hid_report *report)
 	if (report->type != HID_INPUT_REPORT)
 		return;
 
-	if (WACOM_PAD_FIELD(field)) {
-		wacom_wac_pad_battery_report(hdev, report);
-		if (wacom->wacom_wac.pad_input)
-			wacom_wac_pad_report(hdev, report);
-	} else if (WACOM_PEN_FIELD(field) && wacom->wacom_wac.pen_input)
+	wacom_wac_battery_report(hdev, report);
+
+	if (WACOM_PAD_FIELD(field) && wacom->wacom_wac.pad_input)
+		wacom_wac_pad_report(hdev, report);
+	else if (WACOM_PEN_FIELD(field) && wacom->wacom_wac.pen_input)
 		wacom_wac_pen_report(hdev, report);
 	else if (WACOM_FINGER_FIELD(field) && wacom->wacom_wac.touch_input)
 		wacom_wac_finger_report(hdev, report);
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 1824b530bcb5..8a03654048bf 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -153,6 +153,10 @@
 #define WACOM_HID_WT_X                  (WACOM_HID_UP_WACOMTOUCH | 0x130)
 #define WACOM_HID_WT_Y                  (WACOM_HID_UP_WACOMTOUCH | 0x131)
 
+#define WACOM_BATTERY_USAGE(f)	(((f)->hid == HID_DG_BATTERYSTRENGTH) || \
+				 ((f)->hid == WACOM_HID_WD_BATTERY_CHARGING) || \
+				 ((f)->hid == WACOM_HID_WD_BATTERY_LEVEL))
+
 #define WACOM_PAD_FIELD(f)	(((f)->physical == HID_DG_TABLETFUNCTIONKEY) || \
 				 ((f)->physical == WACOM_HID_WD_DIGITIZERFNKEYS) || \
 				 ((f)->physical == WACOM_HID_WD_DIGITIZERINFO))
-- 
2.12.2

