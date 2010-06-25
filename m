From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 3/3] input: samsung-keypad - Add samsung keypad driver
Date: Fri, 25 Jun 2010 01:30:19 -0700
Message-ID: <20100625083019.GD8546@core.coreip.homeip.net>
References: <1277101605-2435-1-git-send-email-jy0922.shim@samsung.com>
 <1277101605-2435-3-git-send-email-jy0922.shim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1277101605-2435-3-git-send-email-jy0922.shim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, ben-linux@fluff.org, kyungmin.park@samsung.com, kgene.kim@samsung.com
List-Id: linux-input@vger.kernel.org

Hi Joonyoung,

On Mon, Jun 21, 2010 at 03:26:45PM +0900, Joonyoung Shim wrote:
> This patch adds support for keypad driver running on Samsung cpus. This
> driver is tested on GONI and Aquila board using S5PC110 cpu.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Following my conversation with Thomas Gleixner reagrding "long playing"
threaded interrupt handlers I tried to convert your driver to use this
concept. The idea is to keep polling within IRQ thread context instead
of using additional work/timer structures to simplify code and ensure
race-free shutdown/unbind.

I think it was based on v4 of your driver and I'd appreciate if you could
give it a try.

Thank you.

-- 
Dmitry



Input: samsung-keypad - updates

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 arch/arm/plat-samsung/include/plat/keypad.h      |   21 -
 arch/arm/plat-samsung/include/plat/regs-keypad.h |   49 ---
 drivers/input/keyboard/samsung-keypad.c          |  334 ++++++++++++++--------
 3 files changed, 215 insertions(+), 189 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/regs-keypad.h


diff --git a/arch/arm/plat-samsung/include/plat/keypad.h b/arch/arm/plat-samsung/include/plat/keypad.h
index 04ba600..0a35784 100644
--- a/arch/arm/plat-samsung/include/plat/keypad.h
+++ b/arch/arm/plat-samsung/include/plat/keypad.h
@@ -34,24 +34,11 @@
  */
 struct samsung_keypad_platdata {
 	const struct matrix_keymap_data	*keymap_data;
-	unsigned int		rows;
-	unsigned int		cols;
-	unsigned int		rep:1;
+	unsigned int rows;
+	unsigned int cols;
+	bool rep;
 
-	void	(*cfg_gpio)(unsigned int rows, unsigned int cols);
+	void (*cfg_gpio)(unsigned int rows, unsigned int cols);
 };
 
-/**
- * samsung_keypad_set_platdata - Set platform data for Samsung Keypad device.
- * @pd: Platform data to register to device.
- *
- * Register the given platform data for use with Samsung Keypad device.
- * The call will copy the platform data, so the board definitions can
- * make the structure itself __initdata.
- */
-extern void samsung_keypad_set_platdata(struct samsung_keypad_platdata *pd);
-
-/* defined by architecture to configure gpio. */
-extern void samsung_keypad_cfg_gpio(unsigned int rows, unsigned int cols);
-
 #endif /* __PLAT_SAMSUNG_KEYPAD_H */
