From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 6/7] input/nomadik-ske: add sleepy GPIO mode
Date: Sun, 13 May 2012 14:44:17 +0200
Message-ID: <1336913057-10189-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:47236 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752342Ab2EMMo0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 May 2012 08:44:26 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Karl-Johan Perntz <karl-johan.perntz@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

From: Karl-Johan Perntz <karl-johan.perntz@stericsson.com>

The pins used by the SKE keypad matrix may also be used as GPIO
pins. By cleverly switching the block between common active mode
and GPIO mode, we may save power.

This patch makes it possible to supply and two arrays of GPIO
pins corresponding to the rows and columns of the SKE, and will
make the driver switch to just waiting for something to happen on
the GPIO lines when nothing is happening on the keypad. Whenever
something happens, causing a GPIO interrupt, the driver switches
back to SKE mode and enables the matrix keypad hardware again.

We have found that this way of doing things makes the SKE consume
considerably less power.

Signed-off-by: Karl-Johan Perntz <karl-johan.perntz@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/plat-nomadik/include/plat/ske.h    |   20 +-
 drivers/input/keyboard/nomadik-ske-keypad.c |  261 +++++++++++++++++++++++++--
 2 files changed, 265 insertions(+), 16 deletions(-)

diff --git a/arch/arm/plat-nomadik/include/plat/ske.h b/arch/arm/plat-nomadik/include/plat/ske.h
index d6002dd..f5e0ff8 100644
--- a/arch/arm/plat-nomadik/include/plat/ske.h
+++ b/arch/arm/plat-nomadik/include/plat/ske.h
@@ -34,20 +34,30 @@
  * @init:	pointer to keypad init function
  * @exit:	pointer to keypad deinitialisation function
  * @keymap_data: matrix scan code table for keycodes
- * @krow:	maximum number of rows
- * @kcol:	maximum number of columns
  * @debounce_ms: platform specific debounce time
  * @no_autorepeat: flag for auto repetition
- * @wakeup_enable: allow waking up the system
+ * @wakeup_enable: allow waking up the system from the SKE block IRQ
+ * @gpio_wakeup_enable: allow waking up the system using GPIO interrups on the
+ *	SKE pins - mutually exclusive with wakeup_enable, which will be
+ *	disabled
+ * @gpio_switch_delay: gpio switch_delay
+ * @gpio_rows:	pointer to gpio input pins (rows)
+ * @gpio_cols:	pointer to gpio output pins (columns)
+ * @krow:	maximum number of rows
+ * @kcol:	maximum number of columns
  */
 struct ske_keypad_platform_data {
 	int (*init)(void);
 	int (*exit)(void);
 	const struct matrix_keymap_data *keymap_data;
-	u8 krow;
-	u8 kcol;
 	u8 debounce_ms;
 	bool no_autorepeat;
 	bool wakeup_enable;
+	bool gpio_wakeup_enable;
+	int gpio_switch_delay;
+	int *gpio_rows;
+	int *gpio_cols;
+	u8 krow;
+	u8 kcol;
 };
 #endif	/*__SKE_KPD_H*/
diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
index 86f7d41..d2cb4df 100644
--- a/drivers/input/keyboard/nomadik-ske-keypad.c
+++ b/drivers/input/keyboard/nomadik-ske-keypad.c
@@ -20,6 +20,7 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/module.h>
+#include <linux/gpio.h>
 
 #include <plat/ske.h>
 
@@ -65,7 +66,15 @@
  * @keymap:		matrix scan code table for keycodes
  * @clk:		clock structure pointer
  * @ske_keypad_lock:    lock used while writting into registers
+ * @enable:		flag to enable the SKE hardware
+ * @enable_on_resume:   set if keypad should be enabled on resume
  * @key_pressed:	hold the key state
+ * @gpio_wakeup:	if we should deactivate hardware and wake on IRQ
+ * @gpio_input_irq:	array for gpio irqs
+ * @gpio_switch_work:	delayed work variable for gpio switch
+ * @gpio_release_work:	delayed work variable for release gpio key
+ * @gpio_row:		gpio row
+ * @gpio_col:		gpio column
  * @keys:		matrix holding key status
  * @scan_work:		delayed work for scaning new key actions
  */
