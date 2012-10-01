From: Ashish Jangam <ashish.jangam@kpitcummins.com>
Subject: [Patch v2 7/7] ONKEY: DA9055 Onkey driver
Date: Mon, 1 Oct 2012 12:54:05 +0530
Message-ID: <1349076245.28328.2.camel@dhruva>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from co1ehsobe004.messaging.microsoft.com ([216.32.180.187]:8691
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751339Ab2JAHNl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 1 Oct 2012 03:13:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-input@vger.kernel.org, David Dajun Chen <dchen@diasemi.com>

This is the ONKEY driver of the Dialog DA9055 PMIC and depends on the
DA9055 MFD core driver.

Signed-off-by: David Dajun Chen <dchen@diasemi.com>
Signed-off-by: Ashish Jangam <ashish.jangam@kpitcummins.com>
---
changes since version v2:
- Add support for button release
- Use of devm_request_threaded_irq API
---
>From 027ad03092d9532292c517aef6be80a2c2e1085e Mon Sep 17 00:00:00 2001
From: Ashish Jangam <ashish.jangam@kpitcummins.com>
Date: Fri, 14 Sep 2012 18:15:15 +0530
Subject: [PATCH 5/5] [Patch v1 7/7] Onkey: DA9055 Onkey driver

This is the ONKEY driver of the Dialog DA9055 PMIC and depends on the DA9055 MFD
core driver.

This patch is functionally tested on SMDK6410 board.

Signed-off-by: David Dajun Chen <dchen@diasemi.com>
Signed-off-by: Ashish Jangam <ashish.jangam@kpitcummins.com>
---
 drivers/input/misc/Kconfig        |   10 ++
 drivers/input/misc/Makefile       |    1 +
 drivers/input/misc/da9055_onkey.c |  177 +++++++++++++++++++++++++++++++++++++
 3 files changed, 188 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/misc/da9055_onkey.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 7c0f1ec..6a45cb8 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -486,6 +486,16 @@ config INPUT_DA9052_ONKEY
 	  To compile this driver as a module, choose M here: the
 	  module will be called da9052_onkey.
 
+config INPUT_DA9055_ONKEY
+	tristate "Dialog Semiconductor DA9055 ONKEY"
+	depends on MFD_DA9055
+	help
+	  Support the ONKEY of DA9055 PMICs as an input device
+	  reporting power button status.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called da9055_onkey.
+
 config INPUT_DM355EVM
 	tristate "TI DaVinci DM355 EVM Keypad and IR Remote"
 	depends on MFD_DM355EVM_MSP
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 83fe6f5..23347e3 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_INPUT_CMA3000)		+= cma3000_d0x.o
 obj-$(CONFIG_INPUT_CMA3000_I2C)		+= cma3000_d0x_i2c.o
 obj-$(CONFIG_INPUT_COBALT_BTNS)		+= cobalt_btns.o
 obj-$(CONFIG_INPUT_DA9052_ONKEY)	+= da9052_onkey.o
+obj-$(CONFIG_INPUT_DA9055_ONKEY)	+= da9055_onkey.o
 obj-$(CONFIG_INPUT_DM355EVM)		+= dm355evm_keys.o
 obj-$(CONFIG_INPUT_GP2A)		+= gp2ap002a00f.o
 obj-$(CONFIG_INPUT_GPIO_TILT_POLLED)	+= gpio_tilt_polled.o
