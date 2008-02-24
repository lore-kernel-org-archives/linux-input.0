From: Keith Mok <ek9852@gmail.com>
Subject: [PATCH] input: add debouncing for generic gpio input device gpio_key.c
Date: Sun, 24 Feb 2008 14:07:03 +0800
Message-ID: <47C10987.9020804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:52343 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755433AbYBXGFg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 24 Feb 2008 01:05:36 -0500
Received: by rv-out-0910.google.com with SMTP id k20so664634rvb.1
        for <linux-input@vger.kernel.org>; Sat, 23 Feb 2008 22:05:35 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru
Cc: linux-input@vger.kernel.org

This patch add debouncing support for the generic gpio input device, since debouncing is most likely to happen.

Comments welcome.

Signed-off-by: Keith Mok <ek9852@gmail.com>
---
Keith Mok


diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 6a9ca4b..79b460e 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -26,26 +26,36 @@
 
 #include <asm/gpio.h>
 
+static void do_gpio_keys_tasklet(unsigned long);
+static void do_gpio_keys_timer(unsigned long);
+
+static struct timer_list gpio_keys_timer;
+DECLARE_TASKLET_DISABLED(gpio_keys_tasklet, do_gpio_keys_tasklet, 0);
+static spinlock_t suspend_lock;
+static int suspended;
+
 static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
 {
-	int i;
 	struct platform_device *pdev = dev_id;
 	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
-	struct input_dev *input = platform_get_drvdata(pdev);
-
-	for (i = 0; i < pdata->nbuttons; i++) {
-		struct gpio_keys_button *button = &pdata->buttons[i];
-		int gpio = button->gpio;
+	int i;
+	unsigned long flags;
 
-		if (irq == gpio_to_irq(gpio)) {
-			unsigned int type = button->type ?: EV_KEY;
-			int state = (gpio_get_value(gpio) ? 1 : 0) ^ button->active_low;
+	spin_lock_irqsave(&suspend_lock, flags);
+	if (suspended) {
+		spin_unlock_irqrestore(&suspend_lock, flags);
+		return IRQ_HANDLED;
+	}
+	spin_unlock_irqrestore(&suspend_lock, flags);
 
-			input_event(input, type, button->code, !!state);
-			input_sync(input);
-		}
+	/* disable keyboard interrupt and schedule for handling */
+	for (i = 0; i < pdata->nbuttons; i++) {
+		int irq = gpio_to_irq(pdata->buttons[i].gpio);
+		disable_irq(irq);
 	}
 
+	tasklet_schedule(&gpio_keys_tasklet);
+
 	return IRQ_HANDLED;
 }
 
@@ -63,6 +73,11 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, input);
 
 	input->evbit[0] = BIT_MASK(EV_KEY);
+	setup_timer(&gpio_keys_timer, do_gpio_keys_timer, (unsigned long) pdev);
+	tasklet_enable(&gpio_keys_tasklet);
+	gpio_keys_tasklet.data = (unsigned long) pdev;
+	spin_lock_init(&suspend_lock);
+	suspended = 0;
 
 	input->name = pdev->name;
 	input->phys = "gpio-keys/input0";
@@ -156,9 +171,14 @@ static int __devexit gpio_keys_remove(struct platform_device *pdev)
 	for (i = 0; i < pdata->nbuttons; i++) {
 		int irq = gpio_to_irq(pdata->buttons[i].gpio);
 		free_irq(irq, pdev);
-		gpio_free(pdata->buttons[i].gpio);
 	}
 
+	del_timer_sync(&gpio_keys_timer);
+	tasklet_kill(&gpio_keys_tasklet);
+
+	for (i = 0; i < pdata->nbuttons; i++)
+		gpio_free(pdata->buttons[i].gpio);
+
 	input_unregister_device(input);
 
 	return 0;
@@ -168,9 +188,29 @@ static int __devexit gpio_keys_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int gpio_keys_suspend(struct platform_device *pdev, pm_message_t state)
 {
+	unsigned long flags;
 	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
 	int i;
 
+	spin_lock_irqsave(&suspend_lock, flags);
+
+	/*
+	 * Re-enable the interrupt in case it has been masked by the
+	 * handler and a key is still pressed.  We need the interrupt
+	 * to wake us up from suspended.
+	 */
+
+	suspended = 1;
+
+	spin_unlock_irqrestore(&suspend_lock, flags);
+	del_timer_sync(&gpio_keys_timer);
+	tasklet_kill(&gpio_keys_tasklet);
+
+	for (i = 0; i < pdata->nbuttons; i++) {
+		int irq = gpio_to_irq(pdata->buttons[i].gpio);
+		enable_irq(irq);
+	}
+
 	if (device_may_wakeup(&pdev->dev)) {
 		for (i = 0; i < pdata->nbuttons; i++) {
 			struct gpio_keys_button *button = &pdata->buttons[i];
@@ -189,6 +229,7 @@ static int gpio_keys_resume(struct platform_device *pdev)
 	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
 	int i;
 
+	suspended = 0;
 	if (device_may_wakeup(&pdev->dev)) {
 		for (i = 0; i < pdata->nbuttons; i++) {
 			struct gpio_keys_button *button = &pdata->buttons[i];
@@ -206,6 +247,45 @@ static int gpio_keys_resume(struct platform_device *pdev)
 #define gpio_keys_resume	NULL
 #endif
 
+static void do_gpio_keys_tasklet(unsigned long data)
+{
+	int pressed;
+	int i;
+	struct platform_device *pdev = (struct platform_device*)data;
+	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
+	struct input_dev *input = platform_get_drvdata(pdev);
+
+	/* check for any changes */
+	pressed = 0;
+	for (i = 0; i < pdata->nbuttons; i++) {
+		struct gpio_keys_button *button = &pdata->buttons[i];
+		int gpio = button->gpio;
+
+		unsigned int type = button->type ?: EV_KEY;
+		int state = (gpio_get_value(gpio) ? 1 : 0) ^ button->active_low;
+
+		input_event(input, type, button->code, !!state);
+		pressed |= !!state;
+		input_sync(input);
+	}
+	if(pressed) {
+                int delay = HZ / 20;
+		/* some key is pressed - keep irq disabled and use timer
+		 * to poll */
+		mod_timer(&gpio_keys_timer, jiffies + delay);
+	} else {
+		for (i = 0; i < pdata->nbuttons; i++) {
+			int irq = gpio_to_irq(pdata->buttons[i].gpio);
+			enable_irq(irq);
+		}
+	}
+}
+
+static void do_gpio_keys_timer(unsigned long data)
+{
+	tasklet_schedule(&gpio_keys_tasklet);
+}
+
 struct platform_driver gpio_keys_device_driver = {
 	.probe		= gpio_keys_probe,
 	.remove		= __devexit_p(gpio_keys_remove),



