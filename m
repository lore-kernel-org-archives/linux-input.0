From: Juergen Beisert <jbe@pengutronix.de>
Subject: RFC: Remove a race from the s3c2410 touch driver
Date: Tue, 24 May 2011 23:35:20 +0200
Message-ID: <201105242335.21603.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36609 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111Ab1EXVgk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 May 2011 17:36:40 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:6f8:1178:4:5054:ff:fe8d:eefb] helo=localhost)
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <jbe@pengutronix.de>)
	id 1QOzHL-0001Zx-N1
	for linux-input@vger.kernel.org; Tue, 24 May 2011 23:36:39 +0200
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

this patch tries to remove a race from the s3c2410 touch driver. But the
problem is, is can only work on the S3C2440, as the S3C2410 does not have the
ADCUPDN register. So, how to to fix the race, but keeping it work on the
S3C2410 CPU?

Comments are welcome.

Juergen

There seems a race in the driver when it uses the bit 15 from the dat0 and dat1
register: These bits are only valid when the pen interrupt feature is enabled.
This isn't the case when a regular touchscreen X/Y conversion is running. It
only works due to a small race between s3c24xx_ts_select(), stylus_irq() and
touch_timer_fire(). It is broken immediately when the debug output of the
touchscreen driver will be enabled or the debug output of the ADC driver. In
this case the conversion never stops, even there is no pressure on the touch
anymore.

This patch simplifies the driver and stops any further conversion if the pen up
interrupt is received. Pen up and down detection is now done only in the
pen interrupt routine. This also prevents the driver forwarding garbage data
to userland, because when the pen is up, the X value is always 0.

diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
index 8feb7f3..2f4c222 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -57,6 +57,10 @@
 
 #define FEAT_PEN_IRQ	(1 << 0)	/* HAS ADCCLRINTPNDNUP */
 
