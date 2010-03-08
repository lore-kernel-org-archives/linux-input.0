From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Subject: [PATCH 5/7] ARM: S3C64XX: Add s3c64xx support to touchscreen driver
Date: Mon, 8 Mar 2010 19:38:59 +0100
Message-ID: <b2e8f9f71003081038v5096204dm8bb4bfaeadb3203d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Cc: Ben Dooks <ben-linux@fluff.org>
List-Id: linux-input@vger.kernel.org

This ack's the extra interrupt s3c64xx platforms have in the touchscreen driver.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 drivers/input/touchscreen/Kconfig      |    6 +++---
 drivers/input/touchscreen/s3c2410_ts.c |   26 ++++++++++++++++++++++----
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig
b/drivers/input/touchscreen/Kconfig
index dfafc76..0378b3d 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -146,11 +146,11 @@ config TOUCHSCREEN_FUJITSU
 	  module will be called fujitsu-ts.

 config TOUCHSCREEN_S3C2410
-	tristate "Samsung S3C2410 touchscreen input driver"
-	depends on ARCH_S3C2410
+	tristate "Samsung S3C touchscreen input driver"
+	depends on ARCH_S3C2410 || ARCH_S3C64XX
 	select S3C24XX_ADC
 	help
-	  Say Y here if you have the s3c2410 touchscreen.
+	  Say Y here if you have the s3c touchscreen.

 	  If unsure, say N.

diff --git a/drivers/input/touchscreen/s3c2410_ts.c
b/drivers/input/touchscreen/s3c2410_ts.c
index 0cd0ca6..04c990e 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -40,7 +40,9 @@
 #include <plat/regs-adc.h>
 #include <plat/ts.h>

+#ifdef PLAT_S3C24XX
 #include <mach/regs-gpio.h>
+#endif

 #define TSC_SLEEP  (S3C2410_ADCTSC_PULL_UP_DISABLE | S3C2410_ADCTSC_XY_PST(0))

@@ -88,6 +90,12 @@ struct s3c2410ts {

 static struct s3c2410ts ts;

+enum s3c_cpu_type {
+	TYPE_S3C2410,
+	TYPE_S3C2440,
+	TYPE_S3C64XX,
+};
+
 /**
  * s3c2410_ts_connect - configure gpio for s3c2410 systems
  *
@@ -97,10 +105,12 @@ static struct s3c2410ts ts;
 */
 static inline void s3c2410_ts_connect(void)
 {
+#ifdef PLAT_S3C24XX
 	s3c2410_gpio_cfgpin(S3C2410_GPG(12), S3C2410_GPG12_XMON);
 	s3c2410_gpio_cfgpin(S3C2410_GPG(13), S3C2410_GPG13_nXPON);
 	s3c2410_gpio_cfgpin(S3C2410_GPG(14), S3C2410_GPG14_YMON);
 	s3c2410_gpio_cfgpin(S3C2410_GPG(15), S3C2410_GPG15_nYPON);
+#endif
 }

 /**
@@ -169,6 +179,7 @@ static DEFINE_TIMER(touch_timer, touch_timer_fire, 0, 0);
  */
 static irqreturn_t stylus_irq(int irq, void *dev_id)
 {
+	struct platform_device *pdev = to_platform_device(ts.dev);
 	unsigned long data0;
 	unsigned long data1;
 	bool down;
@@ -187,6 +198,12 @@ static irqreturn_t stylus_irq(int irq, void *dev_id)
 	else
 		dev_info(ts.dev, "%s: count=%d\n", __func__, ts.count);

+
+	if (platform_get_device_id(pdev)->driver_data == TYPE_S3C64XX) {
+		/* Clear pen down/up interrupt */
+		writel(0x0, ts.io + S3C64XX_ADCCLRINTPNDNUP);
+	}
+
 	return IRQ_HANDLED;
 }

@@ -296,7 +313,7 @@ static int __devinit s3c2410ts_probe(struct
platform_device *pdev)
 	}

 	/* Configure the touchscreen external FETs on the S3C2410 */
-	if (!platform_get_device_id(pdev)->driver_data)
+	if (platform_get_device_id(pdev)->driver_data == TYPE_S3C2410)
 		s3c2410_ts_connect();

 	ts.client = s3c_adc_register(pdev, s3c24xx_ts_select,
@@ -418,15 +435,16 @@ static struct dev_pm_ops s3c_ts_pmops = {
 #endif

 static struct platform_device_id s3cts_driver_ids[] = {
-	{ "s3c2410-ts", 0 },
-	{ "s3c2440-ts", 1 },
+	{ "s3c2410-ts", TYPE_S3C2410 },
+	{ "s3c2440-ts", TYPE_S3C2440 },
+	{ "s3c64xx-ts", TYPE_S3C64XX },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, s3cts_driver_ids);

 static struct platform_driver s3c_ts_driver = {
 	.driver         = {
-		.name   = "s3c24xx-ts",
+		.name   = "s3c-ts",
 		.owner  = THIS_MODULE,
 #ifdef CONFIG_PM
 		.pm	= &s3c_ts_pmops,
-- 
1.7.0.1
