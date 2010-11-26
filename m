From: Sundar Iyer <sundar.iyer@stericsson.com>
Subject: [PATCH] mfd/tc35892: rename tc35892 to tc3589x
Date: Fri, 26 Nov 2010 20:41:37 +0530
Message-ID: <1290784297-31827-1-git-send-email-sundar.iyer@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:52923 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754893Ab0KZPL4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Nov 2010 10:11:56 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ken.lierman@windriver.com
Cc: dmitry.torokhov@gmail.com, alan@linux.intel.com, linus.walleij@stericsson.com, rabin.vincent@stericsson.com, linux-input@vger.kernel.org, sundar.iyer@stericsson.com

Add support for plugging TC3589x devices into the existing
TC35892 MFD driver.

Signed-off-by: Sundar Iyer <sundar.iyer@stericsson.com>
---
 drivers/gpio/Kconfig        |    8 +-
 drivers/gpio/Makefile       |    2 +-
 drivers/gpio/tc35892-gpio.c |  389 ------------------------------------
 drivers/gpio/tc3589x-gpio.c |  381 +++++++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig         |    6 +-
 drivers/mfd/Makefile        |    2 +-
 drivers/mfd/tc35892.c       |  345 --------------------------------
 drivers/mfd/tc3589x.c       |  465 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/tc35892.h |  136 -------------
 include/linux/mfd/tc3589x.h |  192 ++++++++++++++++++
 10 files changed, 1047 insertions(+), 879 deletions(-)
 delete mode 100644 drivers/gpio/tc35892-gpio.c
 create mode 100644 drivers/gpio/tc3589x-gpio.c
 delete mode 100644 drivers/mfd/tc35892.c
 create mode 100644 drivers/mfd/tc3589x.c
 delete mode 100644 include/linux/mfd/tc35892.h
 create mode 100644 include/linux/mfd/tc3589x.h

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 3143ac7..9e32b2b 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -230,11 +230,11 @@ config GPIO_STMPE
 	  This enables support for the GPIOs found on the STMPE I/O
 	  Expanders.
 
-config GPIO_TC35892
-	bool "TC35892 GPIOs"
-	depends on MFD_TC35892
+config GPIO_TC3589X
+	bool "TC3589X GPIOs"
+	depends on MFD_TC3589X
 	help
-	  This enables support for the GPIOs found on the TC35892
+	  This enables support for the GPIOs found on the TC35892/3
 	  I/O Expander.
 
 config GPIO_TWL4030
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index bdf3dde..39bfd7a 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -24,7 +24,7 @@ obj-$(CONFIG_GPIO_PCF857X)	+= pcf857x.o
 obj-$(CONFIG_GPIO_PCH)		+= pch_gpio.o
 obj-$(CONFIG_GPIO_PL061)	+= pl061.o
 obj-$(CONFIG_GPIO_STMPE)	+= stmpe-gpio.o
-obj-$(CONFIG_GPIO_TC35892)	+= tc35892-gpio.o
+obj-$(CONFIG_GPIO_TC3589X)	+= tc3589x-gpio.o
 obj-$(CONFIG_GPIO_TIMBERDALE)	+= timbgpio.o
 obj-$(CONFIG_GPIO_TWL4030)	+= twl4030-gpio.o
 obj-$(CONFIG_GPIO_UCB1400)	+= ucb1400_gpio.o