+/* bits from the ADCUPDN register */
+#define TSC_UP (1 << 1)
+#define TSC_DN (1 << 0)
+
 /* Per-touchscreen data. */
 
 /**
@@ -85,36 +89,21 @@ struct s3c2410ts {
 	int count;
 	int shift;
 	int features;
+	bool pen_is_down;
 };
 
 static struct s3c2410ts ts;
 
-/**
- * get_down - return the down state of the pen
- * @data0: The data read from ADCDAT0 register.
- * @data1: The data read from ADCDAT1 register.
- *
- * Return non-zero if both readings show that the pen is down.
- */
-static inline bool get_down(unsigned long data0, unsigned long data1)
+/* signal an interrupt when the pen hits the touch */
+static void waiting_for_pen_down(struct s3c2410ts *ts)
 {
-	/* returns true if both data values show stylus down */
-	return (!(data0 & S3C2410_ADCDAT0_UPDOWN) &&
-		!(data1 & S3C2410_ADCDAT0_UPDOWN));
+	writel(WAIT4INT | INT_DOWN, ts->io + S3C2410_ADCTSC);
+	ts->pen_is_down = false;
 }
 
 static void touch_timer_fire(unsigned long data)
 {
-	unsigned long data0;
-	unsigned long data1;
-	bool down;
-
-	data0 = readl(ts.io + S3C2410_ADCDAT0);
-	data1 = readl(ts.io + S3C2410_ADCDAT1);
-
-	down = get_down(data0, data1);
-
-	if (down) {
+	if (ts.pen_is_down) {
 		if (ts.count == (1 << ts.shift)) {
 			ts.xp >>= ts.shift;
 			ts.yp >>= ts.shift;
@@ -132,7 +121,7 @@ static void touch_timer_fire(unsigned long data)
 			ts.yp = 0;
 			ts.count = 0;
 		}
-
+		/* as long as the pen is down, trigger the next conversion */
 		s3c_adc_start(ts.client, 0, 1 << ts.shift);
 	} else {
 		ts.xp = 0;
@@ -154,30 +143,31 @@ static DEFINE_TIMER(touch_timer, touch_timer_fire, 0, 0);
  * @dev_id: The device ID.
  *
  * Called when the IRQ_TC is fired for a pen up or down event.
+ *
+ * Do not change the pen detection interrupt setting here. An ADC conversion
+ * may still is ongoing.
  */
 static irqreturn_t stylus_irq(int irq, void *dev_id)
 {
-	unsigned long data0;
-	unsigned long data1;
-	bool down;
-
-	data0 = readl(ts.io + S3C2410_ADCDAT0);
-	data1 = readl(ts.io + S3C2410_ADCDAT1);
-
-	down = get_down(data0, data1);
-
-	/* TODO we should never get an interrupt with down set while
-	 * the timer is running, but maybe we ought to verify that the
-	 * timer isn't running anyways. */
-
-	if (down)
-		s3c_adc_start(ts.client, 0, 1 << ts.shift);
-	else
-		dev_dbg(ts.dev, "%s: count=%d\n", __func__, ts.count);
-
-	if (ts.features & FEAT_PEN_IRQ) {
-		/* Clear pen down/up interrupt */
-		writel(0x0, ts.io + S3C64XX_ADCCLRINTPNDNUP);
+	u32 reg;
+
+	reg = readl(ts.io + S3C64XX_ADCUPDN);
+	writel(0x0, ts.io + S3C64XX_ADCUPDN);	/* just clear the status */
+
+	if (reg & TSC_DN) {
+		if (!ts.pen_is_down) {
+			/* Waiting for pen-up is done after the conversion */
+			ts.pen_is_down = true;
+			s3c_adc_start(ts.client, 0, 1 << ts.shift);
+			dev_dbg(ts.dev, "%s: Start\n", __func__);
+		} else
+			dev_dbg(ts.dev, "%s: Ignoring pen-down bounce\n", __func__);
+	} else {
+		if (reg & TSC_UP) {
+			dev_dbg(ts.dev, "%s: Stop\n", __func__);
+			ts.pen_is_down = false;
+		} else
+			dev_dbg(ts.dev, "%s: Unknown reason\n", __func__);
 	}
 
 	return IRQ_HANDLED;
@@ -223,11 +213,17 @@ static void s3c24xx_ts_conversion(struct s3c_adc_client *client,
 static void s3c24xx_ts_select(struct s3c_adc_client *client, unsigned select)
 {
 	if (select) {
+		/* do a full X/Y conversion */
 		writel(S3C2410_ADCTSC_PULL_UP_DISABLE | AUTOPST,
 		       ts.io + S3C2410_ADCTSC);
 	} else {
-		mod_timer(&touch_timer, jiffies+1);
+		/* Switch back to pen up detection */
 		writel(WAIT4INT | INT_UP, ts.io + S3C2410_ADCTSC);
+		/*
+		 * After each conversion do a small pause to give the
+		 * pen up detection a chance to happen.
+		 */
+		mod_timer(&touch_timer, jiffies + 1);
 	}
 }
 
@@ -304,8 +300,6 @@ static int __devinit s3c2410ts_probe(struct platform_device *pdev)
 	if ((info->delay & 0xffff) > 0)
 		writel(info->delay & 0xffff, ts.io + S3C2410_ADCDLY);
 
-	writel(WAIT4INT | INT_DOWN, ts.io + S3C2410_ADCTSC);
-
 	input_dev = input_allocate_device();
 	if (!input_dev) {
 		dev_err(dev, "Unable to allocate the input device !!\n");
@@ -335,6 +329,8 @@ static int __devinit s3c2410ts_probe(struct platform_device *pdev)
 		goto err_inputdev;
 	}
 
+	waiting_for_pen_down(&ts);
+
 	dev_info(dev, "driver attached, registering input device\n");
 
 	/* All went ok, so register to the input system */
@@ -401,7 +397,7 @@ static int s3c2410ts_resume(struct device *dev)
 	if ((info->delay & 0xffff) > 0)
 		writel(info->delay & 0xffff, ts.io + S3C2410_ADCDLY);
 
-	writel(WAIT4INT | INT_DOWN, ts.io + S3C2410_ADCTSC);
+	waiting_for_pen_down(&ts);
 
 	return 0;
 }

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-5121-206917-5128 |
Vertretung Sued/Muenchen, Germany             | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
