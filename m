From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH v2 02/17] leds: port locomo leds driver to new locomo core
Date: Tue, 28 Apr 2015 02:55:39 +0300
Message-ID: <1430178954-11138-3-git-send-email-dbaryshkov@gmail.com>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-input@vger.kernel.org

Adapt locomo leds driver to new locomo core setup.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/leds/Kconfig       |   1 -
 drivers/leds/leds-locomo.c | 119 +++++++++++++++++++++++----------------------
 2 files changed, 61 insertions(+), 59 deletions(-)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 966b960..4b4650b 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -79,7 +79,6 @@ config LEDS_LM3642
 config LEDS_LOCOMO
 	tristate "LED Support for Locomo device"
 	depends on LEDS_CLASS
-	depends on SHARP_LOCOMO
 	help
 	  This option enables support for the LEDs on Sharp Locomo.
 	  Zaurus models SL-5500 and SL-5600.
diff --git a/drivers/leds/leds-locomo.c b/drivers/leds/leds-locomo.c
index 80ba048..7fde812 100644
--- a/drivers/leds/leds-locomo.c
+++ b/drivers/leds/leds-locomo.c
@@ -9,89 +9,92 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/device.h>
 #include <linux/leds.h>
-
-#include <mach/hardware.h>
-#include <asm/hardware/locomo.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/mfd/locomo.h>
+
+struct locomo_led {
+	struct led_classdev led;
+	struct regmap *regmap;
+	unsigned int reg;
+};
 
 static void locomoled_brightness_set(struct led_classdev *led_cdev,
-				enum led_brightness value, int offset)
+				enum led_brightness value)
 {
-	struct locomo_dev *locomo_dev = LOCOMO_DEV(led_cdev->dev->parent);
-	unsigned long flags;
+	struct locomo_led *led = container_of(led_cdev, struct locomo_led, led);
 
-	local_irq_save(flags);
-	if (value)
-		locomo_writel(LOCOMO_LPT_TOFH, locomo_dev->mapbase + offset);
-	else
-		locomo_writel(LOCOMO_LPT_TOFL, locomo_dev->mapbase + offset);
-	local_irq_restore(flags);
+	regmap_write(led->regmap, led->reg,
+			value ? LOCOMO_LPT_TOFH : LOCOMO_LPT_TOFL);
 }
 
-static void locomoled_brightness_set0(struct led_classdev *led_cdev,
-				enum led_brightness value)
+static int locomo_led_register(
+		struct device *dev,
+		struct locomo_led *led,
+		const char *name,
+		const char *trigger,
+		struct regmap *regmap,
+		unsigned int reg)
 {
-	locomoled_brightness_set(led_cdev, value, LOCOMO_LPT0);
+	led->led.name = name;
+	led->led.flags = LED_CORE_SUSPENDRESUME;
+	led->led.default_trigger = trigger;
+	led->led.brightness_set = locomoled_brightness_set;
+	led->regmap = regmap;
+	led->reg = reg;
+
+	return devm_led_classdev_register(dev, &led->led);
 }
 
-static void locomoled_brightness_set1(struct led_classdev *led_cdev,
-				enum led_brightness value)
-{
-	locomoled_brightness_set(led_cdev, value, LOCOMO_LPT1);
-}
-
-static struct led_classdev locomo_led0 = {
-	.name			= "locomo:amber:charge",
-	.default_trigger	= "main-battery-charging",
-	.brightness_set		= locomoled_brightness_set0,
-};
-
-static struct led_classdev locomo_led1 = {
-	.name			= "locomo:green:mail",
-	.default_trigger	= "nand-disk",
-	.brightness_set		= locomoled_brightness_set1,
-};
-
-static int locomoled_probe(struct locomo_dev *ldev)
+static int locomoled_probe(struct platform_device *pdev)
 {
 	int ret;
-
-	ret = led_classdev_register(&ldev->dev, &locomo_led0);
+	struct locomo_led *leds;
+	struct regmap *regmap;
+
+	leds = devm_kzalloc(&pdev->dev, 2 * sizeof(*leds), GFP_KERNEL);
+	if (!leds)
+		return -ENOMEM;
+
+	regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!regmap)
+		return -ENODEV;
+
+	ret = locomo_led_register(
+			&pdev->dev,
+			leds,
+			"locomo:amber:charge",
+			"main-battery-charging",
+			regmap,
+			LOCOMO_LPT0);
 	if (ret < 0)
 		return ret;
 
-	ret = led_classdev_register(&ldev->dev, &locomo_led1);
+	ret = locomo_led_register(
+			&pdev->dev,
+			leds + 1,
+			"locomo:green:mail",
+			"mmc0",
+			regmap,
+			LOCOMO_LPT1);
 	if (ret < 0)
-		led_classdev_unregister(&locomo_led0);
-
-	return ret;
-}
+		return ret;
 
-static int locomoled_remove(struct locomo_dev *dev)
-{
-	led_classdev_unregister(&locomo_led0);
-	led_classdev_unregister(&locomo_led1);
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
-	.remove	= locomoled_remove,
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
2.1.4

