From: Wan ZongShun <mcuos.com@gmail.com>
Subject: [PATCH v3] input: Add keypad driver for w90p910
Date: Tue, 14 Jul 2009 19:34:02 +0800
Message-ID: <4A5C6D2A.7040501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f185.google.com ([209.85.216.185]:37395 "EHLO
	mail-px0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbZGNLeL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jul 2009 07:34:11 -0400
Received: by pxi15 with SMTP id 15so1063934pxi.33
        for <linux-input@vger.kernel.org>; Tue, 14 Jul 2009 04:34:10 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, "Eric.miao" <eric.y.miao@gmail.com>, H

Dear Dmitry,

This is a latest keypad driver, according to your and H Hartley's advice, I fixed up my keypad driver again and merge this header file patch to keypad driver patch.

Thanks a lot for your help.

Add w90p910 keypad driver for the evaluation board based
on w90p910. There is a 4x4 keypad in my evaluation board.

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
---
 .../arm/mach-w90x900/include/mach/w90p910_keypad.h |   18 ++
 drivers/input/keyboard/Kconfig                     |   10 +
 drivers/input/keyboard/Makefile                    |    1 +
 drivers/input/keyboard/w90p910_keypad.c            |  305 ++++++++++++++++++++
 4 files changed, 334 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-w90x900/include/mach/w90p910_keypad.h
 create mode 100644 drivers/input/keyboard/w90p910_keypad.c

diff --git a/arch/arm/mach-w90x900/include/mach/w90p910_keypad.h b/arch/arm/mach-w90x900/include/mach/w90p910_keypad.h
new file mode 100644
index 0000000..79462fa
--- /dev/null
+++ b/arch/arm/mach-w90x900/include/mach/w90p910_keypad.h
@@ -0,0 +1,18 @@
+#ifndef __ASM_ARCH_W90P910_KEYPAD_H
+#define __ASM_ARCH_W90P910_KEYPAD_H
+
+#include <linux/input/matrix_keypad.h>
+
+extern void mfp_set_groupi(struct device *dev);
+
+struct w90p910_keypad_platform_data {
+
+	unsigned int	prescale;
+	unsigned int	debounce;
+	unsigned int	matrix_key_rows;
+	unsigned int	matrix_key_cols;
+	unsigned int	*matrix_key_map;
+	int		matrix_key_map_size;
+};
+
+#endif /* __ASM_ARCH_W90P910_KEYPAD_H */
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index a6b989a..7bd0d48 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -361,4 +361,14 @@ config KEYBOARD_XTKBD
 	  To compile this driver as a module, choose M here: the
 	  module will be called xtkbd.
 
+config KEYBOARD_W90P910
+	tristate "W90P910 Matrix Keypad support"
+	depends on ARCH_W90X900
+	help
+	  Say Y here to enable the matrix keypad on evaluation board
+	  based on W90P910.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called w90p910_keypad.
+
 endif
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index b5b5eae..1523030 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_KEYBOARD_STOWAWAY)		+= stowaway.o
 obj-$(CONFIG_KEYBOARD_SUNKBD)		+= sunkbd.o
 obj-$(CONFIG_KEYBOARD_TOSA)		+= tosakbd.o
 obj-$(CONFIG_KEYBOARD_XTKBD)		+= xtkbd.o
