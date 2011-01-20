From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] Input: ad7877 - Convert to dev_pm_ops
Date: Thu, 20 Jan 2011 21:10:21 +0000
Message-ID: <1295557823-20907-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:46736 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753882Ab1ATVKI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Jan 2011 16:10:08 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Hennerich <michael.hennerich@analog.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mike Frysinger <vapier@gentoo.org>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

There is a move to deprecate bus-specific PM operations and move to
using dev_pm_ops instead in order to reduce the amount of boilerplate
code in buses and facilitiate updates to the PM core. Do this move for
the ad7879 SPI driver.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/ad7877.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
index a1952fc..714d4e0 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -41,6 +41,7 @@
 #include <linux/delay.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
+#include <linux/pm.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ad7877.h>
@@ -826,39 +827,37 @@ static int __devexit ad7877_remove(struct spi_device *spi)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int ad7877_suspend(struct spi_device *spi, pm_message_t message)
+#ifdef CONFIG_PM_SLEEP
+static int ad7877_suspend(struct device *dev)
 {
-	struct ad7877 *ts = dev_get_drvdata(&spi->dev);
+	struct ad7877 *ts = dev_get_drvdata(dev);
 
 	ad7877_disable(ts);
 
 	return 0;
 }
 
-static int ad7877_resume(struct spi_device *spi)
+static int ad7877_resume(struct device *dev)
 {
-	struct ad7877 *ts = dev_get_drvdata(&spi->dev);
+	struct ad7877 *ts = dev_get_drvdata(dev);
 
 	ad7877_enable(ts);
 
 	return 0;
 }
-#else
-#define ad7877_suspend NULL
-#define ad7877_resume  NULL
 #endif
 
+static SIMPLE_DEV_PM_OPS(ad7877_pm, ad7877_suspend, ad7877_resume);
+
 static struct spi_driver ad7877_driver = {
 	.driver = {
 		.name	= "ad7877",
 		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
+		.pm	= &ad7877_pm,
 	},
 	.probe		= ad7877_probe,
 	.remove		= __devexit_p(ad7877_remove),
-	.suspend	= ad7877_suspend,
-	.resume		= ad7877_resume,
 };
 
 static int __init ad7877_init(void)
-- 
1.7.2.3

