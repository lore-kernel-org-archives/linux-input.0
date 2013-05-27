From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 19/19] mfd/ti_am335x_tscadc: add private lock/unlock function for regmap read/write
Date: Mon, 27 May 2013 21:12:06 +0200
Message-ID: <1369681926-22185-20-git-send-email-bigeasy@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48440 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068Ab3E0TNP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 May 2013 15:13:15 -0400
In-Reply-To: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>, Jonathan Cameron <jic23@cam.ac.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Mark Brown <broonie@kernel.org>

Without this, devm_regmap_init_mmio() creates & uses a simple
spin_lock() and this should be enough. Within the probe function the
registers are read and written in process context. Later they are
accessed from the ISR and lockdep complains because now the lock is
taken suddenly with IRQs enabled. Currently I don't see any other way to
keep lockdep quiet than doing this.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/mfd/ti_am335x_tscadc.c       |   17 +++++++++++++++++
 include/linux/mfd/ti_am335x_tscadc.h |    2 ++
 2 files changed, 19 insertions(+)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 5e4076f..04ed630 100644
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
@@ -110,6 +126,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	} else
 		tscadc->irq = err;
 
+	spin_lock_init(&tscadc->reg_map_lock);
 	res = devm_request_mem_region(&pdev->dev,
 			res->start, resource_size(res), pdev->name);
 	if (!res) {
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

