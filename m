From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Input: synaptics_i2c - Convert to dev_pm_ops
Date: Fri, 11 Feb 2011 15:41:44 +0000
Message-ID: <1297438904-27430-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:46030 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756903Ab1BKPl0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Feb 2011 10:41:26 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>, Igor Grinberg <grinberg@compulab.co.il>, Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

There is a general move to convert drivers to dev_pm_ops rather than bus
specific PM ops in order to facilitate core development. Do this converison
for synaptics-i2c.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/mouse/synaptics_i2c.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index 0ae62f0..f6aa26d 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/workqueue.h>
 #include <linux/slab.h>
+#include <linux/pm.h>
 
 #define DRIVER_NAME		"synaptics_i2c"
 /* maximum product id is 15 characters */
@@ -619,8 +620,9 @@ static int __devexit synaptics_i2c_remove(struct i2c_client *client)
 }
 
 #ifdef CONFIG_PM
-static int synaptics_i2c_suspend(struct i2c_client *client, pm_message_t mesg)
+static int synaptics_i2c_suspend(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct synaptics_i2c *touch = i2c_get_clientdata(client);
 
 	cancel_delayed_work_sync(&touch->dwork);
@@ -631,9 +633,10 @@ static int synaptics_i2c_suspend(struct i2c_client *client, pm_message_t mesg)
 	return 0;
 }
 
-static int synaptics_i2c_resume(struct i2c_client *client)
+static int synaptics_i2c_resume(struct device *dev)
 {
 	int ret;
+	struct i2c_client *client = to_i2c_client(dev);
 	struct synaptics_i2c *touch = i2c_get_clientdata(client);
 
 	ret = synaptics_i2c_reset_config(client);
@@ -645,11 +648,11 @@ static int synaptics_i2c_resume(struct i2c_client *client)
 
 	return 0;
 }
-#else
-#define synaptics_i2c_suspend	NULL
-#define synaptics_i2c_resume	NULL
 #endif
 
+static SIMPLE_DEV_PM_OPS(synaptics_i2c_pm, synaptics_i2c_suspend,
+			 synaptics_i2c_resume);
+
 static const struct i2c_device_id synaptics_i2c_id_table[] = {
 	{ "synaptics_i2c", 0 },
 	{ },
@@ -660,13 +663,12 @@ static struct i2c_driver synaptics_i2c_driver = {
 	.driver = {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
+		.pm	= &synaptics_i2c_pm,
 	},
 
 	.probe		= synaptics_i2c_probe,
 	.remove		= __devexit_p(synaptics_i2c_remove),
 
-	.suspend	= synaptics_i2c_suspend,
-	.resume		= synaptics_i2c_resume,
 	.id_table	= synaptics_i2c_id_table,
 };
 
-- 
1.7.2.3

