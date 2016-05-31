From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 5/8] mfd: ti_am335x_tscadc: Rename regmap_tscadc to regmap
Date: Tue, 31 May 2016 12:00:10 -0500
Message-ID: <20160531170013.2649-6-afd@ti.com>
References: <20160531170013.2649-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160531170013.2649-1-afd-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>
List-Id: linux-input@vger.kernel.org

The regmap structuer pointer is named regmap_tscadc, this is not
consistent with other drivers and is redundant, it also contributes
to several checkpatch warnings involving long lines. Rename this.

Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
---
 drivers/mfd/ti_am335x_tscadc.c       | 36 ++++++++++++++++++------------------
 include/linux/mfd/ti_am335x_tscadc.h |  2 +-
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 9b293b1..d30bea5 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -43,7 +43,7 @@ void am335x_tsc_se_set_cache(struct ti_tscadc_dev *tscadc, u32 val)
 	if (tscadc->adc_waiting)
 		wake_up(&tscadc->reg_se_wait);
 	else if (!tscadc->adc_in_use)
-		regmap_write(tscadc->regmap_tscadc, REG_SE, tscadc->reg_se_cache);
+		regmap_write(tscadc->regmap, REG_SE, tscadc->reg_se_cache);
 
 	spin_unlock_irqrestore(&tscadc->reg_lock, flags);
 }
@@ -54,7 +54,7 @@ static void am335x_tscadc_need_adc(struct ti_tscadc_dev *tscadc)
 	DEFINE_WAIT(wait);
 	u32 reg;
 
-	regmap_read(tscadc->regmap_tscadc, REG_ADCFSM, &reg);
+	regmap_read(tscadc->regmap, REG_ADCFSM, &reg);
 	if (reg & SEQ_STATUS) {
 		tscadc->adc_waiting = true;
 		prepare_to_wait(&tscadc->reg_se_wait, &wait,
@@ -70,7 +70,7 @@ static void am335x_tscadc_need_adc(struct ti_tscadc_dev *tscadc)
 		 * Sequencer should either be idle or
 		 * busy applying the charge step.
 		 */
-		regmap_read(tscadc->regmap_tscadc, REG_ADCFSM, &reg);
+		regmap_read(tscadc->regmap, REG_ADCFSM, &reg);
 		WARN_ON((reg & SEQ_STATUS) && !(reg & CHARGE_STEP));
 		tscadc->adc_waiting = false;
 	}
@@ -82,7 +82,7 @@ void am335x_tsc_se_set_once(struct ti_tscadc_dev *tscadc, u32 val)
 	spin_lock_irq(&tscadc->reg_lock);
 	am335x_tscadc_need_adc(tscadc);
 
-	regmap_write(tscadc->regmap_tscadc, REG_SE, val);
+	regmap_write(tscadc->regmap, REG_SE, val);
 	spin_unlock_irq(&tscadc->reg_lock);
 }
 EXPORT_SYMBOL_GPL(am335x_tsc_se_set_once);
@@ -93,7 +93,7 @@ void am335x_tsc_se_adc_done(struct ti_tscadc_dev *tscadc)
 
 	spin_lock_irqsave(&tscadc->reg_lock, flags);
 	tscadc->adc_in_use = false;
-	regmap_write(tscadc->regmap_tscadc, REG_SE, tscadc->reg_se_cache);
+	regmap_write(tscadc->regmap, REG_SE, tscadc->reg_se_cache);
 	spin_unlock_irqrestore(&tscadc->reg_lock, flags);
 }
 EXPORT_SYMBOL_GPL(am335x_tsc_se_adc_done);
@@ -104,7 +104,7 @@ void am335x_tsc_se_clr(struct ti_tscadc_dev *tscadc, u32 val)
 
 	spin_lock_irqsave(&tscadc->reg_lock, flags);
 	tscadc->reg_se_cache &= ~val;
-	regmap_write(tscadc->regmap_tscadc, REG_SE, tscadc->reg_se_cache);
+	regmap_write(tscadc->regmap, REG_SE, tscadc->reg_se_cache);
 	spin_unlock_irqrestore(&tscadc->reg_lock, flags);
 }
 EXPORT_SYMBOL_GPL(am335x_tsc_se_clr);
