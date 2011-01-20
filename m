From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] Input: ad7879 - Convert SPI to dev_pm_ops
Date: Thu, 20 Jan 2011 21:10:22 +0000
Message-ID: <1295557823-20907-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1295557823-20907-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:46741 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753882Ab1ATVKL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Jan 2011 16:10:11 -0500
In-Reply-To: <1295557823-20907-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Hennerich <michael.hennerich@analog.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mike Frysinger <vapier@gentoo.org>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

There is a move to deprecate bus-specific PM operations and move to
using dev_pm_ops instead in order to reduce the amount of boilerplate
code in buses and facilitiate updates to the PM core. Do this move for
the ad7979 SPI driver.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/ad7879-spi.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879-spi.c b/drivers/input/touchscreen/ad7879-spi.c
index 59c6e68..ddf732f 100644
--- a/drivers/input/touchscreen/ad7879-spi.c
+++ b/drivers/input/touchscreen/ad7879-spi.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/input.h>	/* BUS_SPI */
+#include <linux/pm.h>
 #include <linux/spi/spi.h>
 
 #include "ad7879.h"
@@ -20,9 +21,10 @@
 #define AD7879_WRITECMD(reg) (AD7879_CMD(reg))
 #define AD7879_READCMD(reg)  (AD7879_CMD(reg) | AD7879_CMD_READ)
 
-#ifdef CONFIG_PM
-static int ad7879_spi_suspend(struct spi_device *spi, pm_message_t message)
+#ifdef CONFIG_PM_SLEEP
+static int ad7879_spi_suspend(struct device *dev)
 {
+	struct spi_device *spi = to_spi_device(dev);
 	struct ad7879 *ts = spi_get_drvdata(spi);
 
 	ad7879_suspend(ts);
@@ -30,19 +32,19 @@ static int ad7879_spi_suspend(struct spi_device *spi, pm_message_t message)
 	return 0;
 }
 
-static int ad7879_spi_resume(struct spi_device *spi)
+static int ad7879_spi_resume(struct device *dev)
 {
+	struct spi_device *spi = to_spi_device(dev);
 	struct ad7879 *ts = spi_get_drvdata(spi);
 
 	ad7879_resume(ts);
 
 	return 0;
 }
-#else
-# define ad7879_spi_suspend NULL
-# define ad7879_spi_resume  NULL
 #endif
 
+static SIMPLE_DEV_PM_OPS(ad7879_spi_pm, ad7879_spi_suspend, ad7879_spi_resume);
+
 /*
  * ad7879_read/write are only used for initial setup and for sysfs controls.
  * The main traffic is done in ad7879_collect().
@@ -173,11 +175,10 @@ static struct spi_driver ad7879_spi_driver = {
 		.name	= "ad7879",
 		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
+		.pm	= &ad7879_spi_pm,
 	},
 	.probe		= ad7879_spi_probe,
 	.remove		= __devexit_p(ad7879_spi_remove),
-	.suspend	= ad7879_spi_suspend,
-	.resume		= ad7879_spi_resume,
 };
 
 static int __init ad7879_spi_init(void)
-- 
1.7.2.3

