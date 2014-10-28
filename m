From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH 06/15] video: lcd: add LoCoMo LCD driver
Date: Tue, 28 Oct 2014 03:01:59 +0300
Message-ID: <1414454528-24240-7-git-send-email-dbaryshkov@gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Andrea Adami <andrea.adami@gmail.com>, Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: linux-input@vger.kernel.org

LoCoMo has some special handling for TFT screens attached to Collie and
Poodle. Implement that as a separate driver.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/video/backlight/Kconfig      |   8 ++
 drivers/video/backlight/Makefile     |   1 +
 drivers/video/backlight/locomo_lcd.c | 224 +++++++++++++++++++++++++++++++++++
 3 files changed, 233 insertions(+)
 create mode 100644 drivers/video/backlight/locomo_lcd.c

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 03b77b33..bc5c671 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -48,6 +48,14 @@ config LCD_LMS283GF05
 	  SPI driver for Samsung LMS283GF05. This provides basic support
 	  for powering the LCD up/down through a sysfs interface.
 
+config LCD_LOCOMO
+	tristate "Sharp LOCOMO LCD Driver"
+	depends on MFD_LOCOMO
+	default y
+	help
+	  If you have a Sharp Zaurus SL-5500 (Collie) or SL-5600 (Poodle) say y to
+	  enable the LCD driver.
+
 config LCD_LTV350QV
 	tristate "Samsung LTV350QV LCD Panel"
 	depends on SPI_MASTER
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 2a61b7e..b2580e7 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_LCD_ILI922X)		+= ili922x.o
 obj-$(CONFIG_LCD_ILI9320)		+= ili9320.o
 obj-$(CONFIG_LCD_L4F00242T03)		+= l4f00242t03.o
 obj-$(CONFIG_LCD_LD9040)		+= ld9040.o
+obj-$(CONFIG_LCD_LOCOMO)		+= locomo_lcd.o
 obj-$(CONFIG_LCD_LMS283GF05)		+= lms283gf05.o
 obj-$(CONFIG_LCD_LMS501KF03)		+= lms501kf03.o
 obj-$(CONFIG_LCD_LTV350QV)		+= ltv350qv.o
