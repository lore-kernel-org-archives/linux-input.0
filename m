From: Sundar Iyer <sundar.iyer@stericsson.com>
Subject: [PATCH] input: add support for PowerOn(PonKey) button on the AB8500 MFD
Date: Wed, 1 Sep 2010 13:05:51 +0530
Message-ID: <1283326551-13751-1-git-send-email-sundar.iyer@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:55274 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751865Ab0IAHgX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 1 Sep 2010 03:36:23 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, sameo@linux.intel.com
Cc: linux-input@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, Sundar R Iyer <sundar.iyer@stericsson.com>

From: Sundar R Iyer <sundar.iyer@stericsson.com>

Add the PowerOn(PonKey) button support to detect power on/off events

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Sundar R Iyer <sundar.iyer@stericsson.com>
---
 drivers/input/misc/Kconfig         |    7 ++
 drivers/input/misc/Makefile        |    2 +-
 drivers/input/misc/ab8500-ponkey.c |  156 ++++++++++++++++++++++++++++++++++++
 drivers/mfd/ab8500-core.c          |   20 +++++
 4 files changed, 184 insertions(+), 1 deletions(-)
 create mode 100644 drivers/input/misc/ab8500-ponkey.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index b49e233..cab376c 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -22,6 +22,13 @@ config INPUT_88PM860X_ONKEY
 	  To compile this driver as a module, choose M here: the module
 	  will be called 88pm860x_onkey.
 
+config INPUT_AB8500_PONKEY
+	bool "AB8500 Pon(PowerOn) Key"
+	depends on AB8500_CORE
+	help
+	  Say Y here to use the PowerOn Key for ST-Ericsson's AB8500
+	  Mix-Sig PMIC
+
 config INPUT_AD714X
 	tristate "Analog Devices AD714x Capacitance Touch Sensor"
 	help
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 19ccca7..19b87ef 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -5,6 +5,7 @@
 # Each configuration option enables a list of files.
 
 obj-$(CONFIG_INPUT_88PM860X_ONKEY)	+= 88pm860x_onkey.o
+obj-$(CONFIG_INPUT_AB8500_PONKEY)	+= ab8500-ponkey.o
 obj-$(CONFIG_INPUT_AD714X)		+= ad714x.o
 obj-$(CONFIG_INPUT_AD714X_I2C)		+= ad714x-i2c.o
 obj-$(CONFIG_INPUT_AD714X_SPI)		+= ad714x-spi.o
@@ -41,4 +42,3 @@ obj-$(CONFIG_INPUT_WINBOND_CIR)		+= winbond-cir.o
 obj-$(CONFIG_INPUT_WISTRON_BTNS)	+= wistron_btns.o
 obj-$(CONFIG_INPUT_WM831X_ON)		+= wm831x-on.o
 obj-$(CONFIG_INPUT_YEALINK)		+= yealink.o
