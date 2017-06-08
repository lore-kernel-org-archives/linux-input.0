From: Jianhong Chen <chenjh@rock-chips.com>
Subject: [PATCH v6 08/12] gpio: Add GPIO driver for the RK805 PMIC
Date: Thu,  8 Jun 2017 15:30:01 +0800
Message-ID: <1496907001-27107-1-git-send-email-chenjh@rock-chips.com>
References: <1496905959-29202-1-git-send-email-chenjh@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1496905959-29202-1-git-send-email-chenjh@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gnurou@gmail.com, linus.walleij@linaro.org, dmitry.torokhov@gmail.com
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, huangtao@rock-chips.com, tony.xie@rock-chips.com, zhangqing@rock-chips.com, devicetree@vger.kernel.org, w.egorov@phytec.de, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, chenjh <chenjh@rock-chips.com>
List-Id: linux-input@vger.kernel.org

From: chenjh <chenjh@rock-chips.com>

RK805 has two configurable GPIOs that can be used for several
purposes. These are output only.

This driver is generic for other Rockchip PMICs to be added.

Signed-off-by: chenjh <chenjh@rock-chips.com>
---
 drivers/gpio/Kconfig      |   6 ++
 drivers/gpio/Makefile     |   1 +
 drivers/gpio/gpio-rk805.c | 234 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 241 insertions(+)
 create mode 100644 drivers/gpio/gpio-rk805.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 0504307..c8cca89 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -974,6 +974,12 @@ config GPIO_RC5T583
 	  This driver provides the support for driving/reading the gpio pins
 	  of RC5T583 device through standard gpio library.
 
+config GPIO_RK805
+	bool "Rockchip RK805 GPIO"
+	depends on MFD_RK808
+	help
+	  Select this option to enable GPIO driver for the RK805 PMIC.
+
 config GPIO_STMPE
 	bool "STMPE GPIOs"
 	depends on MFD_STMPE
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index becb96c..55ba941 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -99,6 +99,7 @@ obj-$(CONFIG_GPIO_PXA)		+= gpio-pxa.o
 obj-$(CONFIG_GPIO_RC5T583)	+= gpio-rc5t583.o
 obj-$(CONFIG_GPIO_RDC321X)	+= gpio-rdc321x.o
 obj-$(CONFIG_GPIO_RCAR)		+= gpio-rcar.o
+obj-$(CONFIG_GPIO_RK805)	+= gpio-rk805.o
 obj-$(CONFIG_ARCH_SA1100)	+= gpio-sa1100.o
 obj-$(CONFIG_GPIO_SCH)		+= gpio-sch.o
 obj-$(CONFIG_GPIO_SCH311X)	+= gpio-sch311x.o