diff --git a/drivers/input/misc/da9055_onkey.c b/drivers/input/misc/da9055_onkey.c
new file mode 100644
index 0000000..663c100
--- /dev/null
+++ b/drivers/input/misc/da9055_onkey.c
@@ -0,0 +1,177 @@
+/*
+ * ON pin driver for Dialog DA9055 PMICs
+ *
+ * Copyright(c) 2012 Dialog Semiconductor Ltd.
+ *
+ * Author: David Dajun Chen <dchen@diasemi.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <linux/mfd/da9055/core.h>
+#include <linux/mfd/da9055/reg.h>
+
+struct da9055_onkey {
+	struct da9055 *da9055;
+	struct input_dev *input;
+	struct delayed_work work;
+};
+
+static void da9055_onkey_query(struct da9055_onkey *onkey)
+{
+	int key_stat;
+
+	key_stat = da9055_reg_read(onkey->da9055, DA9055_REG_STATUS_A);
+	if (key_stat < 0) {
+		dev_err(onkey->da9055->dev,
+			"Failed to read onkey event %d\n", key_stat);
+	} else {
+		key_stat &= DA9055_NOKEY_STS;
+		/*
+		 * Onkey status bit is cleared when onkey button is relased.
+		 */
+		if (!key_stat) {
+			input_report_key(onkey->input, KEY_POWER, 0);
+			input_sync(onkey->input);
+		}
+	}
+
+	/*
+	 * Interrupt is generated only when the ONKEY pin is asserted.
+	 * Hence the deassertion of the pin is simulated through work queue.
+	 */
+	if (key_stat)
+		schedule_delayed_work(&onkey->work, msecs_to_jiffies(10));
+
+}
+
+static void da9055_onkey_work(struct work_struct *work)
+{
+	struct da9055_onkey *onkey = container_of(work, struct da9055_onkey,
+						  work.work);
+
+	da9055_onkey_query(onkey);
+}
+
+static irqreturn_t da9055_onkey_irq(int irq, void *data)
+{
+	struct da9055_onkey *onkey = data;
+
+	input_report_key(onkey->input, KEY_POWER, 1);
+	input_sync(onkey->input);
+
+	da9055_onkey_query(onkey);
+
+	return IRQ_HANDLED;
+}
+
+static int __devinit da9055_onkey_probe(struct platform_device *pdev)
+{
+	struct input_dev *input_dev;
+	struct da9055 *da9055 = dev_get_drvdata(pdev->dev.parent);
+	struct da9055_onkey *onkey;
+	int irq, err;
+
+	irq = platform_get_irq_byname(pdev, "ONKEY");
+	if (irq < 0) {
+		dev_err(&pdev->dev,
+			"Failed to get an IRQ for input device, %d\n", irq);
+		return -EINVAL;
+	}
+
+	onkey = devm_kzalloc(&pdev->dev, sizeof(*onkey), GFP_KERNEL);
+	if (!onkey) {
+		dev_err(&pdev->dev, "Failed to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	input_dev = input_allocate_device();
+	if (!input_dev) {
+		dev_err(&pdev->dev, "Failed to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	onkey->input = input_dev;
+	onkey->da9055 = da9055;
+	input_dev->name = "da9055-onkey";
+	input_dev->phys = "da9055-onkey/input0";
+	input_dev->dev.parent = &pdev->dev;
+
+	input_dev->evbit[0] = BIT_MASK(EV_KEY);
+	__set_bit(KEY_POWER, input_dev->keybit);
+
+	INIT_DELAYED_WORK(&onkey->work, da9055_onkey_work);
+
+	err = devm_request_threaded_irq(&pdev->dev, irq, NULL, da9055_onkey_irq,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					"ONKEY", onkey);
+	if (err < 0) {
+		dev_err(&pdev->dev,
+			"Failed to register ONKEY IRQ %d, error = %d\n",
+			irq, err);
+		goto free_onkey;
+	}
+
+	err = input_register_device(input_dev);
+	if (err) {
+		dev_err(&pdev->dev, "Unable to register input device, %d\n",
+			err);
+		goto free_irq;
+	}
+
+	platform_set_drvdata(pdev, onkey);
+
+	return 0;
+
+free_irq:
+free_onkey:
+	cancel_delayed_work_sync(&onkey->work);
+	input_free_device(input_dev);
+
+	return err;
+}
+
+static int __devexit da9055_onkey_remove(struct platform_device *pdev)
+{
+	struct da9055_onkey *onkey = platform_get_drvdata(pdev);
+
+	cancel_delayed_work_sync(&onkey->work);
+	input_unregister_device(onkey->input);
+
+	return 0;
+}
+
+static struct platform_driver da9055_onkey_driver = {
+	.probe	= da9055_onkey_probe,
+	.remove	= __devexit_p(da9055_onkey_remove),
+	.driver = {
+		.name	= "da9055-onkey",
+		.owner	= THIS_MODULE,
+	},
+};
+static int __init da9055_onkey_init(void)
+{
+
+	return platform_driver_register(&da9055_onkey_driver);
+
+}
+module_init(da9055_onkey_init);
+
+static void __exit da9055_onkey_exit(void)
+{
+	platform_driver_unregister(&da9055_onkey_driver);
+}
+module_exit(da9055_onkey_exit);
+
+MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
+MODULE_DESCRIPTION("Onkey driver for DA9055");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:da9055-onkey");
-- 
1.7.0.4


