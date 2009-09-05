From: =?UTF-8?B?7JaR7KeE7ISx?= <jsgood.yang@samsung.com>
Subject: [PATCH 03/03] [INPUT][KEYBOARD] Add new keypad driver for s3c series
 SoCs
Date: Sat, 05 Sep 2009 22:55:24 +0900
Message-ID: <00b101ca2e30$84135d90$8c3a18b0$%yang@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout5.samsung.com ([203.254.224.35]:36619 "EHLO
	mailout5.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbZIEOCs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 Sep 2009 10:02:48 -0400
Received: from epmmp2 (mailout5.samsung.com [203.254.224.35])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KPI00JLC3W2TI@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Sat, 05 Sep 2009 22:52:50 +0900 (KST)
Received: from JSGOODMAIN ([12.23.109.106])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KPI00LOV3W2DY@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Sat, 05 Sep 2009 22:52:50 +0900 (KST)
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: laforge@gnumonks.org, ben-linux@fluff.org, =?UTF-8?B?6rmA6rK97J28L0FQ6rCc67Cc7YyAKFNZUy5MU0kpL0UzKOyCrOybkCkv?= =?UTF-8?B?7IK87ISx7KCE7J6Q?= <ki0351.kim@samsung.com>, =?UTF-8?B?J+q5gOq1reynhC9BUOqwnOuwnO2MgChTWVMuTFNJKS9FNSjssYXsnoQp?= =?UTF-8?B?L+yCvOyEseyghOyekCc=?= <kgene.kim@samsung.com>

This keypad driver supports Samsung s3c based SoCs such as s3c6410.
This driver is written with input device compatibles.

Signed-off-by: Jinsung Yang <jsgood.yang@samsung.com>
Signed-off-by: Kyeongil Kim <ki0351.kim@samsung.com>
---
 drivers/input/keyboard/s3c-keypad.c |  468 +++++++++++++++++++++++++++++++++++
 1 files changed, 468 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/keyboard/s3c-keypad.c

diff --git a/drivers/input/keyboard/s3c-keypad.c b/drivers/input/keyboard/s3c-keypad.c
new file mode 100644
index 0000000..73b9a90
--- /dev/null
+++ b/drivers/input/keyboard/s3c-keypad.c
@@ -0,0 +1,468 @@
+/*
+ * linux/drivers/input/keyboard/s3c_keypad.c
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
+static const unsigned char s3c_keycode[] = {
+	1, 2, KEY_1, KEY_Q, KEY_A, 6, 7, KEY_LEFT,
+	9, 10, KEY_2, KEY_W, KEY_S, KEY_Z, KEY_RIGHT, 16,
+	17, 18, KEY_3, KEY_E, KEY_D, KEY_X, 23, KEY_UP,
+	25, 26, KEY_4, KEY_R, KEY_F, KEY_C, 31, 32,
+	33, KEY_O, KEY_5, KEY_T, KEY_G, KEY_V, KEY_DOWN, KEY_BACKSPACE,
+	KEY_P, KEY_0, KEY_6, KEY_Y, KEY_H, KEY_SPACE, 47, 48,
+	KEY_M, KEY_L, KEY_7, KEY_U, KEY_J, KEY_N, 55, KEY_ENTER,
+	KEY_LEFTSHIFT, KEY_9, KEY_8, KEY_I, KEY_K, KEY_B, 63, KEY_COMMA,
+};
+
+struct s3c_keypad {
+	struct s3c_platform_keypad *pdata;
+	unsigned char keycodes[ARRAY_SIZE(s3c_keycode)];
+	struct input_dev *dev;
+	struct timer_list timer;
+	void __iomem *regs;
+	struct clk *clk;
+	int irq;
+	int timer_enabled;
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
+				dev_dbg(&input->dev, "low released : %d\n", i);
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
+
+		keypad->timer_enabled = 0;
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
+	if (keypad->timer_enabled) {
+		mod_timer(&keypad->timer, keypad->timer.expires);
+	} else {
+		add_timer(&keypad->timer);
+		keypad->timer_enabled = 1;
+	}
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
+	cfg |= 0x1;
+	writel(cfg, keypad->regs + S3C_KEYIFFC);
+
+	cfg = readl(keypad->regs + S3C_KEYIFCOL);
+	cfg &= ~S3C_KEYIF_COL_MASK_ALL;
+	writel(cfg, keypad->regs + S3C_KEYIFCOL);
+
+	/* Scan timer init */
+	init_timer(&keypad->timer);
+	keypad->timer.function = s3c_keypad_timer_handler;
+	keypad->timer.data = (unsigned long)keypad;
+	keypad->timer.expires = jiffies + (HZ / 10);
+
+	if (keypad->timer_enabled) {
+		mod_timer(&keypad->timer, keypad->timer.expires);
+	} else {
+		add_timer(&keypad->timer);
+		keypad->timer_enabled = 1;
+	}
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
+#define res_size(res)	((res)->end - (res)->start + 1)
+
+static int __devinit s3c_keypad_probe(struct platform_device *pdev)
+{
+	struct s3c_platform_keypad *pdata;
+	struct s3c_keypad *keypad;
+	struct input_dev *input;
+	struct resource *res;
+	int irq, error, i;
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
+	memcpy(keypad->keycodes, s3c_keycode, sizeof(keypad->keycodes));
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "failed to get I/O memory\n");
+		error = -ENXIO;
+		goto err_get_io;
+	}
+
+	res = request_mem_region(res->start, res_size(res), pdev->name);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "failed to request I/O memory\n");
+		error = -EBUSY;
+		goto err_get_io;
+	}
+
+	keypad->regs = ioremap(res->start, res_size(res));
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
+	input->keycode = (void *)keypad->keycodes;
+	input->keycodesize = sizeof(keypad->keycodes[0]);
+	input->keycodemax = ARRAY_SIZE(keypad->keycodes);
+
+	keypad->dev = input;
+
+	input_set_drvdata(input, keypad);
+
+	__set_bit(EV_KEY, input->evbit);
+	__set_bit(EV_REP, input->evbit);
+
+	for (i = 0; i < pdata->max_keys; i++) {
+		keypad->keycodes[i] = s3c_keycode[i];
+		if (keypad->keycodes[i] <= 0)
+			continue;
+
+		__set_bit(keypad->keycodes[i] & KEY_MAX, input->keybit);
+	}
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
+
+	/* Register the input device */
+	error = input_register_device(input);
+	if (error) {
+		dev_err(&pdev->dev, "failed to register input device\n");
+		goto err_reg_input;
+	}
+
+	device_init_wakeup(&pdev->dev, 1);
+	dev_info(&pdev->dev, "Samsung Keypad Interface driver\n");
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
+	release_mem_region(res->start, res_size(res));
+
+err_get_io:
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
+
+	clk_disable(keypad->clk);
+	clk_put(keypad->clk);
+
+	input_unregister_device(keypad->dev);
+	input_free_device(keypad->dev);
+
+	iounmap(keypad->regs);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(res->start, res_size(res));
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
+static struct platform_driver s3c_keypad_driver = {
+	.probe		= s3c_keypad_probe,
+	.remove		= s3c_keypad_remove,
+	.suspend	= s3c_keypad_suspend,
+	.resume		= s3c_keypad_resume,
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "s3c-keypad",
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
+MODULE_DESCRIPTION("Keypad interface for Samsung SoC");
+
-- 
1.6.2.5


