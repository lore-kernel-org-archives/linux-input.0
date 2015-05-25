From: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 09/18] gpio: locomo: implement per-pin irq handling
Date: Mon, 25 May 2015 14:41:44 +0300
Message-ID: <1432554113-26280-10-git-send-email-dbaryshkov@gmail.com>
References: <1432554113-26280-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432554113-26280-1-git-send-email-dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: linux-input@vger.kernel.org

LoCoMo has a possibility to generate per-GPIO edge irqs. Support for
that was there in old locomo driver, got 'cleaned up' during old driver
IRQ cascading cleanup and is now reimplemented. It is expected that
SL-5500 (collie) will use locomo gpio irqs for mmc detection irq.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Reviewed-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
