From: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 08/18] gpio: port LoCoMo gpio support from old driver
Date: Mon, 25 May 2015 14:41:43 +0300
Message-ID: <1432554113-26280-9-git-send-email-dbaryshkov@gmail.com>
References: <1432554113-26280-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432554113-26280-1-git-send-email-dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: linux-input@vger.kernel.org

Add gpiolib driver for gpio pins placed on the LoCoMo GA.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Reviewed-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/gpio/Kconfig       |  12 ++++
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-locomo.c | 170 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 183 insertions(+)
 create mode 100644 drivers/gpio/gpio-locomo.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index caefe80..4542684 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -734,6 +734,18 @@ config GPIO_KEMPLD
 	  This driver can also be built as a module. If so, the module will be
 	  called gpio-kempld.
 
+config GPIO_LOCOMO
+	bool "Sharp LoCoMo GPIO support"
+	depends on MFD_LOCOMO
+	help
+	  Select this to support GPIO pins on Sharp LoCoMo Grid Array found
+	  in Sharp Zaurus collie and poodle models.
+
+	  Sat Yes if you have such PDA, say No otherwise.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called gpio-locomo.
+
 config GPIO_LP3943
 	tristate "TI/National Semiconductor LP3943 GPIO expander"
 	depends on MFD_LP3943
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index f71bb97..98655ae 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_GPIO_JANZ_TTL)	+= gpio-janz-ttl.o
 obj-$(CONFIG_GPIO_KEMPLD)	+= gpio-kempld.o
 obj-$(CONFIG_ARCH_KS8695)	+= gpio-ks8695.o
 obj-$(CONFIG_GPIO_INTEL_MID)	+= gpio-intel-mid.o
+obj-$(CONFIG_GPIO_LOCOMO)	+= gpio-locomo.o
 obj-$(CONFIG_GPIO_LOONGSON)	+= gpio-loongson.o
 obj-$(CONFIG_GPIO_LP3943)	+= gpio-lp3943.o
 obj-$(CONFIG_ARCH_LPC32XX)	+= gpio-lpc32xx.o
