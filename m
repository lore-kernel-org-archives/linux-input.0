From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] Input: ad714x-i2c - Convert to dev_pm_ops
Date: Fri, 11 Feb 2011 15:13:02 +0000
Message-ID: <1297437183-23648-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:59196 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756467Ab1BKPMv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Feb 2011 10:12:51 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bryan Wu <cooloney@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, Mike Frysinger <vapier@gentoo.org>, Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

There is a general move to convert drivers to use dev_pm_ops rather than
bus specific PM operations in order to facilitate core work. Do this
conversion for ad714x-i2c.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/misc/ad714x-i2c.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/input/misc/ad714x-i2c.c b/drivers/input/misc/ad714x-i2c.c
index 2bef8fa..e21deb1 100644
--- a/drivers/input/misc/ad714x-i2c.c
+++ b/drivers/input/misc/ad714x-i2c.c
@@ -10,23 +10,23 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/types.h>
+#include <linux/pm.h>
 #include "ad714x.h"
 
 #ifdef CONFIG_PM
-static int ad714x_i2c_suspend(struct i2c_client *client, pm_message_t message)
+static int ad714x_i2c_suspend(struct device *dev)
 {
-	return ad714x_disable(i2c_get_clientdata(client));
+	return ad714x_disable(i2c_get_clientdata(to_i2c_client(dev)));
 }
 
-static int ad714x_i2c_resume(struct i2c_client *client)
+static int ad714x_i2c_resume(struct device *dev)
 {
-	return ad714x_enable(i2c_get_clientdata(client));
+	return ad714x_enable(i2c_get_clientdata(to_i2c_client(dev)));
 }
-#else
-# define ad714x_i2c_suspend NULL
-# define ad714x_i2c_resume  NULL
 #endif
 
+static SIMPLE_DEV_PM_OPS(ad714x_i2c_pm, ad714x_i2c_suspend, ad714x_i2c_resume);
+
 static int ad714x_i2c_write(struct device *dev, unsigned short reg,
 				unsigned short data)
 {
@@ -114,11 +114,10 @@ MODULE_DEVICE_TABLE(i2c, ad714x_id);
 static struct i2c_driver ad714x_i2c_driver = {
 	.driver = {
 		.name = "ad714x_captouch",
+		.pm   = &ad714x_i2c_pm,
 	},
 	.probe    = ad714x_i2c_probe,
 	.remove   = __devexit_p(ad714x_i2c_remove),
-	.suspend  = ad714x_i2c_suspend,
-	.resume	  = ad714x_i2c_resume,
 	.id_table = ad714x_id,
 };
 
-- 
1.7.2.3

