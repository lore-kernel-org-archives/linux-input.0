From: jsgood.yang@samsung.com
Subject: [PATCH 1/4] [INPUT][KEYBOARD] Samsung keypad driver support
Date: Wed,  9 Sep 2009 20:11:03 +0900
Message-ID: <1252494663-17624-1-git-send-email-jsgood.yang@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:38026 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbZIILMh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Sep 2009 07:12:37 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, ben-linux@fluff.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jinsung Yang <jsgood.yang@samsung.com>, Kyeongil Kim <ki0351.kim@samsung.com>

From: Jinsung Yang <jsgood.yang@samsung.com>

Add support for Samsung matrix keypad driver

Signed-off-by: Jinsung Yang <jsgood.yang@samsung.com>
Signed-off-by: Kyeongil Kim <ki0351.kim@samsung.com>
---
 drivers/input/keyboard/Kconfig      |    6 +
 drivers/input/keyboard/Makefile     |    1 +
 drivers/input/keyboard/s3c-keypad.c |  446 +++++++++++++++++++++++++++++++++++
 3 files changed, 453 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/keyboard/s3c-keypad.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index a6b989a..4a04553 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -361,4 +361,10 @@ config KEYBOARD_XTKBD
 	  To compile this driver as a module, choose M here: the
 	  module will be called xtkbd.
 
+config KEYBOARD_S3C
+	tristate "Samsung S3C keypad support"
+	depends on PLAT_S3C
+	help
+	  Enable support for Samsung S3C keypad interface.
+
 endif
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index b5b5eae..21331b8 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_KEYBOARD_STOWAWAY)		+= stowaway.o
 obj-$(CONFIG_KEYBOARD_SUNKBD)		+= sunkbd.o
 obj-$(CONFIG_KEYBOARD_TOSA)		+= tosakbd.o
 obj-$(CONFIG_KEYBOARD_XTKBD)		+= xtkbd.o
