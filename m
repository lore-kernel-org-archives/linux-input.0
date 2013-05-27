From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 16/19] mfd / input: ti_am335x_tsc: rename device from tsc to TI-tsc
Date: Mon, 27 May 2013 21:12:03 +0200
Message-ID: <1369681926-22185-17-git-send-email-bigeasy@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48420 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068Ab3E0TMx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 May 2013 15:12:53 -0400
In-Reply-To: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>, Jonathan Cameron <jic23@cam.ac.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

tsc is a very generic name. This patch adds a TI prefix to make it a
little less generic.
While here add an alias so the driver is loaded on demand.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |    3 ++-
 drivers/mfd/ti_am335x_tscadc.c            |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 96accaa..2921163 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -543,11 +543,12 @@ static struct platform_driver ti_tsc_driver = {
 	.probe	= titsc_probe,
 	.remove	= titsc_remove,
 	.driver	= {
-		.name   = "tsc",
+		.name   = "TI-tsc",
 		.owner	= THIS_MODULE,
 		.pm	= TITSC_PM_OPS,
 	},
 };
+MODULE_ALIAS("platform:TI-tsc");
 module_platform_driver(ti_tsc_driver);
 
 MODULE_DESCRIPTION("TI touchscreen controller driver");
diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index a27401a..c25fe00 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -184,7 +184,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	if (tsc_wires > 0) {
 		tscadc->tsc_cell = tscadc->used_cells;
 		cell = &tscadc->cells[tscadc->used_cells++];
-		cell->name = "tsc";
+		cell->name = "TI-tsc";
 		cell->platform_data = tscadc;
 		cell->pdata_size = sizeof(*tscadc);
 	}
-- 
1.7.10.4

