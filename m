From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: [PATCH v2] Input: da9052_tsi: remove unnecessary worker
Date: Fri,  6 Feb 2015 12:05:48 +0100
Message-ID: <1423220748-21778-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1421595368-31203-1-git-send-email-m.grzeschik@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38975 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbbBFLGB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Feb 2015 06:06:01 -0500
In-Reply-To: <1421595368-31203-1-git-send-email-m.grzeschik@pengutronix.de>
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
v1 -> v2: - removed adc_on variable
	  - added locking for irq switch
	  - event reporting in ts_read and irq switchover in datardy_irq
 drivers/input/touchscreen/da9052_tsi.c | 119 +++++++++++++++++----------------
 1 file changed, 62 insertions(+), 57 deletions(-)

diff --git a/drivers/input/touchscreen/da9052_tsi.c b/drivers/input/touchscreen/da9052_tsi.c
index 5a013bb..c28cfee 100644
--- a/drivers/input/touchscreen/da9052_tsi.c
+++ b/drivers/input/touchscreen/da9052_tsi.c
@@ -22,19 +22,24 @@
 
 #define TSI_PEN_DOWN_STATUS 0x40
 
+#define TSI_PEN_UP		1
+
 struct da9052_tsi {
 	struct da9052 *da9052;
 	struct input_dev *dev;
-	struct delayed_work ts_pen_work;
 	struct mutex mutex;
+	spinlock_t *lock;
 	bool stopped;
-	bool adc_on;
 };
 
 static void da9052_ts_adc_toggle(struct da9052_tsi *tsi, bool on)
 {
 	da9052_reg_update(tsi->da9052, DA9052_TSI_CONT_A_REG, 1 << 0, on);
-	tsi->adc_on = on;
+}
+
+static bool da9052_ts_adc_get_state(struct da9052_tsi *tsi)
+{
+	return da9052_reg_read(tsi->da9052, DA9052_TSI_CONT_A_REG) & (1 < 0);
 }
 
 static irqreturn_t da9052_ts_pendwn_irq(int irq, void *data)
@@ -42,19 +47,23 @@ static irqreturn_t da9052_ts_pendwn_irq(int irq, void *data)
 	struct da9052_tsi *tsi = data;
 
 	if (!tsi->stopped) {
+		unsigned long flags;
+
+		spin_lock_irqsave(tsi->lock, flags);
+
 		/* Mask PEN_DOWN event and unmask TSI_READY event */
 		da9052_disable_irq_nosync(tsi->da9052, DA9052_IRQ_PENDOWN);
 		da9052_enable_irq(tsi->da9052, DA9052_IRQ_TSIREADY);
 
 		da9052_ts_adc_toggle(tsi, true);
 
-		schedule_delayed_work(&tsi->ts_pen_work, HZ / 50);
+		spin_unlock_irqrestore(tsi->lock, flags);
 	}
 
 	return IRQ_HANDLED;
 }
 
-static void da9052_ts_read(struct da9052_tsi *tsi)
+static int da9052_ts_read(struct da9052_tsi *tsi)
 {
 	struct input_dev *input = tsi->dev;
 	int ret;
@@ -63,25 +72,25 @@ static void da9052_ts_read(struct da9052_tsi *tsi)
 
 	ret = da9052_reg_read(tsi->da9052, DA9052_TSI_X_MSB_REG);
 	if (ret < 0)
-		return;
+		return ret;
 
 	x = (u16) ret;
 
 	ret = da9052_reg_read(tsi->da9052, DA9052_TSI_Y_MSB_REG);
 	if (ret < 0)
-		return;
+		return ret;
 
 	y = (u16) ret;
 
 	ret = da9052_reg_read(tsi->da9052, DA9052_TSI_Z_MSB_REG);
 	if (ret < 0)
-		return;
+		return ret;
 
 	z = (u16) ret;
 
 	ret = da9052_reg_read(tsi->da9052, DA9052_TSI_LSB_REG);
 	if (ret < 0)
-		return;
+		return ret;
 
 	v = (u8) ret;
 
@@ -89,56 +98,53 @@ static void da9052_ts_read(struct da9052_tsi *tsi)
 	y = ((y << 2) & 0x3fc) | ((v & 0xc) >> 2);
 	z = ((z << 2) & 0x3fc) | ((v & 0x30) >> 4);
 
+	/* Check for last TSI_READY irq */
+	if (!(ret & TSI_PEN_DOWN_STATUS)) {
+		/* Report Pen UP */
+		input_report_key(input, BTN_TOUCH, 0);
+		input_report_abs(input, ABS_PRESSURE, 0);
+		input_sync(input);
+
+		return TSI_PEN_UP;
+	}
+
 	input_report_key(input, BTN_TOUCH, 1);
 	input_report_abs(input, ABS_X, x);
 	input_report_abs(input, ABS_Y, y);
 	input_report_abs(input, ABS_PRESSURE, z);
 	input_sync(input);
+
+	return 0;
 }
 
 static irqreturn_t da9052_ts_datardy_irq(int irq, void *data)
 {
 	struct da9052_tsi *tsi = data;
+	unsigned long flags;
+	int ret;
 
-	da9052_ts_read(tsi);
+	spin_lock_irqsave(tsi->lock, flags);
+	ret = da9052_ts_read(tsi);
+	if (ret == TSI_PEN_UP) {
+		/* Pen UP */
+		da9052_ts_adc_toggle(tsi, false);
 
-	return IRQ_HANDLED;
-}
+		/* Mask TSI_READY event and unmask PEN_DOWN event */
+		da9052_disable_irq_nosync(tsi->da9052, DA9052_IRQ_TSIREADY);
+		da9052_enable_irq(tsi->da9052, DA9052_IRQ_PENDOWN);
 
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
+		/*
+		 * FIXME: Fixes the unhandled irq issue when quick
+		 * pen down and pen up events occurs
+		 */
+		ret = da9052_reg_update(tsi->da9052,
+					DA9052_EVENT_B_REG, 0xC0, 0xC0);
+		if (ret < 0)
+			return ret;
 	}
