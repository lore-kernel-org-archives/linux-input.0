From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/7] Input: cyttsp - guard PM methods with CONFIG_PM_SLEEP
Date: Mon, 14 Nov 2011 00:15:56 -0800
Message-ID: <20111114081556.10141.73034.stgit@hammer.corenet.prv>
References: <20111114080939.10141.46174.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34009 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086Ab1KNIQA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 03:16:00 -0500
Received: by mail-iy0-f174.google.com with SMTP id e36so6951500iag.19
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 00:15:59 -0800 (PST)
In-Reply-To: <20111114080939.10141.46174.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org

This will prevent compiler from complaining about PM methods defined but
not used in case when CONFIG_PM_RUNTIME is defined but CONFIG_PM_SLEEP
is not.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/cyttsp_core.c |    2 +-
 drivers/input/touchscreen/cyttsp_core.h |    2 +-
 drivers/input/touchscreen/cyttsp_i2c.c  |    7 +++----
 drivers/input/touchscreen/cyttsp_spi.c  |    7 +++----
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
index 47a0958..54f36d6 100644
--- a/drivers/input/touchscreen/cyttsp_core.c
+++ b/drivers/input/touchscreen/cyttsp_core.c
@@ -592,7 +592,7 @@ bypass:
 	return retval;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 int cyttsp_resume(void *handle)
 {
 	struct cyttsp *ts = handle;
diff --git a/drivers/input/touchscreen/cyttsp_core.h b/drivers/input/touchscreen/cyttsp_core.h
index c4c7d9e..1a0fd9d 100644
--- a/drivers/input/touchscreen/cyttsp_core.h
+++ b/drivers/input/touchscreen/cyttsp_core.h
@@ -51,7 +51,7 @@ void *cyttsp_core_init(struct cyttsp_bus_ops *bus_ops,
 		       struct device *dev, int irq);
 
 void cyttsp_core_release(void *handle);
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 int cyttsp_resume(void *handle);
 int cyttsp_suspend(void *handle);
 #endif
diff --git a/drivers/input/touchscreen/cyttsp_i2c.c b/drivers/input/touchscreen/cyttsp_i2c.c
index d7d62d4..697c7a88 100644
--- a/drivers/input/touchscreen/cyttsp_i2c.c
+++ b/drivers/input/touchscreen/cyttsp_i2c.c
@@ -122,7 +122,7 @@ static int __devexit cyttsp_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int cyttsp_i2c_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -138,9 +138,10 @@ static int cyttsp_i2c_resume(struct device *dev)
 
 	return cyttsp_resume(ts->ttsp_client);
 }
-static SIMPLE_DEV_PM_OPS(cyttsp_i2c_pm, cyttsp_i2c_suspend, cyttsp_i2c_resume);
 #endif
 
+static SIMPLE_DEV_PM_OPS(cyttsp_i2c_pm, cyttsp_i2c_suspend, cyttsp_i2c_resume);
+
 static const struct i2c_device_id cyttsp_i2c_id[] = {
 	{ CY_I2C_NAME, 0 },  { }
 };
@@ -149,9 +150,7 @@ static struct i2c_driver cyttsp_i2c_driver = {
 	.driver = {
 		.name = CY_I2C_NAME,
 		.owner = THIS_MODULE,
-#ifdef CONFIG_PM
 		.pm = &cyttsp_i2c_pm,
-#endif
 	},
 	.probe = cyttsp_i2c_probe,
 	.remove = __devexit_p(cyttsp_i2c_remove),
diff --git a/drivers/input/touchscreen/cyttsp_spi.c b/drivers/input/touchscreen/cyttsp_spi.c
index 1324695..8138a96 100644
--- a/drivers/input/touchscreen/cyttsp_spi.c
+++ b/drivers/input/touchscreen/cyttsp_spi.c
@@ -227,7 +227,7 @@ static int __devexit cyttsp_spi_remove(struct spi_device *spi)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int cyttsp_spi_suspend(struct device *dev)
 {
 	struct cyttsp_spi *ts = dev_get_drvdata(dev);
@@ -241,16 +241,15 @@ static int cyttsp_spi_resume(struct device *dev)
 
 	return cyttsp_resume(ts->ttsp_client);
 }
-static SIMPLE_DEV_PM_OPS(cyttsp_spi_pm, cyttsp_spi_suspend, cyttsp_spi_resume);
 #endif
 
+static SIMPLE_DEV_PM_OPS(cyttsp_spi_pm, cyttsp_spi_suspend, cyttsp_spi_resume);
+
 static struct spi_driver cyttsp_spi_driver = {
 	.driver = {
 		.name = CY_SPI_NAME,
 		.owner = THIS_MODULE,
-#ifdef CONFIG_PM
 		.pm = &cyttsp_spi_pm,
-#endif
 	},
 	.probe = cyttsp_spi_probe,
 	.remove = __devexit_p(cyttsp_spi_remove),

