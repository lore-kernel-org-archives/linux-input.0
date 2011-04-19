From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3 2.6.39] Input: wm831x-ts - Fix races with IRQ management
Date: Tue, 19 Apr 2011 19:17:52 +0100
Message-ID: <1303237074-12878-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:43455 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753297Ab1DSSRs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Apr 2011 14:17:48 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>

If the WM831x pen down and data IRQs run in parallel it is possible for the
data and pen down IRQs to deadlock themselves as one is part way through
disabling its operation while the other is part way through enabling. Fix
this by always disabling the pen down interrupt while data is active and
vice versa.  When a changeover is required we disable the IRQ that is to
be stopped then schedule work that will enable the new IRQ.

We need to handle the data flow in the data IRQ as the readback from the
device needs to be ordered correctly with the IRQ for robust operation.

This also fixes an issue when using the built in IRQs due to enable_irq()
not being valid from interrupt context on an interrupt controller with bus
operations like the built in IRQ controller - this issue may also have
affected other interrupt controllers.  We can't rely on having the data
and pen down IRQs available via GPIOs on the CPU on every system.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

Main change since last time is that the two struct works have been
merged and we now use disable_irq_nosync() consistently in both IRQ
handlers.

 drivers/input/touchscreen/wm831x-ts.c |   54 +++++++++++++++++++++++++++++---
 1 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/wm831x-ts.c b/drivers/input/touchscreen/wm831x-ts.c
index 6ae054f..b937301 100644
--- a/drivers/input/touchscreen/wm831x-ts.c
+++ b/drivers/input/touchscreen/wm831x-ts.c
@@ -68,8 +68,23 @@ struct wm831x_ts {
 	unsigned int pd_irq;
 	bool pressure;
 	bool pen_down;
+	struct work_struct pd_data_work;
 };
 
+static void wm831x_pd_data_work(struct work_struct *work)
+{
+	struct wm831x_ts *wm831x_ts =
+		container_of(work, struct wm831x_ts, pd_data_work);
+
+	if (wm831x_ts->pen_down) {
+		enable_irq(wm831x_ts->data_irq);
+		dev_dbg(wm831x_ts->wm831x->dev, "IRQ PD->DATA done\n");
+	} else {
+		enable_irq(wm831x_ts->pd_irq);
+		dev_dbg(wm831x_ts->wm831x->dev, "IRQ DATA->PD done\n");
+	}
+}
+
 static irqreturn_t wm831x_ts_data_irq(int irq, void *irq_data)
 {
 	struct wm831x_ts *wm831x_ts = irq_data;
@@ -110,6 +125,9 @@ static irqreturn_t wm831x_ts_data_irq(int irq, void *irq_data)
 	}
 
 	if (!wm831x_ts->pen_down) {
+		/* Switch from data to pen down */
+		dev_dbg(wm831x->dev, "IRQ DATA->PD\n");
+
 		disable_irq_nosync(wm831x_ts->data_irq);
 
 		/* Don't need data any more */
@@ -128,6 +146,8 @@ static irqreturn_t wm831x_ts_data_irq(int irq, void *irq_data)
 					 ABS_PRESSURE, 0);
 
 		input_report_key(wm831x_ts->input_dev, BTN_TOUCH, 0);
+
+		schedule_work(&wm831x_ts->pd_data_work);
 	}
 
 	input_sync(wm831x_ts->input_dev);
@@ -141,6 +161,11 @@ static irqreturn_t wm831x_ts_pen_down_irq(int irq, void *irq_data)
 	struct wm831x *wm831x = wm831x_ts->wm831x;
 	int ena = 0;
 
+	if (wm831x_ts->pen_down)
+		return IRQ_HANDLED;
+
+	disable_irq_nosync(wm831x_ts->pd_irq);
+
 	/* Start collecting data */
 	if (wm831x_ts->pressure)
 		ena |= WM831X_TCH_Z_ENA;
@@ -156,7 +181,10 @@ static irqreturn_t wm831x_ts_pen_down_irq(int irq, void *irq_data)
 			WM831X_TCHPD_EINT, WM831X_TCHPD_EINT);
 
 	wm831x_ts->pen_down = true;
-	enable_irq(wm831x_ts->data_irq);
+
+	/* Switch from pen down to data */
+	dev_dbg(wm831x->dev, "IRQ PD->DATA\n");
+	schedule_work(&wm831x_ts->pd_data_work);
 
 	return IRQ_HANDLED;
 }
@@ -182,13 +210,28 @@ static void wm831x_ts_input_close(struct input_dev *idev)
 	struct wm831x_ts *wm831x_ts = input_get_drvdata(idev);
 	struct wm831x *wm831x = wm831x_ts->wm831x;
 
+	/* Shut the controller down, disabling all other functionality too */
 	wm831x_set_bits(wm831x, WM831X_TOUCH_CONTROL_1,
-			WM831X_TCH_ENA | WM831X_TCH_CVT_ENA |
-			WM831X_TCH_X_ENA | WM831X_TCH_Y_ENA |
-			WM831X_TCH_Z_ENA, 0);
+			WM831X_TCH_ENA | WM831X_TCH_X_ENA |
+			WM831X_TCH_Y_ENA | WM831X_TCH_Z_ENA, 0);
 
-	if (wm831x_ts->pen_down)
+	/* Make sure any pending IRQs are done, the above will prevent
+	 * new ones firing.
+	 */
+	synchronize_irq(wm831x_ts->data_irq);
+	synchronize_irq(wm831x_ts->pd_irq);
+
+	/* Make sure the IRQ completion work is quiesced */
+	flush_work_sync(&wm831x_ts->pd_data_work);
+
+	/* If we ended up with the pen down then make sure we revert back
+	 * to pen detection state for the next time we start up.
+	 */
+	if (wm831x_ts->pen_down) {
 		disable_irq(wm831x_ts->data_irq);
+		enable_irq(wm831x_ts->pd_irq);
+		wm831x_ts->pen_down = false;
+	}
 }
 
 static __devinit int wm831x_ts_probe(struct platform_device *pdev)
@@ -212,6 +255,7 @@ static __devinit int wm831x_ts_probe(struct platform_device *pdev)
 
 	wm831x_ts->wm831x = wm831x;
 	wm831x_ts->input_dev = input_dev;
+	INIT_WORK(&wm831x_ts->pd_data_work, wm831x_pd_data_work);
 
 	/*
 	 * If we have a direct IRQ use it, otherwise use the interrupt
-- 
1.7.4.1

