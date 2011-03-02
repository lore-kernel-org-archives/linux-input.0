From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 3/4 v3] input - wacom : support one finger touch the touchscreen way
Date: Tue,  1 Mar 2011 16:18:43 -0800
Message-ID: <1299025123-8588-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61193 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757298Ab1CBATz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Mar 2011 19:19:55 -0500
Received: by pwi15 with SMTP id 15so997114pwi.19
        for <linux-input@vger.kernel.org>; Tue, 01 Mar 2011 16:19:55 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: rydberg@euromail.se, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

There are two types of 1FGT devices supported in wacom_wac.c.
Changing them to follow the existing touchscreen format, i.e.,
only report BTN_TOUCH as a valid tool type.

Touch data will be ignored if pen is in proximity. This requires
a touch up event sent if touch was down when pen comes in. The
touch up event should be sent before any pen events are emitted.
Otherwise, two pointers would race for the cursor.

However, we can not send a touch up inside wacom_tpc_pen since
pen and touch are on different logical port. That is why we
have to check if touch is up before sending pen events.

Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>
Signed-off-by: Ping Cheng <pingc@wacom.com>
---
v3: Simplify the pen and touch logical flow to avoid manual state
change.
---
 drivers/input/tablet/wacom_wac.c |  130 ++++++++++++++-----------------------
 drivers/input/tablet/wacom_wac.h |    1 +
 2 files changed, 50 insertions(+), 81 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 15bab99..ebbb375 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -675,51 +675,37 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 	return 1;
 }
 
-static void wacom_tpc_touch_out(struct wacom_wac *wacom, int idx)
-{
-	struct input_dev *input = wacom->input;
-	int finger = idx + 1;
-
-	input_report_abs(input, ABS_X, 0);
-	input_report_abs(input, ABS_Y, 0);
-	input_report_abs(input, ABS_MISC, 0);
-	input_report_key(input, wacom->tool[finger], 0);
-	if (!idx)
-		input_report_key(input, BTN_TOUCH, 0);
-	input_event(input, EV_MSC, MSC_SERIAL, finger);
-	input_sync(input);
-}
-
-static void wacom_tpc_touch_in(struct wacom_wac *wacom, size_t len)
+static int wacom_tpc_single_touch(struct wacom_wac *wacom, size_t len)
 {
 	char *data = wacom->data;
 	struct input_dev *input = wacom->input;
+	bool prox = 0;
+	int x = 0, y = 0;
 
-	wacom->tool[1] = BTN_TOOL_DOUBLETAP;
-	wacom->id[0] = TOUCH_DEVICE_ID;
+	if (!wacom->shared->stylus_in_proximity) {
+		if (len == WACOM_PKGLEN_TPC1FG) {
+			prox = data[0] & 0x01;
+			x = get_unaligned_le16(&data[1]);
+			y = get_unaligned_le16(&data[3]);
+		} else { /* with capacity */
+			prox = data[1] & 0x01;
+			x = le16_to_cpup((__le16 *)&data[2]);
+			y = le16_to_cpup((__le16 *)&data[4]);
+		}
+	} else
+		/* force touch out when pen is in prox */
+		prox = 0;
 
-	if (len != WACOM_PKGLEN_TPC1FG) {
+	if (prox) {
+		input_report_abs(input, ABS_X, x);
+		input_report_abs(input, ABS_Y, y);
+	}
+	input_report_key(input, BTN_TOUCH, prox);
 
-		switch (data[0]) {
+	/* keep touch state for pen events */
+	wacom->shared->touch_down = prox;
 
-		case WACOM_REPORT_TPC1FG:
-			input_report_abs(input, ABS_X, le16_to_cpup((__le16 *)&data[2]));
-			input_report_abs(input, ABS_Y, le16_to_cpup((__le16 *)&data[4]));
-			input_report_abs(input, ABS_PRESSURE, le16_to_cpup((__le16 *)&data[6]));
-			input_report_key(input, BTN_TOUCH, le16_to_cpup((__le16 *)&data[6]));
-			input_report_abs(input, ABS_MISC, wacom->id[0]);
-			input_report_key(input, wacom->tool[1], 1);
-			input_sync(input);
-			break;
-		}
-	} else {
-		input_report_abs(input, ABS_X, get_unaligned_le16(&data[1]));
-		input_report_abs(input, ABS_Y, get_unaligned_le16(&data[3]));
-		input_report_key(input, BTN_TOUCH, 1);
-		input_report_abs(input, ABS_MISC, wacom->id[1]);
-		input_report_key(input, wacom->tool[1], 1);
-		input_sync(input);
-	}
+	return 1;
 }
 
 static int wacom_tpc_pen(struct wacom_wac *wacom)
@@ -731,7 +717,7 @@ static int wacom_tpc_pen(struct wacom_wac *wacom)
 
 	prox = data[1] & 0x20;
 
