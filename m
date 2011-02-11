From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] Input: adxl34x-i2c - Convert to dev_pm_ops
Date: Fri, 11 Feb 2011 15:33:40 +0000
Message-ID: <1297438422-25838-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58821 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756528Ab1BKPdY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Feb 2011 10:33:24 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Hennerich <michael.hennerich@analog.com>, Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

There is a general move to convert drivers to use dev_pm_ops rather than
bus specific ones in order to facilitate core development. Do this
conversion for adxl34x-i2c.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/misc/adxl34x-i2c.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/input/misc/adxl34x-i2c.c b/drivers/input/misc/adxl34x-i2c.c
index 0779724..ccacf2b 100644
--- a/drivers/input/misc/adxl34x-i2c.c
+++ b/drivers/input/misc/adxl34x-i2c.c
@@ -11,6 +11,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/types.h>
+#include <linux/pm.h>
 #include "adxl34x.h"
 
 static int adxl34x_smbus_read(struct device *dev, unsigned char reg)
@@ -105,8 +106,9 @@ static int __devexit adxl34x_i2c_remove(struct i2c_client *client)
 }
 
 #ifdef CONFIG_PM
-static int adxl34x_i2c_suspend(struct i2c_client *client, pm_message_t message)
+static int adxl34x_i2c_suspend(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct adxl34x *ac = i2c_get_clientdata(client);
 
 	adxl34x_suspend(ac);
@@ -114,19 +116,20 @@ static int adxl34x_i2c_suspend(struct i2c_client *client, pm_message_t message)
 	return 0;
 }
 
-static int adxl34x_i2c_resume(struct i2c_client *client)
+static int adxl34x_i2c_resume(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct adxl34x *ac = i2c_get_clientdata(client);
 
 	adxl34x_resume(ac);
 
 	return 0;
 }
-#else
-# define adxl34x_i2c_suspend NULL
-# define adxl34x_i2c_resume  NULL
 #endif
 
+static SIMPLE_DEV_PM_OPS(adxl34x_i2c_pm, adxl34x_i2c_suspend,
+			 adxl34x_i2c_resume);
+
 static const struct i2c_device_id adxl34x_id[] = {
 	{ "adxl34x", 0 },
 	{ }
@@ -138,11 +141,10 @@ static struct i2c_driver adxl34x_driver = {
 	.driver = {
 		.name = "adxl34x",
 		.owner = THIS_MODULE,
+		.pm = &adxl34x_i2c_pm,
 	},
 	.probe    = adxl34x_i2c_probe,
 	.remove   = __devexit_p(adxl34x_i2c_remove),
-	.suspend  = adxl34x_i2c_suspend,
-	.resume   = adxl34x_i2c_resume,
 	.id_table = adxl34x_id,
 };
 
-- 
1.7.2.3