diff --git a/drivers/gpio/gpio-locomo.c b/drivers/gpio/gpio-locomo.c
new file mode 100644
index 0000000..dd9a1ca
--- /dev/null
+++ b/drivers/gpio/gpio-locomo.c
@@ -0,0 +1,170 @@
+/*
+ * Sharp LoCoMo support for GPIO
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This file contains all generic LoCoMo support.
+ *
+ * All initialization functions provided here are intended to be called
+ * from machine specific code with proper arguments when required.
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/regmap.h>
+#include <linux/mfd/locomo.h>
+
+struct locomo_gpio {
+	struct regmap *regmap;
+
+	struct gpio_chip gpio;
+
+	u16 rising_edge;
+	u16 falling_edge;
+
+	unsigned int save_gpo;
+	unsigned int save_gpe;
+};
+
+static int locomo_gpio_get(struct gpio_chip *chip,
+		unsigned offset)
+{
+	struct locomo_gpio *lg = container_of(chip, struct locomo_gpio, gpio);
+	unsigned int gpl;
+
+	regmap_read(lg->regmap, LOCOMO_GPL, &gpl);
+
+	return gpl & BIT(offset);
+}
+
+static void locomo_gpio_set(struct gpio_chip *chip,
+		unsigned offset, int value)
+{
+	struct locomo_gpio *lg = container_of(chip, struct locomo_gpio, gpio);
+
+	regmap_update_bits(lg->regmap, LOCOMO_GPO,
+			BIT(offset),
+			value ? BIT(offset) : 0);
+}
+
+static int locomo_gpio_direction_input(struct gpio_chip *chip,
+			unsigned offset)
+{
+	struct locomo_gpio *lg = container_of(chip, struct locomo_gpio, gpio);
+
+	regmap_update_bits(lg->regmap, LOCOMO_GPD, BIT(offset), BIT(offset));
+	regmap_update_bits(lg->regmap, LOCOMO_GPE, BIT(offset), BIT(offset));
+
+	return 0;
+}
+
+static int locomo_gpio_direction_output(struct gpio_chip *chip,
+			unsigned offset, int value)
+{
+	struct locomo_gpio *lg = container_of(chip, struct locomo_gpio, gpio);
+
+	regmap_update_bits(lg->regmap, LOCOMO_GPO,
+			BIT(offset),
+			value ? BIT(offset) : 0);
+	regmap_update_bits(lg->regmap, LOCOMO_GPD, BIT(offset), 0);
+	regmap_update_bits(lg->regmap, LOCOMO_GPE, BIT(offset), 0);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int locomo_gpio_suspend(struct device *dev)
+{
+	struct locomo_gpio *lg = dev_get_drvdata(dev);
+
+	regmap_read(lg->regmap, LOCOMO_GPO, &lg->save_gpo);
+	regmap_write(lg->regmap, LOCOMO_GPO, 0x00);
+	regmap_read(lg->regmap, LOCOMO_GPE, &lg->save_gpe);
+	regmap_write(lg->regmap, LOCOMO_GPE, 0x00);
+
+	return 0;
+}
+
+static int locomo_gpio_resume(struct device *dev)
+{
+	struct locomo_gpio *lg = dev_get_drvdata(dev);
+
+	regmap_write(lg->regmap, LOCOMO_GPO, lg->save_gpo);
+	regmap_write(lg->regmap, LOCOMO_GPE, lg->save_gpe);
+
+	return 0;
+}
+static SIMPLE_DEV_PM_OPS(locomo_gpio_pm,
+		locomo_gpio_suspend, locomo_gpio_resume);
+#define LOCOMO_GPIO_PM	(&locomo_gpio_pm)
+#else
+#define LOCOMO_GPIO_PM	NULL
+#endif
+
+static int locomo_gpio_probe(struct platform_device *pdev)
+{
+	struct locomo_gpio *lg;
+	int ret;
+	struct locomo_gpio_platform_data *pdata = dev_get_platdata(&pdev->dev);
+
+	lg = devm_kzalloc(&pdev->dev, sizeof(struct locomo_gpio),
+			GFP_KERNEL);
+	if (!lg)
+		return -ENOMEM;
+
+	lg->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!lg->regmap)
+		return -EINVAL;
+
+	platform_set_drvdata(pdev, lg);
+
+	regmap_write(lg->regmap, LOCOMO_GPO, 0x00);
+	regmap_write(lg->regmap, LOCOMO_GPE, 0x00);
+	regmap_write(lg->regmap, LOCOMO_GPD, 0x00);
+	regmap_write(lg->regmap, LOCOMO_GIE, 0x00);
+
+	lg->gpio.base = pdata ? pdata->gpio_base : -1;
+	lg->gpio.label = "locomo-gpio";
+	lg->gpio.ngpio = 16;
+	lg->gpio.set = locomo_gpio_set;
+	lg->gpio.get = locomo_gpio_get;
+	lg->gpio.direction_input = locomo_gpio_direction_input;
+	lg->gpio.direction_output = locomo_gpio_direction_output;
+
+	ret = gpiochip_add(&lg->gpio);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int locomo_gpio_remove(struct platform_device *pdev)
+{
+	struct locomo_gpio *lg = platform_get_drvdata(pdev);
+
+	gpiochip_remove(&lg->gpio);
+
+	return 0;
+}
+
+static struct platform_driver locomo_gpio_driver = {
+	.probe		= locomo_gpio_probe,
+	.remove		= locomo_gpio_remove,
+	.driver		= {
+		.name	= "locomo-gpio",
+		.pm	= LOCOMO_GPIO_PM,
+	},
+};
+module_platform_driver(locomo_gpio_driver);
+
+MODULE_DESCRIPTION("Sharp LoCoMo GPIO driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("John Lenz <lenz-hcNo3dDEHLuVc3sceRu5cw@public.gmane.org>");
+MODULE_ALIAS("platform:locomo-gpio");
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
