From: Ashish Jangam <ashish.jangam@kpitcummins.com>
Subject: [Patch v1 7/7] DA9055 Onkey driver
Date: Fri, 14 Sep 2012 19:04:37 +0530
Message-ID: <1347629677.18587.21.camel@dhruva>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:25123
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753585Ab2INNZH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Sep 2012 09:25:07 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-input@vger.kernel.org, David Dajun Chen <dchen@diasemi.com>

This is the ONKEY driver of the Dialog DA9055 PMIC and depends on the
DA9055 MFD core driver.

This patch is functionally tested on SMDK6410 board.

Signed-off-by: David Dajun Chen <dchen@diasemi.com>
Signed-off-by: Ashish Jangam <ashish.jangam@kpitcummins.com>
---
 drivers/input/misc/Kconfig        |   10 +++
 drivers/input/misc/Makefile       |    1 +
 drivers/input/misc/da9055_onkey.c |  121 +++++++++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+), 0 deletions(-)
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
index 0000000..05f2996
--- /dev/null
+++ b/drivers/input/misc/da9055_onkey.c
@@ -0,0 +1,121 @@
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
+
+static irqreturn_t da9055_onkey_irq(int irq, void *data)
+{
+	struct input_dev *input_dev = data;
+
+	input_report_key(input_dev, KEY_POWER, 1);
+	input_sync(input_dev);
+
+	return IRQ_HANDLED;
+}
+
+static int __devinit da9055_onkey_probe(struct platform_device *pdev)
+{
+	struct input_dev *input_dev;
+	int irq, err;
+
+	irq = platform_get_irq_byname(pdev, "ONKEY");
+	if (irq < 0) {
+		dev_err(&pdev->dev,
+			"Failed to get an IRQ for input device, %d\n", irq);
+		return -EINVAL;
+	}
+
+	input_dev = input_allocate_device();
+	if (!input_dev) {
+		dev_err(&pdev->dev, "Failed to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	input_dev->name = "da9055-onkey";
+	input_dev->phys = "da9055-onkey/input0";
+	input_dev->dev.parent = &pdev->dev;
+
+	input_dev->evbit[0] = BIT_MASK(EV_KEY);
+	__set_bit(KEY_POWER, input_dev->keybit);
+
+	err = request_threaded_irq(irq, NULL, da9055_onkey_irq,
+				     IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+				     "ONKEY", input_dev);
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
+	platform_set_drvdata(pdev, input_dev);
+
+	return 0;
+
+free_irq:
+	free_irq(irq, input_dev);
+free_onkey:
+	input_free_device(input_dev);
+
+	return err;
+}
+
+static int __devexit da9055_onkey_remove(struct platform_device *pdev)
+{
+	struct input_dev *input_dev = platform_get_drvdata(pdev);
+	int irq = platform_get_irq(pdev, 0);
+
+	free_irq(irq, input_dev);
+	input_unregister_device(input_dev);
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


