From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 01/22] mfd/ti_am335x_tscadc: remove regmap
Date: Wed,  5 Jun 2013 18:24:34 +0200
Message-ID: <1370449495-29981-2-git-send-email-bigeasy@linutronix.de>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1370449495-29981-1-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

The MFD part uses regmap without caching and is the only user of the
regmap. The child drivers, that is input(touch) and iio(adc), use direct
reg access.
There is a patch which converts them to use regmap as well but I see no
benefit at all doing this. There is a direct MMIO bus access with no
need to cache values like for I2C or SPI devices. Furthermore, most (if
not all) of the access done by the touch & ADC driver read volatile
register.
Therefore this patch removes regmap part of the driver.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/mfd/ti_am335x_tscadc.c       |   23 ++---------------------
 include/linux/mfd/ti_am335x_tscadc.h |    1 -
 2 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index e9f3fb5..804e61e 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -19,7 +19,6 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/clk.h>
-#include <linux/regmap.h>
 #include <linux/mfd/core.h>
 #include <linux/pm_runtime.h>
 
@@ -29,25 +28,15 @@
 
 static unsigned int tscadc_readl(struct ti_tscadc_dev *tsadc, unsigned int reg)
 {
-	unsigned int val;
-
-	regmap_read(tsadc->regmap_tscadc, reg, &val);
-	return val;
+	return readl(tsadc->tscadc_base + reg);
 }
 
 static void tscadc_writel(struct ti_tscadc_dev *tsadc, unsigned int reg,
 					unsigned int val)
 {
-	regmap_write(tsadc->regmap_tscadc, reg, val);
+	writel(val, tsadc->tscadc_base + reg);
 }
 
-static const struct regmap_config tscadc_regmap_config = {
-	.name = "ti_tscadc",
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-};
-
 static void tscadc_idle_config(struct ti_tscadc_dev *config)
 {
 	unsigned int idleconfig;
@@ -121,14 +110,6 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	tscadc->regmap_tscadc = devm_regmap_init_mmio(&pdev->dev,
-			tscadc->tscadc_base, &tscadc_regmap_config);
-	if (IS_ERR(tscadc->regmap_tscadc)) {
-		dev_err(&pdev->dev, "regmap init failed\n");
-		err = PTR_ERR(tscadc->regmap_tscadc);
-		goto ret;
-	}
-
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index c79ad5d..dc75c34 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -137,7 +137,6 @@ struct mfd_tscadc_board {
 
 struct ti_tscadc_dev {
 	struct device *dev;
-	struct regmap *regmap_tscadc;
 	void __iomem *tscadc_base;
 	int irq;
 	struct mfd_cell cells[TSCADC_CELLS];
-- 
1.7.10.4
