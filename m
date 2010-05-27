From: Luotao Fu <l.fu@pengutronix.de>
Subject: [PATCH V2] matrix_keypad: add support for clustered irq
Date: Thu, 27 May 2010 08:43:54 +0200
Message-ID: <1274942634-31735-1-git-send-email-l.fu@pengutronix.de>
References: <1274882226-19778-1-git-send-email-l.fu@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1274882226-19778-1-git-send-email-l.fu@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Marek Vasut <marek.vasut@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Luotao Fu <l.fu@pengutronix.de>
List-Id: linux-input@vger.kernel.org

This one adds support of a combined irq source for the whole matrix keypad.
This can be useful if all rows and columns of the keypad are e.g. connected
to a GPIO expander, which only has one interrupt line for all events on
every single GPIO.

Signed-off-by: Luotao Fu <l.fu@pengutronix.de>
---
V2 Changes:
* create separate functions for suspend/resume calls.
* add bool flag to signal enable/disable state of all gpios.
* add spinlock to suspend and resume callbacks.

 drivers/input/keyboard/matrix_keypad.c |  138 ++++++++++++++++++++++++--------
 include/linux/input/matrix_keypad.h    |    5 +
 2 files changed, 109 insertions(+), 34 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index b443e08..99b7204 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -37,6 +37,7 @@ struct matrix_keypad {
 	spinlock_t lock;
 	bool scan_pending;
 	bool stopped;
+	bool gpio_all_disabled;
 };
 
 /*
@@ -87,8 +88,12 @@ static void enable_row_irqs(struct matrix_keypad *keypad)
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
 	int i;
 
-	for (i = 0; i < pdata->num_row_gpios; i++)
-		enable_irq(gpio_to_irq(pdata->row_gpios[i]));
+	if (pdata->clustered_irq > 0)
+		enable_irq(pdata->clustered_irq);
+	else {
+		for (i = 0; i < pdata->num_row_gpios; i++)
+			enable_irq(gpio_to_irq(pdata->row_gpios[i]));
+	}
 }
 
 static void disable_row_irqs(struct matrix_keypad *keypad)
@@ -96,8 +101,12 @@ static void disable_row_irqs(struct matrix_keypad *keypad)
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
 	int i;
 
-	for (i = 0; i < pdata->num_row_gpios; i++)
-		disable_irq_nosync(gpio_to_irq(pdata->row_gpios[i]));
+	if (pdata->clustered_irq > 0)
+		disable_irq_nosync(pdata->clustered_irq);
+	else {
+		for (i = 0; i < pdata->num_row_gpios; i++)
+			disable_irq_nosync(gpio_to_irq(pdata->row_gpios[i]));
+	}
 }
 
 /*
@@ -216,25 +225,74 @@ static void matrix_keypad_stop(struct input_dev *dev)
 }
 
 #ifdef CONFIG_PM
-static int matrix_keypad_suspend(struct device *dev)
+static inline void __suspend_keypad(struct matrix_keypad *keypad)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct matrix_keypad *keypad = platform_get_drvdata(pdev);
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
+	unsigned int cirq = pdata->clustered_irq;
+	unsigned int gpio;
+	unsigned long flags;
 	int i;
 
-	matrix_keypad_stop(keypad->input_dev);
+	spin_lock_irqsave(&keypad->lock, flags);
 
-	if (device_may_wakeup(&pdev->dev)) {
-		for (i = 0; i < pdata->num_row_gpios; i++) {
-			if (!test_bit(i, keypad->disabled_gpios)) {
-				unsigned int gpio = pdata->row_gpios[i];
+	if (pdata->clustered_irq > 0) {
+		if (enable_irq_wake(cirq) == 0)
+			keypad->gpio_all_disabled = true;
 
-				if (enable_irq_wake(gpio_to_irq(gpio)) == 0)
-					__set_bit(i, keypad->disabled_gpios);
-			}
+		goto out;
+	}
+
+	for (i = 0; i < pdata->num_row_gpios; i++) {
+		if (!test_bit(i, keypad->disabled_gpios)) {
+			gpio = pdata->row_gpios[i];
+
+			if (enable_irq_wake(gpio_to_irq(gpio)) == 0)
+				__set_bit(i, keypad->disabled_gpios);
+		}
+	}
+out:
+	spin_unlock_irqrestore(&keypad->lock, flags);
+}
+
+static inline void __resume_keypad(struct matrix_keypad *keypad)
+{
+	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
+	unsigned int cirq = pdata->clustered_irq;
+	unsigned int gpio;
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&keypad->lock, flags);
+
+	if (pdata->clustered_irq > 0) {
+		if (keypad->gpio_all_disabled) {
+			disable_irq_wake(cirq);
+			keypad->gpio_all_disabled = false;
+		}
+
+		goto out;
+	}
+
+	for (i = 0; i < pdata->num_row_gpios; i++) {
+		if (test_and_clear_bit(i, keypad->disabled_gpios)) {
+			gpio = pdata->row_gpios[i];
+			disable_irq_wake(gpio_to_irq(gpio));
 		}
 	}
+out:
+	spin_unlock_irqrestore(&keypad->lock, flags);
+
+}
+
+static int matrix_keypad_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct matrix_keypad *keypad = platform_get_drvdata(pdev);
+
+	matrix_keypad_stop(keypad->input_dev);
+
+	if (device_may_wakeup(&pdev->dev))
+		__suspend_keypad(keypad);
 
 	return 0;
 }
@@ -246,15 +304,8 @@ static int matrix_keypad_resume(struct device *dev)
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
 	int i;
 
-	if (device_may_wakeup(&pdev->dev)) {
-		for (i = 0; i < pdata->num_row_gpios; i++) {
-			if (test_and_clear_bit(i, keypad->disabled_gpios)) {
-				unsigned int gpio = pdata->row_gpios[i];
-
-				disable_irq_wake(gpio_to_irq(gpio));
-			}
-		}
-	}
+	if (device_may_wakeup(&pdev->dev))
+		__resume_keypad(keypad);
 
 	matrix_keypad_start(keypad->input_dev);
 
@@ -296,17 +347,31 @@ static int __devinit init_matrix_gpio(struct platform_device *pdev,
 		gpio_direction_input(pdata->row_gpios[i]);
 	}
 
-	for (i = 0; i < pdata->num_row_gpios; i++) {
-		err = request_irq(gpio_to_irq(pdata->row_gpios[i]),
+	if (pdata->clustered_irq > 0) {
+		err = request_irq(pdata->clustered_irq,
 				matrix_keypad_interrupt,
-				IRQF_DISABLED |
-				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				pdata->clustered_irq_flags,
 				"matrix-keypad", keypad);
 		if (err) {
 			dev_err(&pdev->dev,
-				"Unable to acquire interrupt for GPIO line %i\n",
-				pdata->row_gpios[i]);
-			goto err_free_irqs;
+				"Unable to acquire clustered interrupt\n");
+			goto err_free_rows;
+		}
+	} else {
+		for (i = 0; i < pdata->num_row_gpios; i++) {
+			err = request_irq(gpio_to_irq(pdata->row_gpios[i]),
+					matrix_keypad_interrupt,
+					IRQF_DISABLED |
+					IRQF_TRIGGER_RISING |
+					IRQF_TRIGGER_FALLING,
+					"matrix-keypad", keypad);
+			if (err) {
+				dev_err(&pdev->dev,
+					"Unable to acquire interrupt "
+					"for GPIO line %i\n",
+					pdata->row_gpios[i]);
+				goto err_free_irqs;
+			}
 		}
 	}
 
@@ -418,11 +483,16 @@ static int __devexit matrix_keypad_remove(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 0);
 
-	for (i = 0; i < pdata->num_row_gpios; i++) {
-		free_irq(gpio_to_irq(pdata->row_gpios[i]), keypad);
-		gpio_free(pdata->row_gpios[i]);
+	if (pdata->clustered_irq > 0) {
+		free_irq(pdata->clustered_irq, keypad);
+	} else {
+		for (i = 0; i < pdata->num_row_gpios; i++)
+			free_irq(gpio_to_irq(pdata->row_gpios[i]), keypad);
 	}
 
+	for (i = 0; i < pdata->num_row_gpios; i++)
+		gpio_free(pdata->row_gpios[i]);
+
 	for (i = 0; i < pdata->num_col_gpios; i++)
 		gpio_free(pdata->col_gpios[i]);
 
diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
index c964cd7..8e8dc2e 100644
--- a/include/linux/input/matrix_keypad.h
+++ b/include/linux/input/matrix_keypad.h
@@ -63,6 +63,11 @@ struct matrix_keypad_platform_data {
 	/* key debounce interval in milli-second */
 	unsigned int	debounce_ms;
 
+	/* used if interrupts of all row/column GPIOs are bundled to one single
+	 * irq */
+	unsigned int	clustered_irq;
+	unsigned int	clustered_irq_flags;
+
 	bool		active_low;
 	bool		wakeup;
 	bool		no_autorepeat;
-- 
1.7.0
