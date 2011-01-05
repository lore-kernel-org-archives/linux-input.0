From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Input: cy8ctmg110_ts - Convert to dev_pm_ops
Date: Wed,  5 Jan 2011 19:04:09 +0000
Message-ID: <1294254249-25932-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:37283 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752163Ab1AETFq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 5 Jan 2011 14:05:46 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuli Konttila <samuli.konttila@aavamobile.com>, Alan Cox <alan@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

There is a general move towards the use of dev_pm_ops rather than
bus specific suspend APIs as this simplifies both the bus and PM core
implementations. Convert the cy8ctmg110_ts driver over.

Compile tested only.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/cy8ctmg110_ts.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/cy8ctmg110_ts.c b/drivers/input/touchscreen/cy8ctmg110_ts.c
index d0c3a72..a93c5c2 100644
--- a/drivers/input/touchscreen/cy8ctmg110_ts.c
+++ b/drivers/input/touchscreen/cy8ctmg110_ts.c
@@ -280,8 +280,9 @@ err_free_mem:
 }
 
 #ifdef CONFIG_PM
-static int cy8ctmg110_suspend(struct i2c_client *client, pm_message_t mesg)
+static int cy8ctmg110_suspend(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct cy8ctmg110 *ts = i2c_get_clientdata(client);
 
 	if (device_may_wakeup(&client->dev))
@@ -293,8 +294,9 @@ static int cy8ctmg110_suspend(struct i2c_client *client, pm_message_t mesg)
 	return 0;
 }
 
-static int cy8ctmg110_resume(struct i2c_client *client)
+static int cy8ctmg110_resume(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct cy8ctmg110 *ts = i2c_get_clientdata(client);
 
 	if (device_may_wakeup(&client->dev))
@@ -305,6 +307,8 @@ static int cy8ctmg110_resume(struct i2c_client *client)
 	}
 	return 0;
 }
+
+static SIMPLE_DEV_PM_OPS(cy8ctmg110_pm, cy8ctmg110_suspend, cy8ctmg110_resume);
 #endif
 
 static int __devexit cy8ctmg110_remove(struct i2c_client *client)
@@ -335,14 +339,13 @@ static struct i2c_driver cy8ctmg110_driver = {
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= CY8CTMG110_DRIVER_NAME,
+#ifdef CONFIG_PM
+		.pm	= &cy8ctmg110_pm,
+#endif
 	},
 	.id_table	= cy8ctmg110_idtable,
 	.probe		= cy8ctmg110_probe,
 	.remove		= __devexit_p(cy8ctmg110_remove),
-#ifdef CONFIG_PM
-	.suspend	= cy8ctmg110_suspend,
-	.resume		= cy8ctmg110_resume,
-#endif
 };
 
 static int __init cy8ctmg110_init(void)
-- 
1.7.2.3

