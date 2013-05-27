From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 10/19] mfd/ti_am335x_tscadc: remove platform_data support
Date: Mon, 27 May 2013 21:11:57 +0200
Message-ID: <1369681926-22185-11-git-send-email-bigeasy@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1369681926-22185-1-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This patch removes access to platform data mfd_tscadc_board because the
platform is DT only.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/mfd/ti_am335x_tscadc.c |   23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 7a4edc0..5b324e5 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -26,8 +26,6 @@
 #include <linux/of_device.h>
 
 #include <linux/mfd/ti_am335x_tscadc.h>
-#include <linux/input/ti_am335x_tsc.h>
-#include <linux/platform_data/ti_am335x_adc.h>
 
 static unsigned int tscadc_readl(struct ti_tscadc_dev *tsadc, unsigned int reg)
 {
@@ -65,31 +63,22 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
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
