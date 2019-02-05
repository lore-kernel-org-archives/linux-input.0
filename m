From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v4 07/10] gpio: max77650: add GPIO support
Date: Tue,  5 Feb 2019 10:12:34 +0100
Message-ID: <20190205091237.6448-8-brgl@bgdev.pl>
References: <20190205091237.6448-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190205091237.6448-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add GPIO support for max77650 mfd device. This PMIC exposes a single
GPIO line.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/Kconfig         |   7 ++
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-max77650.c | 190 +++++++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+)
 create mode 100644 drivers/gpio/gpio-max77650.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b5a2845347ec..fb297fe5bfec 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1095,6 +1095,13 @@ config GPIO_MAX77620
 	  driver also provides interrupt support for each of the gpios.
 	  Say yes here to enable the max77620 to be used as gpio controller.
 
+config GPIO_MAX77650
+	tristate "Maxim MAX77650/77651 GPIO support"
+	depends on MFD_MAX77650
+	help
+	  GPIO driver for MAX77650/77651 PMIC from Maxim Semiconductor.
+	  These chips have a single pin that can be configured as GPIO.
+
 config GPIO_MSIC
 	bool "Intel MSIC mixed signal gpio support"
 	depends on (X86 || COMPILE_TEST) && MFD_INTEL_MSIC
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 37628f8dbf70..8bdad50db822 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -78,6 +78,7 @@ obj-$(CONFIG_GPIO_MAX7300)	+= gpio-max7300.o
 obj-$(CONFIG_GPIO_MAX7301)	+= gpio-max7301.o
 obj-$(CONFIG_GPIO_MAX732X)	+= gpio-max732x.o
 obj-$(CONFIG_GPIO_MAX77620)	+= gpio-max77620.o
+obj-$(CONFIG_GPIO_MAX77650)	+= gpio-max77650.o
 obj-$(CONFIG_GPIO_MB86S7X)	+= gpio-mb86s7x.o
 obj-$(CONFIG_GPIO_MENZ127)	+= gpio-menz127.o
 obj-$(CONFIG_GPIO_MERRIFIELD)	+= gpio-merrifield.o
