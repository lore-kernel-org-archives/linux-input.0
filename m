From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] Input: wm831x-ts - Allow IRQ flags to be specified
Date: Tue, 19 Apr 2011 19:17:53 +0100
Message-ID: <1303237074-12878-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1303237074-12878-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:43453 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753451Ab1DSSRs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Apr 2011 14:17:48 -0400
In-Reply-To: <1303237074-12878-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>

This allows maximum flexibility for configuring the direct GPIO based
interrupts.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/wm831x-ts.c |   16 +++++++++++++---
 include/linux/mfd/wm831x/pdata.h      |    2 ++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/wm831x-ts.c b/drivers/input/touchscreen/wm831x-ts.c
index b937301..78e8705 100644
--- a/drivers/input/touchscreen/wm831x-ts.c
+++ b/drivers/input/touchscreen/wm831x-ts.c
@@ -241,7 +241,7 @@ static __devinit int wm831x_ts_probe(struct platform_device *pdev)
 	struct wm831x_pdata *core_pdata = dev_get_platdata(pdev->dev.parent);
 	struct wm831x_touch_pdata *pdata = NULL;
 	struct input_dev *input_dev;
-	int error;
+	int error, irqf;
 
 	if (core_pdata)
 		pdata = core_pdata->touch;
@@ -314,9 +314,14 @@ static __devinit int wm831x_ts_probe(struct platform_device *pdev)
 	wm831x_set_bits(wm831x, WM831X_TOUCH_CONTROL_1,
 			WM831X_TCH_RATE_MASK, 6);
 
+	if (pdata && pdata->data_irqf)
+		irqf = pdata->data_irqf;
+	else
+		irqf = IRQF_TRIGGER_HIGH;
+
 	error = request_threaded_irq(wm831x_ts->data_irq,
 				     NULL, wm831x_ts_data_irq,
-				     IRQF_ONESHOT,
+				     irqf | IRQF_ONESHOT,
 				     "Touchscreen data", wm831x_ts);
 	if (error) {
 		dev_err(&pdev->dev, "Failed to request data IRQ %d: %d\n",
@@ -325,9 +330,14 @@ static __devinit int wm831x_ts_probe(struct platform_device *pdev)
 	}
 	disable_irq(wm831x_ts->data_irq);
 
+	if (pdata && pdata->pd_irqf)
+		irqf = pdata->pd_irqf;
+	else
+		irqf = IRQF_TRIGGER_HIGH;
+
 	error = request_threaded_irq(wm831x_ts->pd_irq,
 				     NULL, wm831x_ts_pen_down_irq,
-				     IRQF_ONESHOT,
+				     irqf | IRQF_ONESHOT,
 				     "Touchscreen pen down", wm831x_ts);
 	if (error) {
 		dev_err(&pdev->dev, "Failed to request pen down IRQ %d: %d\n",
diff --git a/include/linux/mfd/wm831x/pdata.h b/include/linux/mfd/wm831x/pdata.h
index cef19f0..ff42d70 100644
--- a/include/linux/mfd/wm831x/pdata.h
+++ b/include/linux/mfd/wm831x/pdata.h
@@ -81,7 +81,9 @@ struct wm831x_touch_pdata {
 	int rpu;               /** Pen down sensitivity resistor divider */
 	int pressure;          /** Report pressure (boolean) */
 	unsigned int data_irq; /** Touch data ready IRQ */
+	int data_irqf;         /** IRQ flags for data ready IRQ */
 	unsigned int pd_irq;   /** Touch pendown detect IRQ */
+	int pd_irqf;           /** IRQ flags for pen down IRQ */
 };
 
 enum wm831x_watchdog_action {
-- 
1.7.4.1

