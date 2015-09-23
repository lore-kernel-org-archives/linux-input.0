From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/2] HID: wacom: Add four new Intuos devices
Date: Wed, 23 Sep 2015 09:59:42 -0700
Message-ID: <1443027582-7322-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35062 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932172AbbIWQ7t (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Sep 2015 12:59:49 -0400
Received: by pacfv12 with SMTP id fv12so46118128pac.2
        for <linux-input@vger.kernel.org>; Wed, 23 Sep 2015 09:59:48 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, aaron.skomra@wacom.com, Ping Cheng <pingc@wacom.com>

Signed-off-by: Ping Cheng <pingc@wacom.com>
Tested-By: Aaron Skomra <aaron.skomra@wacom.com>
---
 drivers/hid/wacom_sys.c | 11 ++++--
 drivers/hid/wacom_wac.c | 97 +++++++++++++++++++++++++++++++++++++------------
 drivers/hid/wacom_wac.h |  2 +
 3 files changed, 82 insertions(+), 28 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index f4ba6a0..530476d 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1569,7 +1569,8 @@ static void wacom_wireless_work(struct work_struct *work)
 
 		/* Touch interface */
 		if (wacom_wac1->features.touch_max ||
-		    wacom_wac1->features.type == INTUOSHT) {
+		    (wacom_wac1->features.type >= INTUOSHT &&
+		    wacom_wac1->features.type <= BAMBOO_PT)) {
 			wacom_wac2->features =
 				*((struct wacom_features *)id->driver_data);
 			wacom_wac2->features.pktlen = WACOM_PKGLEN_BBTOUCH3;
@@ -1592,7 +1593,8 @@ static void wacom_wireless_work(struct work_struct *work)
 			if (error)
 				goto fail;
 
-			if (wacom_wac1->features.type == INTUOSHT &&
+			if ((wacom_wac1->features.type == INTUOSHT ||
+			    wacom_wac1->features.type == INTUOSHT2) &&
 			    wacom_wac1->features.touch_max)
 				wacom_wac->shared->touch_input = wacom_wac2->touch_input;
 		}
@@ -1834,8 +1836,9 @@ static int wacom_probe(struct hid_device *hdev,
 	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR)
 		error = hid_hw_open(hdev);
 
-	if (wacom_wac->features.type == INTUOSHT && 
-	    wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
+	if ((wacom_wac->features.type == INTUOSHT ||
+	    wacom_wac->features.type == INTUOSHT2) &&
+	    (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)) {
 			wacom_wac->shared->touch_input = wacom_wac->touch_input;
 	}
 
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index af734ef..a0d875c 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -769,9 +769,11 @@ static void wacom_intuos_general(struct wacom_wac *wacom)
 			t = (t << 1) | (data[1] & 1);
 		}
 		input_report_abs(input, ABS_PRESSURE, t);
-		input_report_abs(input, ABS_TILT_X,
+		if (features->type != INTUOSHT2) {
+		    input_report_abs(input, ABS_TILT_X,
 				 (((data[7] << 1) & 0x7e) | (data[8] >> 7)) - 64);
-		input_report_abs(input, ABS_TILT_Y, (data[8] & 0x7f) - 64);
+		    input_report_abs(input, ABS_TILT_Y, (data[8] & 0x7f) - 64);
+		}
 		input_report_key(input, BTN_STYLUS, data[1] & 2);
 		input_report_key(input, BTN_STYLUS2, data[1] & 4);
 		input_report_key(input, BTN_TOUCH, t > 10);
@@ -799,6 +801,7 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 	    data[0] != WACOM_REPORT_INTUOSREAD &&
 	    data[0] != WACOM_REPORT_INTUOSWRITE &&
 	    data[0] != WACOM_REPORT_INTUOSPAD &&
+	    data[0] != WACOM_REPORT_INTUOS_PEN &&
 	    data[0] != WACOM_REPORT_CINTIQ &&
 	    data[0] != WACOM_REPORT_CINTIQPAD &&
 	    data[0] != WACOM_REPORT_INTUOS5PAD) {
@@ -1896,7 +1899,7 @@ static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data)
 		int y = (data[3] << 4) | (data[4] & 0x0f);
 		int width, height;
 
-		if (features->type >= INTUOSPS && features->type <= INTUOSHT) {
+		if (features->type >= INTUOSPS && features->type <= INTUOSHT2) {
 			width  = data[5] * 100;
 			height = data[6] * 100;
 		} else {
@@ -1924,7 +1927,7 @@ static void wacom_bpt3_button_msg(struct wacom_wac *wacom, unsigned char *data)
 	struct input_dev *input = wacom->pad_input;
 	struct wacom_features *features = &wacom->features;
 
-	if (features->type == INTUOSHT) {
+	if (features->type == INTUOSHT || features->type == INTUOSHT2) {
 		input_report_key(input, BTN_LEFT, (data[1] & 0x02) != 0);
 		input_report_key(input, BTN_BACK, (data[1] & 0x08) != 0);
 	} else {
@@ -1939,7 +1942,7 @@ static int wacom_bpt3_touch(struct wacom_wac *wacom)
 {
 	unsigned char *data = wacom->data;
 	int count = data[1] & 0x07;
-	int i;
+	int  touch_changed = 0, i;
 
 	if (data[0] != 0x02)
 	    return 0;
@@ -1949,15 +1952,16 @@ static int wacom_bpt3_touch(struct wacom_wac *wacom)
 		int offset = (8 * i) + 2;
 		int msg_id = data[offset];
 
-		if (msg_id >= 2 && msg_id <= 17)
+		if (msg_id >= 2 && msg_id <= 17) {
 			wacom_bpt3_touch_msg(wacom, data + offset);
-		else if (msg_id == 128)
+			touch_changed++;
+		} else if (msg_id == 128)
 			wacom_bpt3_button_msg(wacom, data + offset);
 
 	}
 
-	/* only update the touch if we actually have a touchpad */
-	if (wacom->touch_registered) {
+	/* only update touch if we actually have a touchpad and touch data changed */
+	if (wacom->touch_registered && touch_changed) {
 		input_mt_sync_frame(wacom->touch_input);
 		wacom->shared->touch_down = wacom_wac_finger_count_touches(wacom);
 	}
@@ -2038,7 +2042,13 @@ static int wacom_bpt_pen(struct wacom_wac *wacom)
 
 static int wacom_bpt_irq(struct wacom_wac *wacom, size_t len)
 {
-	if (len == WACOM_PKGLEN_BBTOUCH)
+	struct wacom_features *features = &wacom->features;
+
+	if ((features->type == INTUOSHT2) &&
+	    (wacom->data[0] == WACOM_REPORT_INTUOS_PEN) &&
+	    (features->device_type & WACOM_DEVICETYPE_PEN))
+		return wacom_intuos_irq(wacom);
+	else if (len == WACOM_PKGLEN_BBTOUCH)
 		return wacom_bpt_touch(wacom);
 	else if (len == WACOM_PKGLEN_BBTOUCH3)
 		return wacom_bpt3_touch(wacom);
@@ -2145,7 +2155,8 @@ static int wacom_wireless_irq(struct wacom_wac *wacom, size_t len)
 	if (connected) {
 		int pid, battery, charging;
 
-		if ((wacom->shared->type == INTUOSHT) &&
+		if ((wacom->shared->type == INTUOSHT ||
+		    wacom->shared->type == INTUOSHT2) &&
 		    wacom->shared->touch_input &&
 		    wacom->shared->touch_max) {
 			input_report_switch(wacom->shared->touch_input,
@@ -2183,7 +2194,8 @@ static int wacom_status_irq(struct wacom_wac *wacom_wac, size_t len)
 	if (data[0] != WACOM_REPORT_USB)
 		return 0;
 
-	if (features->type == INTUOSHT &&
+	if ((features->type == INTUOSHT ||
+	    features->type == INTUOSHT2) &&
 	    wacom_wac->shared->touch_input &&
 	    features->touch_max) {
 		input_report_switch(wacom_wac->shared->touch_input,
@@ -2303,6 +2315,7 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 	case BAMBOO_PEN:
 	case BAMBOO_TOUCH:
 	case INTUOSHT:
+	case INTUOSHT2:
 		if (wacom_wac->data[0] == WACOM_REPORT_USB)
 			sync = wacom_status_irq(wacom_wac, len);
 		else
@@ -2339,22 +2352,31 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 	}
 }
 
-static void wacom_setup_cintiq(struct wacom_wac *wacom_wac)
+static void wacom_setup_basic_pro_pen(struct wacom_wac *wacom_wac)
 {
 	struct input_dev *input_dev = wacom_wac->pen_input;
 
 	input_set_capability(input_dev, EV_MSC, MSC_SERIAL);
 
-	__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
 	__set_bit(BTN_TOOL_PEN, input_dev->keybit);
-	__set_bit(BTN_TOOL_BRUSH, input_dev->keybit);
-	__set_bit(BTN_TOOL_PENCIL, input_dev->keybit);
-	__set_bit(BTN_TOOL_AIRBRUSH, input_dev->keybit);
 	__set_bit(BTN_STYLUS, input_dev->keybit);
 	__set_bit(BTN_STYLUS2, input_dev->keybit);
 
 	input_set_abs_params(input_dev, ABS_DISTANCE,
 			     0, wacom_wac->features.distance_max, 0, 0);
+}
+
+static void wacom_setup_cintiq(struct wacom_wac *wacom_wac)
+{
+	struct input_dev *input_dev = wacom_wac->pen_input;
+
+	wacom_setup_basic_pro_pen(wacom_wac);
+
+	__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
+	__set_bit(BTN_TOOL_BRUSH, input_dev->keybit);
+	__set_bit(BTN_TOOL_PENCIL, input_dev->keybit);
+	__set_bit(BTN_TOOL_AIRBRUSH, input_dev->keybit);
+
 	input_set_abs_params(input_dev, ABS_WHEEL, 0, 1023, 0, 0);
 	input_set_abs_params(input_dev, ABS_TILT_X, -64, 63, 0, 0);
 	input_abs_set_res(input_dev, ABS_TILT_X, 57);
@@ -2600,16 +2622,21 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 	case INTUOSHT:
 	case BAMBOO_PT:
 	case BAMBOO_PEN:
-		__clear_bit(ABS_MISC, input_dev->absbit);
-
+	case INTUOSHT2:
 		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
-		__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
-		__set_bit(BTN_TOOL_PEN, input_dev->keybit);
-		__set_bit(BTN_STYLUS, input_dev->keybit);
-		__set_bit(BTN_STYLUS2, input_dev->keybit);
-		input_set_abs_params(input_dev, ABS_DISTANCE, 0,
+
+		if (features->type == INTUOSHT2) {
+			wacom_setup_basic_pro_pen(wacom_wac);
+		} else {
+			__clear_bit(ABS_MISC, input_dev->absbit);
+			__set_bit(BTN_TOOL_PEN, input_dev->keybit);
+			__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
+			__set_bit(BTN_STYLUS, input_dev->keybit);
+			__set_bit(BTN_STYLUS2, input_dev->keybit);
+			input_set_abs_params(input_dev, ABS_DISTANCE, 0,
 				      features->distance_max,
 				      0, 0);
+		}
 		break;
 	case BAMBOO_PAD:
 		__clear_bit(ABS_MISC, input_dev->absbit);
@@ -2690,6 +2717,7 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 		break;
 
 	case INTUOSHT:
+	case INTUOSHT2:
 		input_dev->evbit[0] |= BIT_MASK(EV_SW);
 		__set_bit(SW_MUTE_DEVICE, input_dev->swbit);
 		/* fall through */
@@ -2849,6 +2877,7 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 	case INTUOSHT:
 	case BAMBOO_PT:
 	case BAMBOO_TOUCH:
+	case INTUOSHT2:
 		__clear_bit(ABS_MISC, input_dev->absbit);
 
 		__set_bit(BTN_LEFT, input_dev->keybit);
@@ -3335,6 +3364,22 @@ static const struct wacom_features wacom_features_0x331 =
 	{ "Wacom Express Key Remote", .type = REMOTE,
 	  .numbered_buttons = 18, .check_for_hid_type = true,
 	  .hid_type = HID_TYPE_USBNONE };
+static const struct wacom_features wacom_features_0x33B =
+	{ "Wacom Intuos S 2", 15200, 9500, 2047, 63,
+	  INTUOSHT2, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
+	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
+static const struct wacom_features wacom_features_0x33C =
+	{ "Wacom Intuos PT S 2", 15200, 9500, 2047, 63,
+	  INTUOSHT2, WACOM_INTUOS_RES, WACOM_INTUOS_RES, .touch_max = 16,
+	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
+static const struct wacom_features wacom_features_0x33D =
+	{ "Wacom Intuos P M 2", 21600, 13500, 2047, 63,
+	  INTUOSHT2, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
+	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
+static const struct wacom_features wacom_features_0x33E =
+	{ "Wacom Intuos PT M 2", 21600, 13500, 2047, 63,
+	  INTUOSHT2, WACOM_INTUOS_RES, WACOM_INTUOS_RES, .touch_max = 16,
+	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
 
 static const struct wacom_features wacom_features_HID_ANY_ID =
 	{ "Wacom HID", .type = HID_GENERIC };
@@ -3494,6 +3539,10 @@ const struct hid_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x333) },
 	{ USB_DEVICE_WACOM(0x335) },
 	{ USB_DEVICE_WACOM(0x336) },
+	{ USB_DEVICE_WACOM(0x33B) },
+	{ USB_DEVICE_WACOM(0x33C) },
+	{ USB_DEVICE_WACOM(0x33D) },
+	{ USB_DEVICE_WACOM(0x33E) },
 	{ USB_DEVICE_WACOM(0x4001) },
 	{ USB_DEVICE_WACOM(0x4004) },
 	{ USB_DEVICE_WACOM(0x5000) },
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 3f24520..1a30e44 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -68,6 +68,7 @@
 #define WACOM_REPORT_BPAD_PEN		3
 #define WACOM_REPORT_BPAD_TOUCH		16
 #define WACOM_REPORT_DEVICE_LIST	16
+#define WACOM_REPORT_INTUOS_PEN		16
 #define WACOM_REPORT_REMOTE		17
 
 /* device quirks */
@@ -130,6 +131,7 @@ enum {
 	WIRELESS,
 	BAMBOO_PEN,
 	INTUOSHT,
+	INTUOSHT2,
 	BAMBOO_TOUCH,
 	BAMBOO_PT,
 	WACOM_24HDT,
-- 
1.9.1

