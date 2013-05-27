From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 17/19] mfd / iio: ti_am335x_adc: rename device from tiadc to TI-adc
Date: Mon, 27 May 2013 21:12:04 +0200
Message-ID: <1369681926-22185-18-git-send-email-bigeasy@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48445 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068Ab3E0TNT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 May 2013 15:13:19 -0400
In-Reply-To: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>, Jonathan Cameron <jic23@cam.ac.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

TI-adc reads a little better compared to tiadc.
While here add an alias so the driver is loaded on demand.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iio/adc/ti_am335x_adc.c |    4 ++--
 drivers/mfd/ti_am335x_tscadc.c  |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 72ffe89..d0317fc 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -299,14 +299,14 @@ static const struct dev_pm_ops tiadc_pm_ops = {
 
 static struct platform_driver tiadc_driver = {
 	.driver = {
-		.name   = "tiadc",
+		.name   = "TI-adc",
 		.owner	= THIS_MODULE,
 		.pm	= TIADC_PM_OPS,
 	},
 	.probe	= tiadc_probe,
 	.remove	= tiadc_remove,
 };
-
+MODULE_ALIAS("platform:TI-adc");
 module_platform_driver(tiadc_driver);
 
 MODULE_DESCRIPTION("TI ADC controller driver");
diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index c25fe00..014df14 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -193,7 +193,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	if (adc_channels > 0) {
 		tscadc->adc_cell = tscadc->used_cells;
 		cell = &tscadc->cells[tscadc->used_cells++];
-		cell->name = "tiadc";
+		cell->name = "TI-adc";
 		cell->platform_data = tscadc;
 		cell->pdata_size = sizeof(*tscadc);
 	}
-- 
1.7.10.4

