From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 5/7] input/nomadik-ske: move key scanning to delayed work
Date: Sun, 13 May 2012 14:44:09 +0200
Message-ID: <1336913049-10153-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:59341 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752342Ab2EMMoQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 May 2012 08:44:16 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Karl-Johan Perntz <karl-johan.perntz@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

From: Karl-Johan Perntz <karl-johan.perntz@stericsson.com>

Move the key scanning to a delayed work thread, drop the threaded
IRQ since all the IRQ work can now be done quickly.

Signed-off-by: Karl-Johan Perntz <karl-johan.perntz@stericsson.com>
Tested-by: Naga Radesh Y <naga.radheshy@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/plat-nomadik/include/plat/ske.h    |    3 +
 drivers/input/keyboard/nomadik-ske-keypad.c |  134 ++++++++++++++++++++++-----
 2 files changed, 115 insertions(+), 22 deletions(-)

diff --git a/arch/arm/plat-nomadik/include/plat/ske.h b/arch/arm/plat-nomadik/include/plat/ske.h
index 31382fb..d6002dd 100644
--- a/arch/arm/plat-nomadik/include/plat/ske.h
+++ b/arch/arm/plat-nomadik/include/plat/ske.h
@@ -22,6 +22,9 @@
 #define SKE_MIS		0x18
 #define SKE_ICR		0x1C
 
+#define SKE_KPD_MAX_ROWS	8
+#define SKE_KPD_MAX_COLS	8
+
 /*
  * Keypad module
  */
diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
index c69a149..86f7d41 100644
--- a/drivers/input/keyboard/nomadik-ske-keypad.c
+++ b/drivers/input/keyboard/nomadik-ske-keypad.c
@@ -12,6 +12,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
+#include <linux/workqueue.h>
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/delay.h>
@@ -50,6 +51,10 @@
 #define SKE_NUM_ASRX_REGISTERS	(4)
 #define	KEY_PRESSED_DELAY	10
 
+
+#define KEY_REPORTED	1
+#define KEY_PRESSED	2
+
 /**
  * struct ske_keypad  - data structure used by keypad driver
  * @dev:		Pointer to the structure device
@@ -60,6 +65,9 @@
  * @keymap:		matrix scan code table for keycodes
  * @clk:		clock structure pointer
  * @ske_keypad_lock:    lock used while writting into registers
+ * @key_pressed:	hold the key state
+ * @keys:		matrix holding key status
+ * @scan_work:		delayed work for scaning new key actions
  */
 struct ske_keypad {
 	struct device *dev;
@@ -70,6 +78,9 @@ struct ske_keypad {
 	unsigned short keymap[SKE_KPD_KEYMAP_SIZE];
 	struct clk *clk;
 	spinlock_t ske_keypad_lock;
+	int key_pressed;
+	u8 keys[SKE_KPD_MAX_ROWS][SKE_KPD_MAX_COLS];
+	struct delayed_work scan_work;
 };
 
 static void ske_keypad_set_bits(struct ske_keypad *keypad, u16 addr,
@@ -141,9 +152,7 @@ static int __init ske_keypad_chip_init(struct ske_keypad *keypad)
 static void ske_keypad_report(struct ske_keypad *keypad, u8 status, int col)
 {
 	int row = 0, code, pos;
-	struct input_dev *input = keypad->input;
 	u32 ske_ris;
-	int key_pressed;
 	int num_of_rows;
 
 	/* find out the row */
@@ -155,11 +164,15 @@ static void ske_keypad_report(struct ske_keypad *keypad, u8 status, int col)
 
 		code = MATRIX_SCAN_CODE(row, col, SKE_KEYPAD_ROW_SHIFT);
 		ske_ris = readl(keypad->reg_base + SKE_RIS);
-		key_pressed = ske_ris & SKE_KPRISA;
+		keypad->key_pressed = ske_ris & SKE_KPRISA;
+
+		dev_dbg(keypad->dev,
+			"%s key_pressed:%d code:%d row:%d col:%d\n",
+			__func__, keypad->key_pressed, code, row, col);
+
+		if (keypad->key_pressed)
+			keypad->keys[row][col] |= KEY_PRESSED;
 
-		input_event(input, EV_MSC, MSC_SCAN, code);
-		input_report_key(input, keypad->keymap[code], key_pressed);
-		input_sync(input);
 		num_of_rows--;
 	} while (num_of_rows);
 }
@@ -196,27 +209,101 @@ static void ske_keypad_read_data(struct ske_keypad *keypad)
 	}
 }
 
