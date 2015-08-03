From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] HID: wacom: Simplify 'wacom_pl_irq'
Date: Mon,  3 Aug 2015 10:18:10 -0700
Message-ID: <1438622290-6844-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34243 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639AbbHCRSS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Aug 2015 13:18:18 -0400
Received: by pdbbo16 with SMTP id bo16so18887077pdb.1
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2015 10:18:18 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Aaron Skomra <skomra@gmail.com>, Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Unlike other IRQ functions, 'wacom_pl_irq' uses the second element of
the 'tool' array to store information about its single pen. This makes
the function more difficult to understand (since it doesn't follow the
general pattern of other IRQ functions) and prevents the possibility of
refactoring how pen state is stored.

This patch rewrites 'wacom_pl_irq' to follow the usual IRQ conventions,
including storing tool type in 'tool[0]' and implicitly tracking prox
with the 'id[0]' variable.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 84 +++++++++++++++++++++----------------------------
 1 file changed, 35 insertions(+), 49 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 4d11c78..fe164df 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -125,61 +125,47 @@ static int wacom_pl_irq(struct wacom_wac *wacom)
 
 	prox = data[1] & 0x40;
 
-	if (prox) {
-		wacom->id[0] = ERASER_DEVICE_ID;
-		pressure = (signed char)((data[7] << 1) | ((data[4] >> 2) & 1));
-		if (features->pressure_max > 255)
-			pressure = (pressure << 1) | ((data[4] >> 6) & 1);
-		pressure += (features->pressure_max + 1) / 2;
-
-		/*
-		 * if going from out of proximity into proximity select between the eraser
-		 * and the pen based on the state of the stylus2 button, choose eraser if
-		 * pressed else choose pen. if not a proximity change from out to in, send
-		 * an out of proximity for previous tool then a in for new tool.
-		 */
-		if (!wacom->tool[0]) {
-			/* Eraser bit set for DTF */
-			if (data[1] & 0x10)
-				wacom->tool[1] = BTN_TOOL_RUBBER;
-			else
-				/* Going into proximity select tool */
-				wacom->tool[1] = (data[4] & 0x20) ? BTN_TOOL_RUBBER : BTN_TOOL_PEN;
-		} else {
-			/* was entered with stylus2 pressed */
-			if (wacom->tool[1] == BTN_TOOL_RUBBER && !(data[4] & 0x20)) {
-				/* report out proximity for previous tool */
-				input_report_key(input, wacom->tool[1], 0);
-				input_sync(input);
-				wacom->tool[1] = BTN_TOOL_PEN;
-				return 0;
-			}
+	if (!wacom->id[0]) {
+		if ((data[0] & 0x10) || (data[4] & 0x20)) {
+			wacom->tool[0] = BTN_TOOL_RUBBER;
+			wacom->id[0] = ERASER_DEVICE_ID;
 		}
-		if (wacom->tool[1] != BTN_TOOL_RUBBER) {
-			/* Unknown tool selected default to pen tool */
-			wacom->tool[1] = BTN_TOOL_PEN;
+		else {
+			wacom->tool[0] = BTN_TOOL_PEN;
 			wacom->id[0] = STYLUS_DEVICE_ID;
 		}
-		input_report_key(input, wacom->tool[1], prox); /* report in proximity for tool */
-		input_report_abs(input, ABS_MISC, wacom->id[0]); /* report tool id */
-		input_report_abs(input, ABS_X, data[3] | (data[2] << 7) | ((data[1] & 0x03) << 14));
-		input_report_abs(input, ABS_Y, data[6] | (data[5] << 7) | ((data[4] & 0x03) << 14));
-		input_report_abs(input, ABS_PRESSURE, pressure);
+	}
 
-		input_report_key(input, BTN_TOUCH, data[4] & 0x08);
-		input_report_key(input, BTN_STYLUS, data[4] & 0x10);
-		/* Only allow the stylus2 button to be reported for the pen tool. */
-		input_report_key(input, BTN_STYLUS2, (wacom->tool[1] == BTN_TOOL_PEN) && (data[4] & 0x20));
-	} else {
-		/* report proximity-out of a (valid) tool */
-		if (wacom->tool[1] != BTN_TOOL_RUBBER) {
-			/* Unknown tool selected default to pen tool */
-			wacom->tool[1] = BTN_TOOL_PEN;
-		}
-		input_report_key(input, wacom->tool[1], prox);
+	/* If the eraser is in prox, STYLUS2 is always set. If we
+	 * mis-detected the type and notice that STYLUS2 isn't set
+	 * then force the eraser out of prox and let the pen in.
+	 */
+	if (wacom->tool[0] == BTN_TOOL_RUBBER && !(data[4] & 0x20)) {
+		input_report_key(input, BTN_TOOL_RUBBER, 0);
+		input_report_abs(input, ABS_MISC, 0);
+		input_sync(input);
+		wacom->tool[0] = BTN_TOOL_PEN;
+		wacom->id[0] = STYLUS_DEVICE_ID;
 	}
 
-	wacom->tool[0] = prox; /* Save proximity state */
+	pressure = (signed char)((data[7] << 1) | ((data[4] >> 2) & 1));
+	if (features->pressure_max > 255)
+		pressure = (pressure << 1) | ((data[4] >> 6) & 1);
+	pressure += (features->pressure_max + 1) / 2;
+
+	input_report_abs(input, ABS_X, data[3] | (data[2] << 7) | ((data[1] & 0x03) << 14));
+	input_report_abs(input, ABS_Y, data[6] | (data[5] << 7) | ((data[4] & 0x03) << 14));
+	input_report_abs(input, ABS_PRESSURE, pressure);
+
+	input_report_key(input, BTN_TOUCH, data[4] & 0x08);
+	input_report_key(input, BTN_STYLUS, data[4] & 0x10);
+	/* Only allow the stylus2 button to be reported for the pen tool. */
+	input_report_key(input, BTN_STYLUS2, (wacom->tool[0] == BTN_TOOL_PEN) && (data[4] & 0x20));
+
+	if (!prox)
+		wacom->id[0] = 0;
+	input_report_key(input, wacom->tool[0], prox);
+	input_report_abs(input, ABS_MISC, wacom->id[0]);
 	return 1;
 }
 
-- 
2.4.6

