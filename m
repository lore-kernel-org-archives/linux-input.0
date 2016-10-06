From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 13/19] HID: wacom: generic: Pass 'hdev' to 'wacom_map_usage'
Date: Thu,  6 Oct 2016 14:22:25 -0700
Message-ID: <20161006212231.31440-14-killertofu@gmail.com>
References: <20161006212231.31440-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36438 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935088AbcJFVXB (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2016 17:23:01 -0400
Received: by mail-qt0-f195.google.com with SMTP id y38so833218qta.3
        for <linux-input@vger.kernel.org>; Thu, 06 Oct 2016 14:23:00 -0700 (PDT)
In-Reply-To: <20161006212231.31440-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, Jason Gerecke <killertofu@gmail.com>

In the following "Add support for sensor offsets" patch we'll need access
to the 'features' struct within 'wacom_map_usage', so update the function
signature and calls to include a reference to the HID device so this can
be done.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 53 ++++++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index f2aadc4..8f493cc 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1465,9 +1465,12 @@ static int wacom_equivalent_usage(int usage)
 	return usage;
 }
 
-static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
-		struct hid_field *field, __u8 type, __u16 code, int fuzz)
+static void wacom_map_usage(struct input_dev *input, struct hid_device *hdev,
+		struct hid_usage *usage, struct hid_field *field, __u8 type,
+		__u16 code, int fuzz)
 {
+	struct wacom *wacom = hid_get_drvdata(hdev);
+	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
 	int fmin = field->logical_minimum;
 	int fmax = field->logical_maximum;
 	unsigned int equivalent_usage = wacom_equivalent_usage(usage->hid);
@@ -1508,53 +1511,53 @@ static void wacom_wac_pen_usage_mapping(struct hid_device *hdev,
 
 	switch (equivalent_usage) {
 	case HID_GD_X:
-		wacom_map_usage(input, usage, field, EV_ABS, ABS_X, 4);
+		wacom_map_usage(input, hdev, usage, field, EV_ABS, ABS_X, 4);
 		break;
 	case HID_GD_Y:
-		wacom_map_usage(input, usage, field, EV_ABS, ABS_Y, 4);
+		wacom_map_usage(input, hdev, usage, field, EV_ABS, ABS_Y, 4);
 		break;
 	case WACOM_HID_WD_DISTANCE:
 	case HID_GD_Z:
-		wacom_map_usage(input, usage, field, EV_ABS, ABS_DISTANCE, 0);
+		wacom_map_usage(input, hdev, usage, field, EV_ABS, ABS_DISTANCE, 0);
 		break;
 	case HID_DG_TIPPRESSURE:
-		wacom_map_usage(input, usage, field, EV_ABS, ABS_PRESSURE, 0);
+		wacom_map_usage(input, hdev, usage, field, EV_ABS, ABS_PRESSURE, 0);
 		break;
 	case HID_DG_INRANGE:
-		wacom_map_usage(input, usage, field, EV_KEY, BTN_TOOL_PEN, 0);
+		wacom_map_usage(input, hdev, usage, field, EV_KEY, BTN_TOOL_PEN, 0);
 		break;
 	case HID_DG_INVERT:
-		wacom_map_usage(input, usage, field, EV_KEY,
+		wacom_map_usage(input, hdev, usage, field, EV_KEY,
 				BTN_TOOL_RUBBER, 0);
 		break;
 	case HID_DG_TILT_X:
-		wacom_map_usage(input, usage, field, EV_ABS, ABS_TILT_X, 0);
+		wacom_map_usage(input, hdev, usage, field, EV_ABS, ABS_TILT_X, 0);
 		break;
 	case HID_DG_TILT_Y:
-		wacom_map_usage(input, usage, field, EV_ABS, ABS_TILT_Y, 0);
+		wacom_map_usage(input, hdev, usage, field, EV_ABS, ABS_TILT_Y, 0);
 		break;
 	case HID_DG_TWIST:
-		wacom_map_usage(input, usage, field, EV_ABS, ABS_Z, 0);
+		wacom_map_usage(input, hdev, usage, field, EV_ABS, ABS_Z, 0);
 		break;
 	case HID_DG_ERASER:
 	case HID_DG_TIPSWITCH:
-		wacom_map_usage(input, usage, field, EV_KEY, BTN_TOUCH, 0);
+		wacom_map_usage(input, hdev, usage, field, EV_KEY, BTN_TOUCH, 0);
 		break;
 	case HID_DG_BARRELSWITCH:
-		wacom_map_usage(input, usage, field, EV_KEY, BTN_STYLUS, 0);
+		wacom_map_usage(input, hdev, usage, field, EV_KEY, BTN_STYLUS, 0);
 		break;
 	case HID_DG_BARRELSWITCH2:
-		wacom_map_usage(input, usage, field, EV_KEY, BTN_STYLUS2, 0);
+		wacom_map_usage(input, hdev, usage, field, EV_KEY, BTN_STYLUS2, 0);
 		break;
 	case HID_DG_TOOLSERIALNUMBER:
-		wacom_map_usage(input, usage, field, EV_MSC, MSC_SERIAL, 0);
+		wacom_map_usage(input, hdev, usage, field, EV_MSC, MSC_SERIAL, 0);
 		break;
 	case WACOM_HID_WD_SENSE:
 		features->quirks |= WACOM_QUIRK_SENSE;
-		wacom_map_usage(input, usage, field, EV_KEY, BTN_TOOL_PEN, 0);
+		wacom_map_usage(input, hdev, usage, field, EV_KEY, BTN_TOOL_PEN, 0);
 		break;
 	case WACOM_HID_WD_SERIALHI:
-		wacom_map_usage(input, usage, field, EV_ABS, ABS_MISC, 0);
+		wacom_map_usage(input, hdev, usage, field, EV_ABS, ABS_MISC, 0);
 		set_bit(EV_KEY, input->evbit);
 		input_set_capability(input, EV_KEY, BTN_TOOL_PEN);
 		input_set_capability(input, EV_KEY, BTN_TOOL_RUBBER);
@@ -1565,7 +1568,7 @@ static void wacom_wac_pen_usage_mapping(struct hid_device *hdev,
 		input_set_capability(input, EV_KEY, BTN_TOOL_LENS);
 		break;
 	case WACOM_HID_WD_FINGERWHEEL:
-		wacom_map_usage(input, usage, field, EV_ABS, ABS_WHEEL, 0);
+		wacom_map_usage(input, hdev, usage, field, EV_ABS, ABS_WHEEL, 0);
 		break;
 	}
 }
@@ -1722,24 +1725,24 @@ static void wacom_wac_finger_usage_mapping(struct hid_device *hdev,
 	case HID_GD_X:
 		features->last_slot_field = usage->hid;
 		if (touch_max == 1)
-			wacom_map_usage(input, usage, field, EV_ABS, ABS_X, 4);
+			wacom_map_usage(input, hdev, usage, field, EV_ABS, ABS_X, 4);
 		else
-			wacom_map_usage(input, usage, field, EV_ABS,
+			wacom_map_usage(input, hdev, usage, field, EV_ABS,
 					ABS_MT_POSITION_X, 4);
 		break;
 	case HID_GD_Y:
 		features->last_slot_field = usage->hid;
 		if (touch_max == 1)
-			wacom_map_usage(input, usage, field, EV_ABS, ABS_Y, 4);
+			wacom_map_usage(input, hdev, usage, field, EV_ABS, ABS_Y, 4);
 		else
-			wacom_map_usage(input, usage, field, EV_ABS,
+			wacom_map_usage(input, hdev, usage, field, EV_ABS,
 					ABS_MT_POSITION_Y, 4);
 		break;
 	case HID_DG_WIDTH:
 	case HID_DG_HEIGHT:
 		features->last_slot_field = usage->hid;
-		wacom_map_usage(input, usage, field, EV_ABS, ABS_MT_TOUCH_MAJOR, 0);
-		wacom_map_usage(input, usage, field, EV_ABS, ABS_MT_TOUCH_MINOR, 0);
+		wacom_map_usage(input, hdev, usage, field, EV_ABS, ABS_MT_TOUCH_MAJOR, 0);
+		wacom_map_usage(input, hdev, usage, field, EV_ABS, ABS_MT_TOUCH_MINOR, 0);
 		input_set_abs_params(input, ABS_MT_ORIENTATION, 0, 1, 0, 0);
 		break;
 	case HID_DG_CONTACTID:
@@ -1753,7 +1756,7 @@ static void wacom_wac_finger_usage_mapping(struct hid_device *hdev,
 		break;
 	case HID_DG_TIPSWITCH:
 		features->last_slot_field = usage->hid;
-		wacom_map_usage(input, usage, field, EV_KEY, BTN_TOUCH, 0);
+		wacom_map_usage(input, hdev, usage, field, EV_KEY, BTN_TOUCH, 0);
 		break;
 	case HID_DG_CONTACTCOUNT:
 		wacom_wac->hid_data.cc_report = field->report->id;
-- 
2.10.0

