From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Input: ad7879 - Convert I2C to dev_pm_ops
Date: Wed,  5 Jan 2011 19:01:35 +0000
Message-ID: <1294254095-25844-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:56649 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751029Ab1AETDP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 5 Jan 2011 14:03:15 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mike Frysinger <vapier@gentoo.org>, Michael Hennerich <michael.hennerich@analog.com>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

There is a general move towards the use of dev_pm_ops rather than
bus specific suspend APIs as this simplifies both the bus and PM core
implementations. Convert the ad7879-ts I2C support over.

Compile tested only.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/ad7879-i2c.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879-i2c.c b/drivers/input/touchscreen/ad7879-i2c.c
index d82a38e..72b37c3 100644
--- a/drivers/input/touchscreen/ad7879-i2c.c
+++ b/drivers/input/touchscreen/ad7879-i2c.c
@@ -10,14 +10,16 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/types.h>
+#include <linux/pm.h>
 
 #include "ad7879.h"
 
 #define AD7879_DEVID		0x79	/* AD7879-1/AD7889-1 */
 
 #ifdef CONFIG_PM
-static int ad7879_i2c_suspend(struct i2c_client *client, pm_message_t message)
+static int ad7879_i2c_suspend(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct ad7879 *ts = i2c_get_clientdata(client);
 
 	ad7879_suspend(ts);
@@ -25,17 +27,19 @@ static int ad7879_i2c_suspend(struct i2c_client *client, pm_message_t message)
 	return 0;
 }
 
-static int ad7879_i2c_resume(struct i2c_client *client)
+static int ad7879_i2c_resume(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct ad7879 *ts = i2c_get_clientdata(client);
 
 	ad7879_resume(ts);
 
 	return 0;
 }
+
+static SIMPLE_DEV_PM_OPS(ad7879_i2c_pm, ad7879_i2c_suspend, ad7879_i2c_resume);
 #else
-# define ad7879_i2c_suspend NULL
-# define ad7879_i2c_resume  NULL
+# define ad7879_i2c_pm NULL
 #endif
 
 /* All registers are word-sized.
@@ -117,11 +121,10 @@ static struct i2c_driver ad7879_i2c_driver = {
 	.driver = {
 		.name	= "ad7879",
 		.owner	= THIS_MODULE,
+		.pm	= &ad7879_i2c_pm,
 	},
 	.probe		= ad7879_i2c_probe,
 	.remove		= __devexit_p(ad7879_i2c_remove),
-	.suspend	= ad7879_i2c_suspend,
-	.resume		= ad7879_i2c_resume,
 	.id_table	= ad7879_id,
 };
 
-- 
1.7.2.3

