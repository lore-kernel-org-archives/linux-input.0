From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH 03/15] leds: port locomo leds driver to new locomo core
Date: Tue, 28 Oct 2014 03:01:56 +0300
Message-ID: <1414454528-24240-4-git-send-email-dbaryshkov@gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Andrea Adami <andrea.adami@gmail.com>, Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: linux-input@vger.kernel.org

Adapt locomo leds driver to new locomo core setup.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/leds/Kconfig       |   1 -
 drivers/leds/leds-locomo.c | 104 +++++++++++++++++++++++++++------------------
 2 files changed, 62 insertions(+), 43 deletions(-)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index a210338..22ebf1c 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -69,7 +69,6 @@ config LEDS_LM3642
 config LEDS_LOCOMO
 	tristate "LED Support for Locomo device"
 	depends on LEDS_CLASS
-	depends on SHARP_LOCOMO
 	help
 	  This option enables support for the LEDs on Sharp Locomo.
 	  Zaurus models SL-5500 and SL-5600.
diff --git a/drivers/leds/leds-locomo.c b/drivers/leds/leds-locomo.c
index 80ba048..acb288f 100644
--- a/drivers/leds/leds-locomo.c
+++ b/drivers/leds/leds-locomo.c
@@ -11,87 +11,107 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/device.h>
+#include <linux/platform_device.h>
 #include <linux/leds.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/mfd/locomo.h>
 
-#include <mach/hardware.h>
-#include <asm/hardware/locomo.h>
+struct locomo_led {
+	struct led_classdev led;
+	void __iomem *reg;
+};
 
 static void locomoled_brightness_set(struct led_classdev *led_cdev,
-				enum led_brightness value, int offset)
+				enum led_brightness value)
 {
-	struct locomo_dev *locomo_dev = LOCOMO_DEV(led_cdev->dev->parent);
+	struct locomo_led *led = container_of(led_cdev, struct locomo_led, led);
 	unsigned long flags;
 
 	local_irq_save(flags);
 	if (value)
-		locomo_writel(LOCOMO_LPT_TOFH, locomo_dev->mapbase + offset);
+		writew(LOCOMO_LPT_TOFH, led->reg);
 	else
-		locomo_writel(LOCOMO_LPT_TOFL, locomo_dev->mapbase + offset);
+		writew(LOCOMO_LPT_TOFL, led->reg);
 	local_irq_restore(flags);
 }
 
-static void locomoled_brightness_set0(struct led_classdev *led_cdev,
-				enum led_brightness value)
+static int locomo_led_register(
+		struct locomo_led *led,
+		struct device *dev,
+		const char *name,
+		const char *trigger,
+		void __iomem *reg)
 {
-	locomoled_brightness_set(led_cdev, value, LOCOMO_LPT0);
+	led->led.name = name;
+	led->led.default_trigger = trigger;
+	led->led.brightness_set = locomoled_brightness_set;
+	led->reg = reg;
+
+	return led_classdev_register(dev, &led->led);
 }
 
-static void locomoled_brightness_set1(struct led_classdev *led_cdev,
-				enum led_brightness value)
+static int locomoled_probe(struct platform_device *pdev)
 {
-	locomoled_brightness_set(led_cdev, value, LOCOMO_LPT1);
-}
+	int ret;
+	struct resource *mem;
+	void __iomem *regs;
+	struct locomo_led *leds;
 
-static struct led_classdev locomo_led0 = {
-	.name			= "locomo:amber:charge",
-	.default_trigger	= "main-battery-charging",
-	.brightness_set		= locomoled_brightness_set0,
-};
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem)
+		return -EINVAL;
 
-static struct led_classdev locomo_led1 = {
-	.name			= "locomo:green:mail",
-	.default_trigger	= "nand-disk",
-	.brightness_set		= locomoled_brightness_set1,
-};
+	regs = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
 
-static int locomoled_probe(struct locomo_dev *ldev)
-{
-	int ret;
+	leds = devm_kzalloc(&pdev->dev, 2 * sizeof(*leds), GFP_KERNEL);
+	if (!leds)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, leds);
 
-	ret = led_classdev_register(&ldev->dev, &locomo_led0);
+	ret = locomo_led_register(leds,
+			&pdev->dev,
+			"locomo:amber:charge",
+			"main-battery-charging",
+			regs + LOCOMO_LPT0);
 	if (ret < 0)
 		return ret;
 
-	ret = led_classdev_register(&ldev->dev, &locomo_led1);
+	ret = locomo_led_register(leds + 1,
+			&pdev->dev,
+			"locomo:green:mail",
+			"nand-disk",
+			regs + LOCOMO_LPT1);
 	if (ret < 0)
-		led_classdev_unregister(&locomo_led0);
+		led_classdev_unregister(&leds[0].led);
 
 	return ret;
 }
 
-static int locomoled_remove(struct locomo_dev *dev)
+static int locomoled_remove(struct platform_device *pdev)
 {
-	led_classdev_unregister(&locomo_led0);
-	led_classdev_unregister(&locomo_led1);
+	struct locomo_led *leds = platform_get_drvdata(pdev);
+
+	led_classdev_unregister(&leds[0].led);
+	led_classdev_unregister(&leds[1].led);
+
 	return 0;
 }
 
-static struct locomo_driver locomoled_driver = {
-	.drv = {
-		.name = "locomoled"
+static struct platform_driver locomoled_driver = {
+	.driver = {
+		.name = "locomo-led"
 	},
-	.devid	= LOCOMO_DEVID_LED,
 	.probe	= locomoled_probe,
 	.remove	= locomoled_remove,
 };
 
-static int __init locomoled_init(void)
-{
-	return locomo_driver_register(&locomoled_driver);
-}
-module_init(locomoled_init);
+module_platform_driver(locomoled_driver);
 
 MODULE_AUTHOR("John Lenz <lenz@cs.wisc.edu>");
 MODULE_DESCRIPTION("Locomo LED driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:locomo-led");
-- 
2.1.1
