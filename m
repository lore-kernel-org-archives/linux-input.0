From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Input: migor_ts - Convert to dev_pm_ops
Date: Wed,  5 Jan 2011 19:10:06 +0000
Message-ID: <1294254606-26277-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:39281 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751373Ab1AETLn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 5 Jan 2011 14:11:43 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Magnus Damm <damm@igel.co.jp>, Dmitry Torokhov <dtor@mail.ru>, Magnus Damm <damm@opensource.se>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

There is a general move towards the use of dev_pm_ops rather than
bus specific suspend APIs as this simplifies both the bus and PM core
implementations. Convert the migor_ts driver over.

Compile tested only.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/migor_ts.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/migor_ts.c b/drivers/input/touchscreen/migor_ts.c
index defe5dd..5803bd0 100644
--- a/drivers/input/touchscreen/migor_ts.c
+++ b/drivers/input/touchscreen/migor_ts.c
@@ -23,6 +23,7 @@
 #include <linux/kernel.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
+#include <linux/pm.h>
 #include <linux/slab.h>
 #include <asm/io.h>
 #include <linux/i2c.h>
@@ -226,8 +227,9 @@ static int migor_ts_remove(struct i2c_client *client)
 	return 0;
 }
 
-static int migor_ts_suspend(struct i2c_client *client, pm_message_t mesg)
+static int migor_ts_suspend(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct migor_ts_priv *priv = dev_get_drvdata(&client->dev);
 
 	if (device_may_wakeup(&client->dev))
@@ -236,8 +238,9 @@ static int migor_ts_suspend(struct i2c_client *client, pm_message_t mesg)
 	return 0;
 }
 
-static int migor_ts_resume(struct i2c_client *client)
+static int migor_ts_resume(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct migor_ts_priv *priv = dev_get_drvdata(&client->dev);
 
 	if (device_may_wakeup(&client->dev))
@@ -246,6 +249,8 @@ static int migor_ts_resume(struct i2c_client *client)
 	return 0;
 }
 
+static SIMPLE_DEV_PM_OPS(migor_ts_pm, migor_ts_suspend, migor_ts_resume);
+
 static const struct i2c_device_id migor_ts_id[] = {
 	{ "migor_ts", 0 },
 	{ }
@@ -255,11 +260,10 @@ MODULE_DEVICE_TABLE(i2c, migor_ts);
 static struct i2c_driver migor_ts_driver = {
 	.driver = {
 		.name = "migor_ts",
+		.pm = &migor_ts_pm,
 	},
 	.probe = migor_ts_probe,
 	.remove = migor_ts_remove,
-	.suspend = migor_ts_suspend,
-	.resume = migor_ts_resume,
 	.id_table = migor_ts_id,
 };
 
-- 
1.7.2.3

