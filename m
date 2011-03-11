From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH v2 4/4] Input: atmel_mxt_ts - Convert to MT protocol B
Date: Fri, 11 Mar 2011 15:47:26 +0900
Message-ID: <1299826046-20081-1-git-send-email-jy0922.shim@samsung.com>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:33340 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595Ab1CKGuf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2011 01:50:35 -0500
Received: from epmmp1 (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LHV00269S7409F0@mailout3.samsung.com> for
 linux-input@vger.kernel.org; Fri, 11 Mar 2011 15:47:28 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LHV00B7PS74KV@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Fri, 11 Mar 2011 15:47:28 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, iiro.valkonen@atmel.com, rydberg@euromail.se, kyungmin.park@samsung.com

Atmel touchscreen chips can use MT protocol B because they can assign
unique id to ABS_MT_TRACKING_ID from finger id provided by hardware.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index fd1fda5..7d485c2 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -17,7 +17,7 @@
 #include <linux/firmware.h>
 #include <linux/i2c.h>
 #include <linux/i2c/atmel_mxt_ts.h>
-#include <linux/input.h>
+#include <linux/input/mt.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 
@@ -504,19 +504,20 @@ static void mxt_input_report(struct mxt_data *data, int single_id)
 		if (!finger[id].status)
 			continue;
 
-		input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR,
-				finger[id].status != MXT_RELEASE ?
-				finger[id].area : 0);
-		input_report_abs(input_dev, ABS_MT_POSITION_X,
-				finger[id].x);
-		input_report_abs(input_dev, ABS_MT_POSITION_Y,
-				finger[id].y);
-		input_mt_sync(input_dev);
+		input_mt_slot(input_dev, id);
+		input_mt_report_slot_state(input_dev, MT_TOOL_FINGER,
+				finger[id].status != MXT_RELEASE);
 
-		if (finger[id].status == MXT_RELEASE)
-			finger[id].status = 0;
-		else
+		if (finger[id].status != MXT_RELEASE) {
 			finger_num++;
+			input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR,
+					finger[id].area);
+			input_report_abs(input_dev, ABS_MT_POSITION_X,
+					finger[id].x);
+			input_report_abs(input_dev, ABS_MT_POSITION_Y,
+					finger[id].y);
+		} else
+			finger[id].status = 0;
 	}
 
 	input_report_key(input_dev, BTN_TOUCH, finger_num > 0);
@@ -1091,6 +1092,7 @@ static int __devinit mxt_probe(struct i2c_client *client,
 			     0, data->y_size, 0, 0);
 
 	/* For multi touch */
+	input_mt_init_slots(input_dev, MXT_MAX_FINGER);
 	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
 			     0, MXT_MAX_AREA, 0, 0);
 	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
-- 
1.7.0.4

