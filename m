From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 19/19 v2] mfd/ti_am335x_tscadc: add private lock/unlock
 function for regmap read/write
Date: Wed, 29 May 2013 10:46:42 +0200
Message-ID: <20130529084642.GA18273@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
 <1369681926-22185-20-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1369681926-22185-20-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Without this, devm_regmap_init_mmio() creates & uses a simple
spin_lock() and this should be enough. Within the probe function the
registers are read and written in process context. Later they are
accessed from the ISR and lockdep complains because now the lock is
taken suddenly with IRQs enabled. Currently I don't see any other way to
keep lockdep quiet than doing this.

Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---

v1..v2: pass a ti_tscadc_dev via lock arg

 drivers/mfd/ti_am335x_tscadc.c       |   21 ++++++++++++++++++++-
 include/linux/mfd/ti_am335x_tscadc.h |    2 ++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 5e4076f..bd982e5 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -42,11 +42,27 @@ static void tscadc_writel(struct ti_tscadc_dev *tsadc, unsigned int reg,
 	regmap_write(tsadc->regmap_tscadc, reg, val);
 }
 
+static void tscadc_lock_spinlock(void *__map)
+{
+	struct ti_tscadc_dev *tsadc = __map;
+
+	spin_lock_irqsave(&tsadc->reg_map_lock, tsadc->reg_map_flags);
+}
+
+static void tscadc_unlock_spinlock(void *__map)
+{
+	struct ti_tscadc_dev *tsadc = __map;
+
+	spin_unlock_irqrestore(&tsadc->reg_map_lock, tsadc->reg_map_flags);
+}
+
 static const struct regmap_config tscadc_regmap_config = {
 	.name = "ti_tscadc",
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
+	.lock = tscadc_lock_spinlock,
+	.unlock = tscadc_unlock_spinlock,
 };
 
 static void tscadc_idle_config(struct ti_tscadc_dev *config)
@@ -69,6 +85,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	int			err, ctrl;
 	int			clk_value, clock_rate;
 	int			tsc_wires = 0, adc_channels = 0, total_channels;
+	struct regmap_config	tscadc_regmap_cfg = tscadc_regmap_config;
 
 	if (!pdev->dev.of_node) {
 		dev_err(&pdev->dev, "Could not find valid DT data.\n");
@@ -110,6 +127,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	} else
 		tscadc->irq = err;
 
+	spin_lock_init(&tscadc->reg_map_lock);
 	res = devm_request_mem_region(&pdev->dev,
 			res->start, resource_size(res), pdev->name);
 	if (!res) {
@@ -124,8 +142,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	tscadc_regmap_cfg.lock_arg = tscadc;
 	tscadc->regmap_tscadc = devm_regmap_init_mmio(&pdev->dev,
-			tscadc->tscadc_base, &tscadc_regmap_config);
+			tscadc->tscadc_base, &tscadc_regmap_cfg);
 	if (IS_ERR(tscadc->regmap_tscadc)) {
 		dev_err(&pdev->dev, "regmap init failed\n");
 		err = PTR_ERR(tscadc->regmap_tscadc);
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index c985262..284e482 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -129,6 +129,8 @@
 #define TSCADC_CELLS		2
 
 struct ti_tscadc_dev {
+	spinlock_t reg_map_lock;
+	unsigned long reg_map_flags;
 	struct device *dev;
 	struct regmap *regmap_tscadc;
 	void __iomem *tscadc_base;
-- 
1.7.10.4