diff --git a/drivers/gpio/tc35892-gpio.c b/drivers/gpio/tc35892-gpio.c
deleted file mode 100644
index 7e10c93..0000000
--- a/drivers/gpio/tc35892-gpio.c
+++ /dev/null
@@ -1,389 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * License Terms: GNU General Public License, version 2
- * Author: Hanumath Prasad <hanumath.prasad@stericsson.com> for ST-Ericsson
- * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/gpio.h>
-#include <linux/irq.h>
-#include <linux/interrupt.h>
-#include <linux/mfd/tc35892.h>
-
-/*
- * These registers are modified under the irq bus lock and cached to avoid
- * unnecessary writes in bus_sync_unlock.
- */
-enum { REG_IBE, REG_IEV, REG_IS, REG_IE };
-
-#define CACHE_NR_REGS	4
-#define CACHE_NR_BANKS	3
-
-struct tc35892_gpio {
-	struct gpio_chip chip;
-	struct tc35892 *tc35892;
-	struct device *dev;
-	struct mutex irq_lock;
-
-	int irq_base;
-
-	/* Caches of interrupt control registers for bus_lock */
-	u8 regs[CACHE_NR_REGS][CACHE_NR_BANKS];
-	u8 oldregs[CACHE_NR_REGS][CACHE_NR_BANKS];
-};
-
-static inline struct tc35892_gpio *to_tc35892_gpio(struct gpio_chip *chip)
-{
-	return container_of(chip, struct tc35892_gpio, chip);
-}
-
-static int tc35892_gpio_get(struct gpio_chip *chip, unsigned offset)
-{
-	struct tc35892_gpio *tc35892_gpio = to_tc35892_gpio(chip);
-	struct tc35892 *tc35892 = tc35892_gpio->tc35892;
-	u8 reg = TC35892_GPIODATA0 + (offset / 8) * 2;
-	u8 mask = 1 << (offset % 8);
-	int ret;
-
-	ret = tc35892_reg_read(tc35892, reg);
-	if (ret < 0)
-		return ret;
-
-	return ret & mask;
-}
-
-static void tc35892_gpio_set(struct gpio_chip *chip, unsigned offset, int val)
-{
-	struct tc35892_gpio *tc35892_gpio = to_tc35892_gpio(chip);
-	struct tc35892 *tc35892 = tc35892_gpio->tc35892;
-	u8 reg = TC35892_GPIODATA0 + (offset / 8) * 2;
-	unsigned pos = offset % 8;
-	u8 data[] = {!!val << pos, 1 << pos};
-
-	tc35892_block_write(tc35892, reg, ARRAY_SIZE(data), data);
-}
-
-static int tc35892_gpio_direction_output(struct gpio_chip *chip,
-					 unsigned offset, int val)
-{
-	struct tc35892_gpio *tc35892_gpio = to_tc35892_gpio(chip);
-	struct tc35892 *tc35892 = tc35892_gpio->tc35892;
-	u8 reg = TC35892_GPIODIR0 + offset / 8;
-	unsigned pos = offset % 8;
-
-	tc35892_gpio_set(chip, offset, val);
-
-	return tc35892_set_bits(tc35892, reg, 1 << pos, 1 << pos);
-}
-
-static int tc35892_gpio_direction_input(struct gpio_chip *chip,
-					unsigned offset)
-{
-	struct tc35892_gpio *tc35892_gpio = to_tc35892_gpio(chip);
-	struct tc35892 *tc35892 = tc35892_gpio->tc35892;
-	u8 reg = TC35892_GPIODIR0 + offset / 8;
-	unsigned pos = offset % 8;
-
-	return tc35892_set_bits(tc35892, reg, 1 << pos, 0);
-}
-
-static int tc35892_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
-{
-	struct tc35892_gpio *tc35892_gpio = to_tc35892_gpio(chip);
-
-	return tc35892_gpio->irq_base + offset;
-}
-
-static struct gpio_chip template_chip = {
-	.label			= "tc35892",
-	.owner			= THIS_MODULE,
-	.direction_input	= tc35892_gpio_direction_input,
-	.get			= tc35892_gpio_get,
-	.direction_output	= tc35892_gpio_direction_output,
-	.set			= tc35892_gpio_set,
-	.to_irq			= tc35892_gpio_to_irq,
-	.can_sleep		= 1,
-};
-
-static int tc35892_gpio_irq_set_type(unsigned int irq, unsigned int type)
-{
-	struct tc35892_gpio *tc35892_gpio = get_irq_chip_data(irq);
-	int offset = irq - tc35892_gpio->irq_base;
-	int regoffset = offset / 8;
-	int mask = 1 << (offset % 8);
-
-	if (type == IRQ_TYPE_EDGE_BOTH) {
-		tc35892_gpio->regs[REG_IBE][regoffset] |= mask;
-		return 0;
-	}
-
-	tc35892_gpio->regs[REG_IBE][regoffset] &= ~mask;
-
-	if (type == IRQ_TYPE_LEVEL_LOW || type == IRQ_TYPE_LEVEL_HIGH)
-		tc35892_gpio->regs[REG_IS][regoffset] |= mask;
-	else
-		tc35892_gpio->regs[REG_IS][regoffset] &= ~mask;
-
-	if (type == IRQ_TYPE_EDGE_RISING || type == IRQ_TYPE_LEVEL_HIGH)
-		tc35892_gpio->regs[REG_IEV][regoffset] |= mask;
-	else
-		tc35892_gpio->regs[REG_IEV][regoffset] &= ~mask;
-
-	return 0;
-}
-
-static void tc35892_gpio_irq_lock(unsigned int irq)
-{
-	struct tc35892_gpio *tc35892_gpio = get_irq_chip_data(irq);
-
-	mutex_lock(&tc35892_gpio->irq_lock);
-}
-
-static void tc35892_gpio_irq_sync_unlock(unsigned int irq)
-{
-	struct tc35892_gpio *tc35892_gpio = get_irq_chip_data(irq);
-	struct tc35892 *tc35892 = tc35892_gpio->tc35892;
-	static const u8 regmap[] = {
-		[REG_IBE]	= TC35892_GPIOIBE0,
-		[REG_IEV]	= TC35892_GPIOIEV0,
-		[REG_IS]	= TC35892_GPIOIS0,
-		[REG_IE]	= TC35892_GPIOIE0,
-	};
-	int i, j;
-
-	for (i = 0; i < CACHE_NR_REGS; i++) {
-		for (j = 0; j < CACHE_NR_BANKS; j++) {
-			u8 old = tc35892_gpio->oldregs[i][j];
-			u8 new = tc35892_gpio->regs[i][j];
-
-			if (new == old)
-				continue;
-
-			tc35892_gpio->oldregs[i][j] = new;
-			tc35892_reg_write(tc35892, regmap[i] + j * 8, new);
-		}
-	}
-
-	mutex_unlock(&tc35892_gpio->irq_lock);
-}
-
-static void tc35892_gpio_irq_mask(unsigned int irq)
-{
-	struct tc35892_gpio *tc35892_gpio = get_irq_chip_data(irq);
-	int offset = irq - tc35892_gpio->irq_base;
-	int regoffset = offset / 8;
-	int mask = 1 << (offset % 8);
-
-	tc35892_gpio->regs[REG_IE][regoffset] &= ~mask;
-}
-
-static void tc35892_gpio_irq_unmask(unsigned int irq)
-{
-	struct tc35892_gpio *tc35892_gpio = get_irq_chip_data(irq);
-	int offset = irq - tc35892_gpio->irq_base;
-	int regoffset = offset / 8;
-	int mask = 1 << (offset % 8);
-
-	tc35892_gpio->regs[REG_IE][regoffset] |= mask;
-}
-
-static struct irq_chip tc35892_gpio_irq_chip = {
-	.name			= "tc35892-gpio",
-	.bus_lock		= tc35892_gpio_irq_lock,
-	.bus_sync_unlock	= tc35892_gpio_irq_sync_unlock,
-	.mask			= tc35892_gpio_irq_mask,
-	.unmask			= tc35892_gpio_irq_unmask,
-	.set_type		= tc35892_gpio_irq_set_type,
-};
-
-static irqreturn_t tc35892_gpio_irq(int irq, void *dev)
-{
-	struct tc35892_gpio *tc35892_gpio = dev;
-	struct tc35892 *tc35892 = tc35892_gpio->tc35892;
-	u8 status[CACHE_NR_BANKS];
-	int ret;
-	int i;
-
-	ret = tc35892_block_read(tc35892, TC35892_GPIOMIS0,
-				 ARRAY_SIZE(status), status);
-	if (ret < 0)
-		return IRQ_NONE;
-
-	for (i = 0; i < ARRAY_SIZE(status); i++) {
-		unsigned int stat = status[i];
-		if (!stat)
-			continue;
-
-		while (stat) {
-			int bit = __ffs(stat);
-			int line = i * 8 + bit;
-
-			handle_nested_irq(tc35892_gpio->irq_base + line);
-			stat &= ~(1 << bit);
-		}
-
-		tc35892_reg_write(tc35892, TC35892_GPIOIC0 + i, status[i]);
-	}
-
-	return IRQ_HANDLED;
-}
-
-static int tc35892_gpio_irq_init(struct tc35892_gpio *tc35892_gpio)
-{
-	int base = tc35892_gpio->irq_base;
-	int irq;
-
-	for (irq = base; irq < base + tc35892_gpio->chip.ngpio; irq++) {
-		set_irq_chip_data(irq, tc35892_gpio);
-		set_irq_chip_and_handler(irq, &tc35892_gpio_irq_chip,
-					 handle_simple_irq);
-		set_irq_nested_thread(irq, 1);
-#ifdef CONFIG_ARM
-		set_irq_flags(irq, IRQF_VALID);
-#else
-		set_irq_noprobe(irq);
-#endif
-	}
-
-	return 0;
-}
-
-static void tc35892_gpio_irq_remove(struct tc35892_gpio *tc35892_gpio)
-{
-	int base = tc35892_gpio->irq_base;
-	int irq;
-
-	for (irq = base; irq < base + tc35892_gpio->chip.ngpio; irq++) {
-#ifdef CONFIG_ARM
-		set_irq_flags(irq, 0);
-#endif
-		set_irq_chip_and_handler(irq, NULL, NULL);
-		set_irq_chip_data(irq, NULL);
-	}
-}
-
-static int __devinit tc35892_gpio_probe(struct platform_device *pdev)
-{
-	struct tc35892 *tc35892 = dev_get_drvdata(pdev->dev.parent);
-	struct tc35892_gpio_platform_data *pdata;
-	struct tc35892_gpio *tc35892_gpio;
-	int ret;
-	int irq;
-
-	pdata = tc35892->pdata->gpio;
-	if (!pdata)
-		return -ENODEV;
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
-	tc35892_gpio = kzalloc(sizeof(struct tc35892_gpio), GFP_KERNEL);
-	if (!tc35892_gpio)
-		return -ENOMEM;
-
-	mutex_init(&tc35892_gpio->irq_lock);
-
-	tc35892_gpio->dev = &pdev->dev;
-	tc35892_gpio->tc35892 = tc35892;
-
-	tc35892_gpio->chip = template_chip;
-	tc35892_gpio->chip.ngpio = tc35892->num_gpio;
-	tc35892_gpio->chip.dev = &pdev->dev;
-	tc35892_gpio->chip.base = pdata->gpio_base;
-
-	tc35892_gpio->irq_base = tc35892->irq_base + TC35892_INT_GPIO(0);
-
-	/* Bring the GPIO module out of reset */
-	ret = tc35892_set_bits(tc35892, TC35892_RSTCTRL,
-			       TC35892_RSTCTRL_GPIRST, 0);
-	if (ret < 0)
-		goto out_free;
-
-	ret = tc35892_gpio_irq_init(tc35892_gpio);
-	if (ret)
-		goto out_free;
-
-	ret = request_threaded_irq(irq, NULL, tc35892_gpio_irq, IRQF_ONESHOT,
-				   "tc35892-gpio", tc35892_gpio);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to get irq: %d\n", ret);
-		goto out_removeirq;
-	}
-
-	ret = gpiochip_add(&tc35892_gpio->chip);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to add gpiochip: %d\n", ret);
-		goto out_freeirq;
-	}
-
-	if (pdata->setup)
-		pdata->setup(tc35892, tc35892_gpio->chip.base);
-
-	platform_set_drvdata(pdev, tc35892_gpio);
-
-	return 0;
-
-out_freeirq:
-	free_irq(irq, tc35892_gpio);
-out_removeirq:
-	tc35892_gpio_irq_remove(tc35892_gpio);
-out_free:
-	kfree(tc35892_gpio);
-	return ret;
-}
-
-static int __devexit tc35892_gpio_remove(struct platform_device *pdev)
-{
-	struct tc35892_gpio *tc35892_gpio = platform_get_drvdata(pdev);
-	struct tc35892 *tc35892 = tc35892_gpio->tc35892;
-	struct tc35892_gpio_platform_data *pdata = tc35892->pdata->gpio;
-	int irq = platform_get_irq(pdev, 0);
-	int ret;
-
-	if (pdata->remove)
-		pdata->remove(tc35892, tc35892_gpio->chip.base);
-
-	ret = gpiochip_remove(&tc35892_gpio->chip);
-	if (ret < 0) {
-		dev_err(tc35892_gpio->dev,
-			"unable to remove gpiochip: %d\n", ret);
-		return ret;
-	}
-
-	free_irq(irq, tc35892_gpio);
-	tc35892_gpio_irq_remove(tc35892_gpio);
-
-	platform_set_drvdata(pdev, NULL);
-	kfree(tc35892_gpio);
-
-	return 0;
-}
-
-static struct platform_driver tc35892_gpio_driver = {
-	.driver.name	= "tc35892-gpio",
-	.driver.owner	= THIS_MODULE,
-	.probe		= tc35892_gpio_probe,
-	.remove		= __devexit_p(tc35892_gpio_remove),
-};
-
-static int __init tc35892_gpio_init(void)
-{
-	return platform_driver_register(&tc35892_gpio_driver);
-}
-subsys_initcall(tc35892_gpio_init);
-
-static void __exit tc35892_gpio_exit(void)
-{
-	platform_driver_unregister(&tc35892_gpio_driver);
-}
-module_exit(tc35892_gpio_exit);
-
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("TC35892 GPIO driver");
-MODULE_AUTHOR("Hanumath Prasad, Rabin Vincent");
diff --git a/drivers/gpio/tc3589x-gpio.c b/drivers/gpio/tc3589x-gpio.c
new file mode 100644
index 0000000..4c75970
--- /dev/null
+++ b/drivers/gpio/tc3589x-gpio.c
@@ -0,0 +1,381 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * License Terms: GNU General Public License, version 2
+ * Author: Hanumath Prasad <hanumath.prasad@stericsson.com> for ST-Ericsson
+ * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/gpio.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/tc3589x.h>
+
+/*
+ * These registers are modified under the irq bus lock and cached to avoid
+ * unnecessary writes in bus_sync_unlock.
+ */
+enum { REG_IBE, REG_IEV, REG_IS, REG_IE };
+
+#define CACHE_NR_REGS	4
+#define CACHE_NR_BANKS	3
+
+struct tc3589x_gpio {
+	struct gpio_chip chip;
+	struct tc3589x *tc3589x;
+	struct device *dev;
+	struct mutex irq_lock;
+
+	int irq_base;
+
+	/* Caches of interrupt control registers for bus_lock */
+	u8 regs[CACHE_NR_REGS][CACHE_NR_BANKS];
+	u8 oldregs[CACHE_NR_REGS][CACHE_NR_BANKS];
+};
+
+static inline struct tc3589x_gpio *to_tc3589x_gpio(struct gpio_chip *chip)
+{
+	return container_of(chip, struct tc3589x_gpio, chip);
+}
+
+static int tc3589x_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	struct tc3589x_gpio *tc3589x_gpio = to_tc3589x_gpio(chip);
+	struct tc3589x *tc3589x = tc3589x_gpio->tc3589x;
+	u8 reg = TC3589x_GPIODATA0 + (offset / 8) * 2;
+	u8 mask = 1 << (offset % 8);
+	int ret;
+
+	ret = tc3589x_reg_read(tc3589x, reg);
+	if (ret < 0)
+		return ret;
+
+	return ret & mask;
+}
+
+static void tc3589x_gpio_set(struct gpio_chip *chip, unsigned offset, int val)
+{
+	struct tc3589x_gpio *tc3589x_gpio = to_tc3589x_gpio(chip);
+	struct tc3589x *tc3589x = tc3589x_gpio->tc3589x;
+	u8 reg = TC3589x_GPIODATA0 + (offset / 8) * 2;
+	unsigned pos = offset % 8;
+	u8 data[] = {!!val << pos, 1 << pos};
+
+	tc3589x_block_write(tc3589x, reg, ARRAY_SIZE(data), data);
+}
+
+static int tc3589x_gpio_direction_output(struct gpio_chip *chip,
+					 unsigned offset, int val)
+{
+	struct tc3589x_gpio *tc3589x_gpio = to_tc3589x_gpio(chip);
+	struct tc3589x *tc3589x = tc3589x_gpio->tc3589x;
+	u8 reg = TC3589x_GPIODIR0 + offset / 8;
+	unsigned pos = offset % 8;
+
+	tc3589x_gpio_set(chip, offset, val);
+
+	return tc3589x_set_bits(tc3589x, reg, 1 << pos, 1 << pos);
+}
+
+static int tc3589x_gpio_direction_input(struct gpio_chip *chip,
+					unsigned offset)
+{
+	struct tc3589x_gpio *tc3589x_gpio = to_tc3589x_gpio(chip);
+	struct tc3589x *tc3589x = tc3589x_gpio->tc3589x;
+	u8 reg = TC3589x_GPIODIR0 + offset / 8;
+	unsigned pos = offset % 8;
+
+	return tc3589x_set_bits(tc3589x, reg, 1 << pos, 0);
+}
+
+static int tc3589x_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	struct tc3589x_gpio *tc3589x_gpio = to_tc3589x_gpio(chip);
+
+	return tc3589x_gpio->irq_base + offset;
+}
+
+static struct gpio_chip template_chip = {
+	.label			= "tc3589x",
+	.owner			= THIS_MODULE,
+	.direction_input	= tc3589x_gpio_direction_input,
+	.get			= tc3589x_gpio_get,
+	.direction_output	= tc3589x_gpio_direction_output,
+	.set			= tc3589x_gpio_set,
+	.to_irq			= tc3589x_gpio_to_irq,
+	.can_sleep		= 1,
+};
+
+static int tc3589x_gpio_irq_set_type(unsigned int irq, unsigned int type)
+{
+	struct tc3589x_gpio *tc3589x_gpio = get_irq_chip_data(irq);
+	int offset = irq - tc3589x_gpio->irq_base;
+	int regoffset = offset / 8;
+	int mask = 1 << (offset % 8);
+
+	if (type == IRQ_TYPE_EDGE_BOTH) {
+		tc3589x_gpio->regs[REG_IBE][regoffset] |= mask;
+		return 0;
+	}
+
+	tc3589x_gpio->regs[REG_IBE][regoffset] &= ~mask;
+
+	if (type == IRQ_TYPE_LEVEL_LOW || type == IRQ_TYPE_LEVEL_HIGH)
+		tc3589x_gpio->regs[REG_IS][regoffset] |= mask;
+	else
+		tc3589x_gpio->regs[REG_IS][regoffset] &= ~mask;
+
+	if (type == IRQ_TYPE_EDGE_RISING || type == IRQ_TYPE_LEVEL_HIGH)
+		tc3589x_gpio->regs[REG_IEV][regoffset] |= mask;
+	else
+		tc3589x_gpio->regs[REG_IEV][regoffset] &= ~mask;
+
+	return 0;
+}
+
+static void tc3589x_gpio_irq_lock(unsigned int irq)
+{
+	struct tc3589x_gpio *tc3589x_gpio = get_irq_chip_data(irq);
+
+	mutex_lock(&tc3589x_gpio->irq_lock);
+}
+
+static void tc3589x_gpio_irq_sync_unlock(unsigned int irq)
+{
+	struct tc3589x_gpio *tc3589x_gpio = get_irq_chip_data(irq);
+	struct tc3589x *tc3589x = tc3589x_gpio->tc3589x;
+	static const u8 regmap[] = {
+		[REG_IBE]	= TC3589x_GPIOIBE0,
+		[REG_IEV]	= TC3589x_GPIOIEV0,
+		[REG_IS]	= TC3589x_GPIOIS0,
+		[REG_IE]	= TC3589x_GPIOIE0,
+	};
+	int i, j;
+
+	for (i = 0; i < CACHE_NR_REGS; i++) {
+		for (j = 0; j < CACHE_NR_BANKS; j++) {
+			u8 old = tc3589x_gpio->oldregs[i][j];
+			u8 new = tc3589x_gpio->regs[i][j];
+
+			if (new == old)
+				continue;
+
+			tc3589x_gpio->oldregs[i][j] = new;
+			tc3589x_reg_write(tc3589x, regmap[i] + j * 8, new);
+		}
+	}
+
+	mutex_unlock(&tc3589x_gpio->irq_lock);
+}
+
+static void tc3589x_gpio_irq_mask(unsigned int irq)
+{
+	struct tc3589x_gpio *tc3589x_gpio = get_irq_chip_data(irq);
+	int offset = irq - tc3589x_gpio->irq_base;
+	int regoffset = offset / 8;
+	int mask = 1 << (offset % 8);
+
+	tc3589x_gpio->regs[REG_IE][regoffset] &= ~mask;
+}
+
+static void tc3589x_gpio_irq_unmask(unsigned int irq)
+{
+	struct tc3589x_gpio *tc3589x_gpio = get_irq_chip_data(irq);
+	int offset = irq - tc3589x_gpio->irq_base;
+	int regoffset = offset / 8;
+	int mask = 1 << (offset % 8);
+
+	tc3589x_gpio->regs[REG_IE][regoffset] |= mask;
+}
+
+static struct irq_chip tc3589x_gpio_irq_chip = {
+	.name			= "tc3589x-gpio",
+	.bus_lock		= tc3589x_gpio_irq_lock,
+	.bus_sync_unlock	= tc3589x_gpio_irq_sync_unlock,
+	.mask			= tc3589x_gpio_irq_mask,
+	.unmask			= tc3589x_gpio_irq_unmask,
+	.set_type		= tc3589x_gpio_irq_set_type,
+};
+
+static irqreturn_t tc3589x_gpio_irq(int irq, void *dev)
+{
+	struct tc3589x_gpio *tc3589x_gpio = dev;
+	struct tc3589x *tc3589x = tc3589x_gpio->tc3589x;
+	u8 status[CACHE_NR_BANKS];
+	int ret;
+	int i;
+
+	ret = tc3589x_block_read(tc3589x, TC3589x_GPIOMIS0,
+				 ARRAY_SIZE(status), status);
+	if (ret < 0)
+		return IRQ_NONE;
+
+	for (i = 0; i < ARRAY_SIZE(status); i++) {
+		unsigned int stat = status[i];
+		if (!stat)
+			continue;
+
+		while (stat) {
+			int bit = __ffs(stat);
+			int line = i * 8 + bit;
+
+			handle_nested_irq(tc3589x_gpio->irq_base + line);
+			stat &= ~(1 << bit);
+		}
+
+		tc3589x_reg_write(tc3589x, TC3589x_GPIOIC0 + i, status[i]);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int tc3589x_gpio_irq_init(struct tc3589x_gpio *tc3589x_gpio)
+{
+	int base = tc3589x_gpio->irq_base;
+	int irq;
+
+	for (irq = base; irq < base + tc3589x_gpio->chip.ngpio; irq++) {
+		set_irq_chip_data(irq, tc3589x_gpio);
+		set_irq_chip_and_handler(irq, &tc3589x_gpio_irq_chip,
+					 handle_simple_irq);
+		set_irq_nested_thread(irq, 1);
+#ifdef CONFIG_ARM
+		set_irq_flags(irq, IRQF_VALID);
+#else
+		set_irq_noprobe(irq);
+#endif
+	}
+
+	return 0;
+}
+
+static void tc3589x_gpio_irq_remove(struct tc3589x_gpio *tc3589x_gpio)
+{
+	int base = tc3589x_gpio->irq_base;
+	int irq;
+
+	for (irq = base; irq < base + tc3589x_gpio->chip.ngpio; irq++) {
+#ifdef CONFIG_ARM
+		set_irq_flags(irq, 0);
+#endif
+		set_irq_chip_and_handler(irq, NULL, NULL);
+		set_irq_chip_data(irq, NULL);
+	}
+}
+
+static int __devinit tc3589x_gpio_probe(struct platform_device *pdev)
+{
+	struct tc3589x *tc3589x = dev_get_drvdata(pdev->dev.parent);
+	struct tc3589x_gpio_platform_data *pdata;
+	struct tc3589x_gpio *tc3589x_gpio;
+	int ret;
+	int irq;
+
+	pdata = tc3589x->pdata->gpio;
+	if (!pdata)
+		return -ENODEV;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	tc3589x_gpio = kzalloc(sizeof(struct tc3589x_gpio), GFP_KERNEL);
+	if (!tc3589x_gpio)
+		return -ENOMEM;
+
+	mutex_init(&tc3589x_gpio->irq_lock);
+
+	tc3589x_gpio->dev = &pdev->dev;
+	tc3589x_gpio->tc3589x = tc3589x;
+
+	tc3589x_gpio->chip = template_chip;
+	tc3589x_gpio->chip.ngpio = tc3589x->num_gpio;
+	tc3589x_gpio->chip.dev = &pdev->dev;
+	tc3589x_gpio->chip.base = pdata->gpio_base;
+
+	tc3589x_gpio->irq_base = tc3589x->irq_base + TC3589x_INT_GPIO(0);
+
+	/* Bring the GPIO module out of reset */
+	ret = tc3589x_set_bits(tc3589x, TC3589x_RSTCTRL,
+			       TC3589x_RSTCTRL_GPIRST, 0);
+	if (ret < 0)
+		goto out_free;
+
+	ret = tc3589x_gpio_irq_init(tc3589x_gpio);
+	if (ret)
+		goto out_free;
+
+	ret = request_threaded_irq(irq, NULL, tc3589x_gpio_irq, IRQF_ONESHOT,
+				   "tc3589x-gpio", tc3589x_gpio);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to get irq: %d\n", ret);
+		goto out_removeirq;
+	}
+
+	ret = gpiochip_add(&tc3589x_gpio->chip);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to add gpiochip: %d\n", ret);
+		goto out_freeirq;
+	}
+
+	platform_set_drvdata(pdev, tc3589x_gpio);
+
+	return 0;
+
+out_freeirq:
+	free_irq(irq, tc3589x_gpio);
+out_removeirq:
+	tc3589x_gpio_irq_remove(tc3589x_gpio);
+out_free:
+	kfree(tc3589x_gpio);
+	return ret;
+}
+
+static int __devexit tc3589x_gpio_remove(struct platform_device *pdev)
+{
+	struct tc3589x_gpio *tc3589x_gpio = platform_get_drvdata(pdev);
+	int irq = platform_get_irq(pdev, 0);
+	int ret;
+
+	ret = gpiochip_remove(&tc3589x_gpio->chip);
+	if (ret < 0) {
+		dev_err(tc3589x_gpio->dev,
+			"unable to remove gpiochip: %d\n", ret);
+		return ret;
+	}
+
+	free_irq(irq, tc3589x_gpio);
+	tc3589x_gpio_irq_remove(tc3589x_gpio);
+
+	platform_set_drvdata(pdev, NULL);
+	kfree(tc3589x_gpio);
+
+	return 0;
+}
+
+static struct platform_driver tc3589x_gpio_driver = {
+	.driver.name	= "tc3589x-gpio",
+	.driver.owner	= THIS_MODULE,
+	.probe		= tc3589x_gpio_probe,
+	.remove		= __devexit_p(tc3589x_gpio_remove),
+};
+
+static int __init tc3589x_gpio_init(void)
+{
+	return platform_driver_register(&tc3589x_gpio_driver);
+}
+subsys_initcall(tc3589x_gpio_init);
+
+static void __exit tc3589x_gpio_exit(void)
+{
+	platform_driver_unregister(&tc3589x_gpio_driver);
+}
+module_exit(tc3589x_gpio_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("TC3589x GPIO driver");
+MODULE_AUTHOR("Hanumath Prasad, Rabin Vincent");
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 57a8eee..5faeb4e 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -218,12 +218,12 @@ config MFD_STMPE
 		Keypad: stmpe-keypad
 		Touchscreen: stmpe-ts
 
-config MFD_TC35892
-	bool "Support Toshiba TC35892"
+config MFD_TC3589X
+	bool "Support Toshiba TC35892/3"
 	depends on I2C=y && GENERIC_HARDIRQS
 	select MFD_CORE
 	help
-	  Support for the Toshiba TC35892 I/O Expander.
+	  Support for the Toshiba TC35892/3 I/O Expander.
 
 	  This driver provides common support for accessing the device,
 	  additional drivers must be enabled in order to use the
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 741ccfd..4aacb41 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_MFD_DAVINCI_VOICECODEC)	+= davinci_voicecodec.o
 obj-$(CONFIG_MFD_DM355EVM_MSP)	+= dm355evm_msp.o
 
 obj-$(CONFIG_MFD_STMPE)		+= stmpe.o
