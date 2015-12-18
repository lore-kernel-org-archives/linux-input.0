From: "james.chen" <james.chen@emc.com.tw>
Subject: [PATCH] CHROMIUM: Input: elants_i2c: fixed wake-on-touch issue
Date: Fri, 18 Dec 2015 10:48:48 +0800
Message-ID: <1450406929-5975-1-git-send-email-james.chen@emc.com.tw>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:21695 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964901AbbLRDJR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Dec 2015 22:09:17 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jennifer Tsai <jennifer.tsai@emc.com.tw>, Herman Lin <herman.lin@emc.com.tw>, Scott Liu <scott.liu@emc.com.tw>, Charlie Mooney <charliemooney@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Jeff Chuang <jeff.chuang@emc.com.tw>, Agnes Cheng <agnescheng@google.com>, "james.chen" <james.chen@emc.com.tw>

From: "james.chen" <james.chen@emc.com.tw>

Something wrong in suspend/resume of kernel v3.14 for the function of
wake-on-touch. The function of device_may_wakeup will return true if
the device supports wake-on-touch (for example, kitty and buddy).
So, modify the code from "if (device_may_wakeup(dev))" to
"if (!device_may_wakeup(dev))". And adjust the condition check of
keep_power_in_suspend (designed for minnie).

Signed-off-by: James Chen <james.chen@emc.com.tw>
---
 drivers/input/touchscreen/elants_i2c.c | 37 +++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index 17cc20e..06ee814 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -1307,7 +1307,7 @@ static int __maybe_unused elants_i2c_suspend(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct elants_data *ts = i2c_get_clientdata(client);
 	const u8 set_sleep_cmd[] = { 0x54, 0x50, 0x00, 0x01 };
-	int retry_cnt;
+	int retry;
 	int error;
 
 	/* Command not support in IAP recovery mode */
@@ -1316,24 +1316,25 @@ static int __maybe_unused elants_i2c_suspend(struct device *dev)
 
 	disable_irq(client->irq);
 
-	if (device_may_wakeup(dev) || ts->keep_power_in_suspend) {
-		for (retry_cnt = 0; retry_cnt < MAX_RETRIES; retry_cnt++) {
+	if (device_may_wakeup(dev)) {
+		/*
+		 * The device will automatically enter idle mode
+		 * that has reduced power consumption.
+		 */
+		ts->wake_irq_enabled = (enable_irq_wake(client->irq) == 0);
+	} else if (ts->keep_power_in_suspend) {
+		for (retry = 0; retry < MAX_RETRIES; retry++) {
 			error = elants_i2c_send(client, set_sleep_cmd,
-						sizeof(set_sleep_cmd));
+					sizeof(set_sleep_cmd));
 			if (!error)
 				break;
 
 			dev_err(&client->dev,
 				"suspend command failed: %d\n", error);
 		}
-
-		if (device_may_wakeup(dev))
-			ts->wake_irq_enabled =
-					(enable_irq_wake(client->irq) == 0);
 	} else {
-		elants_i2c_power_off(ts);
+			elants_i2c_power_off(ts);
 	}
-
 	return 0;
 }
 
@@ -1342,16 +1343,17 @@ static int __maybe_unused elants_i2c_resume(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct elants_data *ts = i2c_get_clientdata(client);
 	const u8 set_active_cmd[] = { 0x54, 0x58, 0x00, 0x01 };
-	int retry_cnt;
+	int retry;
 	int error;
 
-	if (device_may_wakeup(dev) && ts->wake_irq_enabled)
-		disable_irq_wake(client->irq);
-
-	if (ts->keep_power_in_suspend) {
-		for (retry_cnt = 0; retry_cnt < MAX_RETRIES; retry_cnt++) {
+	if (device_may_wakeup(dev)) {
+		if (ts->wake_irq_enabled)
+			disable_irq_wake(client->irq);
+		elants_i2c_sw_reset(client);
+	} else if (ts->keep_power_in_suspend) {
+		for (retry = 0; retry < MAX_RETRIES; retry++) {
 			error = elants_i2c_send(client, set_active_cmd,
-						sizeof(set_active_cmd));
+					sizeof(set_active_cmd));
 			if (!error)
 				break;
 
@@ -1362,7 +1364,6 @@ static int __maybe_unused elants_i2c_resume(struct device *dev)
 		elants_i2c_power_on(ts);
 		elants_i2c_initialize(ts);
 	}
-
 	ts->state = ELAN_STATE_NORMAL;
 	enable_irq(client->irq);
 
-- 
1.8.3.2