-	if (!wacom->shared->stylus_in_proximity) { /* first in prox */
+	if (!wacom->shared->stylus_in_proximity) {
 		/* Going into proximity select tool */
 		wacom->tool[0] = (data[1] & 0x0c) ? BTN_TOOL_RUBBER : BTN_TOOL_PEN;
 		if (wacom->tool[0] == BTN_TOOL_PEN)
@@ -741,57 +727,38 @@ static int wacom_tpc_pen(struct wacom_wac *wacom)
 
 		wacom->shared->stylus_in_proximity = true;
 	}
-	input_report_key(input, BTN_STYLUS, data[1] & 0x02);
-	input_report_key(input, BTN_STYLUS2, data[1] & 0x10);
-	input_report_abs(input, ABS_X, le16_to_cpup((__le16 *)&data[2]));
-	input_report_abs(input, ABS_Y, le16_to_cpup((__le16 *)&data[4]));
-	pressure = ((data[7] & 0x01) << 8) | data[6];
-	if (pressure < 0)
-		pressure = features->pressure_max + pressure + 1;
-	input_report_abs(input, ABS_PRESSURE, pressure);
-	input_report_key(input, BTN_TOUCH, data[1] & 0x05);
-	if (!prox) { /* out-prox */
-		wacom->id[0] = 0;
-		wacom->shared->stylus_in_proximity = false;
+
+	/* send pen events only when touch is up or touch are forced out */
+	if (!wacom->shared->touch_down) {
+		input_report_key(input, BTN_STYLUS, data[1] & 0x02);
+		input_report_key(input, BTN_STYLUS2, data[1] & 0x10);
+		input_report_abs(input, ABS_X, le16_to_cpup((__le16 *)&data[2]));
+		input_report_abs(input, ABS_Y, le16_to_cpup((__le16 *)&data[4]));
+		pressure = ((data[7] & 0x01) << 8) | data[6];
+		if (pressure < 0)
+			pressure = features->pressure_max + pressure + 1;
+		input_report_abs(input, ABS_PRESSURE, pressure);
+		input_report_key(input, BTN_TOUCH, data[1] & 0x05);
+		if (!prox) { /* out-prox */
+			wacom->id[0] = 0;
+			wacom->shared->stylus_in_proximity = false;
+		}
+		input_report_key(input, wacom->tool[0], prox);
+		return 1;
 	}
-	input_report_key(input, wacom->tool[0], prox);
 
-	return 1;
+	return 0;
 }
 
 static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
 {
 	char *data = wacom->data;
-	int prox = 0;
 
 	dbg("wacom_tpc_irq: received report #%d", data[0]);
 
-	if (len == WACOM_PKGLEN_TPC1FG ||
-	    data[0] == WACOM_REPORT_TPC1FG) {	/* single touch */
-
-		if (wacom->shared->stylus_in_proximity) {
-			if (wacom->id[1] & 0x01)
-				wacom_tpc_touch_out(wacom, 0);
-
-			wacom->id[1] = 0;
-			return 0;
-		}
-
-		if (len == WACOM_PKGLEN_TPC1FG)
-			prox = data[0] & 0x01;
-		else  /* with capacity */
-			prox = data[1] & 0x01;
-
-		if (prox)
-			wacom_tpc_touch_in(wacom, len);
-		else {
-			wacom_tpc_touch_out(wacom, 0);
-
-			wacom->id[0] = 0;
-		}
-		/* keep prox bit to send proper out-prox event */
-		wacom->id[1] = prox;
-	} else if (data[0] == WACOM_REPORT_PENABLED)
+	if (len == WACOM_PKGLEN_TPC1FG || data[0] == WACOM_REPORT_TPC1FG)
+		return wacom_tpc_single_touch(wacom, len);
+	else if (data[0] == WACOM_REPORT_PENABLED)
 		return wacom_tpc_pen(wacom);
 
 	return 0;
@@ -1172,6 +1139,8 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 		/* fall through */
 
 	case TABLETPC:
+		__clear_bit(ABS_MISC, input_dev->absbit);
+
 		if (features->device_type == BTN_TOOL_DOUBLETAP ||
 		    features->device_type == BTN_TOOL_TRIPLETAP) {
 			input_abs_set_res(input_dev, ABS_X,
@@ -1180,7 +1149,6 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 			input_abs_set_res(input_dev, ABS_Y,
 				wacom_calculate_touch_res(features->y_max,
 							features->y_phy));
-			__set_bit(BTN_TOOL_DOUBLETAP, input_dev->keybit);
 		}
 
 		if (features->device_type != BTN_TOOL_PEN)
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index 8f747dd..835f756 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -88,6 +88,7 @@ struct wacom_features {
 
 struct wacom_shared {
 	bool stylus_in_proximity;
+	bool touch_down;
 };
 
 struct wacom_wac {
-- 
1.7.4

