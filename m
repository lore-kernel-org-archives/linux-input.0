From: Sundar Iyer <sundar.iyer@stericsson.com>
Subject: [Patch v7 1/2] input: add support for Nomadik SKE keypad controller
Date: Tue, 28 Sep 2010 15:02:04 +0530
Message-ID: <1285666324-14578-1-git-send-email-sundar.iyer@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:49632 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753576Ab0I1JcX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Sep 2010 05:32:23 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Sundar Iyer <sundar.iyer@stericsson.com>, Dmitry Torokhov <dtor@mail.ru>, Linus Walleij <linus.walleij@stericsson.com>

Add support for the keypad controller in the Scroll Key Encoder (SKE)
module on the Nomadik family and the DB8500 SoC.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Sundar Iyer <sundar.iyer@stericsson.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
Changes:

v6:
 - re-orged the probe routine as per Dmitry's suggestions.

v5:
 - re-orged IRQ handler according to Dmitry's comments about
   "retries" for ASRx registers getting stabilized.

v4:
 - IRQ handler is no longer threaded
 - incorporated Dmitry's comments to make sure multikey is working
 - assorted comments from Trilok
 - pin configuration mistake pointed out thanx to Kwangwoo LEE

v3:
 - fixed Dmitry's comments assorted comments,
 - re-orged the IRQ to include a timer instead of cpu_relax()

 arch/arm/plat-nomadik/include/plat/ske.h    |   50 ++++
 drivers/input/keyboard/Kconfig              |   10 +
 drivers/input/keyboard/Makefile             |    1 +
 drivers/input/keyboard/nomadik-ske-keypad.c |  408 +++++++++++++++++++++++++++
 4 files changed, 469 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-nomadik/include/plat/ske.h
 create mode 100644 drivers/input/keyboard/nomadik-ske-keypad.c

diff --git a/arch/arm/plat-nomadik/include/plat/ske.h b/arch/arm/plat-nomadik/include/plat/ske.h
new file mode 100644
index 0000000..148b2bc
--- /dev/null
+++ b/arch/arm/plat-nomadik/include/plat/ske.h
@@ -0,0 +1,50 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * License Terms: GNU General Public License v2
+ * Author: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
+ *
+ * ux500 Scroll key and Keypad Encoder (SKE) header
+ */
+
+#ifndef __SKE_H
+#define __SKE_H
+
+#include <linux/input/matrix_keypad.h>
+
+/* register definitions for SKE peripheral */
+#define SKE_CR		0x00
+#define SKE_VAL0	0x04
+#define SKE_VAL1	0x08
+#define SKE_DBCR	0x0C
+#define SKE_IMSC	0x10
+#define SKE_RIS		0x14
+#define SKE_MIS		0x18
+#define SKE_ICR		0x1C
+
+/*
+ * Keypad module
+ */
+
+/**
+ * struct keypad_platform_data - structure for platform specific data
+ * @init:	pointer to keypad init function
+ * @exit:	pointer to keypad deinitialisation function
+ * @keymap_data: matrix scan code table for keycodes
+ * @krow:	maximum number of rows
+ * @kcol:	maximum number of columns
+ * @debounce_ms: platform specific debounce time
+ * @no_autorepeat: flag for auto repetition
+ * @wakeup_enable: allow waking up the system
+ */
+struct ske_keypad_platform_data {
+	int (*init)(void);
+	int (*exit)(void);
+	struct matrix_keymap_data *keymap_data;
+	u8 krow;
+	u8 kcol;
+	u8 debounce_ms;
+	bool no_autorepeat;
+	bool wakeup_enable;
+};
+#endif	/*__SKE_KPD_H*/
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 89a3227..7dacba3 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -327,6 +327,16 @@ config KEYBOARD_NEWTON
 	  To compile this driver as a module, choose M here: the
 	  module will be called newtonkbd.
 
+config KEYBOARD_NOMADIK
+	tristate "ST-Ericsson Nomadik SKE keyboard"
+	depends on PLAT_NOMADIK
+	help
+	  Say Y here if you want to use a keypad provided on the SKE controller
+	  used on the Ux500 and Nomadik platforms
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called nmk-ske-keypad.
+
 config KEYBOARD_OPENCORES
 	tristate "OpenCores Keyboard Controller"
 	help
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 1fde961..a34452e 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_KEYBOARD_MATRIX)		+= matrix_keypad.o
 obj-$(CONFIG_KEYBOARD_MAX7359)		+= max7359_keypad.o
 obj-$(CONFIG_KEYBOARD_MCS)		+= mcs_touchkey.o
 obj-$(CONFIG_KEYBOARD_NEWTON)		+= newtonkbd.o
