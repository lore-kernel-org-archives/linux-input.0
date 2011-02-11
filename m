From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] Input: ad714x-spi - Convert to dev_pm_ops
Date: Fri, 11 Feb 2011 15:13:03 +0000
Message-ID: <1297437183-23648-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1297437183-23648-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:59200 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756590Ab1BKPMw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Feb 2011 10:12:52 -0500
In-Reply-To: <1297437183-23648-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bryan Wu <cooloney@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, Mike Frysinger <vapier@gentoo.org>, Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

There is a general move to convert drivers to use dev_pm_ops rather than
bus specific PM operations in order to facilitate core work. Do this
conversion for ad714x-spi.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/misc/ad714x-spi.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/input/misc/ad714x-spi.c b/drivers/input/misc/ad714x-spi.c
index 7f8dedf..4120dd5 100644
--- a/drivers/input/misc/ad714x-spi.c
+++ b/drivers/input/misc/ad714x-spi.c
@@ -9,6 +9,7 @@
 #include <linux/input.h>	/* BUS_I2C */
 #include <linux/module.h>
 #include <linux/spi/spi.h>
+#include <linux/pm.h>
 #include <linux/types.h>
 #include "ad714x.h"
 
@@ -16,20 +17,19 @@
 #define AD714x_SPI_READ            BIT(10)
 
 #ifdef CONFIG_PM
-static int ad714x_spi_suspend(struct spi_device *spi, pm_message_t message)
+static int ad714x_spi_suspend(struct device *dev)
 {
-	return ad714x_disable(spi_get_drvdata(spi));
+	return ad714x_disable(spi_get_drvdata(to_spi_device(dev)));
 }
 
-static int ad714x_spi_resume(struct spi_device *spi)
+static int ad714x_spi_resume(struct device *dev)
 {
-	return ad714x_enable(spi_get_drvdata(spi));
+	return ad714x_enable(spi_get_drvdata(to_spi_device(dev)));
 }
-#else
-# define ad714x_spi_suspend NULL
-# define ad714x_spi_resume  NULL
 #endif
 
+static SIMPLE_DEV_PM_OPS(ad714x_spi_pm, ad714x_spi_suspend, ad714x_spi_resume);
+
 static int ad714x_spi_read(struct device *dev, unsigned short reg,
 		unsigned short *data)
 {
@@ -79,11 +79,10 @@ static struct spi_driver ad714x_spi_driver = {
 	.driver = {
 		.name	= "ad714x_captouch",
 		.owner	= THIS_MODULE,
+		.pm	= &ad714x_spi_pm,
 	},
 	.probe		= ad714x_spi_probe,
 	.remove		= __devexit_p(ad714x_spi_remove),
-	.suspend	= ad714x_spi_suspend,
-	.resume		= ad714x_spi_resume,
 };
 
 static __init int ad714x_spi_init(void)
-- 
1.7.2.3

