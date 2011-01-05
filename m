From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Input: mcs5000_ts - Convert to dev_pm_ops
Date: Wed,  5 Jan 2011 19:07:54 +0000
Message-ID: <1294254474-26173-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:37308 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751322Ab1AETJb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 5 Jan 2011 14:09:31 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>, Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

There is a general move towards the use of dev_pm_ops rather than
bus specific suspend APIs as this simplifies both the bus and PM core
implementations. Convert the mcs5000_ts driver over.

Compile tested only.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/mcs5000_ts.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/mcs5000_ts.c b/drivers/input/touchscreen/mcs5000_ts.c
index 6ee9940..6f72989 100644
--- a/drivers/input/touchscreen/mcs5000_ts.c
+++ b/drivers/input/touchscreen/mcs5000_ts.c
@@ -261,25 +261,29 @@ static int __devexit mcs5000_ts_remove(struct i2c_client *client)
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
+
+static SIMPLE_DEV_PM_OPS(mcs5000_ts_pm, mcs5000_ts_suspend, mcs5000_ts_resume);
 #else
-#define mcs5000_ts_suspend	NULL
-#define mcs5000_ts_resume	NULL
+#define mcs5000_ts_pm     NULL
 #endif
 
 static const struct i2c_device_id mcs5000_ts_id[] = {
@@ -291,10 +295,9 @@ MODULE_DEVICE_TABLE(i2c, mcs5000_ts_id);
 static struct i2c_driver mcs5000_ts_driver = {
 	.probe		= mcs5000_ts_probe,
 	.remove		= __devexit_p(mcs5000_ts_remove),
-	.suspend	= mcs5000_ts_suspend,
-	.resume		= mcs5000_ts_resume,
 	.driver = {
 		.name = "mcs5000_ts",
+		.pm   = &mcs5000_ts_pm,
 	},
 	.id_table	= mcs5000_ts_id,
 };
-- 
1.7.2.3

