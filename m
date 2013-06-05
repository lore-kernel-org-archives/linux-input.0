From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 10/22] mfd/ti_am335x_tscadc: Add DT support
Date: Wed,  5 Jun 2013 18:24:43 +0200
Message-ID: <1370449495-29981-11-git-send-email-bigeasy@linutronix.de>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35271 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754553Ab3FEQ1W (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Jun 2013 12:27:22 -0400
In-Reply-To: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@cam.ac.uk>, "Patil, Rachna" <rachna@ti.com>, Pantelis Antoniou <panto@antoniou-consulting.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

From: "Patil, Rachna" <rachna@ti.com>

Make changes to add DT support in the MFD core driver.

[ panto@antoniou-consulting.com : use of_get_child_by_name
	instead of of_find_node_by_name ]

Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
Signed-off-by: Patil, Rachna <rachna@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
[bigeasy: module alias, rename to ti,am3359-tscadc as it was tested on
          AM3359]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/mfd/ti_am335x_tscadc.c |   32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 7b091c4..e74e7e0 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -21,6 +21,8 @@
 #include <linux/clk.h>
 #include <linux/mfd/core.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <linux/mfd/ti_am335x_tscadc.h>
 #include <linux/input/ti_am335x_tsc.h>
@@ -79,20 +81,31 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	struct resource		*res;
 	struct clk		*clk;
 	struct mfd_tscadc_board	*pdata = pdev->dev.platform_data;
+	struct device_node	*node = pdev->dev.of_node;
 	struct mfd_cell		*cell;
 	int			err, ctrl;
 	int			clk_value, clock_rate;
-	int			tsc_wires, adc_channels = 0, total_channels;
+	int			tsc_wires = 0, adc_channels = 0, total_channels;
 
-	if (!pdata) {
+	if (!pdata && !pdev->dev.of_node) {
 		dev_err(&pdev->dev, "Could not find platform data\n");
 		return -EINVAL;
 	}
 
-	if (pdata->adc_init)
-		adc_channels = pdata->adc_init->adc_channels;
+	if (pdev->dev.platform_data) {
+		if (pdata->tsc_init)
+			tsc_wires = pdata->tsc_init->wires;
+
+		if (pdata->adc_init)
+			adc_channels = pdata->adc_init->adc_channels;
+	} else {
+		node = of_get_child_by_name(pdev->dev.of_node, "tsc");
+		of_property_read_u32(node, "ti,wires", &tsc_wires);
+
+		node = of_get_child_by_name(pdev->dev.of_node, "adc");
+		of_property_read_u32(node, "ti,adc-channels", &adc_channels);
+	}
 
-	tsc_wires = pdata->tsc_init->wires;
 	total_channels = tsc_wires + adc_channels;
 
 	if (total_channels > 8) {
@@ -264,11 +277,18 @@ static const struct dev_pm_ops tscadc_pm_ops = {
 #define TSCADC_PM_OPS NULL
 #endif
 
+static const struct of_device_id ti_tscadc_dt_ids[] = {
+	{ .compatible = "ti,am3359-tscadc", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ti_tscadc_dt_ids);
+
 static struct platform_driver ti_tscadc_driver = {
 	.driver = {
-		.name   = "ti_tscadc",
+		.name   = "ti_am3359-tscadc",
 		.owner	= THIS_MODULE,
 		.pm	= TSCADC_PM_OPS,
+		.of_match_table = of_match_ptr(ti_tscadc_dt_ids),
 	},
 	.probe	= ti_tscadc_probe,
 	.remove	= ti_tscadc_remove,
-- 
1.7.10.4

