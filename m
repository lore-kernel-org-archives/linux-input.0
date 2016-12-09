From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/4 v2] HID: wacom: generic: Don't return a value for wacom_wac_event
Date: Thu,  8 Dec 2016 22:03:27 -0800
Message-ID: <1481263407-6051-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36075 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932232AbcLIGDm (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 9 Dec 2016 01:03:42 -0500
Received: by mail-pg0-f67.google.com with SMTP id x23so1189144pgx.3
        for <linux-input@vger.kernel.org>; Thu, 08 Dec 2016 22:03:41 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org, jason.gerecke@wacom.com, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>

From: Ping Cheng <pinglinux@gmail.com>

It is unnecessary to return a value since nothing is expecting a
value from it.

Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
Reviewed-By: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom.h     |  2 +-
 drivers/hid/wacom_wac.c | 62 +++++++++++++++++++++----------------------------
 2 files changed, 28 insertions(+), 36 deletions(-)

diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index b4800ea..d303e41 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -210,7 +210,7 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 				       struct wacom_wac *wacom_wac);
 void wacom_wac_usage_mapping(struct hid_device *hdev,
 		struct hid_field *field, struct hid_usage *usage);
-int wacom_wac_event(struct hid_device *hdev, struct hid_field *field,
+void wacom_wac_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value);
 void wacom_wac_report(struct hid_device *hdev, struct hid_report *report);
 void wacom_battery_work(struct work_struct *work);
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index f1ef3e1..f1c49a4 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1582,7 +1582,7 @@ static void wacom_wac_pad_usage_mapping(struct hid_device *hdev,
 	}
 }
 
-static int wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field,
+static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
@@ -1598,23 +1598,21 @@ static int wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field,
 	case WACOM_HID_WD_BATTERY_LEVEL:
 		wacom_wac->hid_data.battery_capacity = value;
 		wacom_wac->hid_data.bat_connected = 1;
-		return 0;
+		break;
 
 	case WACOM_HID_WD_BATTERY_CHARGING:
 		wacom_wac->hid_data.bat_charging = value;
 		wacom_wac->hid_data.ps_connected = value;
 		wacom_wac->hid_data.bat_connected = 1;
-		return 0;
+		break;
 
 	case WACOM_HID_WD_TOUCHRINGSTATUS:
-		return 0;
+		break;
 
 	default:
 		input_event(input, usage->type, usage->code, value);
 		break;
 	}
-
-	return 0;
 }
 
 static void wacom_wac_pad_pre_report(struct hid_device *hdev,
@@ -1731,7 +1729,7 @@ static void wacom_wac_pen_usage_mapping(struct hid_device *hdev,
 	}
 }
 
-static int wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field,
+static void wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
@@ -1753,25 +1751,25 @@ static int wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field,
 		wacom_wac->hid_data.inrange_state = value;
 		if (!(features->quirks & WACOM_QUIRK_SENSE))
 			wacom_wac->hid_data.sense_state = value;
-		return 0;
+		return;
 	case HID_DG_BATTERYSTRENGTH:
 		wacom_wac->hid_data.battery_capacity = value;
 		wacom_wac->hid_data.bat_connected = 1;
 		break;
 	case HID_DG_INVERT:
 		wacom_wac->hid_data.invert_state = value;
-		return 0;
+		return;
 	case HID_DG_ERASER:
 	case HID_DG_TIPSWITCH:
 		wacom_wac->hid_data.tipswitch |= value;
-		return 0;
+		return;
 	case HID_DG_TOOLSERIALNUMBER:
 		wacom_wac->serial[0] = (wacom_wac->serial[0] & ~0xFFFFFFFFULL);
 		wacom_wac->serial[0] |= value;
-		return 0;
+		return;
 	case WACOM_HID_WD_SENSE:
 		wacom_wac->hid_data.sense_state = value;
-		return 0;
+		return;
 	case WACOM_HID_WD_SERIALHI:
 		wacom_wac->serial[0] = (wacom_wac->serial[0] & 0xFFFFFFFF);
 		wacom_wac->serial[0] |= ((__u64)value) << 32;
@@ -1783,7 +1781,7 @@ static int wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field,
 		if (value >> 20 == 1) {
 			wacom_wac->id[0] |= value & 0xFFFFF;
 		}
-		return 0;
+		return;
 	case WACOM_HID_WD_TOOLTYPE:
 		/*
 		 * Some devices (MobileStudio Pro, and possibly later
@@ -1793,50 +1791,48 @@ static int wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field,
 		 * up over time :(
 		 */
 		wacom_wac->id[0] |= value;