diff --git a/drivers/gpio/gpio-rk805.c b/drivers/gpio/gpio-rk805.c
new file mode 100644
index 0000000..bc17c92
--- /dev/null
+++ b/drivers/gpio/gpio-rk805.c
@@ -0,0 +1,234 @@
+/*
+ * GPIO driver for Rockchip RK805 PMIC
+ *
+ * Copyright (c) 2017, Fuzhou Rockchip Electronics Co., Ltd
+ *
+ * Author: Chen Jianhong <chenjh@rock-chips.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under  the terms of the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * Based on the TPS65218 driver
+ */
+
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/mfd/rk808.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+/* rk805 */
+#define RK805_OUT_REG		0x52
+#define RK805_OUT1_VAL_MSK	BIT(0)
+#define RK805_OUT2_VAL_MSK	BIT(1)
+
+#define OUTPUT_MODE		BIT(0)
+#define INPUT_MODE		BIT(1)
+
+/*
+ * @mode: supported modes for this gpio, i.e. OUTPUT_MODE, OUTPUT_MODE...
+ * @reg: gpio status setting register
+ * @func_mask: functions select mask value
+ * @dir_mask: input or output mask value
+ * @val_mask: gpio set value
+ */
+struct gpio_pin {
+	u8 mode;
+	u8 reg;
+	u8 func_mask;
+	u8 dir_msk;
+	u8 val_msk;
+};
+
+struct rk805_gpio {
+	struct device *dev;
+	struct gpio_chip chip;
+	struct gpio_pin *pins;
+	struct rk808 *rk808;
+};
+
+static int rk805_gpio_direction_input(struct gpio_chip *chip,
+				      unsigned offset)
+{
+	int ret;
+	struct rk805_gpio *gpio = gpiochip_get_data(chip);
+
+	if (!(gpio->pins[offset].mode & INPUT_MODE)) {
+		dev_err(gpio->dev, "gpio%d not support input mode\n", offset);
+		return -EINVAL;
+	}
+
+	if (gpio->pins[offset].dir_msk) {
+		ret = regmap_update_bits(gpio->rk808->regmap,
+					 gpio->pins[offset].reg,
+					 gpio->pins[offset].dir_msk, 0);
+		if (ret) {
+			dev_err(gpio->dev, "set gpio%d input failed\n", offset);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int rk805_gpio_direction_output(struct gpio_chip *chip,
+				       unsigned offset, int value)
+{
+	int ret;
+	struct rk805_gpio *gpio = gpiochip_get_data(chip);
+
+	if (!(gpio->pins[offset].mode & OUTPUT_MODE)) {
+		dev_err(gpio->dev, "gpio%d not support output mode\n", offset);
+		return -EINVAL;
+	}
+
+	if (gpio->pins[offset].dir_msk) {
+		ret = regmap_update_bits(gpio->rk808->regmap,
+					 gpio->pins[offset].reg,
+					 gpio->pins[offset].dir_msk,
+					 gpio->pins[offset].dir_msk);
+		if (ret) {
+			dev_err(gpio->dev, "set gpio%d out failed\n", offset);
+			return ret;
+		}
+	}
+
+	ret = regmap_update_bits(gpio->rk808->regmap,
+				 gpio->pins[offset].reg,
+				 gpio->pins[offset].val_msk,
+				 value ? gpio->pins[offset].val_msk : 0);
+	if (ret) {
+		dev_err(gpio->dev, "set gpio%d value failed\n", offset);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int rk805_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	int ret, val;
+	struct rk805_gpio *gpio = gpiochip_get_data(chip);
+
+	ret = regmap_read(gpio->rk808->regmap, gpio->pins[offset].reg, &val);
+	if (ret) {
+		dev_err(gpio->dev, "gpio%d not support output mode\n", offset);
+		return ret;
+	}
+
+	return (val & gpio->pins[offset].val_msk) ? 1 : 0;
+}
+
+static void rk805_gpio_set(struct gpio_chip *chip, unsigned offset,
+			   int value)
+{
+	struct rk805_gpio *gpio = gpiochip_get_data(chip);
+
+	if (!(gpio->pins[offset].mode & OUTPUT_MODE)) {
+		dev_err(gpio->dev, "gpio%d not support output mode\n", offset);
+		return;
+	}
+
+	regmap_update_bits(gpio->rk808->regmap,
+			   gpio->pins[offset].reg,
+			   gpio->pins[offset].val_msk,
+			   value ? gpio->pins[offset].val_msk : 0);
+}
+
+static int rk805_gpio_request(struct gpio_chip *chip, unsigned offset)
+{
+	int ret;
+	struct rk805_gpio *gpio = gpiochip_get_data(chip);
+
+	/* switch to gpio mode */
+	if (gpio->pins[offset].func_mask) {
+		ret = regmap_update_bits(gpio->rk808->regmap,
+					 gpio->pins[offset].reg,
+					 gpio->pins[offset].func_mask,
+					 gpio->pins[offset].func_mask);
+		if (ret) {
+			dev_err(gpio->dev, "set gpio%d func failed\n", offset);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct gpio_chip rk805_chip = {
+	.label			= "rk805-gpio",
+	.owner			= THIS_MODULE,
+	.direction_input	= rk805_gpio_direction_input,
+	.direction_output	= rk805_gpio_direction_output,
+	.get			= rk805_gpio_get,
+	.set			= rk805_gpio_set,
+	.request		= rk805_gpio_request,
+	.base			= -1,
+	.ngpio			= 2,
+	.can_sleep		= true,
+};
+
+static struct gpio_pin rk805_gpio_pins[] = {
+	{
+		.mode = OUTPUT_MODE,
+		.reg = RK805_OUT_REG,
+		.val_msk = RK805_OUT1_VAL_MSK,
+	},
+	{
+		.mode = OUTPUT_MODE,
+		.reg = RK805_OUT_REG,
+		.val_msk = RK805_OUT2_VAL_MSK,
+	},
+};
+
+static int rk805_gpio_probe(struct platform_device *pdev)
+{
+	struct rk808 *rk808 = dev_get_drvdata(pdev->dev.parent);
+	struct i2c_client *client = rk808->i2c;
+	struct rk805_gpio *gpio;
+	int ret;
+
+	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
+	if (!gpio)
+		return -ENOMEM;
+
+	switch (rk808->variant) {
+	case RK805_ID:
+		gpio->chip = rk805_chip;
+		gpio->pins = rk805_gpio_pins;
+		break;
+	default:
+		dev_err(&pdev->dev, "unsupported RK8XX ID %lu\n",
+			rk808->variant);
+		return -EINVAL;
+	}
+
+	gpio->chip.parent = &client->dev;
+	gpio->rk808 = rk808;
+	gpio->dev = &pdev->dev;
+
+	ret = devm_gpiochip_add_data(&pdev->dev, &gpio->chip, gpio);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not register gpiochip, %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, gpio);
+
+	return 0;
+}
+
+static struct platform_driver rk805_gpio_driver = {
+	.probe = rk805_gpio_probe,
+	.driver = {
+		.name = "rk805-gpio",
+	},
+};
+module_platform_driver(rk805_gpio_driver);
+
+MODULE_AUTHOR("Chen Jianghong <chenjh@rock-chips.com>");
+MODULE_DESCRIPTION("Rockchip RK805 PMIC GPIO driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
