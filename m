From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: [PATCH] Input: da9052_tsi: remove unnecessary worker
Date: Sun, 18 Jan 2015 16:36:08 +0100
Message-ID: <1421595368-31203-1-git-send-email-m.grzeschik@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54444 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbbARPgQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Jan 2015 10:36:16 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, support.opensource@diasemi.com, kernel@pengutronix.de

With the datardy irq we get the information if the
pen got pulled from the screen. This patch changes
the irq by checking this condition every time instead
of triggering the worker.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/input/touchscreen/da9052_tsi.c | 68 ++++++++++++++--------------------
 1 file changed, 27 insertions(+), 41 deletions(-)

diff --git a/drivers/input/touchscreen/da9052_tsi.c b/drivers/input/touchscreen/da9052_tsi.c
index 5a013bb..e6019dd 100644
--- a/drivers/input/touchscreen/da9052_tsi.c
+++ b/drivers/input/touchscreen/da9052_tsi.c
@@ -25,7 +25,6 @@
 struct da9052_tsi {
 	struct da9052 *da9052;
 	struct input_dev *dev;
-	struct delayed_work ts_pen_work;
 	struct mutex mutex;
 	bool stopped;
 	bool adc_on;
@@ -47,8 +46,6 @@ static irqreturn_t da9052_ts_pendwn_irq(int irq, void *data)
 		da9052_enable_irq(tsi->da9052, DA9052_IRQ_TSIREADY);
 
 		da9052_ts_adc_toggle(tsi, true);
-
-		schedule_delayed_work(&tsi->ts_pen_work, HZ / 50);
 	}
 
 	return IRQ_HANDLED;
@@ -89,6 +86,33 @@ static void da9052_ts_read(struct da9052_tsi *tsi)
 	y = ((y << 2) & 0x3fc) | ((v & 0xc) >> 2);
 	z = ((z << 2) & 0x3fc) | ((v & 0x30) >> 4);
 
+	/* Check for last TSI_READY irq */
+	if (!(ret & TSI_PEN_DOWN_STATUS)) {
+
+		/* Pen UP */
+		da9052_ts_adc_toggle(tsi, false);
+
+		/* Report Pen UP */
+		input_report_key(input, BTN_TOUCH, 0);
+		input_report_abs(input, ABS_PRESSURE, 0);
+		input_sync(input);
+
+		/*
+		 * FIXME: Fixes the unhandled irq issue when quick
+		 * pen down and pen up events occurs
+		 */
+		ret = da9052_reg_update(tsi->da9052,
+					DA9052_EVENT_B_REG, 0xC0, 0xC0);
+		if (ret < 0)
+			return;
+
+		/* Mask TSI_READY event and unmask PEN_DOWN event */
+		da9052_disable_irq_nosync(tsi->da9052, DA9052_IRQ_TSIREADY);
+		da9052_enable_irq(tsi->da9052, DA9052_IRQ_PENDOWN);
+
+		return;
+	}
+
 	input_report_key(input, BTN_TOUCH, 1);
 	input_report_abs(input, ABS_X, x);
 	input_report_abs(input, ABS_Y, y);
@@ -105,42 +129,6 @@ static irqreturn_t da9052_ts_datardy_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void da9052_ts_pen_work(struct work_struct *work)
-{
-	struct da9052_tsi *tsi = container_of(work, struct da9052_tsi,
-					      ts_pen_work.work);
-	if (!tsi->stopped) {
-		int ret = da9052_reg_read(tsi->da9052, DA9052_TSI_LSB_REG);
-		if (ret < 0 || (ret & TSI_PEN_DOWN_STATUS)) {
-			/* Pen is still DOWN (or read error) */
-			schedule_delayed_work(&tsi->ts_pen_work, HZ / 50);
-		} else {
-			struct input_dev *input = tsi->dev;
-
-			/* Pen UP */
-			da9052_ts_adc_toggle(tsi, false);
-
-			/* Report Pen UP */
-			input_report_key(input, BTN_TOUCH, 0);
-			input_report_abs(input, ABS_PRESSURE, 0);
-			input_sync(input);
-
-			/*
-			 * FIXME: Fixes the unhandled irq issue when quick
-			 * pen down and pen up events occurs
-			 */
-			ret = da9052_reg_update(tsi->da9052,
-						DA9052_EVENT_B_REG, 0xC0, 0xC0);
-			if (ret < 0)
-				return;
-
-			/* Mask TSI_READY event and unmask PEN_DOWN event */
-			da9052_disable_irq(tsi->da9052, DA9052_IRQ_TSIREADY);
-			da9052_enable_irq(tsi->da9052, DA9052_IRQ_PENDOWN);
-		}
-	}
-}
-
 static int da9052_ts_configure_gpio(struct da9052 *da9052)
 {
 	int error;
@@ -209,7 +197,6 @@ static void da9052_ts_input_close(struct input_dev *input_dev)
 	tsi->stopped = true;
 	mb();
 	da9052_disable_irq(tsi->da9052, DA9052_IRQ_PENDOWN);
-	cancel_delayed_work_sync(&tsi->ts_pen_work);
 
 	if (tsi->adc_on) {
 		da9052_disable_irq(tsi->da9052, DA9052_IRQ_TSIREADY);
@@ -248,7 +235,6 @@ static int da9052_ts_probe(struct platform_device *pdev)
 	tsi->da9052 = da9052;
 	tsi->dev = input_dev;
 	tsi->stopped = true;
-	INIT_DELAYED_WORK(&tsi->ts_pen_work, da9052_ts_pen_work);
 
 	input_dev->id.version = 0x0101;
 	input_dev->id.vendor = 0x15B6;
-- 
2.1.4

