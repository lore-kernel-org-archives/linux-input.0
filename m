From: "eric miao" <eric.y.miao@gmail.com>
Subject: [PATCH 1/12] pxa: rename the pxa27x_keyboard to pxa27x_keypad
Date: Wed, 23 Jan 2008 15:16:30 +0800
Message-ID: <f17812d70801222316w52070845r123fd9b54bb27b36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:25459 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756AbYAWHQb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jan 2008 02:16:31 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4880326wah.23
        for <linux-input@vger.kernel.org>; Tue, 22 Jan 2008 23:16:30 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

>From bd0e7b847887682ccedc921527173a3643ced383 Mon Sep 17 00:00:00 2001
From: eric miao <eric.miao@marvell.com>
Date: Tue, 22 Jan 2008 16:30:39 +0800
Subject: [PATCH] pxa: rename the pxa27x_keyboard to pxa27x_keypad

The controller should really be called keypad, and also align
the naming of functions and structures to use "pxa27x_keypad"
as prefix, instead of "pxakbd".

Signed-off-by: eric miao <eric.miao@marvell.com>
---
 drivers/input/keyboard/Kconfig             |    6 +-
 drivers/input/keyboard/Makefile            |    2 +-
 drivers/input/keyboard/pxa27x_keyboard.c   |  274 ----------------------------
 drivers/input/keyboard/pxa27x_keypad.c     |  274 ++++++++++++++++++++++++++++
 include/asm-arm/arch-pxa/pxa27x_keyboard.h |   13 --
 include/asm-arm/arch-pxa/pxa27x_keypad.h   |   13 ++
 6 files changed, 291 insertions(+), 291 deletions(-)
 delete mode 100644 drivers/input/keyboard/pxa27x_keyboard.c
 create mode 100644 drivers/input/keyboard/pxa27x_keypad.c
 delete mode 100644 include/asm-arm/arch-pxa/pxa27x_keyboard.h
 create mode 100644 include/asm-arm/arch-pxa/pxa27x_keypad.h

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index dfa6592..33e292b 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -239,13 +239,13 @@ config KEYBOARD_OMAP
 	  module will be called omap-keypad.

 config KEYBOARD_PXA27x
-	tristate "PXA27x keyboard support"
+	tristate "PXA27x keypad support"
 	depends on PXA27x
 	help
-	  Enable support for PXA27x matrix keyboard controller
+	  Enable support for PXA27x keypad controller

 	  To compile this driver as a module, choose M here: the
-	  module will be called pxa27x_keyboard.
+	  module will be called pxa27x_keypad.

 config KEYBOARD_AAED2000
 	tristate "AAED-2000 keyboard"
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index e97455f..b361bb9 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_KEYBOARD_SPITZ)		+= spitzkbd.o
 obj-$(CONFIG_KEYBOARD_HIL)		+= hil_kbd.o
 obj-$(CONFIG_KEYBOARD_HIL_OLD)		+= hilkbd.o
 obj-$(CONFIG_KEYBOARD_OMAP)		+= omap-keypad.o
-obj-$(CONFIG_KEYBOARD_PXA27x)		+= pxa27x_keyboard.o
+obj-$(CONFIG_KEYBOARD_PXA27x)		+= pxa27x_keypad.o
 obj-$(CONFIG_KEYBOARD_AAED2000)		+= aaed2000_kbd.o
 obj-$(CONFIG_KEYBOARD_GPIO)		+= gpio_keys.o
 obj-$(CONFIG_KEYBOARD_HP6XX)		+= jornada680_kbd.o
