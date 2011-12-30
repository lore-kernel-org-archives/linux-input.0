From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input: add support for TI Touchscreen controller
Date: Thu, 29 Dec 2011 19:55:21 -0800
Message-ID: <20111230035521.GD17850@core.coreip.homeip.net>
References: <1323430182-27626-1-git-send-email-rachna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47934 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754995Ab1L3Dz2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Dec 2011 22:55:28 -0500
Received: by iaeh11 with SMTP id h11so24645083iae.19
        for <linux-input@vger.kernel.org>; Thu, 29 Dec 2011 19:55:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323430182-27626-1-git-send-email-rachna@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Patil, Rachna" <rachna@ti.com>
Cc: linux-input@vger.kernel.org

Hi Rachna,


On Fri, Dec 09, 2011 at 04:59:42PM +0530, Patil, Rachna wrote:
> From: Rachna Patil <rachna@ti.com>
> 
> This patch adds support for TI's touchscreen
> controller for a 4/5/8 wire resistive panel
> that is directly fed to the ADC.
> 
> This touchscreen controller will be part of
> AM335x TI SoC. The TRM can be found at:
> http://www.ti.com/lit/ug/spruh73a/spruh73a.pdf
> 

This looks mostly good, could you also try the patch below (on top of
yours) and let me know if the driver still works?

Thanks!

-- 
Dmitry


Input: ti_tscadc - misc changes

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

- rely on input core to implement defuzzing (filtering out smaller
  variations in coordinates);
- release the 2nd clock after getting its rate;
- IRQF_DISABLE is obsolete;
- split filtering of measurements into a separate function;
- misc formatting changes;

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/ti_tscadc.c |  244 ++++++++++++++++-----------------
 1 files changed, 115 insertions(+), 129 deletions(-)


diff --git a/drivers/input/touchscreen/ti_tscadc.c b/drivers/input/touchscreen/ti_tscadc.c
index ed6f1eb..8d23f5f 100644
--- a/drivers/input/touchscreen/ti_tscadc.c
+++ b/drivers/input/touchscreen/ti_tscadc.c
@@ -87,17 +87,17 @@
 #define SEQ_SETTLE		275
 #define ADC_CLK			3000000
 #define MAX_12BIT		((1 << 12) - 1)
+#define TSCADC_FUZZ_X		15
+#define TSCADC_FUZZ_Y		15
 
 struct tscadc {
 	struct input_dev	*input;
 	struct clk		*tsc_ick;
-	int			irq;
-	int			pen;
-	int			wires;
-	int			x_plate_resistance;
-	unsigned int		bckup_x;
-	unsigned int		bckup_y;
 	void __iomem		*tsc_base;
+	unsigned int		irq;
+	unsigned int		wires;
+	unsigned int		x_plate_resistance;
+	bool			pen_down;
 };
 
 static unsigned int tscadc_readl(struct tscadc *ts, unsigned int reg)
@@ -111,7 +111,7 @@ static void tscadc_writel(struct tscadc *tsc, unsigned int reg,
 	writel(val, tsc->tsc_base + reg);
 }
 
