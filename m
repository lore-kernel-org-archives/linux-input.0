From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 3/3] HID: wacom: set stylus_in_proximity before checking touch_down
Date: Fri, 20 Mar 2015 14:58:01 -0700
Message-ID: <1426888681-8755-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:32876 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbbCTV6E (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Mar 2015 17:58:04 -0400
Received: by pabxg6 with SMTP id xg6so108318985pab.0
        for <linux-input@vger.kernel.org>; Fri, 20 Mar 2015 14:58:03 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: benjamin.tissoires@gmail.com, jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

In wacom_bpt_pen, we checked touch_down before assigning new
stylus_in_proximity value. This would cause stylus_in_proximity
not updated properly if touch is down before pen is in proximity.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/hid/wacom_wac.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 60d9ccb..63e767e 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1752,9 +1752,6 @@ static int wacom_bpt_pen(struct wacom_wac *wacom)
 		return 0;
 	}
 
-	if (wacom->shared->touch_down)
-		return 0;
-
 	prox = (data[1] & 0x20) == 0x20;
 
 	/*
@@ -1767,17 +1764,21 @@ static int wacom_bpt_pen(struct wacom_wac *wacom)
 	 *
 	 * Hardware does report zero in most out-of-prox cases but not all.
 	 */
-	if (prox) {
-		if (!wacom->shared->stylus_in_proximity) {
-			if (data[1] & 0x08) {
-				wacom->tool[0] = BTN_TOOL_RUBBER;
-				wacom->id[0] = ERASER_DEVICE_ID;
-			} else {
-				wacom->tool[0] = BTN_TOOL_PEN;
-				wacom->id[0] = STYLUS_DEVICE_ID;
-			}
-			wacom->shared->stylus_in_proximity = true;
+	if (!wacom->shared->stylus_in_proximity) {
+		if (data[1] & 0x08) {
+			wacom->tool[0] = BTN_TOOL_RUBBER;
+			wacom->id[0] = ERASER_DEVICE_ID;
+		} else {
+			wacom->tool[0] = BTN_TOOL_PEN;
+			wacom->id[0] = STYLUS_DEVICE_ID;
 		}
+	}
+
+	wacom->shared->stylus_in_proximity = prox;
+	if (wacom->shared->touch_down)
+		return 0;
+
+	if (prox) {
 		x = le16_to_cpup((__le16 *)&data[2]);
 		y = le16_to_cpup((__le16 *)&data[4]);
 		p = le16_to_cpup((__le16 *)&data[6]);
@@ -1793,7 +1794,8 @@ static int wacom_bpt_pen(struct wacom_wac *wacom)
 		pen = data[1] & 0x01;
 		btn1 = data[1] & 0x02;
 		btn2 = data[1] & 0x04;
-	}
+	} else
+		wacom->id[0] = 0;
 
 	input_report_key(input, BTN_TOUCH, pen);
 	input_report_key(input, BTN_STYLUS, btn1);
@@ -1804,11 +1806,6 @@ static int wacom_bpt_pen(struct wacom_wac *wacom)
 	input_report_abs(input, ABS_PRESSURE, p);
 	input_report_abs(input, ABS_DISTANCE, d);
 
-	if (!prox) {
-		wacom->id[0] = 0;
-		wacom->shared->stylus_in_proximity = false;
-	}
-
 	input_report_key(input, wacom->tool[0], prox); /* PEN or RUBBER */
 	input_report_abs(input, ABS_MISC, wacom->id[0]); /* TOOL ID */
 
-- 
1.9.1