diff --git a/drivers/input/keyboard/pxa27x_keyboard.c
b/drivers/input/keyboard/pxa27x_keyboard.c
deleted file mode 100644
index bdd64ee..0000000
--- a/drivers/input/keyboard/pxa27x_keyboard.c
+++ /dev/null
@@ -1,274 +0,0 @@
-/*
- * linux/drivers/input/keyboard/pxa27x_keyboard.c
- *
- * Driver for the pxa27x matrix keyboard controller.
- *
- * Created:	Feb 22, 2007
- * Author:	Rodolfo Giometti <giometti@linux.it>
- *
- * Based on a previous implementations by Kevin O'Connor
- * <kevin_at_koconnor.net> and Alex Osborne <bobofdoom@gmail.com> and
- * on some suggestions by Nicolas Pitre <nico@cam.org>.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/input.h>
-#include <linux/device.h>
-#include <linux/platform_device.h>
-#include <linux/clk.h>
-#include <linux/err.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-
-#include <asm/arch/hardware.h>
-#include <asm/arch/pxa-regs.h>
-#include <asm/arch/irqs.h>
-#include <asm/arch/pxa27x_keyboard.h>
-
-#define DRIVER_NAME		"pxa27x-keyboard"
-
-#define KPASMKP(col)		(col/2 == 0 ? KPASMKP0 : \
-				 col/2 == 1 ? KPASMKP1 : \
-				 col/2 == 2 ? KPASMKP2 : KPASMKP3)
-#define KPASMKPx_MKC(row, col)	(1 << (row + 16 * (col % 2)))
-
-static struct clk *pxakbd_clk;
-
-static irqreturn_t pxakbd_irq_handler(int irq, void *dev_id)
-{
-	struct platform_device *pdev = dev_id;
-	struct pxa27x_keyboard_platform_data *pdata = pdev->dev.platform_data;
-	struct input_dev *input_dev = platform_get_drvdata(pdev);
-	unsigned long kpc = KPC;
-	int p, row, col, rel;
-
-	if (kpc & KPC_DI) {
-		unsigned long kpdk = KPDK;
-
-		if (!(kpdk & KPDK_DKP)) {
-			/* better luck next time */
-		} else if (kpc & KPC_REE0) {
-			unsigned long kprec = KPREC;
-			KPREC = 0x7f;
-
-			if (kprec & KPREC_OF0)
-				rel = (kprec & 0xff) + 0x7f;
-			else if (kprec & KPREC_UF0)
-				rel = (kprec & 0xff) - 0x7f - 0xff;
-			else
-				rel = (kprec & 0xff) - 0x7f;
-
-			if (rel) {
-				input_report_rel(input_dev, REL_WHEEL, rel);
-				input_sync(input_dev);
-			}
-		}
-	}
-
-	if (kpc & KPC_MI) {
-		/* report the status of every button */
-		for (row = 0; row < pdata->nr_rows; row++) {
-			for (col = 0; col < pdata->nr_cols; col++) {
-				p = KPASMKP(col) & KPASMKPx_MKC(row, col) ?
-					1 : 0;
-				pr_debug("keycode %x - pressed %x\n",
-						pdata->keycodes[row][col], p);
-				input_report_key(input_dev,
-						pdata->keycodes[row][col], p);
-			}
-		}
-		input_sync(input_dev);
-	}
-
-	return IRQ_HANDLED;
-}
-
-static int pxakbd_open(struct input_dev *dev)
-{
-	/* Set keypad control register */
-	KPC |= (KPC_ASACT |
-		KPC_MS_ALL |
-		(2 << 6) | KPC_REE0 | KPC_DK_DEB_SEL |
-		KPC_ME | KPC_MIE | KPC_DE | KPC_DIE);
-
-	KPC &= ~KPC_AS;         /* disable automatic scan */
-	KPC &= ~KPC_IMKP;       /* do not ignore multiple keypresses */
-
-	/* Set rotary count to mid-point value */
-	KPREC = 0x7F;
-
-	/* Enable unit clock */
-	clk_enable(pxakbd_clk);
-
-	return 0;
-}
-
-static void pxakbd_close(struct input_dev *dev)
-{
-	/* Disable clock unit */
-	clk_disable(pxakbd_clk);
-}
-
-#ifdef CONFIG_PM
-static int pxakbd_suspend(struct platform_device *pdev, pm_message_t state)
-{
-	struct pxa27x_keyboard_platform_data *pdata = pdev->dev.platform_data;
-
-	/* Save controller status */
-	pdata->reg_kpc = KPC;
-	pdata->reg_kprec = KPREC;
-
-	return 0;
-}
-
-static int pxakbd_resume(struct platform_device *pdev)
-{
-	struct pxa27x_keyboard_platform_data *pdata = pdev->dev.platform_data;
-	struct input_dev *input_dev = platform_get_drvdata(pdev);
-
-	mutex_lock(&input_dev->mutex);
-
-	if (input_dev->users) {
-		/* Restore controller status */
-		KPC = pdata->reg_kpc;
-		KPREC = pdata->reg_kprec;
-
-		/* Enable unit clock */
-		clk_disable(pxakbd_clk);
-		clk_enable(pxakbd_clk);
-	}
-
-	mutex_unlock(&input_dev->mutex);
-
-	return 0;
-}
-#else
-#define pxakbd_suspend	NULL
-#define pxakbd_resume	NULL
-#endif
-
-static int __devinit pxakbd_probe(struct platform_device *pdev)
-{
-	struct pxa27x_keyboard_platform_data *pdata = pdev->dev.platform_data;
-	struct input_dev *input_dev;
-	int i, row, col, error;
-
-	pxakbd_clk = clk_get(&pdev->dev, "KBDCLK");
-	if (IS_ERR(pxakbd_clk)) {
-		error = PTR_ERR(pxakbd_clk);
-		goto err_clk;
-	}
-
-	/* Create and register the input driver. */
-	input_dev = input_allocate_device();
-	if (!input_dev) {
-		printk(KERN_ERR "Cannot request keypad device\n");
-		error = -ENOMEM;
-		goto err_alloc;
-	}
-
-	input_dev->name = DRIVER_NAME;
-	input_dev->id.bustype = BUS_HOST;
-	input_dev->open = pxakbd_open;
-	input_dev->close = pxakbd_close;
-	input_dev->dev.parent = &pdev->dev;
-
-	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
-		BIT_MASK(EV_REL);
-	input_dev->relbit[BIT_WORD(REL_WHEEL)] = BIT_MASK(REL_WHEEL);
-	for (row = 0; row < pdata->nr_rows; row++) {
-		for (col = 0; col < pdata->nr_cols; col++) {
-			int code = pdata->keycodes[row][col];
-			if (code > 0)
-				set_bit(code, input_dev->keybit);
-		}
-	}
-
-	error = request_irq(IRQ_KEYPAD, pxakbd_irq_handler, IRQF_DISABLED,
-			    DRIVER_NAME, pdev);
-	if (error) {
-		printk(KERN_ERR "Cannot request keypad IRQ\n");
-		goto err_free_dev;
-	}
-
-	platform_set_drvdata(pdev, input_dev);
-
-	/* Register the input device */
-	error = input_register_device(input_dev);
-	if (error)
-		goto err_free_irq;
-
-	/* Setup GPIOs. */
-	for (i = 0; i < pdata->nr_rows + pdata->nr_cols; i++)
-		pxa_gpio_mode(pdata->gpio_modes[i]);
-
-	/*
-	 * Store rows/cols info into keyboard registers.
-	 */
-
-	KPC |= (pdata->nr_rows - 1) << 26;
-	KPC |= (pdata->nr_cols - 1) << 23;
-
-	for (col = 0; col < pdata->nr_cols; col++)
-		KPC |= KPC_MS0 << col;
-
-	return 0;
-
- err_free_irq:
-	platform_set_drvdata(pdev, NULL);
-	free_irq(IRQ_KEYPAD, pdev);
- err_free_dev:
-	input_free_device(input_dev);
- err_alloc:
-	clk_put(pxakbd_clk);
- err_clk:
-	return error;
-}
-
-static int __devexit pxakbd_remove(struct platform_device *pdev)
-{
-	struct input_dev *input_dev = platform_get_drvdata(pdev);
-
-	input_unregister_device(input_dev);
-	free_irq(IRQ_KEYPAD, pdev);
-	clk_put(pxakbd_clk);
-	platform_set_drvdata(pdev, NULL);
-
-	return 0;
-}
-
-static struct platform_driver pxakbd_driver = {
-	.probe		= pxakbd_probe,
-	.remove		= __devexit_p(pxakbd_remove),
-	.suspend	= pxakbd_suspend,
-	.resume		= pxakbd_resume,
-	.driver		= {
-		.name	= DRIVER_NAME,
-	},
-};
-
-static int __init pxakbd_init(void)
-{
-	return platform_driver_register(&pxakbd_driver);
-}
-
-static void __exit pxakbd_exit(void)
-{
-	platform_driver_unregister(&pxakbd_driver);
-}
-
-module_init(pxakbd_init);
-module_exit(pxakbd_exit);
-
-MODULE_DESCRIPTION("PXA27x Matrix Keyboard Driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/input/keyboard/pxa27x_keypad.c
b/drivers/input/keyboard/pxa27x_keypad.c
new file mode 100644
index 0000000..06c1d5a
--- /dev/null
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -0,0 +1,274 @@
+/*
+ * linux/drivers/input/keyboard/pxa27x_keypad.c
+ *
+ * Driver for the pxa27x matrix keyboard controller.
+ *
+ * Created:	Feb 22, 2007
+ * Author:	Rodolfo Giometti <giometti@linux.it>
+ *
+ * Based on a previous implementations by Kevin O'Connor
+ * <kevin_at_koconnor.net> and Alex Osborne <bobofdoom@gmail.com> and
+ * on some suggestions by Nicolas Pitre <nico@cam.org>.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
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
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include <asm/arch/hardware.h>
+#include <asm/arch/pxa-regs.h>
+#include <asm/arch/irqs.h>
+#include <asm/arch/pxa27x_keypad.h>
+
+#define DRIVER_NAME		"pxa27x-keypad"
+
+#define KPASMKP(col)		(col/2 == 0 ? KPASMKP0 : \
+				 col/2 == 1 ? KPASMKP1 : \
+				 col/2 == 2 ? KPASMKP2 : KPASMKP3)
+#define KPASMKPx_MKC(row, col)	(1 << (row + 16 * (col % 2)))
+
+static struct clk *pxa27x_keypad_clk;
+
+static irqreturn_t pxa27x_keypad_irq_handler(int irq, void *dev_id)
+{
+	struct platform_device *pdev = dev_id;
+	struct pxa27x_keypad_platform_data *pdata = pdev->dev.platform_data;
+	struct input_dev *input_dev = platform_get_drvdata(pdev);
+	unsigned long kpc = KPC;
+	int p, row, col, rel;
+
+	if (kpc & KPC_DI) {
+		unsigned long kpdk = KPDK;
+
+		if (!(kpdk & KPDK_DKP)) {
+			/* better luck next time */
+		} else if (kpc & KPC_REE0) {
+			unsigned long kprec = KPREC;
+			KPREC = 0x7f;
+
+			if (kprec & KPREC_OF0)
+				rel = (kprec & 0xff) + 0x7f;
+			else if (kprec & KPREC_UF0)
+				rel = (kprec & 0xff) - 0x7f - 0xff;
+			else
+				rel = (kprec & 0xff) - 0x7f;
+
+			if (rel) {
+				input_report_rel(input_dev, REL_WHEEL, rel);
+				input_sync(input_dev);
+			}
+		}
+	}
+
+	if (kpc & KPC_MI) {
+		/* report the status of every button */
+		for (row = 0; row < pdata->nr_rows; row++) {
+			for (col = 0; col < pdata->nr_cols; col++) {
+				p = KPASMKP(col) & KPASMKPx_MKC(row, col) ?
+					1 : 0;
+				pr_debug("keycode %x - pressed %x\n",
+						pdata->keycodes[row][col], p);
+				input_report_key(input_dev,
+						pdata->keycodes[row][col], p);
+			}
+		}
+		input_sync(input_dev);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int pxa27x_keypad_open(struct input_dev *dev)
+{
+	/* Set keypad control register */
+	KPC |= (KPC_ASACT |
+		KPC_MS_ALL |
+		(2 << 6) | KPC_REE0 | KPC_DK_DEB_SEL |
+		KPC_ME | KPC_MIE | KPC_DE | KPC_DIE);
+
+	KPC &= ~KPC_AS;         /* disable automatic scan */
+	KPC &= ~KPC_IMKP;       /* do not ignore multiple keypresses */
+
+	/* Set rotary count to mid-point value */
+	KPREC = 0x7F;
+
+	/* Enable unit clock */
+	clk_enable(pxa27x_keypad_clk);
+
+	return 0;
+}
+
+static void pxa27x_keypad_close(struct input_dev *dev)
+{
+	/* Disable clock unit */
+	clk_disable(pxa27x_keypad_clk);
+}
+
+#ifdef CONFIG_PM
+static int pxa27x_keypad_suspend(struct platform_device *pdev,
pm_message_t state)
+{
+	struct pxa27x_keypad_platform_data *pdata = pdev->dev.platform_data;
+
+	/* Save controller status */
+	pdata->reg_kpc = KPC;
+	pdata->reg_kprec = KPREC;
+
+	return 0;
+}
+
+static int pxa27x_keypad_resume(struct platform_device *pdev)
+{
+	struct pxa27x_keypad_platform_data *pdata = pdev->dev.platform_data;
+	struct input_dev *input_dev = platform_get_drvdata(pdev);
+
+	mutex_lock(&input_dev->mutex);
+
+	if (input_dev->users) {
+		/* Restore controller status */
+		KPC = pdata->reg_kpc;
+		KPREC = pdata->reg_kprec;
+
+		/* Enable unit clock */
+		clk_disable(pxa27x_keypad_clk);
+		clk_enable(pxa27x_keypad_clk);
+	}
+
+	mutex_unlock(&input_dev->mutex);
+
+	return 0;
+}
+#else
+#define pxa27x_keypad_suspend	NULL
+#define pxa27x_keypad_resume	NULL
+#endif
+
+static int __devinit pxa27x_keypad_probe(struct platform_device *pdev)
+{
+	struct pxa27x_keypad_platform_data *pdata = pdev->dev.platform_data;
+	struct input_dev *input_dev;
+	int i, row, col, error;
+
+	pxa27x_keypad_clk = clk_get(&pdev->dev, "KBDCLK");
+	if (IS_ERR(pxa27x_keypad_clk)) {
+		error = PTR_ERR(pxa27x_keypad_clk);
+		goto err_clk;
+	}
+
+	/* Create and register the input driver. */
+	input_dev = input_allocate_device();
+	if (!input_dev) {
+		printk(KERN_ERR "Cannot request keypad device\n");
+		error = -ENOMEM;
+		goto err_alloc;
+	}
+
+	input_dev->name = DRIVER_NAME;
+	input_dev->id.bustype = BUS_HOST;
+	input_dev->open = pxa27x_keypad_open;
+	input_dev->close = pxa27x_keypad_close;
+	input_dev->dev.parent = &pdev->dev;
+
+	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
+		BIT_MASK(EV_REL);
+	input_dev->relbit[BIT_WORD(REL_WHEEL)] = BIT_MASK(REL_WHEEL);
+	for (row = 0; row < pdata->nr_rows; row++) {
+		for (col = 0; col < pdata->nr_cols; col++) {
+			int code = pdata->keycodes[row][col];
+			if (code > 0)
+				set_bit(code, input_dev->keybit);
+		}
+	}
+
+	error = request_irq(IRQ_KEYPAD, pxa27x_keypad_irq_handler, IRQF_DISABLED,
+			    DRIVER_NAME, pdev);
+	if (error) {
+		printk(KERN_ERR "Cannot request keypad IRQ\n");
+		goto err_free_dev;
+	}
+
+	platform_set_drvdata(pdev, input_dev);
+
+	/* Register the input device */
+	error = input_register_device(input_dev);
+	if (error)
+		goto err_free_irq;
+
+	/* Setup GPIOs. */
+	for (i = 0; i < pdata->nr_rows + pdata->nr_cols; i++)
+		pxa_gpio_mode(pdata->gpio_modes[i]);
+
+	/*
+	 * Store rows/cols info into keyboard registers.
+	 */
+
+	KPC |= (pdata->nr_rows - 1) << 26;
+	KPC |= (pdata->nr_cols - 1) << 23;
+
+	for (col = 0; col < pdata->nr_cols; col++)
+		KPC |= KPC_MS0 << col;
+
+	return 0;
+
+ err_free_irq:
+	platform_set_drvdata(pdev, NULL);
+	free_irq(IRQ_KEYPAD, pdev);
+ err_free_dev:
+	input_free_device(input_dev);
+ err_alloc:
+	clk_put(pxa27x_keypad_clk);
+ err_clk:
+	return error;
+}
+
+static int __devexit pxa27x_keypad_remove(struct platform_device *pdev)
+{
+	struct input_dev *input_dev = platform_get_drvdata(pdev);
+
+	input_unregister_device(input_dev);
+	free_irq(IRQ_KEYPAD, pdev);
+	clk_put(pxa27x_keypad_clk);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver pxa27x_keypad_driver = {
+	.probe		= pxa27x_keypad_probe,
+	.remove		= __devexit_p(pxa27x_keypad_remove),
+	.suspend	= pxa27x_keypad_suspend,
+	.resume		= pxa27x_keypad_resume,
+	.driver		= {
+		.name	= DRIVER_NAME,
+	},
+};
+
+static int __init pxa27x_keypad_init(void)
+{
+	return platform_driver_register(&pxa27x_keypad_driver);
+}
+
+static void __exit pxa27x_keypad_exit(void)
+{
+	platform_driver_unregister(&pxa27x_keypad_driver);
+}
+
+module_init(pxa27x_keypad_init);
+module_exit(pxa27x_keypad_exit);
+
+MODULE_DESCRIPTION("PXA27x Keypad Controller Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/asm-arm/arch-pxa/pxa27x_keyboard.h
b/include/asm-arm/arch-pxa/pxa27x_keyboard.h
deleted file mode 100644
index 3aaff92..0000000
--- a/include/asm-arm/arch-pxa/pxa27x_keyboard.h
+++ /dev/null
@@ -1,13 +0,0 @@
-#define PXAKBD_MAXROW		8
-#define PXAKBD_MAXCOL		8
-
-struct pxa27x_keyboard_platform_data {
-	int nr_rows, nr_cols;
-	int keycodes[PXAKBD_MAXROW][PXAKBD_MAXCOL];
-	int gpio_modes[PXAKBD_MAXROW + PXAKBD_MAXCOL];
-
-#ifdef CONFIG_PM
-	u32 reg_kpc;
-	u32 reg_kprec;
-#endif
-};
diff --git a/include/asm-arm/arch-pxa/pxa27x_keypad.h
b/include/asm-arm/arch-pxa/pxa27x_keypad.h
new file mode 100644
index 0000000..f19f74a
--- /dev/null
+++ b/include/asm-arm/arch-pxa/pxa27x_keypad.h
@@ -0,0 +1,13 @@
+#define PXAKBD_MAXROW		8
+#define PXAKBD_MAXCOL		8
+
+struct pxa27x_keypad_platform_data {
+	int nr_rows, nr_cols;
+	int keycodes[PXAKBD_MAXROW][PXAKBD_MAXCOL];
+	int gpio_modes[PXAKBD_MAXROW + PXAKBD_MAXCOL];
+
+#ifdef CONFIG_PM
+	u32 reg_kpc;
+	u32 reg_kprec;
+#endif
+};
-- 
1.5.2.5.GIT



-- 
Cheers
- eric
