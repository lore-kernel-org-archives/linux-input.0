From: Cyril Chemparathy <cyril@ti.com>
Subject: [PATCH v2 1/5] input: add driver for tnetv107x on-chip keypad controller
Date: Thu, 16 Sep 2010 15:54:40 -0400
Message-ID: <1284666884-10374-2-git-send-email-cyril@ti.com>
References: <1284666884-10374-1-git-send-email-cyril@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47464 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753851Ab0IPTyu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Sep 2010 15:54:50 -0400
In-Reply-To: <1284666884-10374-1-git-send-email-cyril@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com
Cc: shubhrajyoti@ti.com, dmitry.torokhov@gmail.com, khilman@deeprootsystems.com, Cyril Chemparathy <cyril@ti.com>

This patch adds support for tnetv107x's on-chip keypad controller.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
---
 drivers/input/keyboard/Kconfig            |    9 +
 drivers/input/keyboard/Makefile           |    1 +
 drivers/input/keyboard/tnetv107x-keypad.c |  329 +++++++++++++++++++++++++++++
 3 files changed, 339 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/keyboard/tnetv107x-keypad.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 9cc488d..df1facb 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -424,6 +424,15 @@ config KEYBOARD_OMAP
 	  To compile this driver as a module, choose M here: the
 	  module will be called omap-keypad.
 
+config KEYBOARD_TNETV107X
+	tristate "TI TNETV107X keypad support"
+	depends on ARCH_DAVINCI_TNETV107X
+	help
+	  Say Y here if you want to use the TNETV107X keypad.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called tnetv107x-keypad.
+
 config KEYBOARD_TWL4030
 	tristate "TI TWL4030/TWL5030/TPS659x0 keypad support"
 	depends on TWL4030_CORE
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 504b591..dc04518 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_KEYBOARD_SH_KEYSC)		+= sh_keysc.o
 obj-$(CONFIG_KEYBOARD_STMPE)		+= stmpe-keypad.o
 obj-$(CONFIG_KEYBOARD_STOWAWAY)		+= stowaway.o
 obj-$(CONFIG_KEYBOARD_SUNKBD)		+= sunkbd.o
+obj-$(CONFIG_KEYBOARD_TNETV107X)	+= tnetv107x-keypad.o
 obj-$(CONFIG_KEYBOARD_TWL4030)		+= twl4030_keypad.o
 obj-$(CONFIG_KEYBOARD_XTKBD)		+= xtkbd.o
 obj-$(CONFIG_KEYBOARD_W90P910)		+= w90p910_keypad.o