@@ -116,7 +116,7 @@ static void tscadc_idle_config(struct ti_tscadc_dev *tscadc)
 	idleconfig = STEPCONFIG_YNN | STEPCONFIG_INM_ADCREFM |
 			STEPCONFIG_INP_ADCREFM | STEPCONFIG_YPN;
 
-	regmap_write(tscadc->regmap_tscadc, REG_IDLECONFIG, idleconfig);
+	regmap_write(tscadc->regmap, REG_IDLECONFIG, idleconfig);
 }
 
 static	int ti_tscadc_probe(struct platform_device *pdev)
@@ -188,11 +188,11 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	if (IS_ERR(tscadc->tscadc_base))
 		return PTR_ERR(tscadc->tscadc_base);
 
-	tscadc->regmap_tscadc = devm_regmap_init_mmio(&pdev->dev,
+	tscadc->regmap = devm_regmap_init_mmio(&pdev->dev,
 			tscadc->tscadc_base, &tscadc_regmap_config);
-	if (IS_ERR(tscadc->regmap_tscadc)) {
+	if (IS_ERR(tscadc->regmap)) {
 		dev_err(&pdev->dev, "regmap init failed\n");
-		err = PTR_ERR(tscadc->regmap_tscadc);
+		err = PTR_ERR(tscadc->regmap);
 		goto ret;
 	}
 
@@ -222,11 +222,11 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 
 	/* TSCADC_CLKDIV needs to be configured to the value minus 1 */
 	tscadc->clk_div--;
-	regmap_write(tscadc->regmap_tscadc, REG_CLKDIV, tscadc->clk_div);
+	regmap_write(tscadc->regmap, REG_CLKDIV, tscadc->clk_div);
 
 	/* Set the control register bits */
 	ctrl = CNTRLREG_STEPCONFIGWRT |	CNTRLREG_STEPID;
-	regmap_write(tscadc->regmap_tscadc, REG_CTRL, ctrl);
+	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
 
 	/* Set register bits for Idle Config Mode */
 	if (tsc_wires > 0) {
@@ -240,7 +240,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 
 	/* Enable the TSC module enable bit */
 	ctrl |= CNTRLREG_TSCSSENB;
-	regmap_write(tscadc->regmap_tscadc, REG_CTRL, ctrl);
+	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
 
 	tscadc->used_cells = 0;
 	tscadc->tsc_cell = -1;
@@ -286,7 +286,7 @@ static int ti_tscadc_remove(struct platform_device *pdev)
 {
 	struct ti_tscadc_dev	*tscadc = platform_get_drvdata(pdev);
 
-	regmap_write(tscadc->regmap_tscadc, REG_SE, 0x00);
+	regmap_write(tscadc->regmap, REG_SE, 0x00);
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -300,7 +300,7 @@ static int __maybe_unused tscadc_suspend(struct device *dev)
 {
 	struct ti_tscadc_dev	*tscadc = dev_get_drvdata(dev);
 
-	regmap_write(tscadc->regmap_tscadc, REG_SE, 0x00);
+	regmap_write(tscadc->regmap, REG_SE, 0x00);
 	pm_runtime_put_sync(dev);
 
 	return 0;
@@ -315,7 +315,7 @@ static int __maybe_unused tscadc_resume(struct device *dev)
 
 	/* context restore */
 	ctrl = CNTRLREG_STEPCONFIGWRT |	CNTRLREG_STEPID;
-	regmap_write(tscadc->regmap_tscadc, REG_CTRL, ctrl);
+	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
 
 	if (tscadc->tsc_cell != -1) {
 		if (tscadc->tsc_wires == 5)
@@ -325,9 +325,9 @@ static int __maybe_unused tscadc_resume(struct device *dev)
 		tscadc_idle_config(tscadc);
 	}
 	ctrl |= CNTRLREG_TSCSSENB;
-	regmap_write(tscadc->regmap_tscadc, REG_CTRL, ctrl);
+	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
 
-	regmap_write(tscadc->regmap_tscadc, REG_CLKDIV, tscadc->clk_div);
+	regmap_write(tscadc->regmap, REG_CLKDIV, tscadc->clk_div);
 
 	return 0;
 }
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index 1fd50dc..2567a87 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -153,7 +153,7 @@
 
 struct ti_tscadc_dev {
 	struct device *dev;
-	struct regmap *regmap_tscadc;
+	struct regmap *regmap;
 	void __iomem *tscadc_base;
 	int irq;
 	int used_cells;	/* 1-2 */
-- 
2.8.3
