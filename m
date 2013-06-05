From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 11/22] mfd/ti_am335x_tscadc: remove platform_data support
Date: Wed,  5 Jun 2013 18:24:44 +0200
Message-ID: <1370449495-29981-12-git-send-email-bigeasy@linutronix.de>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35314 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756398Ab3FEQ33 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Jun 2013 12:29:29 -0400
In-Reply-To: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@cam.ac.uk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This patch removes access to platform data mfd_tscadc_board because the
platform is DT only.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/mfd/ti_am335x_tscadc.c |   23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index e74e7e0..6b85459 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -25,8 +25,6 @@
 #include <linux/of_device.h>
 
 #include <linux/mfd/ti_am335x_tscadc.h>
-#include <linux/input/ti_am335x_tsc.h>
-#include <linux/platform_data/ti_am335x_adc.h>
 
 static unsigned int tscadc_readl(struct ti_tscadc_dev *tsadc, unsigned int reg)
 {
@@ -80,31 +78,22 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	struct ti_tscadc_dev	*tscadc;
 	struct resource		*res;
 	struct clk		*clk;
-	struct mfd_tscadc_board	*pdata = pdev->dev.platform_data;
 	struct device_node	*node = pdev->dev.of_node;
 	struct mfd_cell		*cell;
 	int			err, ctrl;
 	int			clk_value, clock_rate;
 	int			tsc_wires = 0, adc_channels = 0, total_channels;
 
-	if (!pdata && !pdev->dev.of_node) {
-		dev_err(&pdev->dev, "Could not find platform data\n");
+	if (!pdev->dev.of_node) {
+		dev_err(&pdev->dev, "Could not find valid DT data.\n");
 		return -EINVAL;
 	}
 
-	if (pdev->dev.platform_data) {
-		if (pdata->tsc_init)
-			tsc_wires = pdata->tsc_init->wires;
+	node = of_get_child_by_name(pdev->dev.of_node, "tsc");
+	of_property_read_u32(node, "ti,wires", &tsc_wires);
 
-		if (pdata->adc_init)
-			adc_channels = pdata->adc_init->adc_channels;
-	} else {
-		node = of_get_child_by_name(pdev->dev.of_node, "tsc");
-		of_property_read_u32(node, "ti,wires", &tsc_wires);
-
-		node = of_get_child_by_name(pdev->dev.of_node, "adc");
-		of_property_read_u32(node, "ti,adc-channels", &adc_channels);
-	}
+	node = of_get_child_by_name(pdev->dev.of_node, "adc");
+	of_property_read_u32(node, "ti,adc-channels", &adc_channels);
 
 	total_channels = tsc_wires + adc_channels;
 
-- 
1.7.10.4