-obj-$(CONFIG_MFD_TC35892)	+= tc35892.o
+obj-$(CONFIG_MFD_TC3589X)	+= tc3589x.o
 obj-$(CONFIG_MFD_T7L66XB)	+= t7l66xb.o tmio_core.o
 obj-$(CONFIG_MFD_TC6387XB)	+= tc6387xb.o tmio_core.o
 obj-$(CONFIG_MFD_TC6393XB)	+= tc6393xb.o tmio_core.o
diff --git a/drivers/mfd/tc35892.c b/drivers/mfd/tc35892.c
deleted file mode 100644
index e619e2a..0000000
--- a/drivers/mfd/tc35892.c
+++ /dev/null
@@ -1,345 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * License Terms: GNU General Public License, version 2
- * Author: Hanumath Prasad <hanumath.prasad@stericsson.com> for ST-Ericsson
- * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
- */
-
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/slab.h>
-#include <linux/i2c.h>
-#include <linux/mfd/core.h>
-#include <linux/mfd/tc35892.h>
-
-/**
- * tc35892_reg_read() - read a single TC35892 register
- * @tc35892:	Device to read from
- * @reg:	Register to read
- */
-int tc35892_reg_read(struct tc35892 *tc35892, u8 reg)
-{
-	int ret;
-
-	ret = i2c_smbus_read_byte_data(tc35892->i2c, reg);
-	if (ret < 0)
-		dev_err(tc35892->dev, "failed to read reg %#x: %d\n",
-			reg, ret);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(tc35892_reg_read);
-
-/**
- * tc35892_reg_read() - write a single TC35892 register
- * @tc35892:	Device to write to
- * @reg:	Register to read
- * @data:	Value to write
- */
-int tc35892_reg_write(struct tc35892 *tc35892, u8 reg, u8 data)
-{
-	int ret;
-
-	ret = i2c_smbus_write_byte_data(tc35892->i2c, reg, data);
-	if (ret < 0)
-		dev_err(tc35892->dev, "failed to write reg %#x: %d\n",
-			reg, ret);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(tc35892_reg_write);
-
-/**
- * tc35892_block_read() - read multiple TC35892 registers
- * @tc35892:	Device to read from
- * @reg:	First register
- * @length:	Number of registers
- * @values:	Buffer to write to
- */
-int tc35892_block_read(struct tc35892 *tc35892, u8 reg, u8 length, u8 *values)
-{
-	int ret;
-
-	ret = i2c_smbus_read_i2c_block_data(tc35892->i2c, reg, length, values);
-	if (ret < 0)
-		dev_err(tc35892->dev, "failed to read regs %#x: %d\n",
-			reg, ret);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(tc35892_block_read);
-
-/**
- * tc35892_block_write() - write multiple TC35892 registers
- * @tc35892:	Device to write to
- * @reg:	First register
- * @length:	Number of registers
- * @values:	Values to write
- */
-int tc35892_block_write(struct tc35892 *tc35892, u8 reg, u8 length,
-			const u8 *values)
-{
-	int ret;
-
-	ret = i2c_smbus_write_i2c_block_data(tc35892->i2c, reg, length,
-					     values);
-	if (ret < 0)
-		dev_err(tc35892->dev, "failed to write regs %#x: %d\n",
-			reg, ret);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(tc35892_block_write);
-
-/**
- * tc35892_set_bits() - set the value of a bitfield in a TC35892 register
- * @tc35892:	Device to write to
- * @reg:	Register to write
- * @mask:	Mask of bits to set
- * @values:	Value to set
- */
-int tc35892_set_bits(struct tc35892 *tc35892, u8 reg, u8 mask, u8 val)
-{
-	int ret;
-
-	mutex_lock(&tc35892->lock);
-
-	ret = tc35892_reg_read(tc35892, reg);
-	if (ret < 0)
-		goto out;
-
-	ret &= ~mask;
-	ret |= val;
-
-	ret = tc35892_reg_write(tc35892, reg, ret);
-
-out:
-	mutex_unlock(&tc35892->lock);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(tc35892_set_bits);
-
-static struct resource gpio_resources[] = {
-	{
-		.start	= TC35892_INT_GPIIRQ,
-		.end	= TC35892_INT_GPIIRQ,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct mfd_cell tc35892_devs[] = {
-	{
-		.name		= "tc35892-gpio",
-		.num_resources	= ARRAY_SIZE(gpio_resources),
-		.resources	= &gpio_resources[0],
-	},
-};
-
-static irqreturn_t tc35892_irq(int irq, void *data)
-{
-	struct tc35892 *tc35892 = data;
-	int status;
-
-	status = tc35892_reg_read(tc35892, TC35892_IRQST);
-	if (status < 0)
-		return IRQ_NONE;
-
-	while (status) {
-		int bit = __ffs(status);
-
-		handle_nested_irq(tc35892->irq_base + bit);
-		status &= ~(1 << bit);
-	}
-
-	/*
-	 * A dummy read or write (to any register) appears to be necessary to
-	 * have the last interrupt clear (for example, GPIO IC write) take
-	 * effect.
-	 */
-	tc35892_reg_read(tc35892, TC35892_IRQST);
-
-	return IRQ_HANDLED;
-}
-
-static void tc35892_irq_dummy(unsigned int irq)
-{
-	/* No mask/unmask at this level */
-}
-
-static struct irq_chip tc35892_irq_chip = {
-	.name	= "tc35892",
-	.mask	= tc35892_irq_dummy,
-	.unmask	= tc35892_irq_dummy,
-};
-
-static int tc35892_irq_init(struct tc35892 *tc35892)
-{
-	int base = tc35892->irq_base;
-	int irq;
-
-	for (irq = base; irq < base + TC35892_NR_INTERNAL_IRQS; irq++) {
-		set_irq_chip_data(irq, tc35892);
-		set_irq_chip_and_handler(irq, &tc35892_irq_chip,
-					 handle_edge_irq);
-		set_irq_nested_thread(irq, 1);
-#ifdef CONFIG_ARM
-		set_irq_flags(irq, IRQF_VALID);
-#else
-		set_irq_noprobe(irq);
-#endif
-	}
-
-	return 0;
-}
-
-static void tc35892_irq_remove(struct tc35892 *tc35892)
-{
-	int base = tc35892->irq_base;
-	int irq;
-
-	for (irq = base; irq < base + TC35892_NR_INTERNAL_IRQS; irq++) {
-#ifdef CONFIG_ARM
-		set_irq_flags(irq, 0);
-#endif
-		set_irq_chip_and_handler(irq, NULL, NULL);
-		set_irq_chip_data(irq, NULL);
-	}
-}
-
-static int tc35892_chip_init(struct tc35892 *tc35892)
-{
-	int manf, ver, ret;
-
-	manf = tc35892_reg_read(tc35892, TC35892_MANFCODE);
-	if (manf < 0)
-		return manf;
-
-	ver = tc35892_reg_read(tc35892, TC35892_VERSION);
-	if (ver < 0)
-		return ver;
-
-	if (manf != TC35892_MANFCODE_MAGIC) {
-		dev_err(tc35892->dev, "unknown manufacturer: %#x\n", manf);
-		return -EINVAL;
-	}
-
-	dev_info(tc35892->dev, "manufacturer: %#x, version: %#x\n", manf, ver);
-
-	/* Put everything except the IRQ module into reset */
-	ret = tc35892_reg_write(tc35892, TC35892_RSTCTRL,
-				TC35892_RSTCTRL_TIMRST
-				| TC35892_RSTCTRL_ROTRST
-				| TC35892_RSTCTRL_KBDRST
-				| TC35892_RSTCTRL_GPIRST);
-	if (ret < 0)
-		return ret;
-
-	/* Clear the reset interrupt. */
-	return tc35892_reg_write(tc35892, TC35892_RSTINTCLR, 0x1);
-}
-
-static int __devinit tc35892_probe(struct i2c_client *i2c,
-				   const struct i2c_device_id *id)
-{
-	struct tc35892_platform_data *pdata = i2c->dev.platform_data;
-	struct tc35892 *tc35892;
-	int ret;
-
-	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_BYTE_DATA
-				     | I2C_FUNC_SMBUS_I2C_BLOCK))
-		return -EIO;
-
-	tc35892 = kzalloc(sizeof(struct tc35892), GFP_KERNEL);
-	if (!tc35892)
-		return -ENOMEM;
-
-	mutex_init(&tc35892->lock);
-
-	tc35892->dev = &i2c->dev;
-	tc35892->i2c = i2c;
-	tc35892->pdata = pdata;
-	tc35892->irq_base = pdata->irq_base;
-	tc35892->num_gpio = id->driver_data;
-
-	i2c_set_clientdata(i2c, tc35892);
-
-	ret = tc35892_chip_init(tc35892);
-	if (ret)
-		goto out_free;
-
-	ret = tc35892_irq_init(tc35892);
-	if (ret)
-		goto out_free;
-
-	ret = request_threaded_irq(tc35892->i2c->irq, NULL, tc35892_irq,
-				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				   "tc35892", tc35892);
-	if (ret) {
-		dev_err(tc35892->dev, "failed to request IRQ: %d\n", ret);
-		goto out_removeirq;
-	}
-
-	ret = mfd_add_devices(tc35892->dev, -1, tc35892_devs,
-			      ARRAY_SIZE(tc35892_devs), NULL,
-			      tc35892->irq_base);
-	if (ret) {
-		dev_err(tc35892->dev, "failed to add children\n");
-		goto out_freeirq;
-	}
-
-	return 0;
-
-out_freeirq:
-	free_irq(tc35892->i2c->irq, tc35892);
-out_removeirq:
-	tc35892_irq_remove(tc35892);
-out_free:
-	kfree(tc35892);
-	return ret;
-}
-
-static int __devexit tc35892_remove(struct i2c_client *client)
-{
-	struct tc35892 *tc35892 = i2c_get_clientdata(client);
-
-	mfd_remove_devices(tc35892->dev);
-
-	free_irq(tc35892->i2c->irq, tc35892);
-	tc35892_irq_remove(tc35892);
-
-	kfree(tc35892);
-
-	return 0;
-}
-
-static const struct i2c_device_id tc35892_id[] = {
-	{ "tc35892", 24 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, tc35892_id);
-
-static struct i2c_driver tc35892_driver = {
-	.driver.name	= "tc35892",
-	.driver.owner	= THIS_MODULE,
-	.probe		= tc35892_probe,
-	.remove		= __devexit_p(tc35892_remove),
-	.id_table	= tc35892_id,
-};
-
-static int __init tc35892_init(void)
-{
-	return i2c_add_driver(&tc35892_driver);
-}
-subsys_initcall(tc35892_init);
-
-static void __exit tc35892_exit(void)
-{
-	i2c_del_driver(&tc35892_driver);
-}
-module_exit(tc35892_exit);
-
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("TC35892 MFD core driver");
-MODULE_AUTHOR("Hanumath Prasad, Rabin Vincent");
diff --git a/drivers/mfd/tc3589x.c b/drivers/mfd/tc3589x.c
new file mode 100644
index 0000000..e23e499
--- /dev/null
+++ b/drivers/mfd/tc3589x.c
@@ -0,0 +1,465 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * License Terms: GNU General Public License, version 2
+ * Author: Hanumath Prasad <hanumath.prasad@stericsson.com> for ST-Ericsson
+ * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
+ */
+
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/tc3589x.h>
+
+#define TC3589x_CLKMODE_MODCTL_SLEEP		0x0
+#define TC3589x_CLKMODE_MODCTL_OPERATION	(1 << 0)
+
+/**
+ * tc3589x_reg_read() - read a single TC3589x register
+ * @tc3589x:	Device to read from
+ * @reg:	Register to read
+ */
+int tc3589x_reg_read(struct tc3589x *tc3589x, u8 reg)
+{
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(tc3589x->i2c, reg);
+	if (ret < 0)
+		dev_err(tc3589x->dev, "failed to read reg %#x: %d\n",
+			reg, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tc3589x_reg_read);
+
+/**
+ * tc3589x_reg_read() - write a single TC3589x register
+ * @tc3589x:	Device to write to
+ * @reg:	Register to read
+ * @data:	Value to write
+ */
+int tc3589x_reg_write(struct tc3589x *tc3589x, u8 reg, u8 data)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(tc3589x->i2c, reg, data);
+	if (ret < 0)
+		dev_err(tc3589x->dev, "failed to write reg %#x: %d\n",
+			reg, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tc3589x_reg_write);
+
+/**
+ * tc3589x_block_read() - read multiple TC3589x registers
+ * @tc3589x:	Device to read from
+ * @reg:	First register
+ * @length:	Number of registers
+ * @values:	Buffer to write to
+ */
+int tc3589x_block_read(struct tc3589x *tc3589x, u8 reg, u8 length, u8 *values)
+{
+	int ret;
+
+	ret = i2c_smbus_read_i2c_block_data(tc3589x->i2c, reg, length, values);
+	if (ret < 0)
+		dev_err(tc3589x->dev, "failed to read regs %#x: %d\n",
+			reg, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tc3589x_block_read);
+
+/**
+ * tc3589x_block_write() - write multiple TC3589x registers
+ * @tc3589x:	Device to write to
+ * @reg:	First register
+ * @length:	Number of registers
+ * @values:	Values to write
+ */
+int tc3589x_block_write(struct tc3589x *tc3589x, u8 reg, u8 length,
+			const u8 *values)
+{
+	int ret;
+
+	ret = i2c_smbus_write_i2c_block_data(tc3589x->i2c, reg, length,
+					     values);
+	if (ret < 0)
+		dev_err(tc3589x->dev, "failed to write regs %#x: %d\n",
+			reg, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tc3589x_block_write);
+
+/**
+ * tc3589x_set_bits() - set the value of a bitfield in a TC3589x register
+ * @tc3589x:	Device to write to
+ * @reg:	Register to write
+ * @mask:	Mask of bits to set
+ * @values:	Value to set
+ */
+int tc3589x_set_bits(struct tc3589x *tc3589x, u8 reg, u8 mask, u8 val)
+{
+	int ret;
+
+	mutex_lock(&tc3589x->lock);
+
+	ret = tc3589x_reg_read(tc3589x, reg);
+	if (ret < 0)
+		goto out;
+
+	ret &= ~mask;
+	ret |= val;
+
+	ret = tc3589x_reg_write(tc3589x, reg, ret);
+
+out:
+	mutex_unlock(&tc3589x->lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tc3589x_set_bits);
+
+static struct resource gpio_resources[] = {
+	{
+		.start	= TC3589x_INT_GPIIRQ,
+		.end	= TC3589x_INT_GPIIRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct resource keypad_resources[] = {
+	{
+		.start	= TC3589x_INT_KBDIRQ,
+		.end	= TC3589x_INT_KBDIRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct mfd_cell tc3589x_devs_gpio[] = {
+	{
+		.name		= "tc3589x-gpio",
+		.num_resources	= ARRAY_SIZE(gpio_resources),
+		.resources	= &gpio_resources[0],
+	},
+};
+
+static struct mfd_cell tc3589x_devs_keypad[] = {
+	{
+		.name		= "tc3589x-keypad",
+		.num_resources	= ARRAY_SIZE(keypad_resources),
+		.resources	= &keypad_resources[0],
+	},
+};
+
+static irqreturn_t tc3589x_irq(int irq, void *data)
+{
+	struct tc3589x *tc3589x = data;
+	int status;
+
+again:
+	status = tc3589x_reg_read(tc3589x, TC3589x_IRQST);
+	if (status < 0)
+		return IRQ_NONE;
+
+	while (status) {
+		int bit = __ffs(status);
+
+		handle_nested_irq(tc3589x->irq_base + bit);
+		status &= ~(1 << bit);
+	}
+
+	/*
+	 * A dummy read or write (to any register) appears to be necessary to
+	 * have the last interrupt clear (for example, GPIO IC write) take
+	 * effect. In such a case, recheck for any interrupt which is still
+	 * pending.
+	 */
+	status = tc3589x_reg_read(tc3589x, TC3589x_IRQST);
+	if (status)
+		goto again;
+
+	return IRQ_HANDLED;
+}
+
+static void tc3589x_irq_dummy(unsigned int irq)
+{
+	/* No mask/unmask at this level */
+}
+
+static struct irq_chip tc3589x_irq_chip = {
+	.name	= "tc3589x",
+	.mask	= tc3589x_irq_dummy,
+	.unmask	= tc3589x_irq_dummy,
+};
+
+static int tc3589x_irq_init(struct tc3589x *tc3589x)
+{
+	int base = tc3589x->irq_base;
+	int irq;
+
+	for (irq = base; irq < base + TC3589x_NR_INTERNAL_IRQS; irq++) {
+		set_irq_chip_data(irq, tc3589x);
+		set_irq_chip_and_handler(irq, &tc3589x_irq_chip,
+					 handle_edge_irq);
+		set_irq_nested_thread(irq, 1);
+#ifdef CONFIG_ARM
+		set_irq_flags(irq, IRQF_VALID);
+#else
+		set_irq_noprobe(irq);
+#endif
+	}
+
+	return 0;
+}
+
+static void tc3589x_irq_remove(struct tc3589x *tc3589x)
+{
+	int base = tc3589x->irq_base;
+	int irq;
+
+	for (irq = base; irq < base + TC3589x_NR_INTERNAL_IRQS; irq++) {
+#ifdef CONFIG_ARM
+		set_irq_flags(irq, 0);
+#endif
+		set_irq_chip_and_handler(irq, NULL, NULL);
+		set_irq_chip_data(irq, NULL);
+	}
+}
+
+static int tc3589x_chip_init(struct tc3589x *tc3589x)
+{
+	int manf, ver, ret;
+
+	manf = tc3589x_reg_read(tc3589x, TC3589x_MANFCODE);
+	if (manf < 0)
+		return manf;
+
+	ver = tc3589x_reg_read(tc3589x, TC3589x_VERSION);
+	if (ver < 0)
+		return ver;
+
+	if (manf != TC3589x_MANFCODE_MAGIC) {
+		dev_err(tc3589x->dev, "unknown manufacturer: %#x\n", manf);
+		return -EINVAL;
+	}
+
+	dev_info(tc3589x->dev, "manufacturer: %#x, version: %#x\n", manf, ver);
+
+	/*
+	 * Put everything except the IRQ module into reset;
+	 * also spare the GPIO module for any pin initialization
+	 * done during pre-kernel boot
+	 */
+	ret = tc3589x_reg_write(tc3589x, TC3589x_RSTCTRL,
+				TC3589x_RSTCTRL_TIMRST
+				| TC3589x_RSTCTRL_ROTRST
+				| TC3589x_RSTCTRL_KBDRST);
+	if (ret < 0)
+		return ret;
+
+	/* Clear the reset interrupt. */
+	return tc3589x_reg_write(tc3589x, TC3589x_RSTINTCLR, 0x1);
+}
+
+static int __devinit tc3589x_device_init(struct tc3589x *tc3589x)
+{
+	int ret = 0;
+	unsigned int blocks = tc3589x->pdata->block;
+
+	if (blocks & TC3589x_BLOCK_GPIO) {
+                ret = mfd_add_devices(tc3589x->dev, -1, tc3589x_devs_gpio,
+                                ARRAY_SIZE(tc3589x_devs_gpio), NULL,
+                                tc3589x->irq_base);
+                if (ret) {
+                        dev_err(tc3589x->dev, "failed to add children\n");
+                        return ret;
+                }
+		dev_info(tc3589x->dev, "added gpio block\n");
+	}
+
+	if (blocks & TC3589x_BLOCK_KEYPAD) {
+                ret = mfd_add_devices(tc3589x->dev, -1, tc3589x_devs_keypad,
+                                ARRAY_SIZE(tc3589x_devs_keypad), NULL,
+                                tc3589x->irq_base);
+                if (ret) {
+                        dev_err(tc3589x->dev, "failed to add children\n");
+                        return ret;
+                }
+		dev_info(tc3589x->dev, "added keypad block\n");
+	}
+
+	return ret;
+
+}
+
+static int __devinit tc3589x_probe(struct i2c_client *i2c,
+				   const struct i2c_device_id *id)
+{
+	struct tc3589x_platform_data *pdata = i2c->dev.platform_data;
+	struct tc3589x *tc3589x;
+	int ret;
+
+	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_BYTE_DATA
+				     | I2C_FUNC_SMBUS_I2C_BLOCK))
+		return -EIO;
+
+	tc3589x = kzalloc(sizeof(struct tc3589x), GFP_KERNEL);
+	if (!tc3589x)
+		return -ENOMEM;
+
+	mutex_init(&tc3589x->lock);
+
+	tc3589x->dev = &i2c->dev;
+	tc3589x->i2c = i2c;
+	tc3589x->pdata = pdata;
+	tc3589x->irq_base = pdata->irq_base;
+	tc3589x->num_gpio = id->driver_data;
+
+	i2c_set_clientdata(i2c, tc3589x);
+
+	ret = tc3589x_chip_init(tc3589x);
+	if (ret)
+		goto out_free;
+
+	ret = tc3589x_irq_init(tc3589x);
+	if (ret)
+		goto out_free;
+
+	ret = request_threaded_irq(tc3589x->i2c->irq, NULL, tc3589x_irq,
+			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+			"tc3589x", tc3589x);
+	if (ret) {
+		dev_err(tc3589x->dev, "failed to request IRQ: %d\n", ret);
+		goto out_removeirq;
+	}
+
+	ret = tc3589x_device_init(tc3589x);
+	if (ret) {
+		dev_err(tc3589x->dev, "failed to add mfd cells\n");
+		goto out_removeirq;
+	}
+#if 0
+	/* if GPIO block */
+	if (pdata->block == 0)	{
+		ret = mfd_add_devices(tc3589x->dev, -1, tc3589x_devs_gpio,
+				ARRAY_SIZE(tc3589x_devs_gpio), NULL,
+				tc3589x->irq_base);
+		if (ret) {
+			dev_err(tc3589x->dev, "failed to add children\n");
+			goto out_freeirq;
+		}
+		dev_info(tc3589x->dev, "Added GPIO block client\n");
+	}
+
+	/* if keypad block */
+	if (pdata->block == 1)	{
+		ret = mfd_add_devices(tc3589x->dev, -1, tc3589x_devs_keypad,
+				ARRAY_SIZE(tc3589x_devs_keypad), NULL,
+				tc3589x->irq_base);
+		if (ret) {
+			dev_err(tc3589x->dev, "failed to add children\n");
+			goto out_freeirq;
+		}
+		dev_info(tc3589x->dev, "Added Keypad block client\n");
+	}
+#endif
+	return 0;
+
+out_freeirq:
+	free_irq(tc3589x->i2c->irq, tc3589x);
+out_removeirq:
+	tc3589x_irq_remove(tc3589x);
+out_free:
+	i2c_set_clientdata(i2c, NULL);
+	kfree(tc3589x);
+	return ret;
+}
+
+static int __devexit tc3589x_remove(struct i2c_client *client)
+{
+	struct tc3589x *tc3589x = i2c_get_clientdata(client);
+
+	mfd_remove_devices(tc3589x->dev);
+
+	free_irq(tc3589x->i2c->irq, tc3589x);
+	tc3589x_irq_remove(tc3589x);
+
+	i2c_set_clientdata(client, NULL);
+	kfree(tc3589x);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int tc3589x_suspend(struct device *dev)
+{
+	struct tc3589x *tc3589x = dev_get_drvdata(dev);
+	struct i2c_client *client = tc3589x->i2c;
+	int ret = 0;
+
+	/* put the system to sleep mode */
+	if (!device_may_wakeup(&client->dev))
+		ret = tc3589x_reg_write(tc3589x, TC3589x_CLKMODE,
+				TC3589x_CLKMODE_MODCTL_SLEEP);
+
+	return ret;
+}
+
+static int tc3589x_resume(struct device *dev)
+{
+	struct tc3589x *tc3589x = dev_get_drvdata(dev);
+	struct i2c_client *client = tc3589x->i2c;
+	int ret = 0;
+
+	/* enable the system into operation */
+	if (!device_may_wakeup(&client->dev))
+		ret = tc3589x_reg_write(tc3589x, TC3589x_CLKMODE,
+				TC3589x_CLKMODE_MODCTL_OPERATION);
+
+	return ret;
+}
+
+
+static const struct dev_pm_ops tc3589x_dev_pm_ops = {
+	.suspend = tc3589x_suspend,
+	.resume  = tc3589x_resume,
+};
+#endif
+
+static const struct i2c_device_id tc3589x_id[] = {
+	{ "tc3589x", 24 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tc3589x_id);
+
+static struct i2c_driver tc3589x_driver = {
+	.driver.name	= "tc3589x",
+	.driver.owner	= THIS_MODULE,
+#ifdef CONFIG_PM
+	.driver.pm      = &tc3589x_dev_pm_ops,
+#endif
+	.probe		= tc3589x_probe,
+	.remove		= __devexit_p(tc3589x_remove),
+	.id_table	= tc3589x_id,
+};
+
+static int __init tc3589x_init(void)
+{
+	return i2c_add_driver(&tc3589x_driver);
+}
+subsys_initcall(tc3589x_init);
+
+static void __exit tc3589x_exit(void)
+{
+	i2c_del_driver(&tc3589x_driver);
+}
+module_exit(tc3589x_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("TC3589x MFD core driver");
+MODULE_AUTHOR("Hanumath Prasad, Rabin Vincent");
diff --git a/include/linux/mfd/tc35892.h b/include/linux/mfd/tc35892.h
deleted file mode 100644
index eff3094..0000000
--- a/include/linux/mfd/tc35892.h
+++ /dev/null
@@ -1,136 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * License Terms: GNU General Public License, version 2
- */
-
-#ifndef __LINUX_MFD_TC35892_H
-#define __LINUX_MFD_TC35892_H
-
-#include <linux/device.h>
-
-#define TC35892_RSTCTRL_IRQRST	(1 << 4)
-#define TC35892_RSTCTRL_TIMRST	(1 << 3)
-#define TC35892_RSTCTRL_ROTRST	(1 << 2)
-#define TC35892_RSTCTRL_KBDRST	(1 << 1)
-#define TC35892_RSTCTRL_GPIRST	(1 << 0)
-
-#define TC35892_IRQST		0x91
-
-#define TC35892_MANFCODE_MAGIC	0x03
-#define TC35892_MANFCODE	0x80
-#define TC35892_VERSION		0x81
-#define TC35892_IOCFG		0xA7
-
-#define TC35892_CLKMODE		0x88
-#define TC35892_CLKCFG		0x89
-#define TC35892_CLKEN		0x8A
-
-#define TC35892_RSTCTRL		0x82
-#define TC35892_EXTRSTN		0x83
-#define TC35892_RSTINTCLR	0x84
-
-#define TC35892_GPIOIS0		0xC9
-#define TC35892_GPIOIS1		0xCA
-#define TC35892_GPIOIS2		0xCB
-#define TC35892_GPIOIBE0	0xCC
-#define TC35892_GPIOIBE1	0xCD
-#define TC35892_GPIOIBE2	0xCE
-#define TC35892_GPIOIEV0	0xCF
-#define TC35892_GPIOIEV1	0xD0
-#define TC35892_GPIOIEV2	0xD1
-#define TC35892_GPIOIE0		0xD2
-#define TC35892_GPIOIE1		0xD3
-#define TC35892_GPIOIE2		0xD4
-#define TC35892_GPIORIS0	0xD6
-#define TC35892_GPIORIS1	0xD7
-#define TC35892_GPIORIS2	0xD8
-#define TC35892_GPIOMIS0	0xD9
-#define TC35892_GPIOMIS1	0xDA
-#define TC35892_GPIOMIS2	0xDB
-#define TC35892_GPIOIC0		0xDC
-#define TC35892_GPIOIC1		0xDD
-#define TC35892_GPIOIC2		0xDE
-
-#define TC35892_GPIODATA0	0xC0
-#define TC35892_GPIOMASK0	0xc1
-#define TC35892_GPIODATA1	0xC2
-#define TC35892_GPIOMASK1	0xc3
-#define TC35892_GPIODATA2	0xC4
-#define TC35892_GPIOMASK2	0xC5
-
-#define TC35892_GPIODIR0	0xC6
-#define TC35892_GPIODIR1	0xC7
-#define TC35892_GPIODIR2	0xC8
-
-#define TC35892_GPIOSYNC0	0xE6
-#define TC35892_GPIOSYNC1	0xE7
-#define TC35892_GPIOSYNC2	0xE8
-
-#define TC35892_GPIOWAKE0	0xE9
-#define TC35892_GPIOWAKE1	0xEA
-#define TC35892_GPIOWAKE2	0xEB
-
-#define TC35892_GPIOODM0	0xE0
-#define TC35892_GPIOODE0	0xE1
-#define TC35892_GPIOODM1	0xE2
-#define TC35892_GPIOODE1	0xE3
-#define TC35892_GPIOODM2	0xE4
-#define TC35892_GPIOODE2	0xE5
-
-#define TC35892_INT_GPIIRQ	0
-#define TC35892_INT_TI0IRQ	1
-#define TC35892_INT_TI1IRQ	2
-#define TC35892_INT_TI2IRQ	3
-#define TC35892_INT_ROTIRQ	5
-#define TC35892_INT_KBDIRQ	6
-#define TC35892_INT_PORIRQ	7
-
-#define TC35892_NR_INTERNAL_IRQS	8
-#define TC35892_INT_GPIO(x)	(TC35892_NR_INTERNAL_IRQS + (x))
-
-struct tc35892 {
-	struct mutex lock;
-	struct device *dev;
-	struct i2c_client *i2c;
-
-	int irq_base;
-	int num_gpio;
-	struct tc35892_platform_data *pdata;
-};
-
-extern int tc35892_reg_write(struct tc35892 *tc35892, u8 reg, u8 data);
-extern int tc35892_reg_read(struct tc35892 *tc35892, u8 reg);
-extern int tc35892_block_read(struct tc35892 *tc35892, u8 reg, u8 length,
-			      u8 *values);
-extern int tc35892_block_write(struct tc35892 *tc35892, u8 reg, u8 length,
-			       const u8 *values);
-extern int tc35892_set_bits(struct tc35892 *tc35892, u8 reg, u8 mask, u8 val);
-
-/**
- * struct tc35892_gpio_platform_data - TC35892 GPIO platform data
- * @gpio_base: first gpio number assigned to TC35892.  A maximum of
- *	       %TC35892_NR_GPIOS GPIOs will be allocated.
- * @setup: callback for board-specific initialization
- * @remove: callback for board-specific teardown
- */
-struct tc35892_gpio_platform_data {
-	int gpio_base;
-	void (*setup)(struct tc35892 *tc35892, unsigned gpio_base);
-	void (*remove)(struct tc35892 *tc35892, unsigned gpio_base);
-};
-
-/**
- * struct tc35892_platform_data - TC35892 platform data
- * @irq_base: base IRQ number.  %TC35892_NR_IRQS irqs will be used.
- * @gpio: GPIO-specific platform data
- */
-struct tc35892_platform_data {
-	int irq_base;
-	struct tc35892_gpio_platform_data *gpio;
-};
-
-#define TC35892_NR_GPIOS	24
-#define TC35892_NR_IRQS		TC35892_INT_GPIO(TC35892_NR_GPIOS)
-
-#endif
diff --git a/include/linux/mfd/tc3589x.h b/include/linux/mfd/tc3589x.h
new file mode 100644
index 0000000..ef7d6fe
--- /dev/null
+++ b/include/linux/mfd/tc3589x.h
@@ -0,0 +1,192 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * License Terms: GNU General Public License, version 2
+ */
+
+#ifndef __LINUX_MFD_TC3589x_H
+#define __LINUX_MFD_TC3589x_H
+
+#include <linux/device.h>
+
+#define TC3589x_RSTCTRL_IRQRST	(1 << 4)
+#define TC3589x_RSTCTRL_TIMRST	(1 << 3)
+#define TC3589x_RSTCTRL_ROTRST	(1 << 2)
+#define TC3589x_RSTCTRL_KBDRST	(1 << 1)
+#define TC3589x_RSTCTRL_GPIRST	(1 << 0)
+
+/* Keyboard Configuration Registers Index */
+#define TC3589x_KBDSETTLE_REG   0x01
+#define TC3589x_KBDBOUNCE       0x02
+#define TC3589x_KBDSIZE         0x03
+#define TC3589x_KBCFG_LSB       0x04
+#define TC3589x_KBCFG_MSB       0x05
+#define TC3589x_KBDIC           0x08
+#define TC3589x_KBDMSK          0x09
+#define TC3589x_EVTCODE_FIFO    0x10
+
+/* Pull up/down  configuration registers */
+#define TC3589x_IOCFG           0xA7
+#define TC3589x_IOPULLCFG0_LSB  0xAA
+#define TC3589x_IOPULLCFG0_MSB  0xAB
+#define TC3589x_IOPULLCFG1_LSB  0xAC
+#define TC3589x_IOPULLCFG1_MSB  0xAD
+#define TC3589x_IOPULLCFG2_LSB  0xAE
+
+#define TC3589x_IRQST		0x91
+
+#define TC3589x_MANFCODE_MAGIC	0x03
+#define TC3589x_MANFCODE	0x80
+#define TC3589x_VERSION		0x81
+#define TC3589x_IOCFG		0xA7
+
+#define TC3589x_CLKMODE		0x88
+#define TC3589x_CLKCFG		0x89
+#define TC3589x_CLKEN		0x8A
+
+#define TC3589x_RSTCTRL		0x82
+#define TC3589x_EXTRSTN		0x83
+#define TC3589x_RSTINTCLR	0x84
+
+#define TC3589x_KBDMFS		0x8F
+
+#define TC3589x_GPIOIS0		0xC9
+#define TC3589x_GPIOIS1		0xCA
+#define TC3589x_GPIOIS2		0xCB
+#define TC3589x_GPIOIBE0	0xCC
+#define TC3589x_GPIOIBE1	0xCD
+#define TC3589x_GPIOIBE2	0xCE
+#define TC3589x_GPIOIEV0	0xCF
+#define TC3589x_GPIOIEV1	0xD0
+#define TC3589x_GPIOIEV2	0xD1
+#define TC3589x_GPIOIE0		0xD2
+#define TC3589x_GPIOIE1		0xD3
+#define TC3589x_GPIOIE2		0xD4
+#define TC3589x_GPIORIS0	0xD6
+#define TC3589x_GPIORIS1	0xD7
+#define TC3589x_GPIORIS2	0xD8
+#define TC3589x_GPIOMIS0	0xD9
+#define TC3589x_GPIOMIS1	0xDA
+#define TC3589x_GPIOMIS2	0xDB
+#define TC3589x_GPIOIC0		0xDC
+#define TC3589x_GPIOIC1		0xDD
+#define TC3589x_GPIOIC2		0xDE
+
+#define TC3589x_GPIODATA0	0xC0
+#define TC3589x_GPIOMASK0	0xc1
+#define TC3589x_GPIODATA1	0xC2
+#define TC3589x_GPIOMASK1	0xc3
+#define TC3589x_GPIODATA2	0xC4
+#define TC3589x_GPIOMASK2	0xC5
+
+#define TC3589x_GPIODIR0	0xC6
+#define TC3589x_GPIODIR1	0xC7
+#define TC3589x_GPIODIR2	0xC8
+
+#define TC3589x_GPIOSYNC0	0xE6
+#define TC3589x_GPIOSYNC1	0xE7
+#define TC3589x_GPIOSYNC2	0xE8
+
+#define TC3589x_GPIOWAKE0	0xE9
+#define TC3589x_GPIOWAKE1	0xEA
+#define TC3589x_GPIOWAKE2	0xEB
+
+#define TC3589x_GPIOODM0	0xE0
+#define TC3589x_GPIOODE0	0xE1
+#define TC3589x_GPIOODM1	0xE2
+#define TC3589x_GPIOODE1	0xE3
+#define TC3589x_GPIOODM2	0xE4
+#define TC3589x_GPIOODE2	0xE5
+
+#define TC3589x_INT_GPIIRQ	0
+#define TC3589x_INT_TI0IRQ	1
+#define TC3589x_INT_TI1IRQ	2
+#define TC3589x_INT_TI2IRQ	3
+#define TC3589x_INT_ROTIRQ	5
+#define TC3589x_INT_KBDIRQ	6
+#define TC3589x_INT_PORIRQ	7
+
+#define TC3589x_NR_INTERNAL_IRQS	8
+#define TC3589x_INT_GPIO(x)	(TC3589x_NR_INTERNAL_IRQS + (x))
+
+struct tc3589x {
+	struct mutex lock;
+	struct device *dev;
+	struct i2c_client *i2c;
+
+	int irq_base;
+	int num_gpio;
+	struct tc3589x_platform_data *pdata;
+};
+
+extern int tc3589x_reg_write(struct tc3589x *tc3589x, u8 reg, u8 data);
+extern int tc3589x_reg_read(struct tc3589x *tc3589x, u8 reg);
+extern int tc3589x_block_read(struct tc3589x *tc3589x, u8 reg, u8 length,
+			      u8 *values);
+extern int tc3589x_block_write(struct tc3589x *tc3589x, u8 reg, u8 length,
+			       const u8 *values);
+extern int tc3589x_set_bits(struct tc3589x *tc3589x, u8 reg, u8 mask, u8 val);
+
+/*
+ * Keypad related platform specific constants
+ * These values may be modified for fine tuning
+ */
+#define TC_KPD_ROWS             0x8
+#define TC_KPD_COLUMNS          0x8
+#define TC_KPD_DEBOUNCE_PERIOD  0xA3
+#define TC_KPD_SETTLE_TIME      0xA3
+
+/**
+ * struct tc35893_platform_data - data structure for platform specific data
+ * @keymap_data:        matrix scan code table for keycodes
+ * @krow:               mask for available rows, value is 0xFF
+ * @kcol:               mask for available columns, value is 0xFF
+ * @debounce_period:    platform specific debounce time
+ * @settle_time:        platform specific settle down time
+ * @irqtype:            type of interrupt, falling or rising edge
+ * @irq:                irq no,
+ * @enable_wakeup:      specifies if keypad event can wake up system from sleep
+ * @no_autorepeat:      flag for auto repetition
+ */
+struct tc3589x_keypad_platform_data {
+        struct matrix_keymap_data *keymap_data;
+        u8                      krow;
+        u8                      kcol;
+        u8                      debounce_period;
+        u8                      settle_time;
+        unsigned long           irqtype;
+        int                     irq;
+        bool                    enable_wakeup;
+        bool                    no_autorepeat;
+};
+
+/**
+ * struct tc3589x_gpio_platform_data - TC3589x GPIO platform data
+ * @gpio_base: first gpio number assigned to TC3589x.  A maximum of
+ *	       %TC3589x_NR_GPIOS GPIOs will be allocated.
+ */
+struct tc3589x_gpio_platform_data {
+	int gpio_base;
+};
+
+enum tx3589x_block {
+	TC3589x_BLOCK_GPIO        = 1 << 0,
+	TC3589x_BLOCK_KEYPAD      = 1 << 1,
+};
+
+/**
+ * struct tc3589x_platform_data - TC3589x platform data
+ * @irq_base: base IRQ number.  %TC3589x_NR_IRQS irqs will be used.
+ * @gpio: GPIO-specific platform data
+ */
+struct tc3589x_platform_data {
+	int block;
+	int irq_base;
+	struct tc3589x_gpio_platform_data *gpio;
+	struct tc3589x_keypad_platform_data *keypad;
+};
+
+#define TC3589x_NR_GPIOS	24
+#define TC3589x_NR_IRQS		TC3589x_INT_GPIO(TC3589x_NR_GPIOS)
+
+#endif
-- 
1.7.2.dirty

