From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] Input: wm831x-ts - Fix races with IRQ management
Date: Mon, 14 Mar 2011 22:45:01 +0000
Message-ID: <1300142701-22260-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1300142701-22260-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:35947 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751715Ab1CNWoq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Mar 2011 18:44:46 -0400
In-Reply-To: <1300142701-22260-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

This revision reworks the close() implementation, hopefully more
robustly, which should address the main thrust of your comments
previously.  As I said in my previous e-mail the restrictions on
enable_irq() seem reasonable to me, the thing that's nasty here is that
we need to enable and disable the IRQs at all.

 drivers/input/touchscreen/wm831x-ts.c |   60 ++++++++++++++++++++++++++++++--
 1 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/wm831x-ts.c b/drivers/input/touchscreen/wm831x-ts.c
index 6ae054f..3f825cb 100644
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
@@ -182,13 +209,36 @@ static void wm831x_ts_input_close(struct input_dev *idev)
 	struct wm831x_ts *wm831x_ts = input_get_drvdata(idev);
 	struct wm831x *wm831x = wm831x_ts->wm831x;
 
+	/* Shut the controller down, disabling all other functionality */
+	wm831x_set_bits(wm831x, WM831X_TOUCH_CONTROL_1,
+			WM831X_TCH_ENA, 0);
+
+	/* Make sure any pending IRQs are done, the above will prevent
+	 * new ones firing.
+	 */
+	synchronize_irq(wm831x_ts->data_irq);
+	synchronize_irq(wm831x_ts->pd_irq);
+
+	/* Make sure the IRQ completion work is quiesced */
+	flush_work_sync(&wm831x_ts->data_pd_work);
+	flush_work_sync(&wm831x_ts->pd_data_work);
+
+	/* If we ended up with the pen down then make sure we revert back
+	 * to pen detection state for the next time we start up.
+	 */
+	if (wm831x_ts->pen_down) {
+		disable_irq(wm831x_ts->data_irq);
+		enable_irq(wm831x_ts->pd_irq);
+		wm831x_ts->pen_down = false;
+	}
+
+	/* Be nice to the next user and make sure everything is
+	 * flagged as disabled.
+	 */
 	wm831x_set_bits(wm831x, WM831X_TOUCH_CONTROL_1,
 			WM831X_TCH_ENA | WM831X_TCH_CVT_ENA |
 			WM831X_TCH_X_ENA | WM831X_TCH_Y_ENA |
 			WM831X_TCH_Z_ENA, 0);
-
-	if (wm831x_ts->pen_down)
-		disable_irq(wm831x_ts->data_irq);
 }
 
 static __devinit int wm831x_ts_probe(struct platform_device *pdev)
@@ -212,6 +262,8 @@ static __devinit int wm831x_ts_probe(struct platform_device *pdev)
 
 	wm831x_ts->wm831x = wm831x;
 	wm831x_ts->input_dev = input_dev;
+	INIT_WORK(&wm831x_ts->pd_data_work, wm831x_pd_data);
+	INIT_WORK(&wm831x_ts->data_pd_work, wm831x_data_pd);
 
 	/*
 	 * If we have a direct IRQ use it, otherwise use the interrupt
-- 
1.7.4.1

