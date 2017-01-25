From: Aaron Armstrong Skomra <skomra@gmail.com>
Subject: [PATCH 7/8] HID: wacom: generic: support generic touch switch
Date: Wed, 25 Jan 2017 12:08:41 -0800
Message-ID: <1485374922-3417-8-git-send-email-skomra@gmail.com>
References: <1485374922-3417-1-git-send-email-skomra@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34382 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbdAYUJl (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 25 Jan 2017 15:09:41 -0500
Received: by mail-pg0-f66.google.com with SMTP id 3so2782741pgj.1
        for <linux-input@vger.kernel.org>; Wed, 25 Jan 2017 12:09:41 -0800 (PST)
In-Reply-To: <1485374922-3417-1-git-send-email-skomra@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz, benjamin.tissoires@redhat.com, pinglinux@gmail.com, killertofu@gmail.com
Cc: Aaron Armstrong Skomra <skomra@gmail.com>, Aaron Skomra <aaron.skomra@wacom.com>

The second generation Intuos Pro is the first device
in the generic codepath which has a touchswitch. We
utilize a flag in wacom_shared in order to report
this switch event received from the pad on the touch
input.

Signed-off-by: Aaron Skomra <aaron.skomra@wacom.com>
---
 drivers/hid/wacom_sys.c | 26 +++++++++++++++++++-------
 drivers/hid/wacom_wac.c | 19 ++++++++++++++++++-
 drivers/hid/wacom_wac.h |  4 +++-
 3 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index a4884e7..a8e68dc 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2053,6 +2053,24 @@ static void wacom_release_resources(struct wacom *wacom)
 	wacom->wacom_wac.pad_input = NULL;
 }
 
+static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
+{
+	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
+		wacom_wac->shared->type = wacom_wac->features.type;
+		wacom_wac->shared->touch_input = wacom_wac->touch_input;
+	}
+
+	if (wacom_wac->has_mute_touch_switch)
+		wacom_wac->shared->has_mute_touch_switch = true;
+
+	if (wacom_wac->shared->has_mute_touch_switch &&
+	    wacom_wac->shared->touch_input) {
+		set_bit(EV_SW, wacom_wac->shared->touch_input->evbit);
+		input_set_capability(wacom_wac->shared->touch_input, EV_SW,
+				     SW_MUTE_DEVICE);
+	}
+}
+
 static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 {
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
@@ -2172,13 +2190,7 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR)
 		error = hid_hw_open(hdev);
 
-	if ((wacom_wac->features.type == INTUOSHT ||
-	     wacom_wac->features.type == INTUOSHT2) &&
-	    (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)) {
-		wacom_wac->shared->type = wacom_wac->features.type;
-		wacom_wac->shared->touch_input = wacom_wac->touch_input;
-	}
-
+	wacom_set_shared_values(wacom_wac);
 	devres_close_group(&hdev->dev, wacom);
 
 	return 0;
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 2eeaa05..06d152a 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1728,7 +1728,17 @@ static void wacom_wac_pad_usage_mapping(struct hid_device *hdev,
 		features->device_type |= WACOM_DEVICETYPE_PAD;
 		break;
 	case WACOM_HID_WD_TOUCHONOFF:
-		wacom_map_usage(input, usage, field, EV_SW, SW_MUTE_DEVICE, 0);
+		/*
+		 * This usage, which is used to mute touch events, comes
+		 * from the pad packet, but is reported on the touch
+		 * interface. Because the touch interface may not have
+		 * been created yet, we cannot call wacom_map_usage(). In
+		 * order to process this usage when we receive it, we set
+		 * the usage type and code directly.
+		 */
+		wacom_wac->has_mute_touch_switch = true;
+		usage->type = EV_SW;
+		usage->code = SW_MUTE_DEVICE;
 		features->device_type |= WACOM_DEVICETYPE_PAD;
 		break;
 	case WACOM_HID_WD_TOUCHSTRIP:
@@ -1807,6 +1817,13 @@ static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field
 			input_event(input, usage->type, usage->code, 0);
 		break;
 
+	case WACOM_HID_WD_TOUCHONOFF:
+		if (wacom_wac->shared->touch_input) {
+			input_report_switch(wacom_wac->shared->touch_input,
+					    SW_MUTE_DEVICE, !value);
+			input_sync(wacom_wac->shared->touch_input);
+		}
+		break;
 	default:
 		input_event(input, usage->type, usage->code, value);
 		break;
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index da38f77..4feaf94 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -115,6 +115,7 @@
 #define WACOM_HID_WD_ACCELEROMETER_Y    (WACOM_HID_UP_WACOMDIGITIZER | 0x0402)
 #define WACOM_HID_WD_ACCELEROMETER_Z    (WACOM_HID_UP_WACOMDIGITIZER | 0x0403)
 #define WACOM_HID_WD_BATTERY_CHARGING   (WACOM_HID_UP_WACOMDIGITIZER | 0x0404)
+#define WACOM_HID_WD_TOUCHONOFF         (WACOM_HID_UP_WACOMDIGITIZER | 0x0454)
 #define WACOM_HID_WD_BATTERY_LEVEL      (WACOM_HID_UP_WACOMDIGITIZER | 0x043b)
 #define WACOM_HID_WD_EXPRESSKEY00       (WACOM_HID_UP_WACOMDIGITIZER | 0x0910)
 #define WACOM_HID_WD_EXPRESSKEYCAP00    (WACOM_HID_UP_WACOMDIGITIZER | 0x0950)
@@ -124,7 +125,6 @@
 #define WACOM_HID_WD_BUTTONLEFT         (WACOM_HID_UP_WACOMDIGITIZER | 0x0993)
 #define WACOM_HID_WD_BUTTONRIGHT        (WACOM_HID_UP_WACOMDIGITIZER | 0x0994)
 #define WACOM_HID_WD_BUTTONCENTER       (WACOM_HID_UP_WACOMDIGITIZER | 0x0995)
-#define WACOM_HID_WD_TOUCHONOFF         (WACOM_HID_UP_WACOMDIGITIZER | 0x0996)
 #define WACOM_HID_WD_FINGERWHEEL        (WACOM_HID_UP_WACOMDIGITIZER | 0x0d03)
 #define WACOM_HID_WD_OFFSETLEFT         (WACOM_HID_UP_WACOMDIGITIZER | 0x0d30)
 #define WACOM_HID_WD_OFFSETTOP          (WACOM_HID_UP_WACOMDIGITIZER | 0x0d31)
@@ -268,6 +268,7 @@ struct wacom_shared {
 	struct input_dev *touch_input;
 	struct hid_device *pen;
 	struct hid_device *touch;
+	bool has_mute_touch_switch;
 };
 
 struct hid_data {
@@ -324,6 +325,7 @@ struct wacom_wac {
 	int mode_report;
 	int mode_value;
 	struct hid_data hid_data;
+	bool has_mute_touch_switch;
 };
 
 #endif
-- 
2.7.4

