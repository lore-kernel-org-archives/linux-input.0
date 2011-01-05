From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Input: eeti_ts - Convert to dev_pm_ops
Date: Wed,  5 Jan 2011 19:06:01 +0000
Message-ID: <1294254361-26066-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:37293 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751989Ab1AETHi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 5 Jan 2011 14:07:38 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>, Sven Neumann <s.neumann@raumfeld.com>, Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

There is a general move towards the use of dev_pm_ops rather than
bus specific suspend APIs as this simplifies both the bus and PM core
implementations. Convert the eeti_ts driver over.

Compile tested only.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/eeti_ts.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index 7a3a916..1f0ef91 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -261,8 +261,9 @@ static int __devexit eeti_ts_remove(struct i2c_client *client)
 }
 
 #ifdef CONFIG_PM
-static int eeti_ts_suspend(struct i2c_client *client, pm_message_t mesg)
+static int eeti_ts_suspend(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct eeti_ts_priv *priv = i2c_get_clientdata(client);
 	struct input_dev *input_dev = priv->input;
 
@@ -279,8 +280,9 @@ static int eeti_ts_suspend(struct i2c_client *client, pm_message_t mesg)
 	return 0;
 }
 
-static int eeti_ts_resume(struct i2c_client *client)
+static int eeti_ts_resume(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct eeti_ts_priv *priv = i2c_get_clientdata(client);
 	struct input_dev *input_dev = priv->input;
 
@@ -296,9 +298,10 @@ static int eeti_ts_resume(struct i2c_client *client)
 
 	return 0;
 }
+
+static SIMPLE_DEV_PM_OPS(eeti_ts_pm, eeti_ts_suspend, eeti_ts_resume);
 #else
-#define eeti_ts_suspend NULL
-#define eeti_ts_resume NULL
+#define eeti_ts_pm NULL
 #endif
 
 static const struct i2c_device_id eeti_ts_id[] = {
@@ -310,11 +313,10 @@ MODULE_DEVICE_TABLE(i2c, eeti_ts_id);
 static struct i2c_driver eeti_ts_driver = {
 	.driver = {
 		.name = "eeti_ts",
+		.pm = &eeti_ts_pm,
 	},
 	.probe = eeti_ts_probe,
 	.remove = __devexit_p(eeti_ts_remove),
-	.suspend = eeti_ts_suspend,
-	.resume = eeti_ts_resume,
 	.id_table = eeti_ts_id,
 };
 
-- 
1.7.2.3

