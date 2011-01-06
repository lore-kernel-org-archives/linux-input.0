From: Mark Brown <broonie@opensource.wolfsonmciro.com>
Subject: [PATCH v2] Input: mcs5000_ts - Convert to dev_pm_ops
Date: Thu,  6 Jan 2011 12:12:47 +0000
Message-ID: <1294315967-9600-1-git-send-email-broonie@opensource.wolfsonmciro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:37449 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752187Ab1AFMO2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Jan 2011 07:14:28 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

From: Mark Brown <broonie@opensource.wolfsonmicro.com>

There is a general move towards the use of dev_pm_ops rather than
bus specific suspend APIs as this simplifies both the bus and PM core
implementations. Convert the mcs5000_ts driver over.

Compile tested only.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

Updated to only use dev_pm_ops when PM is enabled.

 drivers/input/touchscreen/mcs5000_ts.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/mcs5000_ts.c b/drivers/input/touchscreen/mcs5000_ts.c
index 6ee9940..2d84c80 100644
--- a/drivers/input/touchscreen/mcs5000_ts.c
+++ b/drivers/input/touchscreen/mcs5000_ts.c
@@ -261,25 +261,27 @@ static int __devexit mcs5000_ts_remove(struct i2c_client *client)
 }
 
 #ifdef CONFIG_PM
-static int mcs5000_ts_suspend(struct i2c_client *client, pm_message_t mesg)
+static int mcs5000_ts_suspend(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
+
 	/* Touch sleep mode */
 	i2c_smbus_write_byte_data(client, MCS5000_TS_OP_MODE, OP_MODE_SLEEP);
 
 	return 0;
 }
 
-static int mcs5000_ts_resume(struct i2c_client *client)
+static int mcs5000_ts_resume(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct mcs5000_ts_data *data = i2c_get_clientdata(client);
 
 	mcs5000_ts_phys_init(data);
 
 	return 0;
 }
-#else
-#define mcs5000_ts_suspend	NULL
-#define mcs5000_ts_resume	NULL
+
+static SIMPLE_DEV_PM_OPS(mcs5000_ts_pm, mcs5000_ts_suspend, mcs5000_ts_resume);
 #endif
 
 static const struct i2c_device_id mcs5000_ts_id[] = {
@@ -291,10 +293,11 @@ MODULE_DEVICE_TABLE(i2c, mcs5000_ts_id);
 static struct i2c_driver mcs5000_ts_driver = {
 	.probe		= mcs5000_ts_probe,
 	.remove		= __devexit_p(mcs5000_ts_remove),
-	.suspend	= mcs5000_ts_suspend,
-	.resume		= mcs5000_ts_resume,
 	.driver = {
 		.name = "mcs5000_ts",
+#ifdef CONFIG_PM
+		.pm   = &mcs5000_ts_pm,
+#endif
 	},
 	.id_table	= mcs5000_ts_id,
 };
-- 
1.7.2.3

