From: Saurabh Sengar <saurabh.truth@gmail.com>
Subject: [PATCH] Input: smtpe-ts: better way of using of_property_read_u32()
Date: Tue, 24 Nov 2015 12:36:38 +0530
Message-ID: <1448348798-5950-1-git-send-email-saurabh.truth@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34373 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbbKXHGz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Nov 2015 02:06:55 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, marex@denx.de, viresh.kumar@linaro.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Saurabh Sengar <saurabh.truth@gmail.com>

better way of using of_property_read_u32(), helps remove one variable
and many 'if' conditions

Signed-off-by: Saurabh Sengar <saurabh.truth@gmail.com>
---
 drivers/input/touchscreen/stmpe-ts.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
index e414d43..51abe62 100644
--- a/drivers/input/touchscreen/stmpe-ts.c
+++ b/drivers/input/touchscreen/stmpe-ts.c
@@ -268,27 +268,18 @@ static void stmpe_ts_get_platform_info(struct platform_device *pdev,
 					struct stmpe_touch *ts)
 {
 	struct device_node *np = pdev->dev.of_node;
-	u32 val;
 
 	if (np) {
-		if (!of_property_read_u32(np, "st,sample-time", &val))
-			ts->sample_time = val;
-		if (!of_property_read_u32(np, "st,mod-12b", &val))
-			ts->mod_12b = val;
-		if (!of_property_read_u32(np, "st,ref-sel", &val))
-			ts->ref_sel = val;
-		if (!of_property_read_u32(np, "st,adc-freq", &val))
-			ts->adc_freq = val;
-		if (!of_property_read_u32(np, "st,ave-ctrl", &val))
-			ts->ave_ctrl = val;
-		if (!of_property_read_u32(np, "st,touch-det-delay", &val))
-			ts->touch_det_delay = val;
-		if (!of_property_read_u32(np, "st,settling", &val))
-			ts->settling = val;
-		if (!of_property_read_u32(np, "st,fraction-z", &val))
-			ts->fraction_z = val;
-		if (!of_property_read_u32(np, "st,i-drive", &val))
-			ts->i_drive = val;
+		of_property_read_u32(np, "st,sample-time", &ts->sample_time);
+		of_property_read_u32(np, "st,mod-12b", &ts->mod_12b);
+		of_property_read_u32(np, "st,ref-sel", &ts->ref_sel);
+		of_property_read_u32(np, "st,adc-freq", &ts->adc_freq);
+		of_property_read_u32(np, "st,ave-ctrl", &ts->ave_ctrl);
+		of_property_read_u32(np, "st,touch-det-delay",
+						&ts->touch_det_delay);
+		of_property_read_u32(np, "st,settling", &ts->settling = val);
+		of_property_read_u32(np, "st,fraction-z", &ts->fraction_z);
+		of_property_read_u32(np, "st,i-drive", &ts->i_drive);
 	}
 }
 
-- 
1.9.1

