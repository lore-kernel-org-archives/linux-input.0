From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH v3 08/17] gpio: locomo: implement per-pin irq handling
Date: Sun, 17 May 2015 19:27:48 +0300
Message-ID: <1431880077-26321-9-git-send-email-dbaryshkov@gmail.com>
References: <1431880077-26321-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1431880077-26321-1-git-send-email-dbaryshkov@gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-input@vger.kernel.org

LoCoMo has a possibility to generate per-GPIO edge irqs. Support for
that was there in old locomo driver, got 'cleaned up' during old driver
IRQ cascading cleanup and is now reimplemented. It is expected that
SL-5500 (collie) will use locomo gpio irqs for mmc detection irq.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/Kconfig       |   1 +
 drivers/gpio/gpio-locomo.c | 117 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 4542684..6b77614 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -737,6 +737,7 @@ config GPIO_KEMPLD
 config GPIO_LOCOMO
 	bool "Sharp LoCoMo GPIO support"
 	depends on MFD_LOCOMO
+	select GPIOLIB_IRQCHIP
 	help
 	  Select this to support GPIO pins on Sharp LoCoMo Grid Array found
 	  in Sharp Zaurus collie and poodle models.
diff --git a/drivers/gpio/gpio-locomo.c b/drivers/gpio/gpio-locomo.c
index dd9a1ca..75dbf6b 100644
--- a/drivers/gpio/gpio-locomo.c
+++ b/drivers/gpio/gpio-locomo.c
@@ -16,13 +16,15 @@
 #include <linux/slab.h>
 #include <linux/bitops.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/io.h>
+#include <linux/irq.h>
 #include <linux/regmap.h>
 #include <linux/mfd/locomo.h>
 
 struct locomo_gpio {
 	struct regmap *regmap;
+	int irq;
 
 	struct gpio_chip gpio;
 
@@ -79,6 +81,99 @@ static int locomo_gpio_direction_output(struct gpio_chip *chip,
 	return 0;
 }
 
+static void
+locomo_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
+{
+	struct gpio_chip *chip = irq_get_handler_data(irq);
+	struct locomo_gpio *lg = container_of(chip, struct locomo_gpio, gpio);
+	struct irq_chip *irqchip = irq_desc_get_chip(desc);
+	unsigned int gir;
+	unsigned int gpd;
+	unsigned int req;
+
+	chained_irq_enter(irqchip, desc);
+
+	while (1) {
+		regmap_read(lg->regmap, LOCOMO_GIR, &gir);
+		regmap_read(lg->regmap, LOCOMO_GPD, &gpd);
+		req = gir & gpd;
+
+		if (!req)
+			break;
+
+		generic_handle_irq(irq_find_mapping(lg->gpio.irqdomain,
+					ffs(req) - 1));
+	}
+
+	chained_irq_exit(irqchip, desc);
+}
+
+static void locomo_gpio_ack_irq(struct irq_data *d)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	struct locomo_gpio *lg = container_of(chip, struct locomo_gpio, gpio);
+	unsigned int mask = BIT(d->hwirq);
+
+	regmap_update_bits(lg->regmap, LOCOMO_GWE, mask, mask);
+	regmap_update_bits(lg->regmap, LOCOMO_GIS, mask, 0);
+	regmap_update_bits(lg->regmap, LOCOMO_GWE, mask, 0);
+}
+
+static void locomo_gpio_mask_irq(struct irq_data *d)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	struct locomo_gpio *lg = container_of(chip, struct locomo_gpio, gpio);
+	unsigned int mask = BIT(d->hwirq);
+
+	regmap_update_bits(lg->regmap, LOCOMO_GIE, mask, 0);
+}
+
+static void locomo_gpio_unmask_irq(struct irq_data *d)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	struct locomo_gpio *lg = container_of(chip, struct locomo_gpio, gpio);
+	unsigned int mask = BIT(d->hwirq);
+
+	regmap_update_bits(lg->regmap, LOCOMO_GIE, mask, mask);
+}
+
+static int locomo_gpio_type_irq(struct irq_data *d, unsigned int type)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	struct locomo_gpio *lg = container_of(chip, struct locomo_gpio, gpio);
+	unsigned int mask;
+
+	mask = BIT(d->hwirq);
+
+	if (type == IRQ_TYPE_PROBE) {
+		if ((lg->rising_edge | lg->falling_edge) & mask)
+			return 0;
+		type = IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING;
+	}
+
+	if (type & IRQ_TYPE_EDGE_RISING)
+		lg->rising_edge |= mask;
+	else
+		lg->rising_edge &= ~mask;
+	if (type & IRQ_TYPE_EDGE_FALLING)
+		lg->falling_edge |= mask;
+	else
+		lg->falling_edge &= ~mask;
+
+	regmap_write(lg->regmap, LOCOMO_GRIE, lg->rising_edge);
+	regmap_write(lg->regmap, LOCOMO_GFIE, lg->falling_edge);
+
+	return 0;
+}
+
+static struct irq_chip locomo_gpio_irq_chip = {
+	.name		= "locomo-GPIO",
+	.irq_ack	= locomo_gpio_ack_irq,
+	.irq_mask	= locomo_gpio_mask_irq,
+	.irq_unmask	= locomo_gpio_unmask_irq,
+	.irq_set_type	= locomo_gpio_type_irq,
+};
+
 #ifdef CONFIG_PM_SLEEP
 static int locomo_gpio_suspend(struct device *dev)
 {
@@ -119,6 +214,10 @@ static int locomo_gpio_probe(struct platform_device *pdev)
 	if (!lg)
 		return -ENOMEM;
 
+	lg->irq = platform_get_irq(pdev, 0);
+	if (lg->irq < 0)
+		return -ENXIO;
+
 	lg->regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!lg->regmap)
 		return -EINVAL;
@@ -130,6 +229,7 @@ static int locomo_gpio_probe(struct platform_device *pdev)
 	regmap_write(lg->regmap, LOCOMO_GPD, 0x00);
 	regmap_write(lg->regmap, LOCOMO_GIE, 0x00);
 
+	lg->gpio.dev = &pdev->dev;
 	lg->gpio.base = pdata ? pdata->gpio_base : -1;
 	lg->gpio.label = "locomo-gpio";
 	lg->gpio.ngpio = 16;
@@ -142,7 +242,22 @@ static int locomo_gpio_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = gpiochip_irqchip_add(&lg->gpio, &locomo_gpio_irq_chip, 0,
+				   handle_level_irq, IRQ_TYPE_NONE);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to add irq chip\n");
+		goto err_rm_gpiochip;
+	}
+
+	gpiochip_set_chained_irqchip(&lg->gpio, &locomo_gpio_irq_chip, lg->irq,
+				     locomo_gpio_irq_handler);
+
 	return 0;
+
+err_rm_gpiochip:
+	gpiochip_remove(&lg->gpio);
+
+	return ret;
 }
 
 static int locomo_gpio_remove(struct platform_device *pdev)
-- 
2.1.4
