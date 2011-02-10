From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Input: lm8323 - Convert to dev_pm_ops
Date: Thu, 10 Feb 2011 13:16:39 +0000
Message-ID: <1297343799-6620-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:48877 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751147Ab1BJNQW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Feb 2011 08:16:22 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>, Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

There is a general move away from bus specific PM operations to using
dev_pm_ops in order to facilicate core improvements. Update lm8323 to
the new model.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/keyboard/lm8323.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index f7c2a16..b732870 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -30,6 +30,7 @@
 #include <linux/delay.h>
 #include <linux/input.h>
 #include <linux/leds.h>
+#include <linux/pm.h>
 #include <linux/i2c/lm8323.h>
 #include <linux/slab.h>
 
@@ -802,8 +803,9 @@ static int __devexit lm8323_remove(struct i2c_client *client)
  * We don't need to explicitly suspend the chip, as it already switches off
  * when there's no activity.
  */
-static int lm8323_suspend(struct i2c_client *client, pm_message_t mesg)
+static int lm8323_suspend(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct lm8323_chip *lm = i2c_get_clientdata(client);
 	int i;
 
@@ -821,8 +823,9 @@ static int lm8323_suspend(struct i2c_client *client, pm_message_t mesg)
 	return 0;
 }
 
-static int lm8323_resume(struct i2c_client *client)
+static int lm8323_resume(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct lm8323_chip *lm = i2c_get_clientdata(client);
 	int i;
 
@@ -839,11 +842,10 @@ static int lm8323_resume(struct i2c_client *client)
 
 	return 0;
 }
-#else
-#define lm8323_suspend	NULL
-#define lm8323_resume	NULL
 #endif
 
+static SIMPLE_DEV_PM_OPS(lm8323_pm_ops, lm8323_suspend, lm8323_resume);
+
 static const struct i2c_device_id lm8323_id[] = {
 	{ "lm8323", 0 },
 	{ }
@@ -852,11 +854,10 @@ static const struct i2c_device_id lm8323_id[] = {
 static struct i2c_driver lm8323_i2c_driver = {
 	.driver = {
 		.name	= "lm8323",
+		.pm	= &lm8323_pm_ops,
 	},
 	.probe		= lm8323_probe,
 	.remove		= __devexit_p(lm8323_remove),
-	.suspend	= lm8323_suspend,
-	.resume		= lm8323_resume,
 	.id_table	= lm8323_id,
 };
 MODULE_DEVICE_TABLE(i2c, lm8323_id);
-- 
1.7.2.3