-
diff --git a/drivers/input/misc/ab8500-ponkey.c b/drivers/input/misc/ab8500-ponkey.c
new file mode 100644
index 0000000..35b2998
--- /dev/null
+++ b/drivers/input/misc/ab8500-ponkey.c
@@ -0,0 +1,156 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * License Terms: GNU General Public License v2
+ * Author: Sundar Iyer <sundar.iyer@stericsson.com> for ST-Ericsson
+ *
+ * AB8500 Power-On Key handler
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/ab8500.h>
+#include <linux/slab.h>
+
+/**
+ * struct ab8500_ponkey_info - ab8500 ponkey information
+ * @input_dev: pointer to input device
+ * @ab8500: ab8500 parent
+ * @irq_dbf: irq number for falling transition
+ * @irq_dbr: irq number for rising transition
+ */
+struct ab8500_ponkey_info {
+	struct input_dev	*idev;
+	struct ab8500		*ab8500;
+	int			irq_dbf;
+	int			irq_dbr;
+};
+
+/* AB8500 gives us an interrupt when ONKEY is held */
+static irqreturn_t ab8500_ponkey_handler(int irq, void *data)
+{
+	struct ab8500_ponkey_info *info = data;
+
+	if (irq == info->irq_dbf)
+		input_report_key(info->idev, KEY_POWER, true);
+	else if (irq == info->irq_dbr)
+		input_report_key(info->idev, KEY_POWER, false);
+
+	input_sync(info->idev);
+
+	return IRQ_HANDLED;
+}
+
+static int __devinit ab8500_ponkey_probe(struct platform_device *pdev)
+{
+	struct ab8500 *ab8500 = dev_get_drvdata(pdev->dev.parent);
+	struct ab8500_ponkey_info *info;
+	int irq_dbf, irq_dbr, ret;
+
+	irq_dbf = platform_get_irq_byname(pdev, "ONKEY_DBF");
+	if (irq_dbf < 0) {
+		dev_err(&pdev->dev, "No IRQ for ONKEY_DBF,error=%d\n", irq_dbf);
+		return irq_dbf;
+	}
+
+	irq_dbr = platform_get_irq_byname(pdev, "ONKEY_DBR");
+	if (irq_dbr < 0) {
+		dev_err(&pdev->dev, "No IRQ for ONKEY_DBR,error=%d\n", irq_dbr);
+		return irq_dbr;
+	}
+
+	info = kzalloc(sizeof(struct ab8500_ponkey_info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->ab8500 = ab8500;
+	info->irq_dbf = irq_dbf;
+	info->irq_dbr = irq_dbr;
+
+	info->idev = input_allocate_device();
+	if (!info->idev) {
+		dev_err(ab8500->dev, "Failed to allocate input dev\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	info->idev->name = "AB8500 POn(PowerOn) Key";
+	info->idev->dev.parent = &pdev->dev;
+	info->idev->evbit[0] = BIT_MASK(EV_KEY);
+	info->idev->keybit[BIT_WORD(KEY_POWER)] = BIT_MASK(KEY_POWER);
+
+	ret = input_register_device(info->idev);
+	if (ret) {
+		dev_err(ab8500->dev, "Can't register input device: %d\n", ret);
+		goto out_unfreedevice;
+	}
+
+	ret = request_threaded_irq(info->irq_dbf, NULL, ab8500_ponkey_handler,
+					0, "ab8500-ponkey-dbf", info);
+	if (ret < 0) {
+		dev_err(ab8500->dev, "Failed to request dbf IRQ#%d: %d\n",
+				info->irq_dbf, ret);
+		goto out_unregisterdevice;
+	}
+
+	ret = request_threaded_irq(info->irq_dbr, NULL, ab8500_ponkey_handler,
+					0, "ab8500-ponkey-dbr", info);
+	if (ret < 0) {
+		dev_err(ab8500->dev, "Failed to request dbr IRQ#%d: %d\n",
+				info->irq_dbr, ret);
+		goto out_irq_dbf;
+	}
+
+	platform_set_drvdata(pdev, info);
+
+	return 0;
+
+out_irq_dbf:
+	free_irq(info->irq_dbf, info);
+out_unregisterdevice:
+	input_unregister_device(info->idev);
+	info->idev = NULL;
+out_unfreedevice:
+	input_free_device(info->idev);
+out:
+	kfree(info);
+	return ret;
+}
+
+static int __devexit ab8500_ponkey_remove(struct platform_device *pdev)
+{
+	struct ab8500_ponkey_info *info = platform_get_drvdata(pdev);
+
+	free_irq(info->irq_dbf, info);
+	free_irq(info->irq_dbr, info);
+	input_unregister_device(info->idev);
+	kfree(info);
+	return 0;
+}
+
+static struct platform_driver ab8500_ponkey_driver = {
+	.driver		= {
+		.name	= "ab8500-poweron-key",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= ab8500_ponkey_probe,
+	.remove		= __devexit_p(ab8500_ponkey_remove),
+};
+
+static int __init ab8500_ponkey_init(void)
+{
+	return platform_driver_register(&ab8500_ponkey_driver);
+}
+module_init(ab8500_ponkey_init);
+
+static void __exit ab8500_ponkey_exit(void)
+{
+	platform_driver_unregister(&ab8500_ponkey_driver);
+}
+module_exit(ab8500_ponkey_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Sundar Iyer <sundar.iyer@stericsson.com>");
+MODULE_DESCRIPTION("ST-Ericsson AB8500 Power-ON(Pon) Key driver");
diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 6548f50..d21362b 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -378,6 +378,21 @@ static struct resource ab8500_rtc_resources[] = {
 	},
 };
 
+static struct resource ab8500_poweronkey_db_resources[] = {
+	{
+		.name	= "ONKEY_DBF",
+		.start	= AB8500_INT_PON_KEY1DB_F,
+		.end	= AB8500_INT_PON_KEY1DB_F,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.name	= "ONKEY_DBR",
+		.start	= AB8500_INT_PON_KEY1DB_R,
+		.end	= AB8500_INT_PON_KEY1DB_R,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
 static struct mfd_cell ab8500_devs[] = {
 #ifdef CONFIG_DEBUG_FS
 	{
@@ -399,6 +414,11 @@ static struct mfd_cell ab8500_devs[] = {
 	{ .name = "ab8500-usb", },
 	{ .name = "ab8500-pwm", },
 	{ .name = "ab8500-regulator", },
+	{
+		.name = "ab8500-poweron-key",
+		.num_resources = ARRAY_SIZE(ab8500_poweronkey_db_resources),
+		.resources = ab8500_poweronkey_db_resources,
+	},
 };
 
 int __devinit ab8500_init(struct ab8500 *ab8500)
-- 
1.7.2.dirty

