From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 7/7] Input: cyttsp - consolidate PM methods
Date: Mon, 14 Nov 2011 00:16:17 -0800
Message-ID: <20111114081617.10141.41781.stgit@hammer.corenet.prv>
References: <20111114080939.10141.46174.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34009 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507Ab1KNIQV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 03:16:21 -0500
Received: by mail-iy0-f174.google.com with SMTP id e36so6951500iag.19
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 00:16:20 -0800 (PST)
In-Reply-To: <20111114080939.10141.46174.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org

The PM methods are basically the same for SPI and I2C busses, so let's
use the same dev_pm_ops for both of them.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/cyttsp_core.c |   22 ++++++++++------------
 drivers/input/touchscreen/cyttsp_core.h |    6 ++----
 drivers/input/touchscreen/cyttsp_i2c.c  |   22 +---------------------
 drivers/input/touchscreen/cyttsp_spi.c  |   20 +-------------------
 4 files changed, 14 insertions(+), 56 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
index ccdfa10..cd0fe40 100644
--- a/drivers/input/touchscreen/cyttsp_core.c
+++ b/drivers/input/touchscreen/cyttsp_core.c
@@ -504,16 +504,13 @@ bypass:
 }
 
 #ifdef CONFIG_PM_SLEEP
-int cyttsp_resume(struct cyttsp *ts)
+static int cyttsp_resume(struct device *dev)
 {
+	struct cyttsp *ts = dev_get_drvdata(dev);
 	int retval = 0;
 	struct cyttsp_xydata xydata;
 
-	if (!ts)
-		return retval;
-
-	if (ts->pdata->use_sleep && (ts->power_state !=
-					     CY_ACTIVE_STATE)) {
+	if (ts->pdata->use_sleep && ts->power_state != CY_ACTIVE_STATE) {
 
 		if (ts->pdata->wakeup)
 			retval = ts->pdata->wakeup();
@@ -532,16 +529,15 @@ int cyttsp_resume(struct cyttsp *ts)
 
 	return retval;
 }
-EXPORT_SYMBOL_GPL(cyttsp_resume);
 
-int cyttsp_suspend(struct cyttsp *ts)
+static int cyttsp_suspend(struct device *dev)
 {
+	struct cyttsp *ts = dev_get_drvdata(dev);
 	u8 sleep_mode = 0;
 	int retval = 0;
 
-	if (ts->pdata->use_sleep &&
-		(ts->power_state == CY_ACTIVE_STATE)) {
-		sleep_mode = ts->pdata->use_sleep;
+	if (ts->pdata->use_sleep && ts->power_state == CY_ACTIVE_STATE) {
+		sleep_mode = ts->platform_data->use_sleep;
 		retval = ttsp_write_block_data(ts,
 			CY_REG_BASE, sizeof(sleep_mode), &sleep_mode);
 		if (retval >= 0)
@@ -550,9 +546,11 @@ int cyttsp_suspend(struct cyttsp *ts)
 
 	return retval;
 }
-EXPORT_SYMBOL_GPL(cyttsp_suspend);
 #endif
 
+SIMPLE_DEV_PM_OPS(cyttsp_pm_ops, cyttsp_suspend, cyttsp_resume);
+EXPORT_SYMBOL_GPL(cyttsp_pm_ops);
+
 static int cyttsp_open(struct input_dev *dev)
 {
 	struct cyttsp *ts = input_get_drvdata(dev);
diff --git a/drivers/input/touchscreen/cyttsp_core.h b/drivers/input/touchscreen/cyttsp_core.h
index 1d9f185..5087b2b 100644
--- a/drivers/input/touchscreen/cyttsp_core.h
+++ b/drivers/input/touchscreen/cyttsp_core.h
@@ -134,9 +134,7 @@ struct cyttsp {
 struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
 			    struct device *dev, int irq, size_t xfer_buf_size);
 void cyttsp_remove(struct cyttsp *ts);
-#ifdef CONFIG_PM_SLEEP
-int cyttsp_resume(struct cyttsp *ts);
-int cyttsp_suspend(struct cyttsp *ts);
-#endif
+
+extern const struct dev_pm_ops cyttsp_pm_ops;
 
 #endif /* __CYTTSP_CORE_H__ */
diff --git a/drivers/input/touchscreen/cyttsp_i2c.c b/drivers/input/touchscreen/cyttsp_i2c.c
index b476441..2b6acf4 100644
--- a/drivers/input/touchscreen/cyttsp_i2c.c
+++ b/drivers/input/touchscreen/cyttsp_i2c.c
@@ -107,26 +107,6 @@ static int __devexit cyttsp_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int cyttsp_i2c_suspend(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct cyttsp *ts = i2c_get_clientdata(client);
-
-	return cyttsp_suspend(ts);
-}
-
-static int cyttsp_i2c_resume(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct cyttsp *ts = i2c_get_clientdata(client);
-
-	return cyttsp_resume(ts);
-}
-#endif
-
-static SIMPLE_DEV_PM_OPS(cyttsp_i2c_pm, cyttsp_i2c_suspend, cyttsp_i2c_resume);
-
 static const struct i2c_device_id cyttsp_i2c_id[] = {
 	{ CY_I2C_NAME, 0 },
 	{ }
@@ -137,7 +117,7 @@ static struct i2c_driver cyttsp_i2c_driver = {
 	.driver = {
 		.name	= CY_I2C_NAME,
 		.owner	= THIS_MODULE,
-		.pm	= &cyttsp_i2c_pm,
+		.pm	= &cyttsp_pm_ops,
 	},
 	.probe		= cyttsp_i2c_probe,
 	.remove		= __devexit_p(cyttsp_i2c_remove),
diff --git a/drivers/input/touchscreen/cyttsp_spi.c b/drivers/input/touchscreen/cyttsp_spi.c
index eafa357..61a2e6c 100644
--- a/drivers/input/touchscreen/cyttsp_spi.c
+++ b/drivers/input/touchscreen/cyttsp_spi.c
@@ -215,29 +215,11 @@ static int __devexit cyttsp_spi_remove(struct spi_device *spi)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int cyttsp_spi_suspend(struct device *dev)
-{
-	struct cyttsp *ts = dev_get_drvdata(dev);
-
-	return cyttsp_suspend(ts);
-}
-
-static int cyttsp_spi_resume(struct device *dev)
-{
-	struct cyttsp *ts = dev_get_drvdata(dev);
-
-	return cyttsp_resume(ts);
-}
-#endif
-
-static SIMPLE_DEV_PM_OPS(cyttsp_spi_pm, cyttsp_spi_suspend, cyttsp_spi_resume);
-
 static struct spi_driver cyttsp_spi_driver = {
 	.driver = {
 		.name	= CY_SPI_NAME,
 		.owner	= THIS_MODULE,
-		.pm	= &cyttsp_spi_pm,
+		.pm	= &cyttsp_pm_ops,
 	},
 	.probe	= cyttsp_spi_probe,
 	.remove = __devexit_p(cyttsp_spi_remove),

