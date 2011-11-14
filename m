From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: ad7879 - consolidate PM methods
Date: Mon, 14 Nov 2011 00:21:31 -0800
Message-ID: <1321258891-10398-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49802 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269Ab1KNIVg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 03:21:36 -0500
Received: by iage36 with SMTP id e36so6956454iag.19
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 00:21:35 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: linux-input@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org

The PM methods are basically the same for SPI and I2C busses, so let's
use the same dev_pm_ops for both of them.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/touchscreen/ad7879-i2c.c |   26 +-------------------------
 drivers/input/touchscreen/ad7879-spi.c |   26 +-------------------------
 drivers/input/touchscreen/ad7879.c     |   19 +++++++++++++++----
 drivers/input/touchscreen/ad7879.h     |    4 ++--
 4 files changed, 19 insertions(+), 56 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879-i2c.c b/drivers/input/touchscreen/ad7879-i2c.c
index c789b97..c4b5117 100644
--- a/drivers/input/touchscreen/ad7879-i2c.c
+++ b/drivers/input/touchscreen/ad7879-i2c.c
@@ -16,30 +16,6 @@
 
 #define AD7879_DEVID		0x79	/* AD7879-1/AD7889-1 */
 
-#ifdef CONFIG_PM_SLEEP
-static int ad7879_i2c_suspend(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct ad7879 *ts = i2c_get_clientdata(client);
-
-	ad7879_suspend(ts);
-
-	return 0;
-}
-
-static int ad7879_i2c_resume(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct ad7879 *ts = i2c_get_clientdata(client);
-
-	ad7879_resume(ts);
-
-	return 0;
-}
-#endif
-
-static SIMPLE_DEV_PM_OPS(ad7879_i2c_pm, ad7879_i2c_suspend, ad7879_i2c_resume);
-
 /* All registers are word-sized.
  * AD7879 uses a high-byte first convention.
  */
@@ -119,7 +95,7 @@ static struct i2c_driver ad7879_i2c_driver = {
 	.driver = {
 		.name	= "ad7879",
 		.owner	= THIS_MODULE,
-		.pm	= &ad7879_i2c_pm,
+		.pm	= &ad7879_pm_ops,
 	},
 	.probe		= ad7879_i2c_probe,
 	.remove		= __devexit_p(ad7879_i2c_remove),
diff --git a/drivers/input/touchscreen/ad7879-spi.c b/drivers/input/touchscreen/ad7879-spi.c
index ddf732f..8b44fc7 100644
--- a/drivers/input/touchscreen/ad7879-spi.c
+++ b/drivers/input/touchscreen/ad7879-spi.c
@@ -21,30 +21,6 @@
 #define AD7879_WRITECMD(reg) (AD7879_CMD(reg))
 #define AD7879_READCMD(reg)  (AD7879_CMD(reg) | AD7879_CMD_READ)
 
-#ifdef CONFIG_PM_SLEEP
-static int ad7879_spi_suspend(struct device *dev)
-{
-	struct spi_device *spi = to_spi_device(dev);
-	struct ad7879 *ts = spi_get_drvdata(spi);
-
-	ad7879_suspend(ts);
-
-	return 0;
-}
-
-static int ad7879_spi_resume(struct device *dev)
-{
-	struct spi_device *spi = to_spi_device(dev);
-	struct ad7879 *ts = spi_get_drvdata(spi);
-
-	ad7879_resume(ts);
-
-	return 0;
-}
-#endif
-
-static SIMPLE_DEV_PM_OPS(ad7879_spi_pm, ad7879_spi_suspend, ad7879_spi_resume);
-
 /*
  * ad7879_read/write are only used for initial setup and for sysfs controls.
  * The main traffic is done in ad7879_collect().
@@ -175,7 +151,7 @@ static struct spi_driver ad7879_spi_driver = {
 		.name	= "ad7879",
 		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
-		.pm	= &ad7879_spi_pm,
+		.pm	= &ad7879_pm_ops,
 	},
 	.probe		= ad7879_spi_probe,
 	.remove		= __devexit_p(ad7879_spi_remove),
diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index 76f5cb4..dce60b8 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -280,8 +280,11 @@ static void ad7879_close(struct input_dev* input)
 		__ad7879_disable(ts);
 }
 
-void ad7879_suspend(struct ad7879 *ts)
+#ifdef CONFIG_PM_SLEEP
+static int ad7879_suspend(struct device *dev)
 {
+	struct ad7879 *ts = dev_get_drvdata(dev);
+
 	mutex_lock(&ts->input->mutex);
 
 	if (!ts->suspended && !ts->disabled && ts->input->users)
@@ -290,11 +293,14 @@ void ad7879_suspend(struct ad7879 *ts)
 	ts->suspended = true;
 
 	mutex_unlock(&ts->input->mutex);
+
+	return 0;
 }
-EXPORT_SYMBOL(ad7879_suspend);
 
-void ad7879_resume(struct ad7879 *ts)
+static int ad7879_resume(struct device *dev)
 {
+	struct ad7879 *ts = dev_get_drvdata(dev);
+
 	mutex_lock(&ts->input->mutex);
 
 	if (ts->suspended && !ts->disabled && ts->input->users)
@@ -303,8 +309,13 @@ void ad7879_resume(struct ad7879 *ts)
 	ts->suspended = false;
 
 	mutex_unlock(&ts->input->mutex);
+
+	return 0;
 }
-EXPORT_SYMBOL(ad7879_resume);
+#endif
+
+SIMPLE_DEV_PM_OPS(ad7879_pm_ops, ad7879_suspend, ad7879_resume);
+EXPORT_SYMBOL(ad7879_pm_ops);
 
 static void ad7879_toggle(struct ad7879 *ts, bool disable)
 {
diff --git a/drivers/input/touchscreen/ad7879.h b/drivers/input/touchscreen/ad7879.h
index 6b45a27..6fd13c4 100644
--- a/drivers/input/touchscreen/ad7879.h
+++ b/drivers/input/touchscreen/ad7879.h
@@ -21,8 +21,8 @@ struct ad7879_bus_ops {
 	int (*write)(struct device *dev, u8 reg, u16 val);
 };
 
-void ad7879_suspend(struct ad7879 *);
-void ad7879_resume(struct ad7879 *);
+extern const struct dev_pm_ops ad7879_pm_ops;
+
 struct ad7879 *ad7879_probe(struct device *dev, u8 devid, unsigned irq,
 			    const struct ad7879_bus_ops *bops);
 void ad7879_remove(struct ad7879 *);
-- 
1.7.6.4

