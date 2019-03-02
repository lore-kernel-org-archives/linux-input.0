From: Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 2/2] Input: add a driver for GPIO controllable vibrators
Date: Sat,  2 Mar 2019 15:11:31 +0100
Message-ID: <20190302141132.21160-2-luca@z3ntu.xyz>
References: <20190302141132.21160-1-luca@z3ntu.xyz>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190302141132.21160-1-luca@z3ntu.xyz>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Luca Weiss <luca@z3ntu.xyz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Xiaotong Lu <xiaotong.lu@spreadtrum.com>, Coly Li <colyli@suse.de>, Stephen Boyd <sboyd@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Aaron Wu <aaron.wu@analog.com>, Rob Herring <robh@kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:INPUT KEYBOARD, MOUSE, JOYSTICK
        , TOUCHSCREEN..." <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Provide a simple driver for GPIO controllable vibrators.
It will be used by the Fairphone 2.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/input/misc/Kconfig      |  12 ++
 drivers/input/misc/Makefile     |   1 +
 drivers/input/misc/gpio-vibra.c | 214 ++++++++++++++++++++++++++++++++
 3 files changed, 227 insertions(+)
 create mode 100644 drivers/input/misc/gpio-vibra.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index ca59a2be9bc5..77480268fef2 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -280,6 +280,18 @@ config INPUT_GPIO_DECODER
 	 To compile this driver as a module, choose M here: the module
 	 will be called gpio_decoder.
 
+config INPUT_GPIO_VIBRA
+	tristate "GPIO vibrator support"
+	depends on GPIOLIB || COMPILE_TEST
+	select INPUT_FF_MEMLESS
+	help
+	  Say Y here to get support for GPIO based vibrator devices.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called gpio-vibra.
+
 config INPUT_IXP4XX_BEEPER
 	tristate "IXP4XX Beeper support"
 	depends on ARCH_IXP4XX
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 9d0f9d1ff68f..79edbad44cf3 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_INPUT_DRV2667_HAPTICS)	+= drv2667.o
 obj-$(CONFIG_INPUT_GP2A)		+= gp2ap002a00f.o
 obj-$(CONFIG_INPUT_GPIO_BEEPER)		+= gpio-beeper.o
 obj-$(CONFIG_INPUT_GPIO_DECODER)	+= gpio_decoder.o
+obj-$(CONFIG_INPUT_GPIO_VIBRA)		+= gpio-vibra.o
 obj-$(CONFIG_INPUT_HISI_POWERKEY)	+= hisi_powerkey.o
 obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
 obj-$(CONFIG_INPUT_IMS_PCU)		+= ims-pcu.o