-static void tsc_step_config(struct tscadc *ts_dev)
+static void tscadc_step_config(struct tscadc *ts_dev)
 {
 	unsigned int	config;
 	int i;
@@ -122,8 +122,7 @@ static void tsc_step_config(struct tscadc *ts_dev)
 			STEPCONFIG_SAMPLES_AVG | STEPCONFIG_XPP;
 	switch (ts_dev->wires) {
 	case 4:
-		config |= STEPCONFIG_INP |
-				STEPCONFIG_XNN;
+		config |= STEPCONFIG_INP | STEPCONFIG_XNN;
 		break;
 	case 5:
 		config |= STEPCONFIG_YNN |
@@ -131,10 +130,10 @@ static void tsc_step_config(struct tscadc *ts_dev)
 				STEPCONFIG_YPP;
 		break;
 	case 8:
-		config |= STEPCONFIG_INP |
-				STEPCONFIG_XNN;
+		config |= STEPCONFIG_INP | STEPCONFIG_XNN;
 		break;
 	}
+
 	for (i = 1; i < 7; i++) {
 		tscadc_writel(ts_dev, REG_STEPCONFIG(i), config);
 		tscadc_writel(ts_dev, REG_STEPDELAY(i), STEPCONFIG_OPENDLY);
@@ -156,6 +155,7 @@ static void tsc_step_config(struct tscadc *ts_dev)
 		config |= STEPCONFIG_YPP;
 		break;
 	}
+
 	for (i = 7; i < 13; i++) {
 		tscadc_writel(ts_dev, REG_STEPCONFIG(i), config);
 		tscadc_writel(ts_dev, REG_STEPDELAY(i), STEPCONFIG_OPENDLY);
@@ -185,9 +185,9 @@ static void tsc_step_config(struct tscadc *ts_dev)
 	tscadc_writel(ts_dev, REG_SE, STPENB_STEPENB);
 }
 
-static void tsc_idle_config(struct tscadc *ts_config)
+static void tscadc_idle_config(struct tscadc *ts_config)
 {
-	unsigned int	 idleconfig;
+	unsigned int idleconfig;
 
 	idleconfig = STEPCONFIG_YNN |
 			STEPCONFIG_INM |
@@ -195,83 +195,78 @@ static void tsc_idle_config(struct tscadc *ts_config)
 	tscadc_writel(ts_config, REG_IDLECONFIG, idleconfig);
 }
 
-static irqreturn_t interrupt(int irq, void *dev)
+static void tscadc_read_coordinates(struct tscadc *ts_dev,
+				    unsigned int *x, unsigned int *y)
 {
-	struct tscadc		*ts_dev = (struct tscadc *)dev;
-	struct input_dev	*input_dev = ts_dev->input;
-	unsigned int		status, irqclr = 0;
-	unsigned int		read, diff;
-	unsigned int		prev_val_x = ~0, prev_val_y = ~0;
-	unsigned int		prev_diff_x = ~0, prev_diff_y = ~0;
-	unsigned int		val_x = 0, val_y = 0, diffx = 0, diffy = 0;
-	unsigned int		z1 = 0, z2 = 0, z = 0;
-	int			i, fsm, fifocount;
+	unsigned int fifocount = tscadc_readl(ts_dev, REG_FIFO0CNT);
+	unsigned int prev_val_x = ~0, prev_val_y = ~0;
+	unsigned int prev_diff_x = ~0, prev_diff_y = ~0;
+	unsigned int read, diff;
+	unsigned int i;
 
-	status = tscadc_readl(ts_dev, REG_IRQSTATUS);
-	if (status & IRQENB_FIFO1THRES) {
-		fifocount = tscadc_readl(ts_dev, REG_FIFO0CNT);
-
-		/* Delta filter is used to remove large variations
-		 * in sampled values from ADC. The filter tries to
-		 * predict where the next coordinate could be.
-		 * This is done by taking a previous coordinate and
-		 * subtracting it form current one. Further the
-		 * algorithm compares the difference with that of
-		 * a present value, if true the value is reported
-		 * to the sub system.
-		 */
-		for (i = 0; i < (fifocount-1); i++) {
-			read = ((tscadc_readl(ts_dev, REG_FIFO0)) & 0xfff);
-			diff = abs(read - prev_val_x);
-			if (diff < prev_diff_x) {
-				prev_diff_x = diff;
-				val_x = read;
-			}
-			prev_val_x = read;
-
-			read = 0;
-			diff = 0;
-			read = ((tscadc_readl(ts_dev, REG_FIFO1)) & 0xfff);
-			diff = abs(read - prev_val_y);
-			if (diff < prev_diff_y) {
-				prev_diff_y = diff;
-				val_y = read;
-			}
-			prev_val_y = read;
+	/*
+	 * Delta filter is used to remove large variations
+	 * in sampled values from ADC. The filter tries to
+	 * predict where the next coordinate could be.
+	 * This is done by taking a previous coordinate and
+	 * subtracting it form current one. Further the
+	 * algorithm compares the difference with that of
+	 * a present value, if true the value is reported
+	 * to the sub system.
+	 */
+	for (i = 0; i < fifocount - 1; i++) {
+		read = tscadc_readl(ts_dev, REG_FIFO0) & 0xfff;
+		diff = abs(read - prev_val_x);
+		if (diff < prev_diff_x) {
+			prev_diff_x = diff;
+			*x = read;
 		}
+		prev_val_x = read;
 
-		diffx = abs(val_x - (ts_dev->bckup_x));
-		diffy = abs(val_y - (ts_dev->bckup_y));
-		ts_dev->bckup_x = val_x;
-		ts_dev->bckup_y = val_y;
-
-		z1 = ((tscadc_readl(ts_dev, REG_FIFO0)) & 0xfff);
-		z2 = ((tscadc_readl(ts_dev, REG_FIFO1)) & 0xfff);
-
-		if (ts_dev->pen == 0) {
-			if ((z1 != 0) && (z2 != 0)) {
-				/* cal pressure using formula
-				 * Resistance(touch) = x plate resistance *
-				 * x postion/4096 * ((z2 / z1) - 1)
-				 */
-				z = z2 - z1;
-				z *= val_x;
-				z *= ts_dev->x_plate_resistance;
-				z /= z1;
-				z = (z + 2047) >> 12;
-
-				if ((diffx < 15) && (diffy < 15)
-						&& (z <= MAX_12BIT)) {
-					input_report_abs(input_dev,
-							ABS_X, val_x);
-					input_report_abs(input_dev,
-							ABS_Y, val_y);
-					input_report_abs(input_dev,
-							ABS_PRESSURE, z);
-					input_report_key(input_dev,
-							BTN_TOUCH, 1);
-					input_sync(input_dev);
-				}
+		read = tscadc_readl(ts_dev, REG_FIFO1) & 0xfff;
+		diff = abs(read - prev_val_y);
+		if (diff < prev_diff_y) {
+			prev_diff_y = diff;
+			*y = read;
+		}
+		prev_val_y = read;
+	}
+}
+
+static irqreturn_t tscadc_irq(int irq, void *dev)
+{
+	struct tscadc *ts_dev = dev;
+	struct input_dev *input_dev = ts_dev->input;
+	unsigned int status, irqclr = 0;
+	unsigned int x = 0, y = 0;
+	unsigned int z1, z2, z;
+	unsigned int fsm;
+
+	status = tscadc_readl(ts_dev, REG_IRQSTATUS);
+	if (status & IRQENB_FIFO1THRES) {
+		tscadc_read_coordinates(ts_dev, &x, &y);
+
+		z1 = tscadc_readl(ts_dev, REG_FIFO0) & 0xfff;
+		z2 = tscadc_readl(ts_dev, REG_FIFO1) & 0xfff;
+
+		if (ts_dev->pen_down && z1 != 0 && z2 != 0) {
+			/*
+			 * Calculate pressure using formula
+			 * Resistance(touch) = x plate resistance *
+			 * x postion/4096 * ((z2 / z1) - 1)
+			 */
+			z = z2 - z1;
+			z *= x;
+			z *= ts_dev->x_plate_resistance;
+			z /= z1;
+			z = (z + 2047) >> 12;
+
+			if (z <= MAX_12BIT) {
+				input_report_abs(input_dev, ABS_X, x);
+				input_report_abs(input_dev, ABS_Y, y);
+				input_report_abs(input_dev, ABS_PRESSURE, z);
+				input_report_key(input_dev, BTN_TOUCH, 1);
+				input_sync(input_dev);
 			}
 		}
 		irqclr |= IRQENB_FIFO1THRES;
@@ -288,14 +283,12 @@ static irqreturn_t interrupt(int irq, void *dev)
 		/* Pen up event */
 		fsm = tscadc_readl(ts_dev, REG_ADCFSM);
 		if (fsm == ADCFSM_STEPID) {
-			ts_dev->pen = 1;
-			ts_dev->bckup_x = 0;
-			ts_dev->bckup_y = 0;
+			ts_dev->pen_down = false;
 			input_report_key(input_dev, BTN_TOUCH, 0);
 			input_report_abs(input_dev, ABS_PRESSURE, 0);
 			input_sync(input_dev);
 		} else {
-			ts_dev->pen = 0;
+			ts_dev->pen_down = true;
 		}
 		irqclr |= IRQENB_PENUP;
 	}
@@ -309,18 +302,18 @@ static irqreturn_t interrupt(int irq, void *dev)
 }
 
 /*
-* The functions for inserting/removing driver as a module.
-*/
+ * The functions for inserting/removing driver as a module.
+ */
 
-static	int __devinit tscadc_probe(struct platform_device *pdev)
+static int __devinit tscadc_probe(struct platform_device *pdev)
 {
-	const struct tsc_data		*pdata = pdev->dev.platform_data;
-	struct resource			*res;
-	struct tscadc			*ts_dev;
-	struct input_dev		*input_dev;
-	struct clk			*clk;
-	int				err;
-	int				clk_value, ctrl;
+	const struct tsc_data *pdata = pdev->dev.platform_data;
+	struct resource *res;
+	struct tscadc *ts_dev;
+	struct input_dev *input_dev;
+	struct clk *clk;
+	int err;
+	int clk_value, ctrl, irq;
 
 	if (!pdata) {
 		dev_err(&pdev->dev, "missing platform data.\n");
@@ -333,6 +326,12 @@ static	int __devinit tscadc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "no irq ID is specified.\n");
+		return -EINVAL;
+	}
+
 	/* Allocate memory for device */
 	ts_dev = kzalloc(sizeof(struct tscadc), GFP_KERNEL);
 	input_dev = input_allocate_device();
@@ -342,7 +341,6 @@ static	int __devinit tscadc_probe(struct platform_device *pdev)
 		goto err_free_mem;
 	}
 
-	ts_dev->irq = platform_get_irq(pdev, 0);
 	if (ts_dev->irq < 0) {
 		dev_err(&pdev->dev, "no irq ID is specified.\n");
 		err = -ENODEV;
@@ -350,11 +348,11 @@ static	int __devinit tscadc_probe(struct platform_device *pdev)
 	}
 
 	ts_dev->input = input_dev;
+	ts_dev->irq = irq;
 	ts_dev->wires = pdata->wires;
 	ts_dev->x_plate_resistance = pdata->x_plate_resistance;
-	ts_dev->pen = 1;
 
-	res =  request_mem_region(res->start, resource_size(res), pdev->name);
+	res = request_mem_region(res->start, resource_size(res), pdev->name);
 	if (!res) {
 		dev_err(&pdev->dev, "failed to reserve registers.\n");
 		err = -EBUSY;
@@ -368,8 +366,8 @@ static	int __devinit tscadc_probe(struct platform_device *pdev)
 		goto err_release_mem_region;
 	}
 
-	err = request_irq(ts_dev->irq, interrupt, IRQF_DISABLED,
-			pdev->dev.driver->name, ts_dev);
+	err = request_irq(ts_dev->irq, tscadc_irq,
+			  0, pdev->dev.driver->name, ts_dev);
 	if (err) {
 		dev_err(&pdev->dev, "failed to allocate irq.\n");
 		goto err_unmap_regs;
@@ -390,18 +388,18 @@ static	int __devinit tscadc_probe(struct platform_device *pdev)
 	}
 
 	clk_value = clk_get_rate(clk) / ADC_CLK;
+	clk_put(clk);
+
 	if (clk_value < 7) {
 		dev_err(&pdev->dev, "clock input less than min clock requirement\n");
 		goto err_disable_clk;
 	}
 	/* CLKDIV needs to be configured to the value minus 1 */
-	clk_value = clk_value - 1;
-	tscadc_writel(ts_dev, REG_CLKDIV, clk_value);
+	tscadc_writel(ts_dev, REG_CLKDIV, clk_value - 1);
 
 	 /* Enable wake-up of the SoC using touchscreen */
 	tscadc_writel(ts_dev, REG_IRQWAKEUP, IRQWKUP_ENB);
 
-
 	ctrl = CNTRLREG_STEPCONFIGWRT |
 			CNTRLREG_TSCENB |
 			CNTRLREG_STEPID;
@@ -418,9 +416,9 @@ static	int __devinit tscadc_probe(struct platform_device *pdev)
 	}
 	tscadc_writel(ts_dev, REG_CTRL, ctrl);
 
-	tsc_idle_config(ts_dev);
+	tscadc_idle_config(ts_dev);
 	tscadc_writel(ts_dev, REG_IRQENABLE, IRQENB_FIFO1THRES);
-	tsc_step_config(ts_dev);
+	tscadc_step_config(ts_dev);
 	tscadc_writel(ts_dev, REG_FIFO1THR, 6);
 
 	ctrl |= CNTRLREG_TSCSSENB;
@@ -432,8 +430,8 @@ static	int __devinit tscadc_probe(struct platform_device *pdev)
 	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
 	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
 
-	input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, 0, 0);
-	input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, 0, 0);
+	input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, TSCADC_FUZZ_X, 0);
+	input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, TSCADC_FUZZ_Y, 0);
 	input_set_abs_params(input_dev, ABS_PRESSURE, 0, MAX_12BIT, 0, 0);
 
 	/* register to the input system */