@@ -78,7 +87,15 @@ struct ske_keypad {
 	unsigned short keymap[SKE_KPD_KEYMAP_SIZE];
 	struct clk *clk;
 	spinlock_t ske_keypad_lock;
+	bool enable;
+	bool enable_on_resume;
 	int key_pressed;
+	bool gpio_wakeup;
+	struct delayed_work gpio_switch_work;
+	struct delayed_work gpio_release_work;
+	int gpio_input_irq[SKE_KPD_MAX_ROWS];
+	int gpio_row;
+	int gpio_col;
 	u8 keys[SKE_KPD_MAX_ROWS][SKE_KPD_MAX_COLS];
 	struct delayed_work scan_work;
 };
@@ -149,6 +166,33 @@ static int __init ske_keypad_chip_init(struct ske_keypad *keypad)
 	return 0;
 }
 
+static void ske_mode_enable(struct ske_keypad *keypad, bool enable)
+{
+	int i;
+
+	if (!enable) {
+		dev_dbg(keypad->dev, "%s disable keypad\n", __func__);
+		writel(0, keypad->reg_base + SKE_CR);
+		if (keypad->board->exit)
+			keypad->board->exit();
+		for (i = 0; i < keypad->board->krow; i++) {
+			enable_irq(keypad->gpio_input_irq[i]);
+			enable_irq_wake(keypad->gpio_input_irq[i]);
+		}
+		clk_disable(keypad->clk);
+	} else {
+		dev_dbg(keypad->dev, "%s enable keypad\n", __func__);
+		clk_enable(keypad->clk);
+		for (i = 0; i < keypad->board->krow; i++) {
+			disable_irq_nosync(keypad->gpio_input_irq[i]);
+			disable_irq_wake(keypad->gpio_input_irq[i]);
+		}
+		if (keypad->board->init)
+			keypad->board->init();
+		ske_keypad_chip_init(keypad);
+	}
+}
+
 static void ske_keypad_report(struct ske_keypad *keypad, u8 status, int col)
 {
 	int row = 0, code, pos;
@@ -292,12 +336,154 @@ static void ske_keypad_scan_work(struct work_struct *work)
 
 		/* Enable auto scan interrupts */
 		ske_keypad_set_bits(keypad, SKE_IMSC, 0x0, SKE_KPIMA);
+
+		/**
+		 * Schedule the work queue to change it to GPIO mode
+		 * if there is no activity in SKE mode
+		 */
+		if (keypad->gpio_wakeup &&
+		    !keypad->key_pressed &&
+		    keypad->enable)
+			schedule_delayed_work(&keypad->gpio_switch_work,
+					      keypad->board->gpio_switch_delay);
+	}
+}
+
+static void ske_gpio_switch_work(struct work_struct *work)
+{
+	struct ske_keypad *keypad = container_of(work,
+						 struct ske_keypad,
+						 gpio_switch_work.work);
+
+	ske_mode_enable(keypad, false);
+	keypad->enable = false;
+}
+
+static void ske_gpio_release_work(struct work_struct *work)
+{
+	int code;
+	struct ske_keypad *keypad = container_of(work,
+						 struct ske_keypad,
+						 gpio_release_work.work);
+	struct input_dev *input = keypad->input;
+
+	code = MATRIX_SCAN_CODE(keypad->gpio_row, keypad->gpio_col,
+						SKE_KEYPAD_ROW_SHIFT);
+
+	dev_dbg(keypad->dev, "%s Key press reported, code:%d\n",
+		__func__, code);
+
+	input_event(input, EV_MSC, MSC_SCAN, code);
+	input_report_key(input, keypad->keymap[code], 1);
+	input_sync(input);
+	input_report_key(input, keypad->keymap[code], 0);
+	input_sync(input);
+}
+
+static int ske_read_get_gpio_row(struct ske_keypad *keypad)
+{
+	int row;
+	int value = 0;
+	int ret;
+
+	/* read all rows GPIO data register values */
+	for (row = 0; row < keypad->board->krow ; row++) {
+		ret  = gpio_get_value(keypad->board->gpio_rows[row]);
+		value += (1 << row) *  ret;
+	}
+
+	/* get the exact row */
+	for (row = 0; row < keypad->board->krow; row++) {
+		if (((1 << row) & value) == 0)
+			return row;
+	}
+
+	return -1;
+}
+
+static void ske_set_cols(struct ske_keypad *keypad, int col)
+{
+	int i ;
+	int value;
+
+	/**
+	 * Set all columns except the requested column
+	 * output pin as high
+	 */
+	for (i = 0; i < keypad->board->krow; i++) {
+		if (i == col)
+			value = 0;
+		else
+			value = 1;
+		gpio_request(keypad->board->gpio_cols[i], "ske-kp");
+		gpio_direction_output(keypad->board->gpio_cols[i],
+				      value);
+		gpio_free(keypad->board->gpio_cols[i]);
 	}
 }
 