+obj-$(CONFIG_KEYBOARD_S3C)		+= s3c-keypad.o
diff --git a/drivers/input/keyboard/s3c-keypad.c b/drivers/input/keyboard/s3c-keypad.c
new file mode 100644
index 0000000..9436a4c
--- /dev/null
+++ b/drivers/input/keyboard/s3c-keypad.c
@@ -0,0 +1,446 @@
+/*
+ * linux/drivers/input/keyboard/s3c-keypad.c
+ *
+ * Copyright (C) 2009 Samsung Electronics
+ *
+ * Author: Jinsung Yang <jsgood.yang@samsung.com>
+ * Author: Kyeongil Kim <ki0351.kim@samsung.com>
+ *
+ * Driver for Samsung SoC matrix keypad controller.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/platform_device.h>
+#include <linux/miscdevice.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+
+#include <mach/hardware.h>
+#include <asm/irq.h>
+
+#include <plat/keypad.h>
+#include <plat/regs-keypad.h>
+
+#undef DEBUG
+
+#define S3C_KEYPAD_MAX_ROWS 16
+#define S3C_KEYPAD_MAX_COLS 8
+
+struct s3c_keypad {
+	struct s3c_platform_keypad *pdata;
+	unsigned short keycodes[S3C_KEYPAD_MAX_ROWS * S3C_KEYPAD_MAX_COLS];
+	struct input_dev *dev;
+	struct timer_list timer;
+	void __iomem *regs;
+	struct clk *clk;
+	int irq;
+	unsigned int prevmask_low;
+	unsigned int prevmask_high;
+	unsigned int keyifcon;
+	unsigned int keyiffc;
+};
+
+static int s3c_keypad_scan(struct s3c_keypad *keypad, u32 *keymask_low,
+				u32 *keymask_high)
+{
+	struct s3c_platform_keypad *pdata = keypad->pdata;
+	int i, j = 0;
+	u32 cval, rval, cfg;
+
+	for (i = 0; i < pdata->nr_cols; i++) {
+		cval = readl(keypad->regs + S3C_KEYIFCOL);
+		cval |= S3C_KEYIF_COL_DMASK;
+		cval &= ~(1 << i);
+		writel(cval, keypad->regs + S3C_KEYIFCOL);
+		udelay(pdata->delay);
+
+		rval = ~(readl(keypad->regs + S3C_KEYIFROW)) &
+			S3C_KEYIF_ROW_DMASK;
+
+		if ((i * pdata->nr_rows) < pdata->max_masks)
+			*keymask_low |= (rval << (i * pdata->nr_rows));
+		else {
+			*keymask_high |= (rval << (j * pdata->nr_rows));
+			j++;
+		}
+	}
+
+	cfg = readl(keypad->regs + S3C_KEYIFCOL);
+	cfg &= ~S3C_KEYIF_COL_MASK_ALL;
+	writel(cfg, keypad->regs + S3C_KEYIFCOL);
+
+	return 0;
+}
+
+static void s3c_keypad_timer_handler(unsigned long data)
+{
+	struct s3c_keypad *keypad = (struct s3c_keypad *)data;
+	struct s3c_platform_keypad *pdata = keypad->pdata;
+	struct input_dev *input = keypad->dev;
+	u32 keymask_low = 0, keymask_high = 0;
+	u32 press_mask_low, press_mask_high;
+	u32 release_mask_low, release_mask_high, code, cfg;
+	int i;
+
+	s3c_keypad_scan(keypad, &keymask_low, &keymask_high);
+
+	if (keymask_low != keypad->prevmask_low) {
+		press_mask_low = ((keymask_low ^ keypad->prevmask_low) &
+					keymask_low);
+		release_mask_low = ((keymask_low ^ keypad->prevmask_low) &
+					keypad->prevmask_low);
+
+		i = 0;
+		while (press_mask_low) {
+			if (press_mask_low & 1) {
+				code = keypad->keycodes[i];
+				input_report_key(input, code, 1);
+				dev_dbg(&input->dev, "low pressed: %d\n", i);
+			}
+			press_mask_low >>= 1;
+			i++;
+		}
+
+		i = 0;
+		while (release_mask_low) {
+			if (release_mask_low & 1) {
+				code = keypad->keycodes[i];
+				input_report_key(input, code, 0);
+				dev_dbg(&input->dev, "low released: %d\n", i);
+			}
+			release_mask_low >>= 1;
+			i++;
+		}
+		keypad->prevmask_low = keymask_low;
+	}
+
+	if (keymask_high != keypad->prevmask_high) {
+		press_mask_high = ((keymask_high ^ keypad->prevmask_high) &
+					keymask_high);
+		release_mask_high = ((keymask_high ^ keypad->prevmask_high) &
+					keypad->prevmask_high);
+
+		i = 0;
+		while (press_mask_high) {
+			if (press_mask_high & 1) {
+				code = keypad->keycodes[i + pdata->max_masks];
+				input_report_key(input, code, 1);
+				dev_dbg(&input->dev, "high pressed: %d %d\n",
+					keypad->keycodes[i + pdata->max_masks],
+					i);
+			}
+			press_mask_high >>= 1;
+			i++;
+		}
+
+		i = 0;
+		while (release_mask_high) {
+			if (release_mask_high & 1) {
+				code = keypad->keycodes[i + pdata->max_masks];
+				input_report_key(input, code, 0);
+				dev_dbg(&input->dev, "high released: %d\n",
+					keypad->keycodes[i + pdata->max_masks]);
+			}
+			release_mask_high >>= 1;
+			i++;
+		}
+		keypad->prevmask_high = keymask_high;
+	}
+
+	if (keymask_low | keymask_high) {
+		mod_timer(&keypad->timer, jiffies + HZ / 10);
+	} else {
+		cfg = readl(keypad->regs + S3C_KEYIFCON);
+		cfg &= ~S3C_KEYIF_CON_MASK_ALL;
+		cfg |= (S3C_KEYIF_INT_F_EN | S3C_KEYIF_INT_R_EN |
+				S3C_KEYIF_DF_EN | S3C_KEYIF_FC_EN);
+		writel(cfg, keypad->regs + S3C_KEYIFCON);
+	}
+}
+
+static irqreturn_t s3c_keypad_irq(int irq, void *dev_id)
+{
+	struct s3c_keypad *keypad = dev_id;
+	u32 cfg;
+
+	/* disable keypad interrupt and schedule for keypad timer handler */
+	cfg = readl(keypad->regs + S3C_KEYIFCON);
+	cfg &= ~(S3C_KEYIF_INT_F_EN | S3C_KEYIF_INT_R_EN);
+	writel(cfg, keypad->regs + S3C_KEYIFCON);
+
+	keypad->timer.expires = jiffies + (HZ / 100);
+	mod_timer(&keypad->timer, keypad->timer.expires);
+
+	/* clear the keypad interrupt status */
+	writel(S3C_KEYIF_STSCLR_CLEAR, keypad->regs + S3C_KEYIFSTSCLR);
+
+	return IRQ_HANDLED;
+}
+
+static int s3c_keypad_open(struct input_dev *dev)
+{
+	struct s3c_keypad *keypad = input_get_drvdata(dev);
+	u32 cfg;
+
+	clk_enable(keypad->clk);
+
+	/* init keypad h/w block */
+	cfg = readl(keypad->regs + S3C_KEYIFCON);
+	cfg &= ~S3C_KEYIF_CON_MASK_ALL;
+	cfg |= (S3C_KEYIF_INT_F_EN | S3C_KEYIF_INT_R_EN |
+			S3C_KEYIF_DF_EN | S3C_KEYIF_FC_EN);
+	writel(cfg, keypad->regs + S3C_KEYIFCON);
+
+	cfg = readl(keypad->regs + S3C_KEYIFFC);
+	cfg |= S3C_KEYIF_FILTER_VAL;
+	writel(cfg, keypad->regs + S3C_KEYIFFC);
+
+	cfg = readl(keypad->regs + S3C_KEYIFCOL);
+	cfg &= ~S3C_KEYIF_COL_MASK_ALL;
+	writel(cfg, keypad->regs + S3C_KEYIFCOL);
+
+	return 0;
+}
+
+static void s3c_keypad_close(struct input_dev *dev)
+{
+	struct s3c_keypad *keypad = input_get_drvdata(dev);
+
+	clk_disable(keypad->clk);
+}
+
+static int __devinit s3c_keypad_probe(struct platform_device *pdev)
+{
+	struct s3c_platform_keypad *pdata;
+	struct s3c_keypad *keypad;
+	struct input_dev *input;
+	struct resource *res;
+	int error = 0, irq, i;
+
+	pdata = pdev->dev.platform_data;
+	if (pdata == NULL) {
+		dev_err(&pdev->dev, "no platform data\n");
+		return -EINVAL;
+	}
+
+	keypad = kzalloc(sizeof(struct s3c_keypad), GFP_KERNEL);
+	if (keypad == NULL) {
+		dev_err(&pdev->dev, "failed to allocate driver data\n");
+		return -ENOMEM;
+	}
+
+	keypad->pdata = pdata;
+	if (!pdata->keymap) {
+		dev_err(&pdev->dev, "failed to get keymap array\n");
+		goto err_keymap;
+	}
+
+	memcpy(keypad->keycodes, pdata->keymap,
+			sizeof(pdata->keymap[0]) * pdata->max_keys);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "failed to get I/O memory\n");
+		error = -ENXIO;
+		goto err_keymap;
+	}
+
+	res = request_mem_region(res->start, resource_size(res), pdev->name);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "failed to request I/O memory\n");
+		error = -EBUSY;
+		goto err_keymap;
+	}
+
+	keypad->regs = ioremap(res->start, resource_size(res));
+	if (keypad->regs == NULL) {
+		dev_err(&pdev->dev, "failed to remap I/O memory\n");
+		error = -ENXIO;
+		goto err_map_io;
+	}
+
+	keypad->clk = clk_get(&pdev->dev, "keypad");
+	if (IS_ERR(keypad->clk)) {
+		dev_err(&pdev->dev, "failed to get keypad clock\n");
+		error = PTR_ERR(keypad->clk);
+		goto err_clk;
+	}
+
+	/* Create and register the input driver. */
+	input = input_allocate_device();
+	if (!input) {
+		dev_err(&pdev->dev, "failed to allocate input device\n");
+		error = -ENOMEM;
+		goto err_alloc_input;
+	}
+
+	input->name = pdev->name;
+	input->id.bustype = BUS_HOST;
+	input->open = s3c_keypad_open;
+	input->close = s3c_keypad_close;
+	input->dev.parent = &pdev->dev;
+	input->keycode = keypad->keycodes;
+	input->keycodesize = sizeof(keypad->keycodes[0]);
+	input->keycodemax = ARRAY_SIZE(keypad->keycodes);
+
+	keypad->dev = input;
+	input_set_drvdata(input, keypad);
+
+	__set_bit(EV_KEY, input->evbit);
+	__set_bit(EV_REP, input->evbit);
+
+	for (i = 0; i < pdata->max_keys; i++)
+		__set_bit(keypad->keycodes[i] & KEY_MAX, input->keybit);
+
+	__clear_bit(KEY_RESERVED, input->keybit);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "failed to get keypad irq\n");
+		error = -ENXIO;
+		goto err_get_irq;
+	}
+
+	platform_set_drvdata(pdev, keypad);
+
+	error = request_irq(irq, s3c_keypad_irq, IRQF_DISABLED,
+			    pdev->name, keypad);
+	if (error) {
+		dev_err(&pdev->dev, "failed to request IRQ\n");
+		goto err_req_irq;
+	}
+
+	keypad->irq = irq;
+	setup_timer(&keypad->timer, s3c_keypad_timer_handler,
+			(unsigned long)keypad);
+
+	/* Register the input device */
+	error = input_register_device(input);
+	if (error) {
+		dev_err(&pdev->dev, "failed to register input device\n");
+		goto err_reg_input;
+	}
+
+	device_init_wakeup(&pdev->dev, 1);
+	dev_info(&pdev->dev, "Samsung Keypad Interface driver loaded\n");
+
+	return 0;
+
+err_reg_input:
+	free_irq(irq, pdev);
+
+err_req_irq:
+	platform_set_drvdata(pdev, NULL);
+
+err_get_irq:
+	input_free_device(input);
+
+err_alloc_input:
+	clk_put(keypad->clk);
+
+err_clk:
+	iounmap(keypad->regs);
+
+err_map_io:
+	release_mem_region(res->start, resource_size(res));
+
+err_keymap:
+	kfree(keypad);
+
+	return error;
+}
+
+static int __devexit s3c_keypad_remove(struct platform_device *pdev)
+{
+	struct s3c_keypad *keypad = platform_get_drvdata(pdev);
+	struct resource *res;
+
+	free_irq(keypad->irq, pdev);
+	clk_put(keypad->clk);
+
+	input_unregister_device(keypad->dev);
+	iounmap(keypad->regs);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(res->start, resource_size(res));
+
+	platform_set_drvdata(pdev, NULL);
+	kfree(keypad);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int s3c_keypad_suspend(struct platform_device *dev, pm_message_t state)
+{
+	struct s3c_keypad *keypad = platform_get_drvdata(pdev);
+
+	keypad->keyifcon = readl(keypad->regs + S3C_KEYIFCON);
+	keypad->keyiffc = readl(keypad->regs + S3C_KEYIFFC);
+
+	disable_irq(IRQ_KEYPAD);
+	clk_disable(keypad->clk);
+
+	return 0;
+}
+
+static int s3c_keypad_resume(struct platform_device *dev)
+{
+	struct s3c_keypad *keypad = platform_get_drvdata(pdev);
+
+	clk_enable(keypad->clock);
+
+	writel(keypad->keyifcon, keypad->regs + S3C_KEYIFCON);
+	writel(keypad->keyiffc, keypad->regs + S3C_KEYIFFC);
+
+	enable_irq(IRQ_KEYPAD);
+
+	return 0;
+}
+#else
+#define s3c_keypad_suspend NULL
+#define s3c_keypad_resume  NULL
+#endif /* CONFIG_PM */
+
+static struct dev_pm_ops s3c_keypad_dev_pm_ops = {
+	.suspend	= s3c_keypad_suspend,
+	.resume		= s3c_keypad_resume,
+};
+
+static struct platform_driver s3c_keypad_driver = {
+	.probe		= s3c_keypad_probe,
+	.remove		= s3c_keypad_remove,
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "s3c-keypad",
+		.pm	= &s3c_keypad_dev_pm_ops,
+	},
+};
+
+static int __init s3c_keypad_init(void)
+{
+	return platform_driver_register(&s3c_keypad_driver);
+}
+
+static void __exit s3c_keypad_exit(void)
+{
+	platform_driver_unregister(&s3c_keypad_driver);
+}
+
+module_init(s3c_keypad_init);
+module_exit(s3c_keypad_exit);
+
+MODULE_AUTHOR("Kyeongil, Kim <ki0351.kim@samsung.com>");
+MODULE_AUTHOR("Jinsung, Yang <jsgood.yang@samsung.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Keypad Interface Driver for Samsung SoC");
+
-- 
1.6.2.5

