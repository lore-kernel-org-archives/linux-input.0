From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/4] input : wacom - Remove 2FGT Tablet PC events in TAP format
Date: Wed, 16 Feb 2011 14:52:09 -0800
Message-ID: <1297896729-2484-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:37396 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346Ab1BPWxF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Feb 2011 17:53:05 -0500
Received: by gwj20 with SMTP id 20so846916gwj.19
        for <linux-input@vger.kernel.org>; Wed, 16 Feb 2011 14:53:04 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: rydberg@euromail.se, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

2FGT Tablet PC touch events were processed in _TAP_ format. Remove
them so we can change to _MT_ format.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |   84 ++++----------------------------------
 drivers/input/tablet/wacom_wac.h |    5 +-
 2 files changed, 10 insertions(+), 79 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 367fa82..5488c61 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -675,40 +675,6 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 	return 1;
 }
 
-
-static void wacom_tpc_finger_in(struct wacom_wac *wacom, char *data, int idx)
-{
-	struct input_dev *input = wacom->input;
-	int finger = idx + 1;
-	int x = le16_to_cpup((__le16 *)&data[finger * 2]) & 0x7fff;
-	int y = le16_to_cpup((__le16 *)&data[4 + finger * 2]) & 0x7fff;
-
-	/*
-	 * Work around input core suppressing "duplicate" events since
-	 * we are abusing ABS_X/ABS_Y to transmit multi-finger data.
-	 * This should go away once we switch to true multitouch
-	 * protocol.
-	 */
-	if (wacom->last_finger != finger) {
-		if (x == input_abs_get_val(input, ABS_X))
-			x++;
-
-		if (y == input_abs_get_val(input, ABS_Y))
-			y++;
-	}
-
-	input_report_abs(input, ABS_X, x);
-	input_report_abs(input, ABS_Y, y);
-	input_report_abs(input, ABS_MISC, wacom->id[0]);
-	input_report_key(input, wacom->tool[finger], 1);
-	if (!idx)
-		input_report_key(input, BTN_TOUCH, 1);
-	input_event(input, EV_MSC, MSC_SERIAL, finger);
-	input_sync(input);
-
-	wacom->last_finger = finger;
-}
-
 static void wacom_tpc_touch_out(struct wacom_wac *wacom, int idx)
 {
 	struct input_dev *input = wacom->input;
@@ -731,7 +697,6 @@ static void wacom_tpc_touch_in(struct wacom_wac *wacom, size_t len)
 
 	wacom->tool[1] = BTN_TOOL_DOUBLETAP;
 	wacom->id[0] = TOUCH_DEVICE_ID;
-	wacom->tool[2] = BTN_TOOL_TRIPLETAP;
 
 	if (len != WACOM_PKGLEN_TPC1FG) {
 
@@ -746,18 +711,6 @@ static void wacom_tpc_touch_in(struct wacom_wac *wacom, size_t len)
 			input_report_key(input, wacom->tool[1], 1);
 			input_sync(input);
 			break;
-
-		case WACOM_REPORT_TPC2FG:
-			if (data[1] & 0x01)
-				wacom_tpc_finger_in(wacom, data, 0);
-			else if (wacom->id[1] & 0x01)
-				wacom_tpc_touch_out(wacom, 0);
-
-			if (data[1] & 0x02)
-				wacom_tpc_finger_in(wacom, data, 1);
-			else if (wacom->id[1] & 0x02)
-				wacom_tpc_touch_out(wacom, 1);
-			break;
 		}
 	} else {
 		input_report_abs(input, ABS_X, get_unaligned_le16(&data[1]));
@@ -779,47 +732,26 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
 
 	dbg("wacom_tpc_irq: received report #%d", data[0]);
 
-	if (len == WACOM_PKGLEN_TPC1FG ||		 /* single touch */
-	    data[0] == WACOM_REPORT_TPC1FG ||		 /* single touch */
-	    data[0] == WACOM_REPORT_TPC2FG) {		 /* 2FG touch */
+	if (len == WACOM_PKGLEN_TPC1FG ||
+	    data[0] == WACOM_REPORT_TPC1FG) {	/* single touch */
 
 		if (wacom->shared->stylus_in_proximity) {
 			if (wacom->id[1] & 0x01)
 				wacom_tpc_touch_out(wacom, 0);
 
-			if (wacom->id[1] & 0x02)
-				wacom_tpc_touch_out(wacom, 1);
-
 			wacom->id[1] = 0;
 			return 0;
 		}
 
-		if (len == WACOM_PKGLEN_TPC1FG) {	/* with touch */
+		if (len == WACOM_PKGLEN_TPC1FG)
 			prox = data[0] & 0x01;
-		} else {  /* with capacity */
-			if (data[0] == WACOM_REPORT_TPC1FG)
-				/* single touch */
-				prox = data[1] & 0x01;
-			else
-				/* 2FG touch data */
-				prox = data[1] & 0x03;
-		}
+		else  /* with capacity */
+			prox = data[1] & 0x01;
 
-		if (prox) {
-			if (!wacom->id[1])
-				wacom->last_finger = 1;
+		if (prox)
 			wacom_tpc_touch_in(wacom, len);
-		} else {
-			if (data[0] == WACOM_REPORT_TPC2FG) {
-				/* 2FGT out-prox */
-				if (wacom->id[1] & 0x01)
-					wacom_tpc_touch_out(wacom, 0);
-
-				if (wacom->id[1] & 0x02)
-					wacom_tpc_touch_out(wacom, 1);
-			} else
-				/* one finger touch */
-				wacom_tpc_touch_out(wacom, 0);
+		else {
+			wacom_tpc_touch_out(wacom, 0);
 
 			wacom->id[0] = 0;
 		}
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index b1310ec..8f747dd 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -93,10 +93,9 @@ struct wacom_shared {
 struct wacom_wac {
 	char name[64];
 	unsigned char *data;
-	int tool[3];
-	int id[3];
+	int tool[2];
+	int id[2];
 	__u32 serial[2];
-	int last_finger;
 	struct wacom_features features;
 	struct wacom_shared *shared;
 	struct input_dev *input;
-- 
1.7.4