+static void ske_free_cols(struct ske_keypad *keypad)
+{
+	int i ;
+
+	for (i = 0; i < keypad->board->kcol; i++) {
+		gpio_request(keypad->board->gpio_cols[i], "ske-kp");
+		gpio_direction_output(keypad->board->gpio_cols[i], 0);
+		gpio_free(keypad->board->gpio_cols[i]);
+	}
+}
+
+static void ske_gpio_scan(struct ske_keypad *keypad)
+{
+	int row;
+	int col;
+
+	for (col = 0; col < keypad->board->kcol; col++) {
+		ske_set_cols(keypad, col);
+		row = ske_read_get_gpio_row(keypad);
+		if (row >= 0) {
+			keypad->key_pressed = 1;
+			keypad->gpio_row = row;
+			keypad->gpio_col = col;
+			break;
+		}
+	}
+	ske_free_cols(keypad);
+}
+
+static irqreturn_t ske_keypad_gpio_irq(int irq, void *dev_id)
+{
+	struct ske_keypad *keypad = dev_id;
+
+	if (!gpio_get_value(NOMADIK_IRQ_TO_GPIO(irq))) {
+		ske_gpio_scan(keypad);
+		if (!keypad->enable) {
+			keypad->enable = true;
+			ske_mode_enable(keypad, true);
+			/*
+			 * Schedule the work queue to change it back to GPIO
+			 * mode if there is no activity in SKE mode
+			 */
+			schedule_delayed_work(&keypad->gpio_switch_work,
+					      keypad->board->gpio_switch_delay);
+		}
+		/*
+		 * Schedule delayed work to report key press if it is not
+		 * detected in SKE mode.
+		 */
+		if (keypad->key_pressed)
+			schedule_delayed_work(&keypad->gpio_release_work,
+						KEY_PRESSED_DELAY);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t ske_keypad_irq(int irq, void *dev_id)
 {
 	struct ske_keypad *keypad = dev_id;
+	cancel_delayed_work_sync(&keypad->gpio_release_work);
+	cancel_delayed_work_sync(&keypad->gpio_switch_work);
 
 	/* disable auto scan interrupt; mask the interrupt generated */
 	ske_keypad_set_bits(keypad, SKE_IMSC, SKE_KPIMA, 0x0);
@@ -318,6 +504,7 @@ static int __init ske_keypad_probe(struct platform_device *pdev)
 	void __iomem *reg_base;
 	int ret = 0;
 	int irq;
+	int i;
 
 	if (!plat) {
 		dev_err(&pdev->dev, "invalid keypad platform data\n");
@@ -401,6 +588,8 @@ static int __init ske_keypad_probe(struct platform_device *pdev)
 	keypad->input	= input;
 	keypad->reg_base = reg_base;
 	keypad->clk	= clk;
+	INIT_DELAYED_WORK(&keypad->gpio_switch_work, ske_gpio_switch_work);
+	INIT_DELAYED_WORK(&keypad->gpio_release_work, ske_gpio_release_work);
 	INIT_DELAYED_WORK(&keypad->scan_work, ske_keypad_scan_work);
 
 	/* allocations are sane, we begin HW initialization */
@@ -412,6 +601,32 @@ static int __init ske_keypad_probe(struct platform_device *pdev)
 		goto out_unregisterinput;
 	}
 
+	if (plat->wakeup_enable) {
+		device_init_wakeup(&pdev->dev, true);
+		if (plat->gpio_wakeup_enable)
+			dev_warn(&pdev->dev, "both SKE block wakeup and "
+				 "GPIO wakeup enabled - GPIO wakeup will "
+				 "be ignored!\n");
+	} else if (plat->gpio_wakeup_enable) {
+		for (i = 0; i < keypad->board->krow; i++) {
+			keypad->gpio_input_irq[i] =
+				gpio_to_irq(keypad->board->gpio_rows[i]);
+			ret =  request_threaded_irq(keypad->gpio_input_irq[i],
+				NULL, ske_keypad_gpio_irq,
+				IRQF_TRIGGER_FALLING | IRQF_NO_SUSPEND,
+				"ske-keypad-gpio", keypad);
+			if (ret) {
+				dev_err(&pdev->dev,
+					"allocate gpio irq %d failed\n",
+					keypad->gpio_input_irq[i]);
+				goto no_wakeup;
+			}
+			enable_irq_wake(keypad->gpio_input_irq[i]);
+		}
+		keypad->gpio_wakeup = true;
+	}
+
+no_wakeup:
 	ret =  request_irq(keypad->irq, ske_keypad_irq, 0,
 			   "ske-keypad", keypad);
 	if (ret) {
@@ -419,9 +634,6 @@ static int __init ske_keypad_probe(struct platform_device *pdev)
 		goto out_unregisterinput;
 	}
 
-	if (plat->wakeup_enable)
-		device_init_wakeup(&pdev->dev, true);
-
 	platform_set_drvdata(pdev, keypad);
 
 	return 0;
@@ -447,15 +659,26 @@ static int __devexit ske_keypad_remove(struct platform_device *pdev)
 {
 	struct ske_keypad *keypad = platform_get_drvdata(pdev);
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	int i;
 
+	cancel_delayed_work_sync(&keypad->gpio_release_work);
+	cancel_delayed_work_sync(&keypad->gpio_switch_work);
 	cancel_delayed_work_sync(&keypad->scan_work);
 
 	input_unregister_device(keypad->input);
-	clk_disable(keypad->clk);
+	if (keypad->enable)
+		clk_disable(keypad->clk);
 	clk_put(keypad->clk);
 
-	if (keypad->board->exit)
+	if (keypad->enable && keypad->board->exit)
 		keypad->board->exit();
+
+	for (i = 0; i < keypad->board->krow; i++) {
+		disable_irq_nosync(keypad->gpio_input_irq[i]);
+		disable_irq_wake(keypad->gpio_input_irq[i]);
+		free_irq(keypad->gpio_input_irq[i], keypad);
+	}
+
 	free_irq(keypad->irq, keypad);
 	iounmap(keypad->reg_base);
 	release_mem_region(res->start, resource_size(res));
@@ -473,11 +696,18 @@ static int ske_keypad_suspend(struct device *dev)
 
 	if (device_may_wakeup(dev))
 		enable_irq_wake(irq);
-	else {
+	else if (keypad->gpio_wakeup) {
+		cancel_delayed_work_sync(&keypad->gpio_release_work);
+		cancel_delayed_work_sync(&keypad->gpio_switch_work);
 		cancel_delayed_work_sync(&keypad->scan_work);
 		disable_irq(irq);
-		ske_keypad_set_bits(keypad, SKE_IMSC, ~SKE_KPIMA, 0x0);
-		clk_disable(keypad->clk);
+
+		keypad->enable_on_resume = keypad->enable;
+
+		if (keypad->enable) {
+			ske_mode_enable(keypad, false);
+			keypad->enable = false;
+		}
 	}
 
 	return 0;
@@ -491,10 +721,19 @@ static int ske_keypad_resume(struct device *dev)
 
 	if (device_may_wakeup(dev))
 		disable_irq_wake(irq);
-	else {
-		clk_enable(keypad->clk);
+	else if (keypad->gpio_wakeup) {
+		if (keypad->enable_on_resume && !keypad->enable) {
+			keypad->enable = true;
+			ske_mode_enable(keypad, true);
+			/*
+			 * Schedule the work queue to change it to GPIO mode
+			 * if there is no activity in SKE mode
+			 */
+			if (!keypad->key_pressed)
+				schedule_delayed_work(&keypad->gpio_switch_work,
+						keypad->board->gpio_switch_delay);
+		}
 		enable_irq(irq);
-		ske_keypad_chip_init(keypad);
 	}
 
 	return 0;
-- 
1.7.9.2

