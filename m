From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 4/4 v3] input - wacom: Support 2FGT in MT format
Date: Tue,  1 Mar 2011 16:19:02 -0800
Message-ID: <1299025142-8626-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61193 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757298Ab1CBAUQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Mar 2011 19:20:16 -0500
Received: by mail-pw0-f46.google.com with SMTP id 15so997114pwi.19
        for <linux-input@vger.kernel.org>; Tue, 01 Mar 2011 16:20:16 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: rydberg@euromail.se, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>
Signed-off-by: Ping Cheng <pingc@wacom.com>
---
v3: Use contact_with_no_pen_down_count instead of individual touch
state to decide touch_down status.
---
 drivers/input/tablet/wacom_sys.c |   12 ++++----
 drivers/input/tablet/wacom_wac.c |   59 ++++++++++++++++++++++++++++++--------
 2 files changed, 53 insertions(+), 18 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index cf8fb9f..449c0a4 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -193,16 +193,16 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
 			case HID_USAGE_X:
 				if (usage == WCM_DESKTOP) {
 					if (finger) {
-						features->device_type = BTN_TOOL_DOUBLETAP;
+						features->device_type = BTN_TOOL_FINGER;
 						if (features->type == TABLETPC2FG) {
 							/* need to reset back */
 							features->pktlen = WACOM_PKGLEN_TPC2FG;
-							features->device_type = BTN_TOOL_TRIPLETAP;
+							features->device_type = BTN_TOOL_DOUBLETAP;
 						}
 						if (features->type == BAMBOO_PT) {
 							/* need to reset back */
 							features->pktlen = WACOM_PKGLEN_BBTOUCH;
-							features->device_type = BTN_TOOL_TRIPLETAP;
+							features->device_type = BTN_TOOL_DOUBLETAP;
 							features->x_phy =
 								get_unaligned_le16(&report[i + 5]);
 							features->x_max =
@@ -241,11 +241,11 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
 			case HID_USAGE_Y:
 				if (usage == WCM_DESKTOP) {
 					if (finger) {
-						features->device_type = BTN_TOOL_DOUBLETAP;
+						features->device_type = BTN_TOOL_FINGER;
 						if (features->type == TABLETPC2FG) {
 							/* need to reset back */
 							features->pktlen = WACOM_PKGLEN_TPC2FG;
-							features->device_type = BTN_TOOL_TRIPLETAP;
+							features->device_type = BTN_TOOL_DOUBLETAP;
 							features->y_max =
 								get_unaligned_le16(&report[i + 3]);
 							features->y_phy =
@@ -254,7 +254,7 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
 						} else if (features->type == BAMBOO_PT) {
 							/* need to reset back */
 							features->pktlen = WACOM_PKGLEN_BBTOUCH;
-							features->device_type = BTN_TOOL_TRIPLETAP;
+							features->device_type = BTN_TOOL_DOUBLETAP;
 							features->y_phy =
 								get_unaligned_le16(&report[i + 3]);
 							features->y_max =
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index ebbb375..f6041f4 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -675,6 +675,37 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 	return 1;
 }
 
+static int wacom_tpc_mt_touch(struct wacom_wac *wacom)
+{
+	struct input_dev *input = wacom->input;
+	unsigned char *data = wacom->data;
+	int contact_with_no_pen_down_count = 0;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		int p = data[1] & (1 << i);
+		bool touch = p && !wacom->shared->stylus_in_proximity;
+
+		input_mt_slot(input, i);
+		input_mt_report_slot_state(input, MT_TOOL_FINGER, touch);
+		if (touch) {
+			int x = le16_to_cpup((__le16 *)&data[i * 2 + 2]) & 0x7fff;
+			int y = le16_to_cpup((__le16 *)&data[i * 2 + 6]) & 0x7fff;
+
+			input_report_abs(input, ABS_MT_POSITION_X, x);
+			input_report_abs(input, ABS_MT_POSITION_Y, y);
+			contact_with_no_pen_down_count++;
+		}
+	}
+
+	/* keep touch state for pen event */
+	wacom->shared->touch_down = (contact_with_no_pen_down_count > 0);
+
+	input_mt_report_pointer_emulation(input, true);
+
+	return 1;
+}
+
 static int wacom_tpc_single_touch(struct wacom_wac *wacom, size_t len)
 {
 	char *data = wacom->data;
@@ -758,6 +789,8 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
 
 	if (len == WACOM_PKGLEN_TPC1FG || data[0] == WACOM_REPORT_TPC1FG)
 		return wacom_tpc_single_touch(wacom, len);
+	else if (data[0] == WACOM_REPORT_TPC2FG)
+		return wacom_tpc_mt_touch(wacom);
 	else if (data[0] == WACOM_REPORT_PENABLED)
 		return wacom_tpc_pen(wacom);
 
@@ -984,7 +1017,7 @@ void wacom_setup_device_quirks(struct wacom_features *features)
 {
 
 	/* touch device found but size is not defined. use default */
-	if (features->device_type == BTN_TOOL_DOUBLETAP && !features->x_max) {
+	if (features->device_type == BTN_TOOL_FINGER && !features->x_max) {
 		features->x_max = 1023;
 		features->y_max = 1023;
 	}
@@ -996,7 +1029,7 @@ void wacom_setup_device_quirks(struct wacom_features *features)
 
 	/* quirks for bamboo touch */
 	if (features->type == BAMBOO_PT &&
-	    features->device_type == BTN_TOOL_TRIPLETAP) {
+	    features->device_type == BTN_TOOL_DOUBLETAP) {
 		features->x_max <<= 5;
 		features->y_max <<= 5;
 		features->x_fuzz <<= 5;
@@ -1132,28 +1165,30 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 		break;
 
 	case TABLETPC2FG:
-		if (features->device_type == BTN_TOOL_TRIPLETAP) {
-			__set_bit(BTN_TOOL_TRIPLETAP, input_dev->keybit);
-			input_set_capability(input_dev, EV_MSC, MSC_SERIAL);
+		if (features->device_type == BTN_TOOL_DOUBLETAP) {
+
+			input_mt_init_slots(input_dev, 2);
+			input_set_abs_params(input_dev, ABS_MT_TOOL_TYPE,
+					0, MT_TOOL_MAX, 0, 0);
+			input_set_abs_params(input_dev, ABS_MT_POSITION_X,
+					0, features->x_max, 0, 0);
+			input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
+					0, features->y_max, 0, 0);
 		}
 		/* fall through */
 
 	case TABLETPC:
 		__clear_bit(ABS_MISC, input_dev->absbit);
 
-		if (features->device_type == BTN_TOOL_DOUBLETAP ||
-		    features->device_type == BTN_TOOL_TRIPLETAP) {
+		if (features->device_type != BTN_TOOL_PEN) {
 			input_abs_set_res(input_dev, ABS_X,
 				wacom_calculate_touch_res(features->x_max,
 							features->x_phy));
 			input_abs_set_res(input_dev, ABS_Y,
 				wacom_calculate_touch_res(features->y_max,
 							features->y_phy));
-		}
-
-		if (features->device_type != BTN_TOOL_PEN)
 			break;  /* no need to process stylus stuff */
-
+		}
 		/* fall through */
 
 	case PL:
@@ -1171,7 +1206,7 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 	case BAMBOO_PT:
 		__clear_bit(ABS_MISC, input_dev->absbit);
 
-		if (features->device_type == BTN_TOOL_TRIPLETAP) {
+		if (features->device_type == BTN_TOOL_DOUBLETAP) {
 			__set_bit(BTN_LEFT, input_dev->keybit);
 			__set_bit(BTN_FORWARD, input_dev->keybit);
 			__set_bit(BTN_BACK, input_dev->keybit);
-- 
1.7.4

