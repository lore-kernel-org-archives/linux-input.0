From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Input: max7359 - Convert to dev_pm_ops
Date: Fri, 11 Feb 2011 14:48:50 +0000
Message-ID: <1297435730-13719-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58054 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752260Ab1BKOsf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Feb 2011 09:48:35 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kim Kyuwon <q1.kim@samsung.com>, Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

There is a general move to convert drivers to use dev_pm_ops rather than
bus specific ops to facilitate core work. Do this conversion for max7359.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/keyboard/max7359_keypad.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/max7359_keypad.c b/drivers/input/keyboard/max7359_keypad.c
index 9091ff5..5afe35a 100644
--- a/drivers/input/keyboard/max7359_keypad.c
+++ b/drivers/input/keyboard/max7359_keypad.c
@@ -17,6 +17,7 @@
 #include <linux/i2c.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
+#include <linux/pm.h>
 #include <linux/input.h>
 #include <linux/input/matrix_keypad.h>
 
@@ -271,8 +272,10 @@ static int __devexit max7359_remove(struct i2c_client *client)
 }
 
 #ifdef CONFIG_PM
-static int max7359_suspend(struct i2c_client *client, pm_message_t mesg)
+static int max7359_suspend(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
+
 	max7359_fall_deepsleep(client);
 
 	if (device_may_wakeup(&client->dev))
@@ -281,8 +284,10 @@ static int max7359_suspend(struct i2c_client *client, pm_message_t mesg)
 	return 0;
 }
 
-static int max7359_resume(struct i2c_client *client)
+static int max7359_resume(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
+
 	if (device_may_wakeup(&client->dev))
 		disable_irq_wake(client->irq);
 
@@ -291,11 +296,10 @@ static int max7359_resume(struct i2c_client *client)
 
 	return 0;
 }
-#else
-#define max7359_suspend	NULL
-#define max7359_resume	NULL
 #endif
 
+static SIMPLE_DEV_PM_OPS(max7359_pm, max7359_suspend, max7359_resume);
+
 static const struct i2c_device_id max7359_ids[] = {
 	{ "max7359", 0 },
 	{ }
@@ -305,11 +309,10 @@ MODULE_DEVICE_TABLE(i2c, max7359_ids);
 static struct i2c_driver max7359_i2c_driver = {
 	.driver = {
 		.name = "max7359",
+		.pm   = &max7359_pm,
 	},
 	.probe		= max7359_probe,
 	.remove		= __devexit_p(max7359_remove),
-	.suspend	= max7359_suspend,
-	.resume		= max7359_resume,
 	.id_table	= max7359_ids,
 };
 
-- 
1.7.2.3

