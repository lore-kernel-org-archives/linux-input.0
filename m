From: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 14/15] gpio: locomo: implement per-pin irq handling
Date: Tue, 28 Oct 2014 03:02:07 +0300
Message-ID: <1414454528-24240-15-git-send-email-dbaryshkov@gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1414454528-24240-1-git-send-email-dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

LoCoMo has a possibility to generate per-GPIO edge irqs. Support for
that was there in old locomo driver, got 'cleaned up' during old driver
IRQ cascading cleanup and is now reimplemented. It is expected that
SL-5500 (collie) will use locomo gpio irqs for mmc detection irq.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/gpio/gpio-locomo.c | 158 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/drivers/gpio/gpio-locomo.c b/drivers/gpio/gpio-locomo.c
index 3b54b07..6ef0fc4 100644
--- a/drivers/gpio/gpio-locomo.c
+++ b/drivers/gpio/gpio-locomo.c
@@ -18,13 +18,18 @@
 #include <linux/gpio.h>
 #include <linux/io.h>
 #include <linux/spinlock.h>
+#include <linux/irq.h>
 #include <linux/mfd/locomo.h>
 
+#define LOCOMO_GPIO_NR_IRQS 16
+
 struct locomo_gpio {
 	void __iomem *regs;
+	int irq;
 
 	spinlock_t lock;
 	struct gpio_chip gpio;
+	int irq_base;
 
 	u16 rising_edge;
 	u16 falling_edge;
@@ -114,6 +119,148 @@ static int locomo_gpio_direction_output(struct gpio_chip *chip,
 	return 0;
 }
 
+static int locomo_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	struct locomo_gpio *lg = container_of(chip, struct locomo_gpio, gpio);
+
+	return lg->irq_base + offset;
+}
+
+static void
+locomo_gpio_handler(unsigned int irq, struct irq_desc *desc)
+{
+	u16 req;
+	struct locomo_gpio *lg = irq_get_handler_data(irq);
+	int i = lg->irq_base;
+
+	req = readw(lg->regs + LOCOMO_GIR) &
+	      readw(lg->regs + LOCOMO_GPD);
+
+	while (req) {
+		if (req & 1)
+			generic_handle_irq(i);
+		req >>= 1;
+		i++;
+	}
+}
+
+static void locomo_gpio_ack_irq(struct irq_data *d)
+{
+	struct locomo_gpio *lg = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
+	u16 r;
+
+	spin_lock_irqsave(&lg->lock, flags);
+
+	r = readw(lg->regs + LOCOMO_GWE);
+	r |= (0x0001 << (d->irq - lg->irq_base));
+	writew(r, lg->regs + LOCOMO_GWE);
+
+	r = readw(lg->regs + LOCOMO_GIS);
+	r &= ~(0x0001 << (d->irq - lg->irq_base));
+	writew(r, lg->regs + LOCOMO_GIS);
+
+	r = readw(lg->regs + LOCOMO_GWE);
+	r &= ~(0x0001 << (d->irq - lg->irq_base));
+	writew(r, lg->regs + LOCOMO_GWE);
+
+	spin_unlock_irqrestore(&lg->lock, flags);
+}
+
+static void locomo_gpio_mask_irq(struct irq_data *d)
+{
+	struct locomo_gpio *lg = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
+	u16 r;
+
+	spin_lock_irqsave(&lg->lock, flags);
+
+	r = readw(lg->regs + LOCOMO_GIE);
+	r &= ~(0x0001 << (d->irq - lg->irq_base));
+	writew(r, lg->regs + LOCOMO_GIE);
+
+	spin_unlock_irqrestore(&lg->lock, flags);
+}
+
+static void locomo_gpio_unmask_irq(struct irq_data *d)
+{
+	struct locomo_gpio *lg = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
+	u16 r;
+
+	spin_lock_irqsave(&lg->lock, flags);
+
+	r = readw(lg->regs + LOCOMO_GIE);
+	r |= (0x0001 << (d->irq - lg->irq_base));
+	writew(r, lg->regs + LOCOMO_GIE);
+
+	spin_unlock_irqrestore(&lg->lock, flags);
+}
+
+static int locomo_gpio_type(struct irq_data *d, unsigned int type)
+{
+	unsigned int mask;
+	struct locomo_gpio *lg = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
+
+	mask = 1 << (d->irq - lg->irq_base);
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
+	spin_lock_irqsave(&lg->lock, flags);
+
+	writew(lg->rising_edge, lg->regs + LOCOMO_GRIE);
+	writew(lg->falling_edge, lg->regs + LOCOMO_GFIE);
+
+	spin_unlock_irqrestore(&lg->lock, flags);
+
+	return 0;
+}
+
+static struct irq_chip locomo_gpio_chip = {
+	.name		= "LOCOMO-gpio",
+	.irq_ack	= locomo_gpio_ack_irq,
+	.irq_mask	= locomo_gpio_mask_irq,
+	.irq_unmask	= locomo_gpio_unmask_irq,
+	.irq_set_type	= locomo_gpio_type,
+};
+
+static void locomo_gpio_setup_irq(struct locomo_gpio *lg)
+{
+	int irq;
+
+	lg->irq_base = irq_alloc_descs(-1, 0, LOCOMO_GPIO_NR_IRQS, -1);
+
+	/* Install handlers for IRQ_LOCOMO_* */
+	for (irq = lg->irq_base;
+			irq < lg->irq_base + LOCOMO_GPIO_NR_IRQS;
+			irq++) {
+		irq_set_chip_and_handler(irq, &locomo_gpio_chip,
+				handle_edge_irq);
+		irq_set_chip_data(irq, lg);
+		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+	}
+
+	/*
+	 * Install handler for IRQ_LOCOMO_HW.
+	 */
+	irq_set_handler_data(lg->irq, lg);
+	irq_set_chained_handler(lg->irq, locomo_gpio_handler);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int locomo_gpio_suspend(struct device *dev)
 {
@@ -169,6 +316,10 @@ static int locomo_gpio_probe(struct platform_device *pdev)
 	if (!lg)
 		return -ENOMEM;
 
+	lg->irq = platform_get_irq(pdev, 0);
+	if (lg->irq < 0)
+		return -ENXIO;
+
 	lg->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(lg->regs))
 		return PTR_ERR(lg->regs);
@@ -189,11 +340,14 @@ static int locomo_gpio_probe(struct platform_device *pdev)
 	lg->gpio.get = locomo_gpio_get;
 	lg->gpio.direction_input = locomo_gpio_direction_input;
 	lg->gpio.direction_output = locomo_gpio_direction_output;
+	lg->gpio.to_irq = locomo_gpio_to_irq;
 
 	ret = gpiochip_add(&lg->gpio);
 	if (ret)
 		return ret;
 
+	locomo_gpio_setup_irq(lg);
+
 	return 0;
 }
 
@@ -208,6 +362,10 @@ static int locomo_gpio_remove(struct platform_device *pdev)
 		return ret;
 	}
 
+	irq_set_chained_handler(lg->irq, NULL);
+	irq_set_handler_data(lg->irq, NULL);
+	irq_free_descs(lg->irq_base, LOCOMO_GPIO_NR_IRQS);
+
 	return 0;
 }
 
-- 
2.1.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
