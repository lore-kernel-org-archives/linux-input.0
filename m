From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/8] mfd: ti_am335x_tscadc: Remove use of single line functions
Date: Tue, 31 May 2016 12:00:08 -0500
Message-ID: <20160531170013.2649-4-afd@ti.com>
References: <20160531170013.2649-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160531170013.2649-1-afd-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>
List-Id: linux-input@vger.kernel.org

tscadc_readl and tscadc_writel are single line functions and do not save
use anything, remove these.

Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
---
 drivers/mfd/ti_am335x_tscadc.c | 44 ++++++++++++++----------------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 644128b..613f15d 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -27,20 +27,6 @@
 
 #include <linux/mfd/ti_am335x_tscadc.h>
 
-static unsigned int tscadc_readl(struct ti_tscadc_dev *tsadc, unsigned int reg)
-{
-	unsigned int val;
-
-	regmap_read(tsadc->regmap_tscadc, reg, &val);
-	return val;
-}
-
-static void tscadc_writel(struct ti_tscadc_dev *tsadc, unsigned int reg,
-					unsigned int val)
-{
-	regmap_write(tsadc->regmap_tscadc, reg, val);
-}
-
 static const struct regmap_config tscadc_regmap_config = {
 	.name = "ti_tscadc",
 	.reg_bits = 32,
@@ -57,7 +43,7 @@ void am335x_tsc_se_set_cache(struct ti_tscadc_dev *tsadc, u32 val)
 	if (tsadc->adc_waiting)
 		wake_up(&tsadc->reg_se_wait);
 	else if (!tsadc->adc_in_use)
-		tscadc_writel(tsadc, REG_SE, tsadc->reg_se_cache);
+		regmap_write(tsadc->regmap_tscadc, REG_SE, tsadc->reg_se_cache);
 
 	spin_unlock_irqrestore(&tsadc->reg_lock, flags);
 }
@@ -68,7 +54,7 @@ static void am335x_tscadc_need_adc(struct ti_tscadc_dev *tsadc)
 	DEFINE_WAIT(wait);
 	u32 reg;
 
-	reg = tscadc_readl(tsadc, REG_ADCFSM);
+	regmap_read(tsadc->regmap_tscadc, REG_ADCFSM, &reg);
 	if (reg & SEQ_STATUS) {
 		tsadc->adc_waiting = true;
 		prepare_to_wait(&tsadc->reg_se_wait, &wait,
@@ -84,7 +70,7 @@ static void am335x_tscadc_need_adc(struct ti_tscadc_dev *tsadc)
 		 * Sequencer should either be idle or
 		 * busy applying the charge step.
 		 */
-		reg = tscadc_readl(tsadc, REG_ADCFSM);
+		regmap_read(tsadc->regmap_tscadc, REG_ADCFSM, &reg);
 		WARN_ON((reg & SEQ_STATUS) && !(reg & CHARGE_STEP));
 		tsadc->adc_waiting = false;
 	}
@@ -96,7 +82,7 @@ void am335x_tsc_se_set_once(struct ti_tscadc_dev *tsadc, u32 val)
 	spin_lock_irq(&tsadc->reg_lock);
 	am335x_tscadc_need_adc(tsadc);
 
-	tscadc_writel(tsadc, REG_SE, val);
+	regmap_write(tsadc->regmap_tscadc, REG_SE, val);
 	spin_unlock_irq(&tsadc->reg_lock);
 }
 EXPORT_SYMBOL_GPL(am335x_tsc_se_set_once);
@@ -107,7 +93,7 @@ void am335x_tsc_se_adc_done(struct ti_tscadc_dev *tsadc)
 
 	spin_lock_irqsave(&tsadc->reg_lock, flags);
 	tsadc->adc_in_use = false;
-	tscadc_writel(tsadc, REG_SE, tsadc->reg_se_cache);
+	regmap_write(tsadc->regmap_tscadc, REG_SE, tsadc->reg_se_cache);
 	spin_unlock_irqrestore(&tsadc->reg_lock, flags);
 }
 EXPORT_SYMBOL_GPL(am335x_tsc_se_adc_done);
@@ -118,7 +104,7 @@ void am335x_tsc_se_clr(struct ti_tscadc_dev *tsadc, u32 val)
 
 	spin_lock_irqsave(&tsadc->reg_lock, flags);
 	tsadc->reg_se_cache &= ~val;