-static irqreturn_t ske_keypad_irq(int irq, void *dev_id)
+static void ske_keypad_scan_work(struct work_struct *work)
 {
-	struct ske_keypad *keypad = dev_id;
-	int timeout = keypad->board->debounce_ms;
-
-	/* disable auto scan interrupt; mask the interrupt generated */
-	ske_keypad_set_bits(keypad, SKE_IMSC, ~SKE_KPIMA, 0x0);
-	ske_keypad_set_bits(keypad, SKE_ICR, 0x0, SKE_KPICA);
+	int timeout = 10;
+	int i, j, code;
+	struct ske_keypad *keypad = container_of(work,
+					struct ske_keypad, scan_work.work);
+	struct input_dev *input = keypad->input;
 
-	while ((readl(keypad->reg_base + SKE_CR) & SKE_KPASON) && --timeout)
+	/* Wait for autoscan to complete */
+	while (readl(keypad->reg_base + SKE_CR) & SKE_KPASON)
 		cpu_relax();
 
 	/* SKEx registers are stable and can be read */
 	ske_keypad_read_data(keypad);
 
-	/* wait until raw interrupt is clear */
-	while ((readl(keypad->reg_base + SKE_RIS)) && --timeout)
-		msleep(KEY_PRESSED_DELAY);
+	/* Check for key actions */
+	for (i = 0; i < SKE_KPD_MAX_ROWS; i++) {
+		for (j = 0; j < SKE_KPD_MAX_COLS; j++) {
+			switch (keypad->keys[i][j]) {
+			case KEY_REPORTED:
+				/**
+				 * Key was reported but is no longer pressed,
+				 * report it as released.
+				 */
+				code = MATRIX_SCAN_CODE(i, j,
+							SKE_KEYPAD_ROW_SHIFT);
+				input_event(input, EV_MSC, MSC_SCAN, code);
+				input_report_key(input, keypad->keymap[code],
+						 0);
+				input_sync(input);
+				keypad->keys[i][j] = 0;
+				dev_dbg(keypad->dev,
+					"%s Key release reported, code:%d\n",
+					__func__, code);
+				break;
+			case KEY_PRESSED:
+				/* Key pressed but not yet reported, report */
+				code = MATRIX_SCAN_CODE(i, j,
+							SKE_KEYPAD_ROW_SHIFT);
+				input_event(input, EV_MSC, MSC_SCAN, code);
+				input_report_key(input, keypad->keymap[code],
+						 1);
+				input_sync(input);
+				dev_dbg(keypad->dev,
+					"%s Key press reported, code:%d\n",
+					__func__, code);
+				/* Intentional fall though */
+			case (KEY_REPORTED | KEY_PRESSED):
+				/**
+				 * Key pressed and reported, just reset
+				 * KEY_PRESSED for next scan
+				 */
+				keypad->keys[i][j] = KEY_REPORTED;
+				break;
+			}
+		}
+	}
+
+	if (keypad->key_pressed) {
+		/*
+		 * Key still pressed, schedule work to poll changes in 100 ms
+		 * After increasing the delay from 50 to 100 it is taking
+		 * 2% to 3% load on average.
+		 */
+		schedule_delayed_work(&keypad->scan_work,
+				      msecs_to_jiffies(100));
+	} else {
+		/* For safety measures, clear interrupt once more */
+		ske_keypad_set_bits(keypad, SKE_ICR, 0x0, SKE_KPICA);
+
+		/* Wait for raw interrupt to clear */
+		while ((readl(keypad->reg_base + SKE_RIS) & SKE_KPRISA) &&
+		       --timeout) {
+			udelay(10);
+		}
+
+		if (!timeout)
+			dev_err(keypad->dev,
+				"%s Timeed out waiting on irq to clear\n",
+				__func__);
 
-	/* enable auto scan interrupts */
-	ske_keypad_set_bits(keypad, SKE_IMSC, 0x0, SKE_KPIMA);
+		/* Enable auto scan interrupts */
+		ske_keypad_set_bits(keypad, SKE_IMSC, 0x0, SKE_KPIMA);
+	}
+}
+
+static irqreturn_t ske_keypad_irq(int irq, void *dev_id)
+{
+	struct ske_keypad *keypad = dev_id;
+
+	/* disable auto scan interrupt; mask the interrupt generated */
+	ske_keypad_set_bits(keypad, SKE_IMSC, SKE_KPIMA, 0x0);
+	ske_keypad_set_bits(keypad, SKE_ICR, 0x0, SKE_KPICA);
+
+	schedule_delayed_work(&keypad->scan_work, 0);
 
 	return IRQ_HANDLED;
 }
@@ -314,6 +401,7 @@ static int __init ske_keypad_probe(struct platform_device *pdev)
 	keypad->input	= input;
 	keypad->reg_base = reg_base;
 	keypad->clk	= clk;
+	INIT_DELAYED_WORK(&keypad->scan_work, ske_keypad_scan_work);
 
 	/* allocations are sane, we begin HW initialization */
 	clk_enable(keypad->clk);
@@ -324,8 +412,8 @@ static int __init ske_keypad_probe(struct platform_device *pdev)
 		goto out_unregisterinput;
 	}
 
-	ret =  request_threaded_irq(keypad->irq, NULL, ske_keypad_irq,
-				IRQF_ONESHOT, "ske-keypad", keypad);
+	ret =  request_irq(keypad->irq, ske_keypad_irq, 0,
+			   "ske-keypad", keypad);
 	if (ret) {
 		dev_err(&pdev->dev, "allocate irq %d failed\n", keypad->irq);
 		goto out_unregisterinput;
@@ -360,8 +448,9 @@ static int __devexit ske_keypad_remove(struct platform_device *pdev)
 	struct ske_keypad *keypad = platform_get_drvdata(pdev);
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-	input_unregister_device(keypad->input);
+	cancel_delayed_work_sync(&keypad->scan_work);
 
+	input_unregister_device(keypad->input);
 	clk_disable(keypad->clk);
 	clk_put(keypad->clk);
 
@@ -385,6 +474,7 @@ static int ske_keypad_suspend(struct device *dev)
 	if (device_may_wakeup(dev))
 		enable_irq_wake(irq);
 	else {
+		cancel_delayed_work_sync(&keypad->scan_work);
 		disable_irq(irq);
 		ske_keypad_set_bits(keypad, SKE_IMSC, ~SKE_KPIMA, 0x0);
 		clk_disable(keypad->clk);
-- 
1.7.9.2

