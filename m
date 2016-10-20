From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v3 06/18] HID: wacom: generic: Add support for height, tilt, and twist usages
Date: Wed, 19 Oct 2016 18:03:42 -0700
Message-ID: <20161020010354.4049-6-killertofu@gmail.com>
References: <20161006212231.31440-1-killertofu@gmail.com>
 <20161020010354.4049-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33879 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753800AbcJTBE1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 19 Oct 2016 21:04:27 -0400
Received: by mail-pf0-f194.google.com with SMTP id 128so3847426pfz.1
        for <linux-input@vger.kernel.org>; Wed, 19 Oct 2016 18:04:26 -0700 (PDT)
In-Reply-To: <20161020010354.4049-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, Jason Gerecke <killertofu@gmail.com>

The HID standard defines usages that allow digitizers to report the pen's
height, tilt, and rotation and which are used by Wacom's new "MobileStudio
Pro" devices.

Note that 'hidinput_calc_abs_res' expects ABS_Z (historically used by our
driver to report twist) to have linear units. To ensure it calculates a
resolution with the actually-angular units provided in the HID descriptor
we nedd to lie and tell it we're calculating it for the (rotational) ABS_RZ
axis instead.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_wac.c | 28 ++++++++++++++++++++++++++--
 include/linux/hid.h     |  3 +++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 8071c18..3f4ba53 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1440,6 +1440,11 @@ static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
 {
 	int fmin = field->logical_minimum;
 	int fmax = field->logical_maximum;
+	int resolution_code = code;
+
+	if (usage->hid == HID_DG_TWIST) {
+		resolution_code = ABS_RZ;
+	}
 
 	usage->type = type;
 	usage->code = code;
@@ -1450,7 +1455,7 @@ static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
 	case EV_ABS:
 		input_set_abs_params(input, code, fmin, fmax, fuzz, 0);
 		input_abs_set_res(input, code,
-				  hidinput_calc_abs_res(field, code));
+				  hidinput_calc_abs_res(field, resolution_code));
 		break;
 	case EV_KEY:
 		input_set_capability(input, EV_KEY, code);
@@ -1475,6 +1480,9 @@ static void wacom_wac_pen_usage_mapping(struct hid_device *hdev,
 	case HID_GD_Y:
 		wacom_map_usage(input, usage, field, EV_ABS, ABS_Y, 4);
 		break;
+	case HID_GD_Z:
+		wacom_map_usage(input, usage, field, EV_ABS, ABS_DISTANCE, 0);
+		break;
 	case HID_DG_TIPPRESSURE:
 		wacom_map_usage(input, usage, field, EV_ABS, ABS_PRESSURE, 0);
 		break;
@@ -1485,6 +1493,15 @@ static void wacom_wac_pen_usage_mapping(struct hid_device *hdev,
 		wacom_map_usage(input, usage, field, EV_KEY,
 				BTN_TOOL_RUBBER, 0);
 		break;
+	case HID_DG_TILT_X:
+		wacom_map_usage(input, usage, field, EV_ABS, ABS_TILT_X, 0);
+		break;
+	case HID_DG_TILT_Y:
+		wacom_map_usage(input, usage, field, EV_ABS, ABS_TILT_Y, 0);
+		break;
+	case HID_DG_TWIST:
+		wacom_map_usage(input, usage, field, EV_ABS, ABS_Z, 0);
+		break;
 	case HID_DG_ERASER:
 	case HID_DG_TIPSWITCH:
 		wacom_map_usage(input, usage, field, EV_KEY, BTN_TOUCH, 0);
@@ -1508,8 +1525,15 @@ static int wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field,
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
 	struct input_dev *input = wacom_wac->pen_input;
 
-	/* checking which Tool / tip switch to send */
 	switch (usage->hid) {
+	case HID_GD_Z:
+		/*
+		 * HID_GD_Z "should increase as the control's position is
+		 * moved from high to low", while ABS_DISTANCE instead
+		 * increases in value as the tool moves from low to high.
+		 */
+		value = field->logical_maximum - value;
+		break;
 	case HID_DG_INRANGE:
 		wacom_wac->hid_data.inrange_state = value;
 		return 0;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index b2ec827..e712101 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -232,6 +232,9 @@ struct hid_item {
 #define HID_DG_TABLETFUNCTIONKEY	0x000d0039
 #define HID_DG_PROGRAMCHANGEKEY	0x000d003a
 #define HID_DG_INVERT		0x000d003c
+#define HID_DG_TILT_X		0x000d003d
+#define HID_DG_TILT_Y		0x000d003e
+#define HID_DG_TWIST		0x000d0041
 #define HID_DG_TIPSWITCH	0x000d0042
 #define HID_DG_TIPSWITCH2	0x000d0043
 #define HID_DG_BARRELSWITCH	0x000d0044
-- 
2.10.0