-	tscadc_writel(tsadc, REG_SE, tsadc->reg_se_cache);
+	regmap_write(tsadc->regmap_tscadc, REG_SE, tsadc->reg_se_cache);
 	spin_unlock_irqrestore(&tsadc->reg_lock, flags);
 }
 EXPORT_SYMBOL_GPL(am335x_tsc_se_clr);
@@ -130,7 +116,7 @@ static void tscadc_idle_config(struct ti_tscadc_dev *config)
 	idleconfig = STEPCONFIG_YNN | STEPCONFIG_INM_ADCREFM |
 			STEPCONFIG_INP_ADCREFM | STEPCONFIG_YPN;
 
-	tscadc_writel(config, REG_IDLECONFIG, idleconfig);
+	regmap_write(config->regmap_tscadc, REG_IDLECONFIG, idleconfig);
 }
 
 static	int ti_tscadc_probe(struct platform_device *pdev)
@@ -236,11 +222,11 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 
 	/* TSCADC_CLKDIV needs to be configured to the value minus 1 */
 	tscadc->clk_div--;
-	tscadc_writel(tscadc, REG_CLKDIV, tscadc->clk_div);
+	regmap_write(tscadc->regmap_tscadc, REG_CLKDIV, tscadc->clk_div);
 
 	/* Set the control register bits */
 	ctrl = CNTRLREG_STEPCONFIGWRT |	CNTRLREG_STEPID;
-	tscadc_writel(tscadc, REG_CTRL, ctrl);
+	regmap_write(tscadc->regmap_tscadc, REG_CTRL, ctrl);
 
 	/* Set register bits for Idle Config Mode */
 	if (tsc_wires > 0) {
@@ -254,7 +240,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 
 	/* Enable the TSC module enable bit */
 	ctrl |= CNTRLREG_TSCSSENB;
-	tscadc_writel(tscadc, REG_CTRL, ctrl);
+	regmap_write(tscadc->regmap_tscadc, REG_CTRL, ctrl);
 
 	tscadc->used_cells = 0;
 	tscadc->tsc_cell = -1;
@@ -300,7 +286,7 @@ static int ti_tscadc_remove(struct platform_device *pdev)
 {
 	struct ti_tscadc_dev	*tscadc = platform_get_drvdata(pdev);
 
-	tscadc_writel(tscadc, REG_SE, 0x00);
+	regmap_write(tscadc->regmap_tscadc, REG_SE, 0x00);
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -314,7 +300,7 @@ static int __maybe_unused tscadc_suspend(struct device *dev)
 {
 	struct ti_tscadc_dev	*tscadc_dev = dev_get_drvdata(dev);
 
-	tscadc_writel(tscadc_dev, REG_SE, 0x00);
+	regmap_write(tscadc_dev->regmap_tscadc, REG_SE, 0x00);
 	pm_runtime_put_sync(dev);
 
 	return 0;
@@ -329,7 +315,7 @@ static int __maybe_unused tscadc_resume(struct device *dev)
 
 	/* context restore */
 	ctrl = CNTRLREG_STEPCONFIGWRT |	CNTRLREG_STEPID;
-	tscadc_writel(tscadc_dev, REG_CTRL, ctrl);
+	regmap_write(tscadc_dev->regmap_tscadc, REG_CTRL, ctrl);
 
 	if (tscadc_dev->tsc_cell != -1) {
 		if (tscadc_dev->tsc_wires == 5)
@@ -339,9 +325,9 @@ static int __maybe_unused tscadc_resume(struct device *dev)
 		tscadc_idle_config(tscadc_dev);
 	}
 	ctrl |= CNTRLREG_TSCSSENB;
-	tscadc_writel(tscadc_dev, REG_CTRL, ctrl);
+	regmap_write(tscadc_dev->regmap_tscadc, REG_CTRL, ctrl);
 
-	tscadc_writel(tscadc_dev, REG_CLKDIV, tscadc_dev->clk_div);
+	regmap_write(tscadc_dev->regmap_tscadc, REG_CLKDIV, tscadc_dev->clk_div);
 
 	return 0;
 }
-- 
2.8.3
