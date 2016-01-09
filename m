From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 3/4] HID: wacom - Cleanup touch arbitration logic
Date: Fri,  8 Jan 2016 17:16:06 -0800
Message-ID: <1452302166-5601-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35796 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852AbcAIBQO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jan 2016 20:16:14 -0500
Received: by mail-pa0-f65.google.com with SMTP id gi1so29468830pac.2
        for <linux-input@vger.kernel.org>; Fri, 08 Jan 2016 17:16:13 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, killertofu@gmail.com, Ping Cheng <pingc@wacom.com>

stylus_in_proximity was introduced to support touch arbitration
before in range was supported. With in range event, the logic
changed. stylus_in_proximity should be set for both in prox and
in range events.

To finish a clean touch arbitration logic, we should send touch
up (if it was down) before posting any general pen events.

Signed-off-by: Ping Cheng <pingc@wacom.com>
Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 8507028..af9ecf4 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -670,19 +670,22 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 			wacom->tool[idx] = BTN_TOOL_PEN;
 			break;
 		}
+		wacom->shared->stylus_in_proximity = true;
 		return 1;
 	}
 
-	wacom->shared->stylus_in_proximity = true;
-	if (wacom->shared->touch_down)
-		return 1;
+	/* in Range */
+	if ((data[1] & 0xfe) == 0x20) {
+		wacom->shared->stylus_in_proximity = true;
 
-	/* in Range while exiting */
-	if (((data[1] & 0xfe) == 0x20) && wacom->reporting_data) {
-		input_report_key(input, BTN_TOUCH, 0);
-		input_report_abs(input, ABS_PRESSURE, 0);
-		input_report_abs(input, ABS_DISTANCE, wacom->features.distance_max);
-		return 2;
+		/* in Range while exiting */
+		if (wacom->reporting_data) {
+			input_report_key(input, BTN_TOUCH, 0);
+			input_report_abs(input, ABS_PRESSURE, 0);
+			input_report_abs(input, ABS_DISTANCE, wacom->features.distance_max);
+			return 2;
+		}
+		return 1;
 	}
 
 	/* Exit report */
@@ -867,6 +870,9 @@ static int wacom_intuos_general(struct wacom_wac *wacom)
 		data[0] != WACOM_REPORT_INTUOS_PEN)
 		return 0;
 
+	if (wacom->shared->touch_down)
+		return 1;
+
 	/* don't report events if we don't know the tool ID */
 	if (!wacom->id[idx]) {
 		/* but reschedule a read of the current tool */
-- 
1.9.1