+obj-$(CONFIG_KEYBOARD_NOMADIK)		+= nomadik-ske-keypad.o
 obj-$(CONFIG_KEYBOARD_OMAP)		+= omap-keypad.o
 obj-$(CONFIG_KEYBOARD_OMAP4)		+= omap4-keypad.o
 obj-$(CONFIG_KEYBOARD_OPENCORES)	+= opencores-kbd.o
diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
new file mode 100644
index 0000000..8c6ce8a
--- /dev/null
+++ b/drivers/input/keyboard/nomadik-ske-keypad.c
@@ -0,0 +1,408 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Naveen Kumar G <naveen.gaddipati@stericsson.com> for ST-Ericsson
+ * Author: Sundar Iyer <sundar.iyer@stericsson.com> for ST-Ericsson
+ *
+ * License terms:GNU General Public License (GPL) version 2
+ *
+ * Keypad controller driver for the SKE (Scroll Key Encoder) module used in
+ * the Nomadik 8815 and Ux500 platforms.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/input.h>
+#include <linux/slab.h>
+#include <linux/clk.h>
+
+#include <plat/ske.h>
+
+/* SKE_CR bits */
+#define SKE_KPMLT	(0x1 << 6)
+#define SKE_KPCN	(0x7 << 3)
+#define SKE_KPASEN	(0x1 << 2)
+#define SKE_KPASON	(0x1 << 7)
+
+/* SKE_IMSC bits */
+#define SKE_KPIMA	(0x1 << 2)
+
+/* SKE_ICR bits */
+#define SKE_KPICS	(0x1 << 3)
+#define SKE_KPICA	(0x1 << 2)
+
+/* SKE_RIS bits */
+#define SKE_KPRISA	(0x1 << 2)
+
+#define SKE_KEYPAD_ROW_SHIFT	3
+#define SKE_KPD_KEYMAP_SIZE	(8 * 8)
+
+/* keypad auto scan registers */
+#define SKE_ASR0	0x20
+#define SKE_ASR1	0x24
+#define SKE_ASR2	0x28
+#define SKE_ASR3	0x2C
+
+#define SKE_NUM_ASRX_REGISTERS	(4)
+
+/**
+ * struct ske_keypad  - data structure used by keypad driver
+ * @irq:	irq no
+ * @reg_base:	ske regsiters base address
+ * @input:	pointer to input device object
+ * @board:	keypad platform device
+ * @keymap:	matrix scan code table for keycodes
+ * @clk:	clock structure pointer
+ */
+struct ske_keypad {
+	int irq;
+	void __iomem *reg_base;
+	struct input_dev *input;
+	const struct ske_keypad_platform_data *board;
+	unsigned short keymap[SKE_KPD_KEYMAP_SIZE];
+	struct clk *clk;
+	spinlock_t ske_keypad_lock;
+};
+
+static void ske_keypad_set_bits(struct ske_keypad *keypad, u16 addr,
+		u8 mask, u8 data)
+{
+	u32 ret;
+
+	spin_lock(&keypad->ske_keypad_lock);
+
+	ret = readl(keypad->reg_base + addr);
+	ret &= ~mask;
+	ret |= data;
+	writel(ret, keypad->reg_base + addr);
+
+	spin_unlock(&keypad->ske_keypad_lock);
+}
+
+/*
+ * ske_keypad_chip_init : init keypad controller configuration
+ *
+ * Enable Multi key press detection, auto scan mode
+ */
+static int __devinit ske_keypad_chip_init(struct ske_keypad *keypad)
+{
+	u32 value;
+	int timeout = 50;
+
+	/* check SKE_RIS to be 0 */
+	while ((readl(keypad->reg_base + SKE_RIS) != 0x00000000) && timeout--)
+		cpu_relax();
+
+	if (!timeout)
+		return -EINVAL;
+
+	/*
+	 * set debounce value
+	 * keypad dbounce is configured in DBCR[15:8]
+	 * dbounce value in steps of 32/32.768 ms
+	 */
+	spin_lock(&keypad->ske_keypad_lock);
+	value = readl(keypad->reg_base + SKE_DBCR);
+	value = value & 0xff;
+	value |= ((keypad->board->debounce_ms * 32000)/32768) << 8;
+	writel(value, keypad->reg_base + SKE_DBCR);
+	spin_unlock(&keypad->ske_keypad_lock);
+
+	/* enable multi key detection */
+	ske_keypad_set_bits(keypad, SKE_CR, 0x0, SKE_KPMLT);
+
+	/*
+	 * set up the number of columns
+	 * KPCN[5:3] defines no. of keypad columns to be auto scanned
+	 */
+	value = (keypad->board->kcol - 1) << 3;
+	ske_keypad_set_bits(keypad, SKE_CR, SKE_KPCN, value);
+
+	/* clear keypad interrupt for auto(and pending SW) scans */
+	ske_keypad_set_bits(keypad, SKE_ICR, 0x0, SKE_KPICA | SKE_KPICS);
+
+	/* un-mask keypad interrupts */
+	ske_keypad_set_bits(keypad, SKE_IMSC, 0x0, SKE_KPIMA);
+
+	/* enable automatic scan */
+	ske_keypad_set_bits(keypad, SKE_CR, 0x0, SKE_KPASEN);
+
+	return 0;
+}
+
+static void ske_keypad_read_data(struct ske_keypad *keypad)
+{
+	struct input_dev *input = keypad->input;
+	u16 status;
+	int col = 0, row = 0, code;
+	int ske_asr, ske_ris, key_pressed, i;
+
+	/*
+	 * Read the auto scan registers
+	 *
+	 * Each SKE_ASRx (x=0 to x=3) contains two row values.
+	 * lower byte contains row value for coloumn 2*x,
+	 * upper byte contains row value for column 2*x + 1
+	 */
+	for (i = 0; i < SKE_NUM_ASRX_REGISTERS; i++) {
+		ske_asr = readl(keypad->reg_base + SKE_ASR0 + (4 * i));
+		if (!ske_asr)
+			continue;
+
+		/* now that ASRx is zero, find out the coloumn x and row y*/
+		if (ske_asr & 0xff) {
+			col = i * 2;
+			status = ske_asr & 0xff;
+		} else {
+			col = (i * 2) + 1;
+			status = (ske_asr & 0xff00) >> 8;
+		}
+
+		/* find out the row */
+		row = __ffs(status);
+
+		code = MATRIX_SCAN_CODE(row, col, SKE_KEYPAD_ROW_SHIFT);
+		ske_ris = readl(keypad->reg_base + SKE_RIS);
+		key_pressed = ske_ris & SKE_KPRISA;
+
+		input_event(input, EV_MSC, MSC_SCAN, code);
+		input_report_key(input, keypad->keymap[code], key_pressed);
+		input_sync(input);
+	}
+}
+
+static irqreturn_t ske_keypad_irq(int irq, void *dev_id)
+{
+	struct ske_keypad *keypad = dev_id;
+	int retries = 20;
+
+	/* disable auto scan interrupt; mask the interrupt generated */
+	ske_keypad_set_bits(keypad, SKE_IMSC, ~SKE_KPIMA, 0x0);
+	ske_keypad_set_bits(keypad, SKE_ICR, 0x0, SKE_KPICA);
+
+	while ((readl(keypad->reg_base + SKE_CR) & SKE_KPASON) && --retries)
+		msleep(5);
+
+	if (retries) {
+		/* SKEx registers are stable and can be read */
+		ske_keypad_read_data(keypad);
+	}
+
+	/* enable auto scan interrupts */
+	ske_keypad_set_bits(keypad, SKE_IMSC, 0x0, SKE_KPIMA);
+
+	return IRQ_HANDLED;
+}
+
+static int __devinit ske_keypad_probe(struct platform_device *pdev)
+{
+	const struct ske_keypad_platform_data *plat = pdev->dev.platform_data;
+	struct ske_keypad *keypad;
+	struct input_dev *input;
+	struct resource *res;
+	int irq;
+	int error;
+
+	if (!plat) {
+		dev_err(&pdev->dev, "invalid keypad platform data\n");
+		return -EINVAL;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "failed to get keypad irq\n");
+		return -EINVAL;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "missing platform resources\n");
+		return -EINVAL;
+	}
+
+	keypad = kzalloc(sizeof(struct ske_keypad), GFP_KERNEL);
+	input = input_allocate_device();
+	if (!keypad || !input) {
+		dev_err(&pdev->dev, "failed to allocate keypad memory\n");
+		error = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	keypad->irq = irq;
+	keypad->board = plat;
+	keypad->input = input;
+	spin_lock_init(&keypad->ske_keypad_lock);
+
+	if (!request_mem_region(res->start, resource_size(res), pdev->name)) {
+		dev_err(&pdev->dev, "failed to request I/O memory\n");
+		error = -EBUSY;
+		goto err_free_mem;
+	}
+
+	keypad->reg_base = ioremap(res->start, resource_size(res));
+	if (!keypad->reg_base) {
+		dev_err(&pdev->dev, "failed to remap I/O memory\n");
+		error = -ENXIO;
+		goto err_free_mem_region;
+	}
+
+	keypad->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(keypad->clk)) {
+		dev_err(&pdev->dev, "failed to clk_get\n");
+		error = PTR_ERR(keypad->clk);
+		goto err_iounmap;
+	}
+
+	input->id.bustype = BUS_HOST;
+	input->name = "ux500-ske-keypad";
+	input->dev.parent = &pdev->dev;
+
+	input->keycode = keypad->keymap;
+	input->keycodesize = sizeof(keypad->keymap[0]);
+	input->keycodemax = ARRAY_SIZE(keypad->keymap);
+
+	input_set_capability(input, EV_MSC, MSC_SCAN);
+
+	__set_bit(EV_KEY, input->evbit);
+	if (!plat->no_autorepeat)
+		__set_bit(EV_REP, input->evbit);
+
+	matrix_keypad_build_keymap(plat->keymap_data, SKE_KEYPAD_ROW_SHIFT,
+			input->keycode, input->keybit);
+
+	clk_enable(keypad->clk);
+
+	/* go through board initialization helpers */
+	if (keypad->board->init)
+		keypad->board->init();
+
+	error = ske_keypad_chip_init(keypad);
+	if (error) {
+		dev_err(&pdev->dev, "unable to init keypad hardware\n");
+		goto err_clk_disable;
+	}
+
+	error = request_irq(keypad->irq, ske_keypad_irq, 0,
+			"ske-keypad", keypad);
+	if (error) {
+		dev_err(&pdev->dev, "allocate irq %d failed\n", keypad->irq);
+		goto err_clk_disable;
+	}
+
+	error = input_register_device(input);
+	if (error) {
+		dev_err(&pdev->dev,
+				"unable to register input device: %d\n", error);
+		goto err_free_irq;
+	}
+
+	if (plat->wakeup_enable)
+		device_init_wakeup(&pdev->dev, true);
+
+	platform_set_drvdata(pdev, keypad);
+
+	return 0;
+
+err_free_irq:
+	free_irq(keypad->irq, keypad);
+err_clk_disable:
+	clk_disable(keypad->clk);
+	clk_put(keypad->clk);
+err_iounmap:
+	iounmap(keypad->reg_base);
+err_free_mem_region:
+	release_mem_region(res->start, resource_size(res));
+err_free_mem:
+	input_free_device(input);
+	kfree(keypad);
+	return error;
+}
+
+static int __devexit ske_keypad_remove(struct platform_device *pdev)
+{
+	struct ske_keypad *keypad = platform_get_drvdata(pdev);
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	free_irq(keypad->irq, keypad);
+
+	input_unregister_device(keypad->input);
+
+	clk_disable(keypad->clk);
+	clk_put(keypad->clk);
+
+	if (keypad->board->exit)
+		keypad->board->exit();
+
+	iounmap(keypad->reg_base);
+	release_mem_region(res->start, resource_size(res));
+	kfree(keypad);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int ske_keypad_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct ske_keypad *keypad = platform_get_drvdata(pdev);
+	int irq = platform_get_irq(pdev, 0);
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(irq);
+	else
+		ske_keypad_set_bits(keypad, SKE_IMSC, ~SKE_KPIMA, 0x0);
+
+	return 0;
+}
+
+static int ske_keypad_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct ske_keypad *keypad = platform_get_drvdata(pdev);
+	int irq = platform_get_irq(pdev, 0);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(irq);
+	else
+		ske_keypad_set_bits(keypad, SKE_IMSC, 0x0, SKE_KPIMA);
+
+	return 0;
+}
+
+static const struct dev_pm_ops ske_keypad_dev_pm_ops = {
+	.suspend = ske_keypad_suspend,
+	.resume = ske_keypad_resume,
+};
+#endif
+
+struct platform_driver ske_keypad_driver = {
+	.driver = {
+		.name = "nmk-ske-keypad",
+		.owner  = THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm = &ske_keypad_dev_pm_ops,
+#endif
+	},
+	.probe = ske_keypad_probe,
+	.remove = __devexit_p(ske_keypad_remove),
+};
+
+static int __init ske_keypad_init(void)
+{
+	return platform_driver_probe(&ske_keypad_driver, ske_keypad_probe);
+}
+module_init(ske_keypad_init);
+
+static void __exit ske_keypad_exit(void)
+{
+	platform_driver_unregister(&ske_keypad_driver);
+}
+module_exit(ske_keypad_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Naveen Kumar <naveen.gaddipati@stericsson.com> / Sundar Iyer <sundar.iyer@stericsson.com>");
+MODULE_DESCRIPTION("Nomadik Scroll-Key-Encoder Keypad Driver");
+MODULE_ALIAS("platform:nomadik-ske-keypad");
-- 
1.7.2.dirty