diff --git a/drivers/gpio/gpio-max77650.c b/drivers/gpio/gpio-max77650.c
new file mode 100644
index 000000000000..3f03f4e8956c
--- /dev/null
+++ b/drivers/gpio/gpio-max77650.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2018 BayLibre SAS
+// Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
+//
+// GPIO driver for MAXIM 77650/77651 charger/power-supply.
+
+#include <linux/gpio/driver.h>
+#include <linux/i2c.h>
+#include <linux/mfd/max77650.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define MAX77650_GPIO_DIR_MASK		BIT(0)
+#define MAX77650_GPIO_INVAL_MASK	BIT(1)
+#define MAX77650_GPIO_DRV_MASK		BIT(2)
+#define MAX77650_GPIO_OUTVAL_MASK	BIT(3)
+#define MAX77650_GPIO_DEBOUNCE_MASK	BIT(4)
+
+#define MAX77650_GPIO_DIR_OUT		0x00
+#define MAX77650_GPIO_DIR_IN		BIT(0)
+#define MAX77650_GPIO_OUT_LOW		0x00
+#define MAX77650_GPIO_OUT_HIGH		BIT(3)
+#define MAX77650_GPIO_DRV_OPEN_DRAIN	0x00
+#define MAX77650_GPIO_DRV_PUSH_PULL	BIT(2)
+#define MAX77650_GPIO_DEBOUNCE		BIT(4)
+
+#define MAX77650_GPIO_DIR_BITS(_reg) \
+		((_reg) & MAX77650_GPIO_DIR_MASK)
+#define MAX77650_GPIO_INVAL_BITS(_reg) \
+		(((_reg) & MAX77650_GPIO_INVAL_MASK) >> 1)
+
+struct max77650_gpio_chip {
+	struct regmap *map;
+	struct gpio_chip gc;
+	int irq;
+};
+
+static int max77650_gpio_direction_input(struct gpio_chip *gc,
+					 unsigned int offset)
+{
+	struct max77650_gpio_chip *chip = gpiochip_get_data(gc);
+
+	return regmap_update_bits(chip->map,
+				  MAX77650_REG_CNFG_GPIO,
+				  MAX77650_GPIO_DIR_MASK,
+				  MAX77650_GPIO_DIR_IN);
+}
+
+static int max77650_gpio_direction_output(struct gpio_chip *gc,
+					  unsigned int offset, int value)
+{
+	struct max77650_gpio_chip *chip = gpiochip_get_data(gc);
+	int mask, regval;
+
+	mask = MAX77650_GPIO_DIR_MASK | MAX77650_GPIO_OUTVAL_MASK;
+	regval = value ? MAX77650_GPIO_OUT_HIGH : MAX77650_GPIO_OUT_LOW;
+	regval |= MAX77650_GPIO_DIR_OUT;
+
+	return regmap_update_bits(chip->map,
+				  MAX77650_REG_CNFG_GPIO, mask, regval);
+}
+
+static void max77650_gpio_set_value(struct gpio_chip *gc,
+				    unsigned int offset, int value)
+{
+	struct max77650_gpio_chip *chip = gpiochip_get_data(gc);
+	int rv, regval;
+
+	regval = value ? MAX77650_GPIO_OUT_HIGH : MAX77650_GPIO_OUT_LOW;
+
+	rv = regmap_update_bits(chip->map, MAX77650_REG_CNFG_GPIO,
+				MAX77650_GPIO_OUTVAL_MASK, regval);
+	if (rv)
+		dev_err(gc->parent, "cannot set GPIO value: %d\n", rv);
+}
+
+static int max77650_gpio_get_value(struct gpio_chip *gc,
+				   unsigned int offset)
+{
+	struct max77650_gpio_chip *chip = gpiochip_get_data(gc);
+	unsigned int val;
+	int rv;
+
+	rv = regmap_read(chip->map, MAX77650_REG_CNFG_GPIO, &val);
+	if (rv)
+		return rv;
+
+	return MAX77650_GPIO_INVAL_BITS(val);
+}
+
+static int max77650_gpio_get_direction(struct gpio_chip *gc,
+				       unsigned int offset)
+{
+	struct max77650_gpio_chip *chip = gpiochip_get_data(gc);
+	unsigned int val;
+	int rv;
+
+	rv = regmap_read(chip->map, MAX77650_REG_CNFG_GPIO, &val);
+	if (rv)
+		return rv;
+
+	return MAX77650_GPIO_DIR_BITS(val);
+}
+
+static int max77650_gpio_set_config(struct gpio_chip *gc,
+				    unsigned int offset, unsigned long cfg)
+{
+	struct max77650_gpio_chip *chip = gpiochip_get_data(gc);
+
+	switch (pinconf_to_config_param(cfg)) {
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		return regmap_update_bits(chip->map,
+					  MAX77650_REG_CNFG_GPIO,
+					  MAX77650_GPIO_DRV_MASK,
+					  MAX77650_GPIO_DRV_OPEN_DRAIN);
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		return regmap_update_bits(chip->map,
+					  MAX77650_REG_CNFG_GPIO,
+					  MAX77650_GPIO_DRV_MASK,
+					  MAX77650_GPIO_DRV_PUSH_PULL);
+	case PIN_CONFIG_INPUT_DEBOUNCE:
+		return regmap_update_bits(chip->map,
+					  MAX77650_REG_CNFG_GPIO,
+					  MAX77650_GPIO_DEBOUNCE_MASK,
+					  MAX77650_GPIO_DEBOUNCE);
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+static int max77650_gpio_to_irq(struct gpio_chip *gc, unsigned int offset)
+{
+	struct max77650_gpio_chip *chip = gpiochip_get_data(gc);
+
+	return chip->irq;
+}
+
+static int max77650_gpio_probe(struct platform_device *pdev)
+{
+	struct max77650_gpio_chip *chip;
+	struct device *dev, *parent;
+	struct i2c_client *i2c;
+
+	dev = &pdev->dev;
+	parent = dev->parent;
+	i2c = to_i2c_client(parent);
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->map = dev_get_regmap(parent, NULL);
+	if (!chip->map)
+		return -ENODEV;
+
+	chip->irq = platform_get_irq_byname(pdev, "GPI");
+	if (chip->irq < 0)
+		return chip->irq;
+
+	chip->gc.base = -1;
+	chip->gc.ngpio = 1;
+	chip->gc.label = i2c->name;
+	chip->gc.parent = dev;
+	chip->gc.owner = THIS_MODULE;
+	chip->gc.can_sleep = true;
+
+	chip->gc.direction_input = max77650_gpio_direction_input;
+	chip->gc.direction_output = max77650_gpio_direction_output;
+	chip->gc.set = max77650_gpio_set_value;
+	chip->gc.get = max77650_gpio_get_value;
+	chip->gc.get_direction = max77650_gpio_get_direction;
+	chip->gc.set_config = max77650_gpio_set_config;
+	chip->gc.to_irq = max77650_gpio_to_irq;
+
+	return devm_gpiochip_add_data(dev, &chip->gc, chip);
+}
+
+static struct platform_driver max77650_gpio_driver = {
+	.driver = {
+		.name = "max77650-gpio",
+	},
+	.probe = max77650_gpio_probe,
+};
+module_platform_driver(max77650_gpio_driver);
+
+MODULE_DESCRIPTION("MAXIM 77650/77651 GPIO driver");
+MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1