+obj-$(CONFIG_KEYBOARD_W90P910)		+= w90p910_keypad.o
diff --git a/drivers/input/keyboard/w90p910_keypad.c b/drivers/input/keyboard/w90p910_keypad.c
new file mode 100644
index 0000000..472c705
--- /dev/null
+++ b/drivers/input/keyboard/w90p910_keypad.c
@@ -0,0 +1,305 @@
+/*
+ * Copyright (c) 2008-2009 Nuvoton technology corporation.
+ *
+ * Wan ZongShun <mcuos.com@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation;version 2 of the License.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+
+#include <mach/w90p910_keypad.h>
+
+/* Keypad Interface Control Registers */
+#define KPI_CONF		0x00
+#define KPI_3KCONF		0x04
+#define KPI_LPCONF		0x08
+#define KPI_STATUS		0x0C
+
+#define IS1KEY			(0x01 << 16)
+#define INTTR			(0x01 << 21)
+#define KEY0R			(0x0f << 3)
+#define KEY0C			0x07
+#define DEBOUNCE_BIT		0x08
+#define KSIZE0			(0x01 << 16)
+#define KSIZE1			(0x01 << 17)
+#define KPSEL			(0x01 << 19)
+#define ENKP			(0x01 << 18)
+
+#define KGET_RAW(n)		(((n) & KEY0R) >> 3)
+#define KGET_COLUMN(n)		((n) & KEY0C)
+
+#define MAX_MATRIX_KEY_NUM	(8 * 8)
+
+struct w90p910_keypad {
+	struct w90p910_keypad_platform_data *pdata;
+	struct clk *clk;
+	struct input_dev *input_dev;
+	void __iomem *mmio_base;
+	int irq;
+	unsigned int matrix_keycodes[MAX_MATRIX_KEY_NUM];
+};
+
+static void w90p910_keypad_build_keycode(struct w90p910_keypad *keypad)
+{
+	struct w90p910_keypad_platform_data *pdata = keypad->pdata;
+	struct input_dev *input_dev = keypad->input_dev;
+	unsigned int *key;
+	int i;
+
+	key = &pdata->matrix_key_map[0];
+	for (i = 0; i < pdata->matrix_key_map_size; i++, key++) {
+		int row = KEY_ROW(*key);
+		int col = KEY_COL(*key);
+		int code = KEY_VAL(*key);
+
+		keypad->matrix_keycodes[(row << 3) + col] = code;
+		__set_bit(code, input_dev->keybit);
+	}
+}
+
+static inline unsigned int lookup_matrix_keycode(
+		struct w90p910_keypad *keypad, int row, int col)
+{
+	return keypad->matrix_keycodes[(row << 3) + col];
+}
+
+static void w90p910_keypad_scan_matrix(struct w90p910_keypad *keypad,
+							unsigned int status)
+{
+	unsigned int row, col, val;
+
+	row = KGET_RAW(status);
+	col = KGET_COLUMN(status);
+
+	val = lookup_matrix_keycode(keypad, row, col);
+
+	input_report_key(keypad->input_dev, val, 1);
+
+	input_sync(keypad->input_dev);
+
+	input_report_key(keypad->input_dev, val, 0);
+
+	input_sync(keypad->input_dev);
+}
+
+static irqreturn_t w90p910_keypad_irq_handler(int irq, void *dev_id)
+{
+	struct w90p910_keypad *keypad = dev_id;
+	unsigned int  kstatus, val;
+
+	kstatus = __raw_readl(keypad->mmio_base + KPI_STATUS);
+
+	val = INTTR | IS1KEY;
+
+	if (kstatus & val)
+		w90p910_keypad_scan_matrix(keypad, kstatus);
+
+	return IRQ_HANDLED;
+}
+
+static int w90p910_keypad_open(struct input_dev *dev)
+{
+	struct w90p910_keypad *keypad = input_get_drvdata(dev);
+	struct w90p910_keypad_platform_data *pdata = keypad->pdata;
+	unsigned int val, config;
+
+	/* Enable unit clock */
+	clk_enable(keypad->clk);
+
+	val = __raw_readl(keypad->mmio_base + KPI_CONF);
+	val |= (KPSEL | ENKP);
+	val &= ~(KSIZE0 | KSIZE1);
+
+	config = pdata->prescale | (pdata->debounce << DEBOUNCE_BIT);
+
+	val |= config;
+
+	__raw_writel(val, keypad->mmio_base + KPI_CONF);
+
+	return 0;
+}
+
+static void w90p910_keypad_close(struct input_dev *dev)
+{
+	struct w90p910_keypad *keypad = input_get_drvdata(dev);
+
+	/* Disable clock unit */
+	clk_disable(keypad->clk);
+}
+
+static int __devinit w90p910_keypad_probe(struct platform_device *pdev)
+{
+	struct w90p910_keypad *keypad;
+	struct input_dev *input_dev;
+	struct resource *res;
+	int irq, error;
+
+	keypad = kzalloc(sizeof(struct w90p910_keypad), GFP_KERNEL);
+	if (keypad == NULL) {
+		dev_err(&pdev->dev, "failed to allocate driver data\n");
+		return -ENOMEM;
+	}
+
+	keypad->pdata = pdev->dev.platform_data;
+	if (keypad->pdata == NULL) {
+		dev_err(&pdev->dev, "no platform data defined\n");
+		error = -EINVAL;
+		goto failed_free;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "failed to get keypad irq\n");
+		error = -ENXIO;
+		goto failed_free;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "failed to get I/O memory\n");
+		error = -ENXIO;
+		goto failed_free;
+	}
+
+	res = request_mem_region(res->start, resource_size(res), pdev->name);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "failed to request I/O memory\n");
+		error = -EBUSY;
+		goto failed_free;
+	}
+
+	keypad->mmio_base = ioremap(res->start, resource_size(res));
+	if (keypad->mmio_base == NULL) {
+		dev_err(&pdev->dev, "failed to remap I/O memory\n");
+		error = -ENXIO;
+		goto failed_free_mem;
+	}
+
+	keypad->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(keypad->clk)) {
+		dev_err(&pdev->dev, "failed to get keypad clock\n");
+		error = PTR_ERR(keypad->clk);
+		goto failed_free_io;
+	}
+
+	/* Create and register the input driver. */
+	input_dev = input_allocate_device();
+	if (!input_dev) {
+		dev_err(&pdev->dev, "failed to allocate input device\n");
+		error = -ENOMEM;
+		goto failed_put_clk;
+	}
+
+	/* set multi-function pin for w90p910 kpi. */
+	mfp_set_groupi(&pdev->dev);
+
+	input_dev->name = pdev->name;
+	input_dev->id.bustype = BUS_HOST;
+	input_dev->open = w90p910_keypad_open;
+	input_dev->close = w90p910_keypad_close;
+	input_dev->dev.parent = &pdev->dev;
+	input_dev->keycode = keypad->matrix_keycodes;
+	input_dev->keycodesize = sizeof(keypad->matrix_keycodes[0]);
+	input_dev->keycodemax = ARRAY_SIZE(keypad->matrix_keycodes);
+
+	keypad->input_dev = input_dev;
+	input_set_drvdata(input_dev, keypad);
+
+	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
+	w90p910_keypad_build_keycode(keypad);
+	platform_set_drvdata(pdev, keypad);
+
+	error = request_irq(irq, w90p910_keypad_irq_handler, IRQF_DISABLED,
+			    pdev->name, keypad);
+	if (error) {
+		dev_err(&pdev->dev, "failed to request IRQ\n");
+		goto failed_free_dev;
+	}
+
+	keypad->irq = irq;
+
+	/* Register the input device */
+	error = input_register_device(input_dev);
+	if (error) {
+		dev_err(&pdev->dev, "failed to register input device\n");
+		goto failed_free_irq;
+	}
+
+	return 0;
+
+failed_free_irq:
+	free_irq(irq, pdev);
+	platform_set_drvdata(pdev, NULL);
+failed_free_dev:
+	input_free_device(input_dev);
+failed_put_clk:
+	clk_put(keypad->clk);
+failed_free_io:
+	iounmap(keypad->mmio_base);
+failed_free_mem:
+	release_mem_region(res->start, resource_size(res));
+failed_free:
+	kfree(keypad);
+	return error;
+}
+
+static int __devexit w90p910_keypad_remove(struct platform_device *pdev)
+{
+	struct w90p910_keypad *keypad = platform_get_drvdata(pdev);
+	struct resource *res;
+
+	free_irq(keypad->irq, pdev);
+
+	clk_put(keypad->clk);
+
+	input_unregister_device(keypad->input_dev);
+
+	iounmap(keypad->mmio_base);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(res->start, resource_size(res));
+
+	platform_set_drvdata(pdev, NULL);
+	kfree(keypad);
+	return 0;
+}
+
+static struct platform_driver w90p910_keypad_driver = {
+	.probe		= w90p910_keypad_probe,
+	.remove		= __devexit_p(w90p910_keypad_remove),
+	.driver		= {
+		.name	= "w90p910-keypad",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init w90p910_keypad_init(void)
+{
+	return platform_driver_register(&w90p910_keypad_driver);
+}
+
+static void __exit w90p910_keypad_exit(void)
+{
+	platform_driver_unregister(&w90p910_keypad_driver);
+}
+
+module_init(w90p910_keypad_init);
+module_exit(w90p910_keypad_exit);
+
+MODULE_AUTHOR("Wan ZongShun <mcuos.com@gmail.com>");
+MODULE_DESCRIPTION("w90p910 keypad driver!");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:w90p910-keypad");
-- 
1.5.6.3
