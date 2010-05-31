From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH v3 5/5] input: samsung-keypad - Add samsung keypad driver
Date: Mon, 31 May 2010 13:37:57 +0900
Message-ID: <1275280677-13357-5-git-send-email-jy0922.shim@samsung.com>
References: <1275280677-13357-1-git-send-email-jy0922.shim@samsung.com>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:63563 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab0EaElS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 May 2010 00:41:18 -0400
In-reply-to: <1275280677-13357-1-git-send-email-jy0922.shim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, kyungmin.park@samsung.com, dmitry.torokhov@gmail.com

This patch adds support for keypad driver running on Samsung cpus. This
driver is tested on GONI and Aquila board using S5PC110 cpu.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/input/keyboard/Kconfig          |    9 +
 drivers/input/keyboard/Makefile         |    1 +
 drivers/input/keyboard/samsung-keypad.c |  397 +++++++++++++++++++++++++++++++
 3 files changed, 407 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/keyboard/samsung-keypad.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index d8fa5d7..bf6a50f 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -342,6 +342,15 @@ config KEYBOARD_PXA930_ROTARY
 	  To compile this driver as a module, choose M here: the
 	  module will be called pxa930_rotary.
 
+config KEYBOARD_SAMSUNG
+	tristate "Samsung keypad support"
+	depends on SAMSUNG_DEV_KEYPAD
+	help
+	  Say Y here if you want to use the Samsung keypad.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called samsung-keypad.
+
 config KEYBOARD_STOWAWAY
 	tristate "Stowaway keyboard"
 	select SERIO
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 4596d0c..8f973ed 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_KEYBOARD_OPENCORES)	+= opencores-kbd.o
 obj-$(CONFIG_KEYBOARD_PXA27x)		+= pxa27x_keypad.o
 obj-$(CONFIG_KEYBOARD_PXA930_ROTARY)	+= pxa930_rotary.o
 obj-$(CONFIG_KEYBOARD_QT2160)		+= qt2160.o
+obj-$(CONFIG_KEYBOARD_SAMSUNG)		+= samsung-keypad.o
 obj-$(CONFIG_KEYBOARD_SH_KEYSC)		+= sh_keysc.o
 obj-$(CONFIG_KEYBOARD_STOWAWAY)		+= stowaway.o
 obj-$(CONFIG_KEYBOARD_SUNKBD)		+= sunkbd.o
diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
new file mode 100644
index 0000000..244a3b6
--- /dev/null
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -0,0 +1,397 @@
+/*
+ * samsung-keypad.c  --  Samsung keypad driver
+ *
+ * Copyright (C) 2010 Samsung Electronics Co.Ltd
+ * Author: Joonyoung Shim <jy0922.shim@samsung.com>
+ * Author: Donghwa Lee <dh09.lee@samsung.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <plat/keypad.h>
+#include <plat/regs-keypad.h>
+
+enum samsung_keypad_type {
+	KEYPAD_TYPE_SAMSUNG,
+	KEYPAD_TYPE_S5PV210,
+};
+
+struct samsung_keypad {
+	struct input_dev *input_dev;
+	struct timer_list timer;
+	struct clk *clk;
+	struct work_struct work;
+	void __iomem *base;
+	unsigned short *keycodes;
+	unsigned int row_shift;
+	unsigned int rows;
+	unsigned int cols;
+	unsigned int row_state[SAMSUNG_MAX_COLS];
+	int irq;
+};
+
+static int samsung_keypad_is_s5pv210(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	enum samsung_keypad_type type;
+
+	type = platform_get_device_id(pdev)->driver_data;
+	return type == KEYPAD_TYPE_S5PV210;
+}
+
+static void samsung_keypad_scan(struct samsung_keypad *keypad,
+		unsigned int *row_state)
+{
+	struct device *dev = keypad->input_dev->dev.parent;
+	unsigned int col;
+	unsigned int val;
+
+	for (col = 0; col < keypad->cols; col++) {
+		if (samsung_keypad_is_s5pv210(dev)) {
+			val = S5PV210_KEYIFCOLEN_MASK;
+			val &= ~(1 << col) << 8;
+		} else {
+			val = SAMSUNG_KEYIFCOL_MASK;
+			val &= ~(1 << col);
+		}
+
+		writel(val, keypad->base + SAMSUNG_KEYIFCOL);
+		mdelay(1);
+
+		val = readl(keypad->base + SAMSUNG_KEYIFROW);
+		row_state[col] = ~val & ((1 << keypad->rows) - 1);
+	}
+
+	/* KEYIFCOL reg clear */
+	writel(0, keypad->base + SAMSUNG_KEYIFCOL);
+}
+
+static void samsung_keypad_worker(struct work_struct *work)
+{
+	struct samsung_keypad *keypad = container_of(work,
+			struct samsung_keypad, work);
+	unsigned int row_state[SAMSUNG_MAX_COLS];
+	unsigned int val;
+	unsigned int changed;
+	unsigned int pressed;
+	unsigned int key_down = 0;
+	int col, row;
+
+	clk_enable(keypad->clk);
+
+	val = readl(keypad->base + SAMSUNG_KEYIFSTSCLR);
+
+	/* interrupt clear */
+	writel(~0x0, keypad->base + SAMSUNG_KEYIFSTSCLR);
+
+	val = readl(keypad->base + SAMSUNG_KEYIFCON);
+	val &= ~(SAMSUNG_KEYIFCON_INT_F_EN | SAMSUNG_KEYIFCON_INT_R_EN);
+	writel(val, keypad->base + SAMSUNG_KEYIFCON);
+
+	samsung_keypad_scan(keypad, row_state);
+
+	for (col = 0; col < keypad->cols; col++) {
+		changed = row_state[col] ^ keypad->row_state[col];
+		key_down |= row_state[col];
+		if (!changed)
+			continue;
+
+		for (row = 0; row < keypad->rows; row++) {
+			if (!(changed & (1 << row)))
+				continue;
+
+			pressed = row_state[col] & (1 << row);
+
+			dev_dbg(&keypad->input_dev->dev,
+				"key %s, row: %d, col: %d\n",
+				pressed ? "pressed" : "released", row, col);
+
+			val = MATRIX_SCAN_CODE(row, col, keypad->row_shift);
+
+			input_report_key(keypad->input_dev,
+					keypad->keycodes[val], pressed);
+			input_sync(keypad->input_dev);
+		}
+	}
+	memcpy(keypad->row_state, row_state, sizeof(row_state));
+
+	if (key_down)
+		mod_timer(&keypad->timer, jiffies + HZ / 20);
+	else {
+		/* enable interrupt bit */
+		val = readl(keypad->base + SAMSUNG_KEYIFCON);
+		val |= (SAMSUNG_KEYIFCON_INT_F_EN | SAMSUNG_KEYIFCON_INT_R_EN);
+		writel(val, keypad->base + SAMSUNG_KEYIFCON);
+		enable_irq(keypad->irq);
+	}
+	clk_disable(keypad->clk);
+}
+
+static irqreturn_t samsung_keypad_interrupt(int irq, void *dev_id)
+{
+	struct samsung_keypad *keypad = dev_id;
+
+	if (!work_pending(&keypad->work)) {
+		disable_irq_nosync(keypad->irq);
+		schedule_work(&keypad->work);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void samsung_keypad_timer(unsigned long data)
+{
+	struct samsung_keypad *keypad = (struct samsung_keypad *)data;
+
+	schedule_work(&keypad->work);
+}
+
+static int __devinit samsung_keypad_probe(struct platform_device *pdev)
+{
+	const struct samsung_keypad_platdata *pdata;
+	const struct matrix_keymap_data *keymap_data;
+	struct samsung_keypad *keypad;
+	struct resource *res;
+	struct input_dev *input_dev;
+	unsigned short *keycodes;
+	unsigned int row_shift;
+	unsigned int val;
+	int ret;
+
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		dev_err(&pdev->dev, "no platform data defined\n");
+		return -EINVAL;
+	}
+
+	keymap_data = pdata->keymap_data;
+	if (!keymap_data) {
+		dev_err(&pdev->dev, "no keymap data defined\n");
+		return -EINVAL;
+	}
+
+	if (!pdata->rows || (pdata->rows > SAMSUNG_MAX_ROWS))
+		return -EINVAL;
+
+	if (!pdata->cols || (pdata->cols > SAMSUNG_MAX_COLS))
+		return -EINVAL;
+
+	/* initialize the gpio */
+	if (pdata->cfg_gpio)
+		pdata->cfg_gpio(pdata->rows, pdata->cols);
+
+	row_shift = get_count_order(pdata->cols);
+	keypad = kzalloc(sizeof(*keypad), GFP_KERNEL);
+	keycodes = kzalloc((pdata->rows << row_shift) * sizeof(*keycodes),
+			GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!keypad || !keycodes || !input_dev) {
+		ret = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		ret = -ENODEV;
+		goto err_free_mem;
+	}
+
+	keypad->base = ioremap(res->start, resource_size(res));
+	if (!keypad->base) {
+		ret = -EBUSY;
+		goto err_free_mem;
+	}
+
+	keypad->clk = clk_get(&pdev->dev, "keypad");
+	if (IS_ERR(keypad->clk)) {
+		dev_err(&pdev->dev, "failed to get keypad clk\n");
+		ret = PTR_ERR(keypad->clk);
+		goto err_unmap_base;
+	}
+	clk_enable(keypad->clk);
+
+	keypad->input_dev = input_dev;
+	keypad->keycodes = keycodes;
+	keypad->row_shift = row_shift;
+	keypad->rows = pdata->rows;
+	keypad->cols = pdata->cols;
+
+	INIT_WORK(&keypad->work, samsung_keypad_worker);
+
+	setup_timer(&keypad->timer, samsung_keypad_timer,
+			(unsigned long)keypad);
+
+	/* enable interrupt and wakeup bit */
+	val = SAMSUNG_KEYIFCON_INT_F_EN | SAMSUNG_KEYIFCON_INT_R_EN |
+		SAMSUNG_KEYIFCON_WAKEUPEN;
+	writel(val, keypad->base + SAMSUNG_KEYIFCON);
+
+	/* KEYIFCOL reg clear */
+	writel(0, keypad->base + SAMSUNG_KEYIFCOL);
+
+	keypad->irq = platform_get_irq(pdev, 0);
+	if (keypad->irq < 0) {
+		ret = keypad->irq;
+		goto err_disable_clk;
+	}
+
+	ret = request_irq(keypad->irq, samsung_keypad_interrupt, 0,
+			dev_name(&pdev->dev), keypad);
+
+	if (ret)
+		goto err_disable_clk;
+
+	input_dev->name = pdev->name;
+	input_dev->id.bustype = BUS_HOST;
+	input_dev->dev.parent = &pdev->dev;
+
+	input_dev->evbit[0] = BIT_MASK(EV_KEY);
+	if (pdata->rep)
+		input_dev->evbit[0] |= BIT_MASK(EV_REP);
+
+	input_dev->keycode = keycodes;
+	input_dev->keycodesize = sizeof(*keycodes);
+	input_dev->keycodemax = pdata->rows << row_shift;
+
+	matrix_keypad_build_keymap(keymap_data, row_shift,
+			input_dev->keycode, input_dev->keybit);
+
+	ret = input_register_device(keypad->input_dev);
+	if (ret)
+		goto err_free_irq;
+
+	platform_set_drvdata(pdev, keypad);
+	clk_disable(keypad->clk);
+
+	return 0;
+
+err_free_irq:
+	free_irq(keypad->irq, keypad);
+err_disable_clk:
+	clk_disable(keypad->clk);
+	clk_put(keypad->clk);
+err_unmap_base:
+	iounmap(keypad->base);
+err_free_mem:
+	input_free_device(input_dev);
+	kfree(keycodes);
+	kfree(keypad);
+
+	return ret;
+}
+
+static int __devexit samsung_keypad_remove(struct platform_device *pdev)
+{
+	struct samsung_keypad *keypad = platform_get_drvdata(pdev);
+
+	free_irq(keypad->irq, keypad);
+	cancel_work_sync(&keypad->work);
+	del_timer_sync(&keypad->timer);
+
+	platform_set_drvdata(pdev, NULL);
+	input_unregister_device(keypad->input_dev);
+
+	clk_disable(keypad->clk);
+	clk_put(keypad->clk);
+
+	iounmap(keypad->base);
+	kfree(keypad->keycodes);
+	kfree(keypad);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int samsung_keypad_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct samsung_keypad *keypad = platform_get_drvdata(pdev);
+
+	disable_irq(keypad->irq);
+
+	return 0;
+}
+
+static int samsung_keypad_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct samsung_keypad *keypad = platform_get_drvdata(pdev);
+	unsigned int val;
+
+	clk_enable(keypad->clk);
+
+	/* enable interrupt and wakeup bit */
+	val = SAMSUNG_KEYIFCON_INT_F_EN | SAMSUNG_KEYIFCON_INT_R_EN |
+		SAMSUNG_KEYIFCON_WAKEUPEN;
+	writel(val, keypad->base + SAMSUNG_KEYIFCON);
+
+	/* KEYIFCOL reg clear */
+	writel(0, keypad->base + SAMSUNG_KEYIFCOL);
+
+	enable_irq(keypad->irq);
+	clk_disable(keypad->clk);
+
+	return 0;
+}
+
+static const struct dev_pm_ops samsung_keypad_pm_ops = {
+	.suspend	= samsung_keypad_suspend,
+	.resume		= samsung_keypad_resume,
+};
+#endif
+
+static struct platform_device_id samsung_keypad_driver_ids[] = {
+	{
+		.name		= "samsung-keypad",
+		.driver_data	= KEYPAD_TYPE_SAMSUNG,
+	}, {
+		.name		= "s5pv210-keypad",
+		.driver_data	= KEYPAD_TYPE_S5PV210,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, samsung_keypad_driver_ids);
+
+static struct platform_driver samsung_keypad_driver = {
+	.probe		= samsung_keypad_probe,
+	.remove		= __devexit_p(samsung_keypad_remove),
+	.driver		= {
+		.name	= "samsung-keypad",
+		.owner	= THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm	= &samsung_keypad_pm_ops,
+#endif
+	},
+	.id_table	= samsung_keypad_driver_ids,
+};
+
+static int __init samsung_keypad_init(void)
+{
+	return platform_driver_register(&samsung_keypad_driver);
+}
+
+static void __exit samsung_keypad_exit(void)
+{
+	platform_driver_unregister(&samsung_keypad_driver);
+}
+
+module_init(samsung_keypad_init);
+module_exit(samsung_keypad_exit);
+
+MODULE_DESCRIPTION("Samsung keypad driver");
+MODULE_AUTHOR("Joonyoung Shim <jy0922.shim@samsung.com>");
+MODULE_AUTHOR("Donghwa Lee <dh09.lee@samsung.com>");
+MODULE_LICENSE("GPL");
-- 
1.7.0.4

