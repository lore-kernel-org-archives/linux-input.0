From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] gpio fixup domain
Date: Tue, 29 Jan 2019 14:35:33 +0100
Message-ID: <20190129133545.1931-3-brgl@bgdev.pl>
References: <20190129133545.1931-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190129133545.1931-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

---
 arch/arm/boot/dts/am335x-bone-common.dtsi |   4 +
 drivers/gpio/gpio-max77650.c              | 138 +++++++++++++++++++++-
 2 files changed, 136 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 62f7f2ac191c..320b4c21fdf3 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -276,6 +276,10 @@
 
 			gpio-controller;
 			#gpio-cells = <2>;
+
+			interrupt-parent = <&pmic>;
+			interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-names = "GPI";
 		};
 
 		leds {
diff --git a/drivers/gpio/gpio-max77650.c b/drivers/gpio/gpio-max77650.c
index 3f03f4e8956c..03a5a2ed07f8 100644
--- a/drivers/gpio/gpio-max77650.c
+++ b/drivers/gpio/gpio-max77650.c
@@ -9,6 +9,7 @@
 #include <linux/i2c.h>
 #include <linux/mfd/max77650.h>
 #include <linux/module.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
@@ -34,7 +35,8 @@
 struct max77650_gpio_chip {
 	struct regmap *map;
 	struct gpio_chip gc;
-	int irq;
+	struct fwnode_handle *fwnode;
+	struct irq_domain *domain;
 };
 
 static int max77650_gpio_direction_input(struct gpio_chip *gc,
@@ -130,20 +132,114 @@ static int max77650_gpio_set_config(struct gpio_chip *gc,
 	}
 }
 
+static struct irq_chip max77650_gpio_irq_chip = {
+	.name = "max77650-gpio",
+	.irq_ack = irq_chip_ack_parent,
+	.irq_mask = irq_chip_mask_parent,
+	.irq_unmask = irq_chip_unmask_parent,
+	.irq_set_type = irq_chip_set_type_parent,
+};
+
+static int max77650_gpio_irq_domain_activate(struct irq_domain *domain,
+					     struct irq_data *data,
+					     bool reserve)
+{
+	struct max77650_gpio_chip *chip = domain->host_data;
+
+	return gpiochip_lock_as_irq(&chip->gc, data->hwirq);
+}
+
+static void max77650_gpio_irq_domain_deactivate(struct irq_domain *domain,
+						struct irq_data *data)
+{
+	struct max77650_gpio_chip *chip = domain->host_data;
+
+	return gpiochip_unlock_as_irq(&chip->gc, data->hwirq);
+}
+
+static int max77650_gpio_domain_translate(struct irq_domain *domain,
+					  struct irq_fwspec *fwspec,
+					  unsigned long *hwirq,
+					  unsigned int *type)
+{
+	struct max77650_gpio_chip *chip = domain->host_data;
+
+	if (fwspec->param_count != 2 || fwspec->param[0] >= chip->gc.ngpio)
+		return -EINVAL;
+
+	*hwirq = fwspec->param[0];
+	*type = fwspec->param[1];
+
+	return 0;
+}
+
+static int max77650_gpio_domain_alloc(struct irq_domain *domain,
+				      unsigned int virq,
+				      unsigned int nr_irqs, void *data)
+{
+	struct max77650_gpio_chip *chip = domain->host_data;
+	struct irq_fwspec *fwspec = data;
+	struct irq_fwspec parent_fwspec;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int ret;
+
+	if (nr_irqs != 1)
+		return -EINVAL;
+
+	ret = max77650_gpio_domain_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	irq_domain_set_info(domain, virq, hwirq,
+			    &max77650_gpio_irq_chip, chip,
+			    handle_level_irq, NULL, NULL);
+
+	parent_fwspec.fwnode = domain->parent->fwnode;
+	parent_fwspec.param_count = 4;
+	parent_fwspec.param[0] = 0;
+	parent_fwspec.param[1] = hwirq;
+	parent_fwspec.param[2] = 0;
+	parent_fwspec.param[3] = fwspec->param[1];
+
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
+					    &parent_fwspec);
+
+	return 0;
+}
+
+static const struct irq_domain_ops max77650_gpio_irq_domain_ops = {
+	.activate = max77650_gpio_irq_domain_activate,
+	.deactivate = max77650_gpio_irq_domain_deactivate,
+	.alloc = max77650_gpio_domain_alloc,
+	.free = irq_domain_free_irqs_common,
+	.translate = max77650_gpio_domain_translate,
+};
+
 static int max77650_gpio_to_irq(struct gpio_chip *gc, unsigned int offset)
 {
 	struct max77650_gpio_chip *chip = gpiochip_get_data(gc);
+	struct irq_fwspec fwspec;
+
+	fwspec.fwnode = chip->fwnode;
+	fwspec.param_count = 2;
+	fwspec.param[0] = 0;
+	fwspec.param[1] = IRQ_TYPE_LEVEL_LOW;
 
-	return chip->irq;
+	return irq_create_fwspec_mapping(&fwspec);
 }
 
 static int max77650_gpio_probe(struct platform_device *pdev)
 {
+	struct device_node *of_node, *parent_node;
+	struct irq_domain *parent_domain;
 	struct max77650_gpio_chip *chip;
 	struct device *dev, *parent;
 	struct i2c_client *i2c;
+	int rv;
 
 	dev = &pdev->dev;
+	of_node = dev->of_node;
 	parent = dev->parent;
 	i2c = to_i2c_client(parent);
 
@@ -151,13 +247,29 @@ static int max77650_gpio_probe(struct platform_device *pdev)
 	if (!chip)
 		return -ENOMEM;
 
+	chip->fwnode = dev->fwnode;
+	platform_set_drvdata(pdev, chip);
+
 	chip->map = dev_get_regmap(parent, NULL);
 	if (!chip->map)
 		return -ENODEV;
 
-	chip->irq = platform_get_irq_byname(pdev, "GPI");
-	if (chip->irq < 0)
-		return chip->irq;
+	parent_node = of_irq_find_parent(of_node);
+	if (!parent_node)
+		return -ENXIO;
+
+	parent_domain = irq_find_host(parent_node);
+	of_node_put(parent_node);
+	if (!parent_domain)
+		return -ENXIO;
+
+	chip->fwnode = of_node_to_fwnode(of_node);
+	chip->domain = irq_domain_create_hierarchy(parent_domain, 0, 1,
+						chip->fwnode,
+						&max77650_gpio_irq_domain_ops,
+						chip);
+	if (!chip->domain)
+		return -ENODEV;
 
 	chip->gc.base = -1;
 	chip->gc.ngpio = 1;
@@ -174,7 +286,20 @@ static int max77650_gpio_probe(struct platform_device *pdev)
 	chip->gc.set_config = max77650_gpio_set_config;
 	chip->gc.to_irq = max77650_gpio_to_irq;
 
-	return devm_gpiochip_add_data(dev, &chip->gc, chip);
+	rv = devm_gpiochip_add_data(dev, &chip->gc, chip);
+	if (rv)
+		irq_domain_remove(chip->domain);
+
+	return rv;
+}
+
+static int max77650_gpio_remove(struct platform_device *pdev)
+{
+	struct max77650_gpio_chip *chip = platform_get_drvdata(pdev);
+
+	irq_domain_remove(chip->domain);
+
+	return 0;
 }
 
 static struct platform_driver max77650_gpio_driver = {
@@ -182,6 +307,7 @@ static struct platform_driver max77650_gpio_driver = {
 		.name = "max77650-gpio",
 	},
 	.probe = max77650_gpio_probe,
+	.remove = max77650_gpio_remove,
 };
 module_platform_driver(max77650_gpio_driver);
 
-- 
2.20.1
