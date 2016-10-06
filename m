From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 17/19] HID: wacom: generic: Add support for battery status on pen and pad interfaces
Date: Thu,  6 Oct 2016 14:22:29 -0700
Message-ID: <20161006212231.31440-18-killertofu@gmail.com>
References: <20161006212231.31440-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34463 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935088AbcJFVXH (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2016 17:23:07 -0400
Received: by mail-qk0-f196.google.com with SMTP id n189so1666601qke.1
        for <linux-input@vger.kernel.org>; Thu, 06 Oct 2016 14:23:06 -0700 (PDT)
In-Reply-To: <20161006212231.31440-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, Jason Gerecke <killertofu@gmail.com>

Adds support for usages that may appear on the pen or pad interface which
report the state of the tablet battery.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 drivers/hid/wacom_wac.h |  6 ++++++
 include/linux/hid.h     |  1 +
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 81b4b99..f75ffae 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1526,6 +1526,10 @@ static void wacom_wac_pad_usage_mapping(struct hid_device *hdev,
 	unsigned equivalent_usage = wacom_equivalent_usage(usage->hid);
 
 	switch (equivalent_usage) {
+	case WACOM_HID_WD_BATTERY_LEVEL:
+	case WACOM_HID_WD_BATTERY_CHARGING:
+		features->quirks |= WACOM_QUIRK_BATTERY;
+		break;
 	case WACOM_HID_WD_ACCELEROMETER_X:
 		__set_bit(INPUT_PROP_ACCELEROMETER, input->propbit);
 		wacom_map_usage(input, hdev, usage, field, EV_ABS, ABS_X, 0);
@@ -1575,8 +1579,25 @@ static int wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field,
 		wacom_wac->hid_data.inrange_state |= value;
 	}
 
-	if (equivalent_usage != WACOM_HID_WD_TOUCHRINGSTATUS)
+	switch (equivalent_usage) {
+	case WACOM_HID_WD_BATTERY_LEVEL:
+		wacom_wac->hid_data.battery_capacity = value;
+		wacom_wac->hid_data.bat_connected = 1;
+		return 0;
+
+	case WACOM_HID_WD_BATTERY_CHARGING:
+		wacom_wac->hid_data.bat_charging = value;
+		wacom_wac->hid_data.ps_connected = value;
+		wacom_wac->hid_data.bat_connected = 1;
+		return 0;
+
+	case WACOM_HID_WD_TOUCHRINGSTATUS:
+		return 0;
+
+	default:
 		input_event(input, usage->type, usage->code, value);
+		break;
+	}
 
 	return 0;
 }
@@ -1595,6 +1616,7 @@ static void wacom_wac_pad_report(struct hid_device *hdev,
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	struct wacom_features *features = &wacom_wac->features;
 	struct input_dev *input = wacom_wac->pad_input;
 	bool active = wacom_wac->hid_data.inrange_state != 0;
 
@@ -1605,6 +1627,16 @@ static void wacom_wac_pad_report(struct hid_device *hdev,
 	if (wacom_equivalent_usage(report->field[0]->physical) == HID_DG_TABLETFUNCTIONKEY)
 		input_event(input, EV_ABS, ABS_MISC, active ? PAD_DEVICE_ID : 0);
 
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
 	input_sync(input);
 }
 
@@ -1634,6 +1666,9 @@ static void wacom_wac_pen_usage_mapping(struct hid_device *hdev,
 	case HID_DG_INRANGE:
 		wacom_map_usage(input, hdev, usage, field, EV_KEY, BTN_TOOL_PEN, 0);
 		break;
+	case HID_DG_BATTERYSTRENGTH:
+		features->quirks |= WACOM_QUIRK_BATTERY;
+		break;
 	case HID_DG_INVERT:
 		wacom_map_usage(input, hdev, usage, field, EV_KEY,
 				BTN_TOOL_RUBBER, 0);
@@ -1704,6 +1739,10 @@ static int wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field,
 		if (!(features->quirks & WACOM_QUIRK_SENSE))
 			wacom_wac->hid_data.sense_state = value;
 		return 0;
+	case HID_DG_BATTERYSTRENGTH:
+		wacom_wac->hid_data.battery_capacity = value;
+		wacom_wac->hid_data.bat_connected = 1;
+		break;
 	case HID_DG_INVERT:
 		wacom_wac->hid_data.invert_state = value;
 		return 0;
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 0c69c1f..fa5b772 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -101,6 +101,8 @@
 #define WACOM_HID_WD_ACCELEROMETER_X    (WACOM_HID_UP_WACOMDIGITIZER | 0x0401)
 #define WACOM_HID_WD_ACCELEROMETER_Y    (WACOM_HID_UP_WACOMDIGITIZER | 0x0402)
 #define WACOM_HID_WD_ACCELEROMETER_Z    (WACOM_HID_UP_WACOMDIGITIZER | 0x0403)
+#define WACOM_HID_WD_BATTERY_CHARGING   (WACOM_HID_UP_WACOMDIGITIZER | 0x0404)
+#define WACOM_HID_WD_BATTERY_LEVEL      (WACOM_HID_UP_WACOMDIGITIZER | 0x043b)
 #define WACOM_HID_WD_EXPRESSKEY00       (WACOM_HID_UP_WACOMDIGITIZER | 0x0910)
 #define WACOM_HID_WD_BUTTONHOME         (WACOM_HID_UP_WACOMDIGITIZER | 0x0990)
 #define WACOM_HID_WD_BUTTONUP           (WACOM_HID_UP_WACOMDIGITIZER | 0x0991)
@@ -257,6 +259,10 @@ struct hid_data {
 	int cc_value_index;
 	int num_expected;
 	int num_received;
+	int battery_capacity;
+	int bat_charging;
+	int bat_connected;
+	int ps_connected;
 };
 
 struct wacom_remote_data {
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 0c05b27..021da44 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -231,6 +231,7 @@ struct hid_item {
 #define HID_DG_TAP		0x000d0035
 #define HID_DG_TABLETFUNCTIONKEY	0x000d0039
 #define HID_DG_PROGRAMCHANGEKEY	0x000d003a
+#define HID_DG_BATTERYSTRENGTH	0x000d003b
 #define HID_DG_INVERT		0x000d003c
 #define HID_DG_TILT_X		0x000d003d
 #define HID_DG_TILT_Y		0x000d003e
-- 
2.10.0

