From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH v2] Input: wacom - allow both MT and pen data to be reported
Date: Sun, 28 Nov 2010 15:46:00 -0800
Message-ID: <1290987960-12118-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40129 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840Ab0K1Xpi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Nov 2010 18:45:38 -0500
Received: by gwj20 with SMTP id 20so1726972gwj.19
        for <linux-input@vger.kernel.org>; Sun, 28 Nov 2010 15:45:37 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

As discussed at linux-input and xorg-devel mailing lists, MT events
are sent even a stylus is in proximity. Clients have the opportunity
to use or ignore them later. To support backward compatibility,
single touch events are still ignored when pen is in proximity.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |   30 +++++++++++++++++-------------
 1 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index b3252ef..e0826d1 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -868,13 +868,11 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
 	for (i = 0; i < 2; i++) {
 		int p = data[9 * i + 2];
 		input_mt_slot(input, i);
-		/*
-		 * Touch events need to be disabled while stylus is
-		 * in proximity because user's hand is resting on touchpad
-		 * and sending unwanted events.  User expects tablet buttons
-		 * to continue working though.
+
+		/* MT events are sent even a stylus is in proximity. Clients
+		 * have the opportunity to use or ignore them later.
 		 */
-		if (p && !wacom->shared->stylus_in_proximity) {
+		if (p) {
 			int x = get_unaligned_be16(&data[9 * i + 3]) & 0x7ff;
 			int y = get_unaligned_be16(&data[9 * i + 5]) & 0x7ff;
 			if (features->quirks & WACOM_QUIRK_BBTOUCH_LOWRES) {
@@ -894,13 +892,19 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
 		input_report_abs(input, ABS_MT_TRACKING_ID, wacom->id[i]);
 	}
 
-	input_report_key(input, BTN_TOUCH, count > 0);
-	input_report_key(input, BTN_TOOL_FINGER, count == 1);
-	input_report_key(input, BTN_TOOL_DOUBLETAP, count == 2);
-
-	input_report_abs(input, ABS_PRESSURE, sp);
-	input_report_abs(input, ABS_X, sx);
-	input_report_abs(input, ABS_Y, sy);
+	/* As discussed at linux-input and xorg-devel mailing lists, single
+	 * touch events are ignored when pen is in prox to support backward
+	 * compatibility
+	 */
+	if (!wacom->shared->stylus_in_proximity) {
+		input_report_key(input, BTN_TOUCH, count > 0);
+		input_report_key(input, BTN_TOOL_FINGER, count == 1);
+		input_report_key(input, BTN_TOOL_DOUBLETAP, count == 2);
+
+		input_report_abs(input, ABS_PRESSURE, sp);
+		input_report_abs(input, ABS_X, sx);
+		input_report_abs(input, ABS_Y, sy);
+	}
 
 	input_report_key(input, BTN_LEFT, (data[1] & 0x08) != 0);
 	input_report_key(input, BTN_FORWARD, (data[1] & 0x04) != 0);
-- 
1.7.2.3