+	spin_unlock_irqrestore(tsi->lock, flags);
+
+	return IRQ_HANDLED;
 }
 
 static int da9052_ts_configure_gpio(struct da9052 *da9052)
@@ -190,7 +196,9 @@ static int da9052_configure_tsi(struct da9052_tsi *tsi)
 static int da9052_ts_input_open(struct input_dev *input_dev)
 {
 	struct da9052_tsi *tsi = input_get_drvdata(input_dev);
+	unsigned long flags;
 
+	spin_lock_irqsave(tsi->lock, flags);
 	tsi->stopped = false;
 	mb();
 
@@ -200,31 +208,28 @@ static int da9052_ts_input_open(struct input_dev *input_dev)
 	/* Enable Pen Detect Circuit */
 	return da9052_reg_update(tsi->da9052, DA9052_TSI_CONT_A_REG,
 				 1 << 1, 1 << 1);
+	spin_unlock_irqrestore(tsi->lock, flags);
 }
 
 static void da9052_ts_input_close(struct input_dev *input_dev)
 {
 	struct da9052_tsi *tsi = input_get_drvdata(input_dev);
+	unsigned long flags;
 
 	tsi->stopped = true;
 	mb();
-	da9052_disable_irq(tsi->da9052, DA9052_IRQ_PENDOWN);
-	cancel_delayed_work_sync(&tsi->ts_pen_work);
 
-	if (tsi->adc_on) {
+	spin_lock_irqsave(tsi->lock, flags);
+	if (da9052_ts_adc_get_state(tsi))
 		da9052_disable_irq(tsi->da9052, DA9052_IRQ_TSIREADY);
-		da9052_ts_adc_toggle(tsi, false);
+	else
+		da9052_disable_irq(tsi->da9052, DA9052_IRQ_PENDOWN);
 
-		/*
-		 * If ADC was on that means that pendwn IRQ was disabled
-		 * twice and we need to enable it to keep enable/disable
-		 * counter balanced. IRQ is still off though.
-		 */
-		da9052_enable_irq(tsi->da9052, DA9052_IRQ_PENDOWN);
-	}
+	da9052_ts_adc_toggle(tsi, false);
 
 	/* Disable Pen Detect Circuit */
 	da9052_reg_update(tsi->da9052, DA9052_TSI_CONT_A_REG, 1 << 1, 0);
+	spin_unlock_irqrestore(tsi->lock, flags);
 }
 
 static int da9052_ts_probe(struct platform_device *pdev)
@@ -245,10 +250,10 @@ static int da9052_ts_probe(struct platform_device *pdev)
 		goto err_free_mem;
 	}
 
+	spin_lock_init(tsi->lock);
 	tsi->da9052 = da9052;
 	tsi->dev = input_dev;
 	tsi->stopped = true;
-	INIT_DELAYED_WORK(&tsi->ts_pen_work, da9052_ts_pen_work);
 
 	input_dev->id.version = 0x0101;
 	input_dev->id.vendor = 0x15B6;
-- 
2.1.4