diff --git a/drivers/input/keyboard/tnetv107x-keypad.c b/drivers/input/keyboard/tnetv107x-keypad.c
new file mode 100644
index 0000000..c262cb4
--- /dev/null
+++ b/drivers/input/keyboard/tnetv107x-keypad.c
@@ -0,0 +1,329 @@
+/*
+ * Texas Instruments TNETV107X Keypad Driver
+ *
+ * Copyright (C) 2010 Texas Instruments
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/input.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/input/matrix_keypad.h>
+
+#define BITS(x)			(BIT(x) - 1)
+
+#define KEYPAD_ROWS		9
+#define KEYPAD_COLS		9
+
+#define DEBOUNCE_MIN		BIT(10)
+#define DEBOUNCE_MAX		BITS(30)
+
+struct keypad_regs {
+	u32	rev;
+	u32	mode;
+	u32	mask;
+	u32	pol;
+	u32	dclock;
+	u32	rclock;
+	u32	stable_cnt;
+	u32	in_en;
+	u32	out;
+	u32	out_en;
+	u32	in;
+	u32	lock;
+	u32	pres[3];
+};
+
+#define keypad_read(kp, reg)		__raw_readl(&(kp)->regs->reg)
+#define keypad_write(kp, reg, val)	__raw_writel(val, &(kp)->regs->reg)
+
+struct keypad_data {
+	struct input_dev		*input_dev;
+	struct resource			*res;
+	struct keypad_regs __iomem	*regs;
+	struct clk			*clk;
+	struct device			*dev;
+	u32				irq_press;
+	u32				irq_release;
+	int				rows, cols, row_shift;
+	int				debounce_ms, active_low;
+	unsigned short			*keycodes;
+	u32				prev_keys[3];
+};
+
+static irqreturn_t keypad_irq(int irq, void *data)
+{
+	struct keypad_data *kp = (struct keypad_data *)data;
+	int i, bit, val, row, col, code;
+	u32 curr_keys[3];
+	u32 change;
+
+	memset(curr_keys, 0, sizeof(curr_keys));
+	if (irq == kp->irq_press)
+		for (i = 0; i < 3; i++)
+			curr_keys[i] = keypad_read(kp, pres[i]);
+
+	for (i = 0; i < 3; i++) {
+		change = curr_keys[i] ^ kp->prev_keys[i];
+
+		while (change) {
+			bit     = fls(change) - 1;
+			change ^= BIT(bit);
+			val     = curr_keys[i] & BIT(bit);
+			bit    += i * 32;
+			row     = bit / KEYPAD_COLS;
+			col     = bit % KEYPAD_COLS;
+
+			code = MATRIX_SCAN_CODE(row, col, kp->row_shift);
+			input_event(kp->input_dev, EV_MSC, MSC_SCAN, code);
+			input_report_key(kp->input_dev, kp->keycodes[code],
+					 val);
+		}
+	}
+	input_sync(kp->input_dev);
+	memcpy(kp->prev_keys, curr_keys, sizeof(curr_keys));
+
+	if (irq == kp->irq_press)
+		keypad_write(kp, lock, 0); /* Allow hardware updates */
+
+	return IRQ_HANDLED;
+}
+
+static int keypad_start(struct input_dev *dev)
+{
+	struct keypad_data *kp = input_get_drvdata(dev);
+	unsigned long mask, debounce, clk_rate_khz;
+	int error;
+
+	clk_enable(kp->clk);
+	clk_rate_khz = clk_get_rate(kp->clk) / 1000;
+
+	/* Initialize device registers */
+	keypad_write(kp, mode, 0);
+
+	mask  = BITS(kp->rows) << KEYPAD_COLS;
+	mask |= BITS(kp->cols);
+	keypad_write(kp, mask, ~mask);
+
+	keypad_write(kp, pol, kp->active_low ? 0 : 0x3ffff);
+	debounce = kp->debounce_ms * clk_rate_khz;
+	debounce = min(debounce, DEBOUNCE_MAX);
+	debounce = max(debounce, DEBOUNCE_MIN);
+	keypad_write(kp, dclock, debounce);
+	keypad_write(kp, rclock, 4 * debounce);
+	keypad_write(kp, stable_cnt, 3);
+	keypad_write(kp, in_en, 1);
+
+	error = request_irq(kp->irq_press, keypad_irq, 0, "key-press", kp);
+	if (error < 0) {
+		dev_err(kp->dev, "Could not allocate keypad press key irq\n");
+		clk_disable(kp->clk);
+		return error;
+	}
+
+	error = request_irq(kp->irq_release, keypad_irq, 0, "key-release", kp);
+	if (error < 0) {
+		dev_err(kp->dev, "Could not allocate keypad release key irq\n");
+		free_irq(kp->irq_press, kp);
+		clk_disable(kp->clk);
+		return error;
+	}
+
+	return 0;
+}
+
+static void keypad_stop(struct input_dev *dev)
+{
+	struct keypad_data *kp = input_get_drvdata(dev);
+
+	free_irq(kp->irq_press, kp);
+	free_irq(kp->irq_release, kp);
+	clk_disable(kp->clk);
+}
+
+static int __devinit keypad_probe(struct platform_device *pdev)
+{
+	const struct matrix_keypad_platform_data *pdata;
+	const struct matrix_keymap_data *keymap_data;
+	struct device *dev = &pdev->dev;
+	struct keypad_data *kp;
+	int error = 0, sz;
+	u32 rev = 0;
+
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		dev_err(dev, "cannot find device data\n");
+		return -EINVAL;
+	}
+
+	keymap_data = pdata->keymap_data;
+	if (!keymap_data) {
+		dev_err(dev, "cannot find keymap data\n");
+		return -EINVAL;
+	}
+
+	kp = kzalloc(sizeof(struct keypad_data), GFP_KERNEL);
+	if (!kp) {
+		dev_err(dev, "cannot allocate device info\n");
+		return -ENOMEM;
+	}
+
+	kp->dev  = dev;
+	kp->rows = pdata->num_row_gpios;
+	kp->cols = pdata->num_col_gpios;
+	kp->row_shift = get_count_order(kp->cols);
+	platform_set_drvdata(pdev, kp);
+
+	sz = (kp->rows << kp->row_shift) * sizeof(*kp->keycodes);
+	kp->keycodes = kzalloc(sz, GFP_KERNEL);
+	if (!kp->keycodes) {
+		dev_err(dev, "cannot allocate keymap info\n");
+		error = -ENOMEM;
+		goto error;
+	}
+
+	kp->irq_press   = platform_get_irq_byname(pdev, "press");
+	kp->irq_release = platform_get_irq_byname(pdev, "release");
+	if (kp->irq_press < 0 || kp->irq_release < 0) {
+		dev_err(dev, "cannot determine device interrupts\n");
+		error = -ENODEV;
+		goto error;
+	}
+
+	kp->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!kp->res) {
+		dev_err(dev, "cannot determine register area\n");
+		error = -ENODEV;
+		goto error;
+	}
+
+	if (!request_mem_region(kp->res->start, resource_size(kp->res),
+				pdev->name)) {
+		dev_err(dev, "cannot claim register memory\n");
+		kp->res = NULL;
+		error = -EINVAL;
+		goto error;
+	}
+
+	kp->regs = ioremap(kp->res->start, resource_size(kp->res));
+	if (!kp->regs) {
+		dev_err(dev, "cannot map register memory\n");
+		error = -ENOMEM;
+		goto error;
+	}
+
+	kp->clk = clk_get(dev, NULL);
+	if (!kp->clk) {
+		dev_err(dev, "cannot claim device clock\n");
+		error = -EINVAL;
+		goto error;
+	}
+
+	kp->input_dev = input_allocate_device();
+	if (!kp->input_dev) {
+		dev_err(dev, "cannot allocate input device\n");
+		error = -ENOMEM;
+		goto error;
+	}
+	input_set_drvdata(kp->input_dev, kp);
+
+	kp->input_dev->name	  = pdev->name;
+	kp->input_dev->dev.parent = &pdev->dev;
+	kp->input_dev->open	  = keypad_start;
+	kp->input_dev->close	  = keypad_stop;
+	kp->input_dev->evbit[0]	  = BIT_MASK(EV_KEY);
+	if (!pdata->no_autorepeat)
+		kp->input_dev->evbit[0] |= BIT_MASK(EV_REP);
+
+	clk_enable(kp->clk);
+	rev = keypad_read(kp, rev);
+	kp->input_dev->id.bustype = BUS_HOST;
+	kp->input_dev->id.product = ((rev >>  8) & 0x07);
+	kp->input_dev->id.version = ((rev >> 16) & 0xfff);
+	clk_disable(kp->clk);
+
+	kp->input_dev->keycode     = kp->keycodes;
+	kp->input_dev->keycodesize = sizeof(*kp->keycodes);
+	kp->input_dev->keycodemax  = kp->rows << kp->row_shift;
+
+	matrix_keypad_build_keymap(keymap_data, kp->row_shift, kp->keycodes,
+				   kp->input_dev->keybit);
+
+	input_set_capability(kp->input_dev, EV_MSC, MSC_SCAN);
+
+	error = input_register_device(kp->input_dev);
+	if (error < 0) {
+		dev_err(dev, "Could not register input device\n");
+		goto error;
+	}
+
+	return 0;
+
+error:
+	if (kp->input_dev)
+		input_free_device(kp->input_dev);
+	if (kp->clk)
+		clk_put(kp->clk);
+	if (kp->regs)
+		iounmap(kp->regs);
+	if (kp->res)
+		release_mem_region(kp->res->start, resource_size(kp->res));
+	platform_set_drvdata(pdev, NULL);
+	kfree(kp->keycodes);
+	kfree(kp);
+	return error;
+}
+
+static int __devexit keypad_remove(struct platform_device *pdev)
+{
+	struct keypad_data *kp = platform_get_drvdata(pdev);
+
+	input_unregister_device(kp->input_dev);
+	clk_put(kp->clk);
+	iounmap(kp->regs);
+	release_mem_region(kp->res->start, resource_size(kp->res));
+	platform_set_drvdata(pdev, NULL);
+	kfree(kp->keycodes);
+	kfree(kp);
+
+	return 0;
+}
+
+static struct platform_driver keypad_driver = {
+	.probe		= keypad_probe,
+	.remove		= keypad_remove,
+	.driver.name	= "tnetv107x-keypad",
+	.driver.owner	= THIS_MODULE,
+};
+
+static int __init keypad_init(void)
+{
+	return platform_driver_register(&keypad_driver);
+}
+
+static void __exit keypad_exit(void)
+{
+	platform_driver_unregister(&keypad_driver);
+}
+
+module_init(keypad_init);
+module_exit(keypad_exit);
+
+MODULE_AUTHOR("Cyril Chemparathy");
+MODULE_DESCRIPTION("TNETV107X Keypad Driver");
+MODULE_ALIAS("platform: tnetv107x-keypad");
+MODULE_LICENSE("GPL");
-- 
1.7.0.4