@@ -461,8 +459,8 @@ err_free_mem:
 
 static int __devexit tscadc_remove(struct platform_device *pdev)
 {
-	struct tscadc		*ts_dev = platform_get_drvdata(pdev);
-	struct resource		*res;
+	struct tscadc *ts_dev = platform_get_drvdata(pdev);
+	struct resource *res;
 
 	free_irq(ts_dev->irq, ts_dev);
 
@@ -485,24 +483,12 @@ static struct platform_driver ti_tsc_driver = {
 	.probe	= tscadc_probe,
 	.remove	= __devexit_p(tscadc_remove),
 	.driver	= {
-			.name   = "tsc",
-			.owner	= THIS_MODULE,
+		.name   = "tsc",
+		.owner	= THIS_MODULE,
 	},
 };
-
-static int __init ti_tsc_init(void)
-{
-	return platform_driver_register(&ti_tsc_driver);
-}
-module_init(ti_tsc_init);
-
-static void __exit ti_tsc_exit(void)
-{
-	platform_driver_unregister(&ti_tsc_driver);
-}
-module_exit(ti_tsc_exit);
+module_platform_driver(ti_tsc_driver);
 
 MODULE_DESCRIPTION("TI touchscreen controller driver");
 MODULE_AUTHOR("Rachna Patil <rachna@ti.com>");
 MODULE_LICENSE("GPL");
-
