From: Marek Vasut <marex@denx.de>
Subject: [PATCH] input: stmpe: Fix the touchscreen interrupt handling
Date: Mon, 22 Apr 2013 01:06:05 +0200
Message-ID: <1366585565-13046-1-git-send-email-marex@denx.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:54643 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960Ab3DUXGT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Apr 2013 19:06:19 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Vipul Kumar Samar <vipulkumar.samar@st.com>, Viresh Kumar <viresh.kumar@linaro.org>, Bill Pemberton <wfp5p@virginia.edu>, Mark Brown <broonie@opensource.wolfsonmicro.com>

The touchscreen interrupt handling in the STMPE touchscreen driver
doesn't seem to work correctly. It relies on FIFO_TH to be asserted
instead of TOUCH_DET interrupt for touchscreen detection.

The FIFO_TH is usually asserted but is asserted independently of the
touchscreen controller operation. Because the bits in the interrupt
status register are not entirely cleaned, the interrupt handler is
triggered even if FIFO_TH is not yet set. Make sure that all bits in
the interrupt status register are cleared early.

Rework the touchscreen interrupt handling so it waits for TOUCH_DET
interrupt to happen. Upon first TOUCH_DET interrupt, worker thread
is started which polls the touchscreen controller for location data
until no touch is detected. Touch is determined by checking the X
and Y coordinates, if they are zero, no touch happens.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Vipul Kumar Samar <vipulkumar.samar@st.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Bill Pemberton <wfp5p@virginia.edu>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/stmpe-ts.c |  111 ++++++++++++++--------------------
 drivers/mfd/stmpe.c                  |   10 +--
 2 files changed, 50 insertions(+), 71 deletions(-)

diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
index 59e81b0..5332a37 100644
--- a/drivers/input/touchscreen/stmpe-ts.c
+++ b/drivers/input/touchscreen/stmpe-ts.c
@@ -67,7 +67,7 @@
 struct stmpe_touch {
 	struct stmpe *stmpe;
 	struct input_dev *idev;
-	struct delayed_work work;
+	struct work_struct work;
 	struct device *dev;
 	u8 sample_time;
 	u8 mod_12b;
@@ -95,77 +95,60 @@ static int __stmpe_reset_fifo(struct stmpe *stmpe)
 
 static void stmpe_work(struct work_struct *work)
 {
-	int int_sta;
-	u32 timeout = 40;
-
+	u8 data[4];
+	int x, y, z, touch = 1;
 	struct stmpe_touch *ts =
-	    container_of(work, struct stmpe_touch, work.work);
-
-	int_sta = stmpe_reg_read(ts->stmpe, STMPE_REG_INT_STA);
-
-	/*
-	 * touch_det sometimes get desasserted or just get stuck. This appears
-	 * to be a silicon bug, We still have to clearify this with the
-	 * manufacture. As a workaround We release the key anyway if the
-	 * touch_det keeps coming in after 4ms, while the FIFO contains no value
-	 * during the whole time.
-	 */
-	while ((int_sta & (1 << STMPE_IRQ_TOUCH_DET)) && (timeout > 0)) {
-		timeout--;
-		int_sta = stmpe_reg_read(ts->stmpe, STMPE_REG_INT_STA);
-		udelay(100);
-	}
+	    container_of(work, struct stmpe_touch, work);
 
-	/* reset the FIFO before we report release event */
-	__stmpe_reset_fifo(ts->stmpe);
+	while (touch) {
+		stmpe_set_bits(ts->stmpe, STMPE_REG_TSC_CTRL,
+				STMPE_TSC_CTRL_TSC_EN, 0);
 
-	input_report_abs(ts->idev, ABS_PRESSURE, 0);
-	input_report_key(ts->idev, BTN_TOUCH, 0);
-	input_sync(ts->idev);
-}
+		stmpe_block_read(ts->stmpe, STMPE_REG_TSC_DATA_XYZ, 4, data);
 
-static irqreturn_t stmpe_ts_handler(int irq, void *data)
-{
-	u8 data_set[4];
-	int x, y, z;
-	struct stmpe_touch *ts = data;
+		x = (data[0] << 4) | (data[1] >> 4);
+		y = ((data[1] & 0xf) << 8) | data[2];
+		z = data[3];
 
-	/*
-	 * Cancel scheduled polling for release if we have new value
-	 * available. Wait if the polling is already running.
-	 */
-	cancel_delayed_work_sync(&ts->work);
-
-	/*
-	 * The FIFO sometimes just crashes and stops generating interrupts. This
-	 * appears to be a silicon bug. We still have to clearify this with
-	 * the manufacture. As a workaround we disable the TSC while we are
-	 * collecting data and flush the FIFO after reading
-	 */
-	stmpe_set_bits(ts->stmpe, STMPE_REG_TSC_CTRL,
-				STMPE_TSC_CTRL_TSC_EN, 0);
+		touch = x && y;
 
-	stmpe_block_read(ts->stmpe, STMPE_REG_TSC_DATA_XYZ, 4, data_set);
+		if (touch) {
+			input_report_abs(ts->idev, ABS_X, x);
+			input_report_abs(ts->idev, ABS_Y, y);
+			/*
+			 * The z-axis (pressure) can be zero if you press too
+			 * hard (do not try this at home, kids!), thus adjust
+			 * it to fit the bill here.
+			 */
+			if (!z)
+				z = 1;
+		} else {
+			z = 0;
+		}
 
-	x = (data_set[0] << 4) | (data_set[1] >> 4);
-	y = ((data_set[1] & 0xf) << 8) | data_set[2];
-	z = data_set[3];
+		input_report_abs(ts->idev, ABS_PRESSURE, z);
+		input_report_key(ts->idev, BTN_TOUCH, touch);
+		input_sync(ts->idev);
 
-	input_report_abs(ts->idev, ABS_X, x);
-	input_report_abs(ts->idev, ABS_Y, y);
-	input_report_abs(ts->idev, ABS_PRESSURE, z);
-	input_report_key(ts->idev, BTN_TOUCH, 1);
-	input_sync(ts->idev);
+		/* Flush the FIFO after we have read out our values. */
+		__stmpe_reset_fifo(ts->stmpe);
 
-       /* flush the FIFO after we have read out our values. */
-	__stmpe_reset_fifo(ts->stmpe);
+		/* Re-enable the TSC so it reads another sample. */
+		stmpe_set_bits(ts->stmpe, STMPE_REG_TSC_CTRL,
+				STMPE_TSC_CTRL_TSC_EN, STMPE_TSC_CTRL_TSC_EN);
 
-	/* reenable the tsc */
-	stmpe_set_bits(ts->stmpe, STMPE_REG_TSC_CTRL,
-			STMPE_TSC_CTRL_TSC_EN, STMPE_TSC_CTRL_TSC_EN);
+		if (!touch)
+			break;
+
+		msleep(10);
+	}
+}
+
+static irqreturn_t stmpe_ts_handler(int irq, void *data)
+{
+	struct stmpe_touch *ts = data;
 
-	/* start polling for touch_det to detect release */
-	schedule_delayed_work(&ts->work, HZ / 50);
+	schedule_work(&ts->work);
 
 	return IRQ_HANDLED;
 }
@@ -259,7 +242,7 @@ static void stmpe_ts_close(struct input_dev *dev)
 {
 	struct stmpe_touch *ts = input_get_drvdata(dev);
 
-	cancel_delayed_work_sync(&ts->work);
+	cancel_work_sync(&ts->work);
 
 	stmpe_set_bits(ts->stmpe, STMPE_REG_TSC_CTRL,
 			STMPE_TSC_CTRL_TSC_EN, 0);
@@ -317,7 +300,7 @@ static int stmpe_input_probe(struct platform_device *pdev)
 	int error;
 	int ts_irq;
 
-	ts_irq = platform_get_irq_byname(pdev, "FIFO_TH");
+	ts_irq = platform_get_irq_byname(pdev, "TOUCH_DET");
 	if (ts_irq < 0)
 		return ts_irq;
 
@@ -335,7 +318,7 @@ static int stmpe_input_probe(struct platform_device *pdev)
 
 	stmpe_ts_get_platform_info(pdev, ts);
 
-	INIT_DELAYED_WORK(&ts->work, stmpe_work);
+	INIT_WORK(&ts->work, stmpe_work);
 
 	error = devm_request_threaded_irq(&pdev->dev, ts_irq,
 					  NULL, stmpe_ts_handler,
diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index bbccd51..5a9ed4c 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -867,13 +867,11 @@ static irqreturn_t stmpe_irq(int irq, void *data)
 	for (i = 0; i < num; i++) {
 		int bank = num - i - 1;
 		u8 status = isr[i];
-		u8 clear;
+		u8 clear = status;
 
-		status &= stmpe->ier[bank];
-		if (!status)
-			continue;
+		stmpe_reg_write(stmpe, israddr + i, clear);
 
-		clear = status;
+		status &= stmpe->ier[bank];
 		while (status) {
 			int bit = __ffs(status);
 			int line = bank * 8 + bit;
@@ -882,8 +880,6 @@ static irqreturn_t stmpe_irq(int irq, void *data)
 			handle_nested_irq(nestedirq);
 			status &= ~(1 << bit);
 		}
-
-		stmpe_reg_write(stmpe, israddr + i, clear);
 	}
 
 	return IRQ_HANDLED;
-- 
1.7.10.4