diff --git a/drivers/input/misc/gpio-vibra.c b/drivers/input/misc/gpio-vibra.c
new file mode 100644
index 000000000000..14f9534668c8
--- /dev/null
+++ b/drivers/input/misc/gpio-vibra.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  GPIO vibrator driver
+ *
+ *  Copyright (C) 2019 Luca Weiss <luca@z3ntu.xyz>
+ *
+ *  Based on PWM vibrator driver:
+ *  Copyright (C) 2017 Collabora Ltd.
+ *
+ *  Based on previous work from:
+ *  Copyright (C) 2012 Dmitry Torokhov <dmitry.torokhov@gmail.com>
+ *
+ *  Based on PWM beeper driver:
+ *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/input.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+
+enum vibrator_state {
+	VIBRATOR_OFF,
+	VIBRATOR_ON
+};
+
+struct gpio_vibrator {
+	struct input_dev *input;
+	struct gpio_desc *gpio;
+	struct regulator *vcc;
+
+	struct work_struct play_work;
+	enum vibrator_state state;
+	bool vcc_on;
+};
+
+static int gpio_vibrator_start(struct gpio_vibrator *vibrator)
+{
+	struct device *pdev = vibrator->input->dev.parent;
+	int err;
+
+	if (!vibrator->vcc_on) {
+		err = regulator_enable(vibrator->vcc);
+		if (err) {
+			dev_err(pdev, "failed to enable regulator: %d", err);
+			return err;
+		}
+		vibrator->vcc_on = true;
+	}
+
+	gpiod_set_value(vibrator->gpio, 1);
+
+	return 0;
+}
+
+static void gpio_vibrator_stop(struct gpio_vibrator *vibrator)
+{
+	gpiod_set_value(vibrator->gpio, 0);
+
+	if (vibrator->vcc_on) {
+		regulator_disable(vibrator->vcc);
+		vibrator->vcc_on = false;
+	}
+}
+
+static void gpio_vibrator_play_work(struct work_struct *work)
+{
+	struct gpio_vibrator *vibrator = container_of(work,
+					struct gpio_vibrator, play_work);
+
+	if (vibrator->state == VIBRATOR_ON)
+		gpio_vibrator_start(vibrator);
+	else
+		gpio_vibrator_stop(vibrator);
+}
+
+static int gpio_vibrator_play_effect(struct input_dev *dev, void *data,
+				    struct ff_effect *effect)
+{
+	struct gpio_vibrator *vibrator = input_get_drvdata(dev);
+
+	int level = effect->u.rumble.strong_magnitude;
+
+	if (!level)
+		level = effect->u.rumble.weak_magnitude;
+
+	if (level)
+		vibrator->state = VIBRATOR_ON;
+	else
+		vibrator->state = VIBRATOR_OFF;
+
+	schedule_work(&vibrator->play_work);
+
+	return 0;
+}
+
+static void gpio_vibrator_close(struct input_dev *input)
+{
+	struct gpio_vibrator *vibrator = input_get_drvdata(input);
+
+	cancel_work_sync(&vibrator->play_work);
+	gpio_vibrator_stop(vibrator);
+}
+
+static int gpio_vibrator_probe(struct platform_device *pdev)
+{
+	struct gpio_vibrator *vibrator;
+	int err;
+
+	vibrator = devm_kzalloc(&pdev->dev, sizeof(*vibrator), GFP_KERNEL);
+	if (!vibrator)
+		return -ENOMEM;
+
+	vibrator->input = devm_input_allocate_device(&pdev->dev);
+	if (!vibrator->input)
+		return -ENOMEM;
+
+	vibrator->vcc = devm_regulator_get(&pdev->dev, "vcc");
+	err = PTR_ERR_OR_ZERO(vibrator->vcc);
+	if (err) {
+		if (err != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Failed to request regulator: %d",
+				err);
+		return err;
+	}
+
+	vibrator->gpio = devm_gpiod_get(&pdev->dev, "enable", GPIOD_OUT_LOW);
+	err = PTR_ERR_OR_ZERO(vibrator->gpio);
+	if (err) {
+		if (err != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Failed to request main gpio: %d",
+				err);
+		return err;
+	}
+
+	INIT_WORK(&vibrator->play_work, gpio_vibrator_play_work);
+
+	vibrator->input->name = "gpio-vibrator";
+	vibrator->input->id.bustype = BUS_HOST;
+	vibrator->input->dev.parent = &pdev->dev;
+	vibrator->input->close = gpio_vibrator_close;
+
+	input_set_drvdata(vibrator->input, vibrator);
+	input_set_capability(vibrator->input, EV_FF, FF_RUMBLE);
+
+	err = input_ff_create_memless(vibrator->input, NULL,
+				      gpio_vibrator_play_effect);
+	if (err) {
+		dev_err(&pdev->dev, "Couldn't create FF dev: %d", err);
+		return err;
+	}
+
+	err = input_register_device(vibrator->input);
+	if (err) {
+		dev_err(&pdev->dev, "Couldn't register input dev: %d", err);
+		return err;
+	}
+
+	platform_set_drvdata(pdev, vibrator);
+
+	return 0;
+}
+
+static int __maybe_unused gpio_vibrator_suspend(struct device *dev)
+{
+	struct gpio_vibrator *vibrator = dev_get_drvdata(dev);
+
+	cancel_work_sync(&vibrator->play_work);
+	if (vibrator->state == VIBRATOR_ON)
+		gpio_vibrator_stop(vibrator);
+
+	return 0;
+}
+
+static int __maybe_unused gpio_vibrator_resume(struct device *dev)
+{
+	struct gpio_vibrator *vibrator = dev_get_drvdata(dev);
+
+	if (vibrator->state == VIBRATOR_ON)
+		gpio_vibrator_start(vibrator);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(gpio_vibrator_pm_ops,
+			 gpio_vibrator_suspend, gpio_vibrator_resume);
+
+#ifdef CONFIG_OF
+static const struct of_device_id gpio_vibra_dt_match_table[] = {
+	{ .compatible = "gpio-vibrator" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, gpio_vibra_dt_match_table);
+#endif
+
+static struct platform_driver gpio_vibrator_driver = {
+	.probe	= gpio_vibrator_probe,
+	.driver	= {
+		.name	= "gpio-vibrator",
+		.pm	= &gpio_vibrator_pm_ops,
+		.of_match_table = of_match_ptr(gpio_vibra_dt_match_table),
+	},
+};
+module_platform_driver(gpio_vibrator_driver);
+
+MODULE_AUTHOR("Luca Weiss <luca@z3ntu.xy>");
+MODULE_DESCRIPTION("GPIO vibrator driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:gpio-vibrator");
-- 
2.21.0
