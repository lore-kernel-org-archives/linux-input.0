From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/5] mfd: ti_am335x_tscadc: Make am335x_tsc_se_update() local
Date: Thu, 19 Dec 2013 16:28:28 +0100
Message-ID: <1387466911-3732-3-git-send-email-bigeasy@linutronix.de>
References: <1387466911-3732-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1387466911-3732-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zubair Lutfullah <zubair.lutfullah@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-input@vger.kernel.org

Since the "recent" changes, am335x_tsc_se_update() has no longer any
users outside of this file so make it local.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/mfd/ti_am335x_tscadc.c       | 3 +--
 include/linux/mfd/ti_am335x_tscadc.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 88718ab..67d0eb4 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -48,11 +48,10 @@ static const struct regmap_config tscadc_regmap_config = {
 	.val_bits = 32,
 };
 
-void am335x_tsc_se_update(struct ti_tscadc_dev *tsadc)
+static void am335x_tsc_se_update(struct ti_tscadc_dev *tsadc)
 {
 	tscadc_writel(tsadc, REG_SE, tsadc->reg_se_cache);
 }
-EXPORT_SYMBOL_GPL(am335x_tsc_se_update);
 
 void am335x_tsc_se_set(struct ti_tscadc_dev *tsadc, u32 val)
 {
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index d498d98f..1fe7219 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -176,7 +176,6 @@ static inline struct ti_tscadc_dev *ti_tscadc_dev_get(struct platform_device *p)
 	return *tscadc_dev;
 }
 
-void am335x_tsc_se_update(struct ti_tscadc_dev *tsadc);
 void am335x_tsc_se_set(struct ti_tscadc_dev *tsadc, u32 val);
 void am335x_tsc_se_clr(struct ti_tscadc_dev *tsadc, u32 val);
 
-- 
1.8.5.1