diff --git a/drivers/video/backlight/locomo_lcd.c b/drivers/video/backlight/locomo_lcd.c
new file mode 100644
index 0000000..245efb8
--- /dev/null
+++ b/drivers/video/backlight/locomo_lcd.c
@@ -0,0 +1,224 @@
+/*
+ * Backlight control code for Sharp Zaurus SL-5500
+ *
+ * Copyright 2005 John Lenz <lenz@cs.wisc.edu>
+ * Maintainer: Pavel Machek <pavel@ucw.cz> (unless John wants to :-)
+ * GPL v2
+ *
+ * This driver assumes single CPU. That's okay, because collie is
+ * slightly old hardware, and no one is going to retrofit second CPU to
+ * old PDA.
+ */
+
+/* LCD power functions */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/fb.h>
+#include <linux/backlight.h>
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/delay.h>
+#include <linux/lcd.h>
+#include <linux/mfd/locomo.h>
+
+static struct platform_device *locomolcd_dev;
+static struct locomo_lcd_platform_data lcd_data;
+static bool locomolcd_is_on;
+static bool locomolcd_is_suspended;
+static void __iomem *locomolcd_regs;
+static struct lcd_device *lcd_dev;
+
+static struct gpio locomo_gpios[] = {
+	{ 0, GPIOF_OUT_INIT_LOW, "LCD VSHA on" },
+	{ 0, GPIOF_OUT_INIT_LOW, "LCD VSHD on" },
+	{ 0, GPIOF_OUT_INIT_LOW, "LCD Vee on" },
+	{ 0, GPIOF_OUT_INIT_LOW, "LCD MOD" },
+};
+
+static void locomolcd_on(void)
+{
+	gpio_set_value(lcd_data.gpio_lcd_vsha_on, 1);
+	mdelay(2);
+
+	gpio_set_value(lcd_data.gpio_lcd_vshd_on, 1);
+	mdelay(2);
+
+	locomo_m62332_senddata(locomolcd_dev->dev.parent, lcd_data.comadj, 0);
+	mdelay(5);
+
+	gpio_set_value(lcd_data.gpio_lcd_vee_on, 1);
+	mdelay(10);
+
+	/* TFTCRST | CPSOUT=0 | CPSEN */
+	writew(0x01, locomolcd_regs + LOCOMO_TC);
+
+	/* Set CPSD */
+	writew(6, locomolcd_regs + LOCOMO_CPSD);
+
+	/* TFTCRST | CPSOUT=0 | CPSEN */
+	writew((0x04 | 0x01), locomolcd_regs + LOCOMO_TC);
+	mdelay(10);
+
+	gpio_set_value(lcd_data.gpio_lcd_mod, 1);
+}
+
+static void locomolcd_off(void)
+{
+	/* TFTCRST=1 | CPSOUT=1 | CPSEN = 0 */
+	writew(0x06, locomolcd_regs + LOCOMO_TC);
+	mdelay(1);
+
+	gpio_set_value(lcd_data.gpio_lcd_vsha_on, 0);
+	mdelay(110);
+
+	gpio_set_value(lcd_data.gpio_lcd_vee_on, 0);
+	mdelay(700);
+
+	locomo_m62332_senddata(locomolcd_dev->dev.parent, 0, 0);
+	mdelay(5);
+
+	/* TFTCRST=0 | CPSOUT=0 | CPSEN = 0 */
+	writew(0, locomolcd_regs + LOCOMO_TC);
+	gpio_set_value(lcd_data.gpio_lcd_mod, 0);
+	gpio_set_value(lcd_data.gpio_lcd_vshd_on, 0);
+}
+
+int locomo_lcd_set_power(struct lcd_device *lcd, int power)
+{
+	dev_dbg(&lcd->dev, "LCD power %d (is %d)\n", power, locomolcd_is_on);
+	if (power == 0 && !locomolcd_is_on) {
+		locomolcd_is_on = 1;
+		locomolcd_on();
+	}
+	if (power != 0 && locomolcd_is_on) {
+		locomolcd_is_on = 0;
+		locomolcd_off();
+	}
+	return 0;
+}
+
+static int locomo_lcd_get_power(struct lcd_device *lcd)
+{
+	return !locomolcd_is_on;
+}
+
+static struct lcd_ops locomo_lcd_ops = {
+	.set_power = locomo_lcd_set_power,
+	.get_power = locomo_lcd_get_power,
+};
+
+#ifdef CONFIG_PM_SLEEP
+static int locomolcd_suspend(struct device *dev)
+{
+	locomolcd_is_suspended = true;
+	locomolcd_off();
+
+	return 0;
+}
+
+static int locomolcd_resume(struct device *dev)
+{
+	locomolcd_is_suspended = false;
+
+	if (locomolcd_is_on)
+		locomolcd_on();
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(locomolcd_pm, locomolcd_suspend, locomolcd_resume);
+#define LOCOMOLCD_PM	(&locomolcd_pm)
+#else
+#define LOCOMOLCD_PM	NULL
+#endif
+
+static int locomolcd_probe(struct platform_device *dev)
+{
+	unsigned long flags;
+	struct resource *res;
+	struct locomo_lcd_platform_data *pdata;
+	int rc;
+
+	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+	locomolcd_regs = devm_ioremap_resource(&dev->dev, res);
+	if (!locomolcd_regs)
+		return -EINVAL;
+
+	pdata = dev_get_platdata(&dev->dev);
+	if (!pdata)
+		return -EINVAL;
+
+	lcd_data = *pdata;
+
+	locomo_gpios[0].gpio = lcd_data.gpio_lcd_vsha_on;
+	locomo_gpios[1].gpio = lcd_data.gpio_lcd_vshd_on;
+	locomo_gpios[2].gpio = lcd_data.gpio_lcd_vee_on;
+	locomo_gpios[3].gpio = lcd_data.gpio_lcd_mod;
+	dev_info(&dev->dev, "GPIOs: %d %d %d %d\n",
+			locomo_gpios[0].gpio,
+			locomo_gpios[1].gpio,
+			locomo_gpios[2].gpio,
+			locomo_gpios[3].gpio);
+
+	rc = gpio_request_array(locomo_gpios, ARRAY_SIZE(locomo_gpios));
+	if (rc)
+		return rc;
+
+	local_irq_save(flags);
+	locomolcd_dev = dev;
+
+	locomolcd_is_on = 1;
+	if (locomolcd_is_on)
+		locomolcd_on();
+
+	local_irq_restore(flags);
+
+	lcd_dev = lcd_device_register("locomo", &dev->dev, NULL,
+			&locomo_lcd_ops);
+
+	return 0;
+}
+
+static int locomolcd_remove(struct platform_device *dev)
+{
+	unsigned long flags;
+
+	lcd_device_unregister(lcd_dev);
+
+	local_irq_save(flags);
+
+	locomolcd_off();
+	locomolcd_dev = NULL;
+
+	local_irq_restore(flags);
+
+	gpio_free_array(locomo_gpios, ARRAY_SIZE(locomo_gpios));
+
+	return 0;
+}
+
+static void locomolcd_shutdown(struct platform_device *dev)
+{
+	locomolcd_off();
+}
+
+static struct platform_driver locomolcd_driver = {
+	.driver = {
+		.name	= "locomo-lcd",
+		.owner	= THIS_MODULE,
+		.pm	= LOCOMOLCD_PM,
+	},
+	.probe	= locomolcd_probe,
+	.remove	= locomolcd_remove,
+	.shutdown = locomolcd_shutdown,
+};
+
+module_platform_driver(locomolcd_driver);
+
+MODULE_AUTHOR("John Lenz <lenz@cs.wisc.edu>, Pavel Machek <pavel@ucw.cz>");
+MODULE_DESCRIPTION("Collie LCD driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:locomo-lcd");
-- 
2.1.1

