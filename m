From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Input: wm831x-ts - Fix races with IRQ management
Date: Tue,  1 Mar 2011 16:54:19 +0000
Message-ID: <1298998459-12526-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:54429 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754051Ab1CAQyB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Mar 2011 11:54:01 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>

If the WM831x pen down and data IRQs run in parallel it is possible for the
data and pen down IRQs to deadlock themselves as one is part way through
disabling its operation while the other is part way through enabling. Fix
this by always disabling the pen down interrupt while data is active and
vice versa.

This also fixes an issue when using the built in IRQs due to enable_irq()
not being valid from interrupt context on an interrupt controller with bus
operations like the built in IRQ controller - this issue may also have
affected other interrupt controllers.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/wm831x-ts.c |   38 +++++++++++++++++++++++++++++++-
 1 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/wm831x-ts.c b/drivers/input/touchscreen/wm831x-ts.c
index 1022f71..3c397c8 100644
--- a/drivers/input/touchscreen/wm831x-ts.c
+++ b/drivers/input/touchscreen/wm831x-ts.c
@@ -68,8 +68,29 @@ struct wm831x_ts {
 	unsigned int pd_irq;
 	bool pressure;
 	bool pen_down;
+	struct work_struct pd_data_work;
+	struct work_struct data_pd_work;
 };
 
+static void wm831x_pd_data(struct work_struct *work)
+{
+	struct wm831x_ts *wm831x_ts =
+		container_of(work, struct wm831x_ts, pd_data_work);
+
+	disable_irq(wm831x_ts->pd_irq);
+	enable_irq(wm831x_ts->data_irq);
+	dev_dbg(wm831x_ts->wm831x->dev, "IRQ PD->DATA done\n");
+}
+
+static void wm831x_data_pd(struct work_struct *work)
+{
+	struct wm831x_ts *wm831x_ts =
+		container_of(work, struct wm831x_ts, data_pd_work);
+
+	enable_irq(wm831x_ts->pd_irq);
+	dev_dbg(wm831x_ts->wm831x->dev, "IRQ DATA->PD done\n");
+}
+
 static irqreturn_t wm831x_ts_data_irq(int irq, void *irq_data)
 {
 	struct wm831x_ts *wm831x_ts = irq_data;
@@ -110,7 +131,10 @@ static irqreturn_t wm831x_ts_data_irq(int irq, void *irq_data)
 	}
 
 	if (!wm831x_ts->pen_down) {
+		/* Switch from data to pen down */
+		dev_dbg(wm831x->dev, "IRQ DATA->PD\n");
 		disable_irq_nosync(wm831x_ts->data_irq);
+		schedule_work(&wm831x_ts->data_pd_work);
 
 		/* Don't need data any more */
 		wm831x_set_bits(wm831x, WM831X_TOUCH_CONTROL_1,
@@ -156,7 +180,10 @@ static irqreturn_t wm831x_ts_pen_down_irq(int irq, void *irq_data)
 			WM831X_TCHPD_EINT, WM831X_TCHPD_EINT);
 
 	wm831x_ts->pen_down = true;
-	enable_irq(wm831x_ts->data_irq);
+
+	/* Switch from pen down to data */
+	dev_dbg(wm831x->dev, "IRQ PD->DATA\n");
+	schedule_work(&wm831x_ts->pd_data_work);
 
 	return IRQ_HANDLED;
 }
@@ -185,8 +212,13 @@ static void wm831x_ts_input_close(struct input_dev *idev)
 			WM831X_TCH_X_ENA | WM831X_TCH_Y_ENA |
 			WM831X_TCH_Z_ENA, 0);
 
-	if (wm831x_ts->pen_down)
+	if (wm831x_ts->pen_down) {
+		flush_work_sync(&wm831x_ts->data_pd_work);
 		disable_irq(wm831x_ts->data_irq);
+		enable_irq(wm831x_ts->pd_irq);
+	} else {
+		flush_work_sync(&wm831x_ts->pd_data_work);
+	}
 }
 
 static __devinit int wm831x_ts_probe(struct platform_device *pdev)
@@ -210,6 +242,8 @@ static __devinit int wm831x_ts_probe(struct platform_device *pdev)
 
 	wm831x_ts->wm831x = wm831x;
 	wm831x_ts->input_dev = input_dev;
+	INIT_WORK(&wm831x_ts->pd_data_work, wm831x_pd_data);
+	INIT_WORK(&wm831x_ts->data_pd_work, wm831x_data_pd);
 
 	/*
 	 * If we have a direct IRQ use it, otherwise use the interrupt
-- 
1.7.2.3