diff --git a/arch/arm/plat-samsung/include/plat/regs-keypad.h b/arch/arm/plat-samsung/include/plat/regs-keypad.h
deleted file mode 100644
index e4688f0..0000000
--- a/arch/arm/plat-samsung/include/plat/regs-keypad.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/*
- * linux/arch/arm/plat-samsung/include/plat/regs-keypad.h
- *
- * Copyright (C) 2010 Samsung Electronics Co.Ltd
- * Author: Joonyoung Shim <jy0922.shim@samsung.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
-
-#ifndef __SAMSUNG_KEYPAD_H__
-#define __SAMSUNG_KEYPAD_H__
-
-#define SAMSUNG_KEYIFCON			0x00
-#define SAMSUNG_KEYIFSTSCLR			0x04
-#define SAMSUNG_KEYIFCOL			0x08
-#define SAMSUNG_KEYIFROW			0x0c
-#define SAMSUNG_KEYIFFC				0x10
-
-/* SAMSUNG_KEYIFCON */
-#define SAMSUNG_KEYIFCON_INT_F_EN		(1 << 0)
-#define SAMSUNG_KEYIFCON_INT_R_EN		(1 << 1)
-#define SAMSUNG_KEYIFCON_DF_EN			(1 << 2)
-#define SAMSUNG_KEYIFCON_FC_EN			(1 << 3)
-#define SAMSUNG_KEYIFCON_WAKEUPEN		(1 << 4)
-
-/* SAMSUNG_KEYIFSTSCLR */
-#define SAMSUNG_KEYIFSTSCLR_P_INT_MASK		(0xff << 0)
-#define SAMSUNG_KEYIFSTSCLR_R_INT_MASK		(0xff << 8)
-#define SAMSUNG_KEYIFSTSCLR_R_INT_OFFSET	8
-#define S5PV210_KEYIFSTSCLR_P_INT_MASK		(0x3fff << 0)
-#define S5PV210_KEYIFSTSCLR_R_INT_MASK		(0x3fff << 16)
-#define S5PV210_KEYIFSTSCLR_R_INT_OFFSET	16
-
-/* SAMSUNG_KEYIFCOL */
-#define SAMSUNG_KEYIFCOL_MASK			(0xff << 0)
-#define S5PV210_KEYIFCOLEN_MASK			(0xff << 8)
-
-/* SAMSUNG_KEYIFROW */
-#define SAMSUNG_KEYIFROW_MASK			(0xff << 0)
-#define S5PV210_KEYIFROW_MASK			(0x3fff << 0)
-
-/* SAMSUNG_KEYIFFC */
-#define SAMSUNG_KEYIFFC_MASK			(0x3ff << 0)
-
-#endif /* __SAMSUNG_KEYPAD_H__ */
diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index 244a3b6..c243fc5 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -1,5 +1,5 @@
 /*
- * samsung-keypad.c  --  Samsung keypad driver
+ * Samsung keypad driver
  *
  * Copyright (C) 2010 Samsung Electronics Co.Ltd
  * Author: Joonyoung Shim <jy0922.shim@samsung.com>
@@ -21,8 +21,45 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-#include <plat/keypad.h>
-#include <plat/regs-keypad.h>
+//#include <plat/keypad.h>
+#include "/home/dtor/kernel/work/arch/arm/plat-samsung/include/plat/keypad.h"
+
+MODULE_DESCRIPTION("Samsung keypad driver");
+MODULE_AUTHOR("Joonyoung Shim <jy0922.shim@samsung.com>");
+MODULE_AUTHOR("Donghwa Lee <dh09.lee@samsung.com>");
+MODULE_LICENSE("GPL");
+
+#define SAMSUNG_KEYIFCON			0x00
+#define SAMSUNG_KEYIFSTSCLR			0x04
+#define SAMSUNG_KEYIFCOL			0x08
+#define SAMSUNG_KEYIFROW			0x0c
+#define SAMSUNG_KEYIFFC				0x10
+
+/* SAMSUNG_KEYIFCON */
+#define SAMSUNG_KEYIFCON_INT_F_EN		(1 << 0)
+#define SAMSUNG_KEYIFCON_INT_R_EN		(1 << 1)
+#define SAMSUNG_KEYIFCON_DF_EN			(1 << 2)
+#define SAMSUNG_KEYIFCON_FC_EN			(1 << 3)
+#define SAMSUNG_KEYIFCON_WAKEUPEN		(1 << 4)
+
+/* SAMSUNG_KEYIFSTSCLR */
+#define SAMSUNG_KEYIFSTSCLR_P_INT_MASK		(0xff << 0)
+#define SAMSUNG_KEYIFSTSCLR_R_INT_MASK		(0xff << 8)
+#define SAMSUNG_KEYIFSTSCLR_R_INT_OFFSET	8
+#define S5PV210_KEYIFSTSCLR_P_INT_MASK		(0x3fff << 0)
+#define S5PV210_KEYIFSTSCLR_R_INT_MASK		(0x3fff << 16)
+#define S5PV210_KEYIFSTSCLR_R_INT_OFFSET	16
+
+/* SAMSUNG_KEYIFCOL */
+#define SAMSUNG_KEYIFCOL_MASK			(0xff << 0)
+#define S5PV210_KEYIFCOLEN_MASK			(0xff << 8)
+
+/* SAMSUNG_KEYIFROW */
+#define SAMSUNG_KEYIFROW_MASK			(0xff << 0)
+#define S5PV210_KEYIFROW_MASK			(0x3fff << 0)
+
+/* SAMSUNG_KEYIFFC */
+#define SAMSUNG_KEYIFFC_MASK			(0x3ff << 0)
 
 enum samsung_keypad_type {
 	KEYPAD_TYPE_SAMSUNG,
@@ -31,29 +68,28 @@ enum samsung_keypad_type {
 
 struct samsung_keypad {
 	struct input_dev *input_dev;
-	struct timer_list timer;
 	struct clk *clk;
-	struct work_struct work;
 	void __iomem *base;
-	unsigned short *keycodes;
+	wait_queue_head_t wait;
+	bool stopped;
+	int irq;
 	unsigned int row_shift;
 	unsigned int rows;
 	unsigned int cols;
 	unsigned int row_state[SAMSUNG_MAX_COLS];
-	int irq;
+	unsigned short keycodes[];
 };
 
 static int samsung_keypad_is_s5pv210(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	enum samsung_keypad_type type;
+	enum samsung_keypad_type type = platform_get_device_id(pdev)->driver_data;
 
-	type = platform_get_device_id(pdev)->driver_data;
 	return type == KEYPAD_TYPE_S5PV210;
 }
 
 static void samsung_keypad_scan(struct samsung_keypad *keypad,
-		unsigned int *row_state)
+				unsigned int *row_state)
 {
 	struct device *dev = keypad->input_dev->dev.parent;
 	unsigned int col;
@@ -79,29 +115,15 @@ static void samsung_keypad_scan(struct samsung_keypad *keypad,
 	writel(0, keypad->base + SAMSUNG_KEYIFCOL);
 }
 
-static void samsung_keypad_worker(struct work_struct *work)
+static bool samsung_keypad_report(struct samsung_keypad *keypad,
+				  unsigned int *row_state)
 {
-	struct samsung_keypad *keypad = container_of(work,
-			struct samsung_keypad, work);
-	unsigned int row_state[SAMSUNG_MAX_COLS];
-	unsigned int val;
+	struct input_dev *input_dev = keypad->input_dev;
 	unsigned int changed;
 	unsigned int pressed;
 	unsigned int key_down = 0;
-	int col, row;
-
-	clk_enable(keypad->clk);
-
-	val = readl(keypad->base + SAMSUNG_KEYIFSTSCLR);
-
-	/* interrupt clear */
-	writel(~0x0, keypad->base + SAMSUNG_KEYIFSTSCLR);
-
-	val = readl(keypad->base + SAMSUNG_KEYIFCON);
-	val &= ~(SAMSUNG_KEYIFCON_INT_F_EN | SAMSUNG_KEYIFCON_INT_R_EN);
-	writel(val, keypad->base + SAMSUNG_KEYIFCON);
-
-	samsung_keypad_scan(keypad, row_state);
+	unsigned int val;
+	unsigned int col, row;
 
 	for (col = 0; col < keypad->cols; col++) {
 		changed = row_state[col] ^ keypad->row_state[col];
@@ -121,42 +143,108 @@ static void samsung_keypad_worker(struct work_struct *work)
 
 			val = MATRIX_SCAN_CODE(row, col, keypad->row_shift);
 
-			input_report_key(keypad->input_dev,
+			input_event(input_dev, EV_MSC, MSC_SCAN, val);
+			input_report_key(input_dev,
 					keypad->keycodes[val], pressed);
-			input_sync(keypad->input_dev);
 		}
+		input_sync(keypad->input_dev);
 	}
+
 	memcpy(keypad->row_state, row_state, sizeof(row_state));
 
-	if (key_down)
-		mod_timer(&keypad->timer, jiffies + HZ / 20);
-	else {
-		/* enable interrupt bit */
-		val = readl(keypad->base + SAMSUNG_KEYIFCON);
-		val |= (SAMSUNG_KEYIFCON_INT_F_EN | SAMSUNG_KEYIFCON_INT_R_EN);
-		writel(val, keypad->base + SAMSUNG_KEYIFCON);
-		enable_irq(keypad->irq);
-	}
-	clk_disable(keypad->clk);
+	return key_down;
 }
 
-static irqreturn_t samsung_keypad_interrupt(int irq, void *dev_id)
+static irqreturn_t samsung_keypad_irq(int irq, void *dev_id)
 {
 	struct samsung_keypad *keypad = dev_id;
+	unsigned int row_state[SAMSUNG_MAX_COLS];
+	unsigned int val;
+	bool key_down;
 
-	if (!work_pending(&keypad->work)) {
-		disable_irq_nosync(keypad->irq);
-		schedule_work(&keypad->work);
-	}
+	do {
+		clk_enable(keypad->clk);
+
+		val = readl(keypad->base + SAMSUNG_KEYIFSTSCLR);
+		/* Clear interrupt. */
+		writel(~0x0, keypad->base + SAMSUNG_KEYIFSTSCLR);
+
+		samsung_keypad_scan(keypad, row_state);
+
+		clk_disable(keypad->clk);
+
+		key_down = samsung_keypad_report(keypad, row_state);
+		if (key_down)
+			wait_event_timeout(keypad->wait, keypad->stopped,
+					   msecs_to_jiffies(50));
+
+	} while (key_down && !keypad->stopped);
 
 	return IRQ_HANDLED;
 }
 
-static void samsung_keypad_timer(unsigned long data)
+static void samsung_keypad_start(struct samsung_keypad *keypad)
+{
+	unsigned int val;
+
+	/* Tell IRQ thread that it may poll the device. */
+	keypad->stopped = false;
+
+	clk_enable(keypad->clk);
+
+	/* Enable interrupt bits. */
+	val = readl(keypad->base + SAMSUNG_KEYIFCON);
+	val |= SAMSUNG_KEYIFCON_INT_F_EN | SAMSUNG_KEYIFCON_INT_R_EN;
+	writel(val, keypad->base + SAMSUNG_KEYIFCON);
+
+	/* KEYIFCOL reg clear. */
+	writel(0, keypad->base + SAMSUNG_KEYIFCOL);
+
+	clk_disable(keypad->clk);
+}
+
+static void samsung_keypad_stop(struct samsung_keypad *keypad)
 {
-	struct samsung_keypad *keypad = (struct samsung_keypad *)data;
+	unsigned int val;
+
+	/* Signal IRQ thread to stop polling and disable the handler. */
+	keypad->stopped = true;
+	wake_up(&keypad->wait);
+	disable_irq(keypad->irq);
 
-	schedule_work(&keypad->work);
+	clk_enable(keypad->clk);
+
+	/* Clear interrupt. */
+	writel(~0x0, keypad->base + SAMSUNG_KEYIFSTSCLR);
+
+	/* Disable interrupt bits. */
+	val = readl(keypad->base + SAMSUNG_KEYIFCON);
+	val &= ~(SAMSUNG_KEYIFCON_INT_F_EN | SAMSUNG_KEYIFCON_INT_R_EN);
+	writel(val, keypad->base + SAMSUNG_KEYIFCON);
+
+	clk_disable(keypad->clk);
+
+	/*
+	 * Now that chip should not generate interrupts we can safely
+	 * re-enable the handler.
+	 */
+	enable_irq(keypad->irq);
+}
+
+static int samsung_keypad_open(struct input_dev *input_dev)
+{
+	struct samsung_keypad *keypad = input_get_drvdata(input_dev);
+
+	samsung_keypad_start(keypad);
+
+	return 0;
+}
+
+static void samsung_keypad_close(struct input_dev *input_dev)
+{
+	struct samsung_keypad *keypad = input_get_drvdata(input_dev);
+
+	samsung_keypad_stop(keypad);
 }
 
 static int __devinit samsung_keypad_probe(struct platform_device *pdev)
@@ -166,10 +254,9 @@ static int __devinit samsung_keypad_probe(struct platform_device *pdev)
 	struct samsung_keypad *keypad;
 	struct resource *res;
 	struct input_dev *input_dev;
-	unsigned short *keycodes;
 	unsigned int row_shift;
-	unsigned int val;
-	int ret;
+	unsigned int keymap_size;
+	int error;
 
 	pdata = pdev->dev.platform_data;
 	if (!pdata) {
@@ -183,10 +270,10 @@ static int __devinit samsung_keypad_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	if (!pdata->rows || (pdata->rows > SAMSUNG_MAX_ROWS))
+	if (!pdata->rows || pdata->rows > SAMSUNG_MAX_ROWS)
 		return -EINVAL;
 
-	if (!pdata->cols || (pdata->cols > SAMSUNG_MAX_COLS))
+	if (!pdata->cols || pdata->cols > SAMSUNG_MAX_COLS)
 		return -EINVAL;
 
 	/* initialize the gpio */
@@ -194,133 +281,144 @@ static int __devinit samsung_keypad_probe(struct platform_device *pdev)
 		pdata->cfg_gpio(pdata->rows, pdata->cols);
 
 	row_shift = get_count_order(pdata->cols);
-	keypad = kzalloc(sizeof(*keypad), GFP_KERNEL);
-	keycodes = kzalloc((pdata->rows << row_shift) * sizeof(*keycodes),
-			GFP_KERNEL);
+	keymap_size = (pdata->rows << row_shift) * sizeof(keypad->keycodes[0]);
+
+	keypad = kzalloc(sizeof(*keypad) + keymap_size, GFP_KERNEL);
 	input_dev = input_allocate_device();
-	if (!keypad || !keycodes || !input_dev) {
-		ret = -ENOMEM;
+	if (!keypad || !input_dev) {
+		error = -ENOMEM;
 		goto err_free_mem;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
-		ret = -ENODEV;
+		error = -ENODEV;
 		goto err_free_mem;
 	}
 
 	keypad->base = ioremap(res->start, resource_size(res));
 	if (!keypad->base) {
-		ret = -EBUSY;
+		error = -EBUSY;
 		goto err_free_mem;
 	}
 
 	keypad->clk = clk_get(&pdev->dev, "keypad");
 	if (IS_ERR(keypad->clk)) {
 		dev_err(&pdev->dev, "failed to get keypad clk\n");
-		ret = PTR_ERR(keypad->clk);
+		error = PTR_ERR(keypad->clk);
 		goto err_unmap_base;
 	}
-	clk_enable(keypad->clk);
 
 	keypad->input_dev = input_dev;
-	keypad->keycodes = keycodes;
 	keypad->row_shift = row_shift;
 	keypad->rows = pdata->rows;
 	keypad->cols = pdata->cols;
-
-	INIT_WORK(&keypad->work, samsung_keypad_worker);
-
-	setup_timer(&keypad->timer, samsung_keypad_timer,
-			(unsigned long)keypad);
-
-	/* enable interrupt and wakeup bit */
-	val = SAMSUNG_KEYIFCON_INT_F_EN | SAMSUNG_KEYIFCON_INT_R_EN |
-		SAMSUNG_KEYIFCON_WAKEUPEN;
-	writel(val, keypad->base + SAMSUNG_KEYIFCON);
-
-	/* KEYIFCOL reg clear */
-	writel(0, keypad->base + SAMSUNG_KEYIFCOL);
-
-	keypad->irq = platform_get_irq(pdev, 0);
-	if (keypad->irq < 0) {
-		ret = keypad->irq;
-		goto err_disable_clk;
-	}
-
-	ret = request_irq(keypad->irq, samsung_keypad_interrupt, 0,
-			dev_name(&pdev->dev), keypad);
-
-	if (ret)
-		goto err_disable_clk;
+	init_waitqueue_head(&keypad->wait);
 
 	input_dev->name = pdev->name;
 	input_dev->id.bustype = BUS_HOST;
 	input_dev->dev.parent = &pdev->dev;
+	input_set_drvdata(input_dev, keypad);
+
+	input_dev->open = samsung_keypad_open;
+	input_dev->close = samsung_keypad_close;
 
 	input_dev->evbit[0] = BIT_MASK(EV_KEY);
 	if (pdata->rep)
 		input_dev->evbit[0] |= BIT_MASK(EV_REP);
 
-	input_dev->keycode = keycodes;
-	input_dev->keycodesize = sizeof(*keycodes);
+	input_dev->keycode = keypad->keycodes;
+	input_dev->keycodesize = sizeof(keypad->keycodes[0]);
 	input_dev->keycodemax = pdata->rows << row_shift;
 
 	matrix_keypad_build_keymap(keymap_data, row_shift,
 			input_dev->keycode, input_dev->keybit);
 
-	ret = input_register_device(keypad->input_dev);
-	if (ret)
+	keypad->irq = platform_get_irq(pdev, 0);
+	if (keypad->irq < 0) {
+		error = keypad->irq;
+		goto err_put_clk;
+	}
+
+	error = request_threaded_irq(keypad->irq, NULL, samsung_keypad_irq,
+				     IRQF_ONESHOT, dev_name(&pdev->dev), keypad);
+	if (error)
+		goto err_put_clk;
+
+	error = input_register_device(keypad->input_dev);
+	if (error)
 		goto err_free_irq;
 
 	platform_set_drvdata(pdev, keypad);
-	clk_disable(keypad->clk);
-
 	return 0;
 
 err_free_irq:
 	free_irq(keypad->irq, keypad);
-err_disable_clk:
-	clk_disable(keypad->clk);
+err_put_clk:
 	clk_put(keypad->clk);
 err_unmap_base:
 	iounmap(keypad->base);
 err_free_mem:
 	input_free_device(input_dev);
-	kfree(keycodes);
 	kfree(keypad);
 
-	return ret;
+	return error;
 }
 
 static int __devexit samsung_keypad_remove(struct platform_device *pdev)
 {
 	struct samsung_keypad *keypad = platform_get_drvdata(pdev);
 
-	free_irq(keypad->irq, keypad);
-	cancel_work_sync(&keypad->work);
-	del_timer_sync(&keypad->timer);
-
 	platform_set_drvdata(pdev, NULL);
+
 	input_unregister_device(keypad->input_dev);
 
-	clk_disable(keypad->clk);
+	/*
+	 * It is safe to free IRQ after unregistering device because
+	 * samsung_keypad_close will shut off interrupts.
+	 */
+	free_irq(keypad->irq, keypad);
+
 	clk_put(keypad->clk);
 
 	iounmap(keypad->base);
-	kfree(keypad->keycodes);
 	kfree(keypad);
 
 	return 0;
 }
 
 #ifdef CONFIG_PM
+static void samsung_keypad_toggle_wakeup(struct samsung_keypad *keypad,
+					 bool enable)
+{
+	unsigned int val;
+
+	clk_enable(keypad->clk);
+
+	val = readl(keypad->base + SAMSUNG_KEYIFCON);
+	if (enable)
+		val |= SAMSUNG_KEYIFCON_WAKEUPEN;
+	else
+		val &= ~SAMSUNG_KEYIFCON_WAKEUPEN;
+	writel(val, keypad->base + SAMSUNG_KEYIFCON);
+
+	clk_disable(keypad->clk);
+}
+
 static int samsung_keypad_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct samsung_keypad *keypad = platform_get_drvdata(pdev);
+	struct input_dev *input_dev = keypad->input_dev;
 
-	disable_irq(keypad->irq);
+	mutex_lock(&input_dev->mutex);
+
+	if (input_dev->users)
+		samsung_keypad_stop(keypad);
+
+	samsung_keypad_toggle_wakeup(keypad, true);
+
+	mutex_unlock(&input_dev->mutex);
 
 	return 0;
 }
@@ -329,20 +427,16 @@ static int samsung_keypad_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct samsung_keypad *keypad = platform_get_drvdata(pdev);
-	unsigned int val;
+	struct input_dev *input_dev = keypad->input_dev;
 
-	clk_enable(keypad->clk);
+	mutex_lock(&input_dev->mutex);
 
-	/* enable interrupt and wakeup bit */
-	val = SAMSUNG_KEYIFCON_INT_F_EN | SAMSUNG_KEYIFCON_INT_R_EN |
-		SAMSUNG_KEYIFCON_WAKEUPEN;
-	writel(val, keypad->base + SAMSUNG_KEYIFCON);
+	samsung_keypad_toggle_wakeup(keypad, false);
 
-	/* KEYIFCOL reg clear */
-	writel(0, keypad->base + SAMSUNG_KEYIFCOL);
+	if (input_dev->users)
+		samsung_keypad_start(keypad);
 
-	enable_irq(keypad->irq);
-	clk_disable(keypad->clk);
+	mutex_unlock(&input_dev->mutex);
 
 	return 0;
 }
@@ -382,16 +476,10 @@ static int __init samsung_keypad_init(void)
 {
 	return platform_driver_register(&samsung_keypad_driver);
 }
+module_init(samsung_keypad_init);
 
 static void __exit samsung_keypad_exit(void)
 {
 	platform_driver_unregister(&samsung_keypad_driver);
 }
-
-module_init(samsung_keypad_init);
 module_exit(samsung_keypad_exit);
-
-MODULE_DESCRIPTION("Samsung keypad driver");
-MODULE_AUTHOR("Joonyoung Shim <jy0922.shim@samsung.com>");
-MODULE_AUTHOR("Donghwa Lee <dh09.lee@samsung.com>");
-MODULE_LICENSE("GPL");