-		return 0;
+		return;
 	case WACOM_HID_WD_OFFSETLEFT:
 		if (features->offset_left && value != features->offset_left)
 			hid_warn(hdev, "%s: overriding exising left offset "
 				 "%d -> %d\n", __func__, value,
 				 features->offset_left);
 		features->offset_left = value;
-		return 0;
+		return;
 	case WACOM_HID_WD_OFFSETRIGHT:
 		if (features->offset_right && value != features->offset_right)
 			hid_warn(hdev, "%s: overriding exising right offset "
 				 "%d -> %d\n", __func__, value,
 				 features->offset_right);
 		features->offset_right = value;
-		return 0;
+		return;
 	case WACOM_HID_WD_OFFSETTOP:
 		if (features->offset_top && value != features->offset_top)
 			hid_warn(hdev, "%s: overriding exising top offset "
 				 "%d -> %d\n", __func__, value,
 				 features->offset_top);
 		features->offset_top = value;
-		return 0;
+		return;
 	case WACOM_HID_WD_OFFSETBOTTOM:
 		if (features->offset_bottom && value != features->offset_bottom)
 			hid_warn(hdev, "%s: overriding exising bottom offset "
 				 "%d -> %d\n", __func__, value,
 				 features->offset_bottom);
 		features->offset_bottom = value;
-		return 0;
+		return;
 	}
 
 	/* send pen events only when touch is up or forced out
 	 * or touch arbitration is off
 	 */
 	if (!usage->type || delay_pen_events(wacom_wac))
-		return 0;
+		return;
 
 	/* send pen events only when the pen is in/entering/leaving proximity */
 	if (!wacom_wac->hid_data.inrange_state && !wacom_wac->tool[0])
-		return 0;
+		return;
 
 	input_event(input, usage->type, usage->code, value);
-
-	return 0;
 }
 
 static void wacom_wac_pen_pre_report(struct hid_device *hdev,
@@ -1980,7 +1976,7 @@ static void wacom_wac_finger_slot(struct wacom_wac *wacom_wac,
 	}
 }
 
-static int wacom_wac_finger_event(struct hid_device *hdev,
+static void wacom_wac_finger_event(struct hid_device *hdev,
 		struct hid_field *field, struct hid_usage *usage, __s32 value)
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
@@ -2013,8 +2009,6 @@ static int wacom_wac_finger_event(struct hid_device *hdev,
 		if (equivalent_usage == wacom_wac->hid_data.last_slot_field)
 			wacom_wac_finger_slot(wacom_wac, wacom_wac->touch_input);
 	}
-
-	return 0;
 }
 
 static void wacom_wac_finger_pre_report(struct hid_device *hdev,
@@ -2100,29 +2094,27 @@ void wacom_wac_usage_mapping(struct hid_device *hdev,
 	features->device_type |= WACOM_DEVICETYPE_DIRECT;
 
 	if (WACOM_PAD_FIELD(field))
-		return wacom_wac_pad_usage_mapping(hdev, field, usage);
+		wacom_wac_pad_usage_mapping(hdev, field, usage);
 	else if (WACOM_PEN_FIELD(field))
-		return wacom_wac_pen_usage_mapping(hdev, field, usage);
+		wacom_wac_pen_usage_mapping(hdev, field, usage);
 	else if (WACOM_FINGER_FIELD(field))
-		return wacom_wac_finger_usage_mapping(hdev, field, usage);
+		wacom_wac_finger_usage_mapping(hdev, field, usage);
 }
 
-int wacom_wac_event(struct hid_device *hdev, struct hid_field *field,
+void wacom_wac_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
 
 	if (wacom->wacom_wac.features.type != HID_GENERIC)
-		return 0;
+		return;
 
 	if (WACOM_PAD_FIELD(field))
-		return wacom_wac_pad_event(hdev, field, usage, value);
+		wacom_wac_pad_event(hdev, field, usage, value);
 	else if (WACOM_PEN_FIELD(field))
-		return wacom_wac_pen_event(hdev, field, usage, value);
+		wacom_wac_pen_event(hdev, field, usage, value);
 	else if (WACOM_FINGER_FIELD(field))
-		return wacom_wac_finger_event(hdev, field, usage, value);
-
-	return 0;
+		wacom_wac_finger_event(hdev, field, usage, value);
 }
 
 static void wacom_report_events(struct hid_device *hdev, struct hid_report *report)
-- 
1.8.3.1

