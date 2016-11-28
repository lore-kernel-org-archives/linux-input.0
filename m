From: Aniroop Mathur <a.mathur@samsung.com>
Subject: [PATCH] Input: mouse: synaptics - change msleep to usleep_range for small msecs
Date: Tue, 29 Nov 2016 01:25:24 +0530
Message-ID: <1480362924-5224-1-git-send-email-a.mathur@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36708 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752333AbcK1Tp6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Nov 2016 14:45:58 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: mike@compulab.co.il, grinberg@compulab.co.il, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: s.samuel@samsung.com, r.mahale@samsung.com, aniroop.mathur@gmail.com, Aniroop Mathur <a.mathur@samsung.com>

msleep(1~20) may not do what the caller intends, and will often sleep longer.
(~20 ms actual sleep for any value given in the 1~20ms range)
This is not the desired behaviour for many cases like device resume time,
device suspend time, device enable time, retry logic, etc.
Thus, change msleep to usleep_range for precise wakeups.

Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
---
 drivers/input/mouse/synaptics_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index aa7c5da..4d688a6 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -29,7 +29,7 @@
  * after soft reset, we should wait for 1 ms
  * before the device becomes operational
  */
-#define SOFT_RESET_DELAY_MS	3
+#define SOFT_RESET_DELAY_US	3000
 /* and after hard reset, we should wait for max 500ms */
 #define HARD_RESET_DELAY_MS	500
 
@@ -311,7 +311,7 @@ static int synaptics_i2c_reset_config(struct i2c_client *client)
 	if (ret) {
 		dev_err(&client->dev, "Unable to reset device\n");
 	} else {
-		msleep(SOFT_RESET_DELAY_MS);
+		usleep_range(SOFT_RESET_DELAY_US, SOFT_RESET_DELAY_US + 100);
 		ret = synaptics_i2c_config(client);
 		if (ret)
 			dev_err(&client->dev, "Unable to config device\n");
-- 
2.6.2

