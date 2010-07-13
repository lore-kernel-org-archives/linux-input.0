From: Alexander Clouter <alex@digriz.org.uk>
Subject: [PATCHv3] input: gpio_keys: polling mode support
Date: Tue, 13 Jul 2010 21:04:55 +0100
Message-ID: <20100713200455.GK2428@chipmunk>
References: <20100706190128.GB24655@chipmunk> <20100712192950.GR6976@chipmunk> <20100713011707.GA12728@linux-sh.org> <20100713012819.GA15800@core.coreip.homeip.net> <20100713072605.GS6976@chipmunk> <20100713195745.GJ2428@chipmunk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from chipmunk.wormnet.eu ([195.195.131.226]:44994 "EHLO
	chipmunk.wormnet.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316Ab0GMUE4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Jul 2010 16:04:56 -0400
Content-Disposition: inline
In-Reply-To: <20100713195745.GJ2428@chipmunk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Paul Mundt <lethal@linux-sh.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

This implements an optional polling mode for the gpio_keys driver,
necessary for GPIOs that are not able to generate IRQs.

gpio_keys_platform_data has been extended with poll_interval
which specifies the polling interval in ms, this is passed onto
input-polldev.

This work was based on the patch[1] originally conceived by Paul
Mundt but now the absolute dependency on INPUT_POLLDEV has been
removed (so existing users of gpio_keys can compile out polldev)
plus some un-necessary code has been removed.

[1] http://article.gmane.org/gmane.linux.kernel.input/5814

Changes since v2:
 * fix minor coding style glitch
Changes since v1:
 * remove #ifdef madness

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 drivers/input/keyboard/gpio_keys.c |  121 +++++++++++++++++++++++++++++++-----
 include/linux/gpio_keys.h          |    1 +
 2 files changed, 105 insertions(+), 17 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index b8213fd..b88a308 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -1,7 +1,9 @@
 /*
- * Driver for keys on GPIO lines capable of generating interrupts.
+ * Driver for keys on GPIO lines, either IRQ-driven or polled.
  *
  * Copyright 2005 Phil Blundell
+ * Copyright 2008 Paul Mundt
+ * Copyright 2010 Alexander Clouter <alex@digriz.org.uk>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -25,6 +27,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/workqueue.h>
 #include <linux/gpio.h>
+#include <linux/input-polldev.h>
 
 struct gpio_button_data {
 	struct gpio_keys_button *button;
@@ -36,11 +39,32 @@ struct gpio_button_data {
 
 struct gpio_keys_drvdata {
 	struct input_dev *input;
+	struct input_polled_dev *poll_dev;
 	struct mutex disable_lock;
 	unsigned int n_buttons;
 	struct gpio_button_data data[0];
 };
 
+#if !defined(CONFIG_INPUT_POLLDEV) && !defined(CONFIG_INPUT_POLLDEV_MODULE)
+inline struct input_polled_dev *input_allocate_polled_device(void)
+{
+	return NULL;
+}
+
+inline void input_free_polled_device(struct input_polled_dev *poll_dev)
+{
+}
+
+inline int input_register_polled_device(struct input_polled_dev *dev)
+{
+	return -ENXIO;
+}
+
+inline void input_unregister_polled_device(struct input_polled_dev *poll_dev)
+{
+}
+#endif
+
 /*
  * SYSFS interface for enabling/disabling keys and switches:
  *
@@ -340,6 +364,16 @@ static void gpio_keys_timer(unsigned long _data)
 	schedule_work(&data->work);
 }
 
+static void gpio_handle_button_event(struct gpio_keys_button *button,
+				     struct gpio_button_data *bdata)
+{
+	if (button->debounce_interval)
+		mod_timer(&bdata->timer,
+			jiffies + msecs_to_jiffies(button->debounce_interval));
+	else
+		gpio_keys_report_event(bdata);
+}
+
 static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
 {
 	struct gpio_button_data *bdata = dev_id;
@@ -347,15 +381,24 @@ static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
 
 	BUG_ON(irq != gpio_to_irq(button->gpio));
 
-	if (button->debounce_interval)
-		mod_timer(&bdata->timer,
-			jiffies + msecs_to_jiffies(button->debounce_interval));
-	else
-		schedule_work(&bdata->work);
+	gpio_handle_button_event(button, bdata);
 
 	return IRQ_HANDLED;
 }
 
+static void gpio_keys_poll(struct input_polled_dev *dev)
+{
+	struct gpio_keys_drvdata *ddata = dev->private;
+	int i;
+
+	for (i = 0; i < ddata->n_buttons; i++) {
+		struct gpio_button_data *bdata = &ddata->data[i];
+		struct gpio_keys_button *button = bdata->button;
+
+		gpio_handle_button_event(button, bdata);
+	}
+}
+
 static int __devinit gpio_keys_setup_key(struct platform_device *pdev,
 					 struct gpio_button_data *bdata,
 					 struct gpio_keys_button *button)
@@ -420,25 +463,47 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 	struct gpio_keys_drvdata *ddata;
 	struct device *dev = &pdev->dev;
 	struct input_dev *input;
+	struct input_polled_dev *poll_dev;
 	int i, error;
 	int wakeup = 0;
 
+#if !defined(CONFIG_INPUT_POLLDEV) && !defined(CONFIG_INPUT_POLLDEV_MODULE)
+	if (pdata->poll_interval) {
+		dev_err(dev, "device needs polling (enable INPUT_POLLDEV)\n");
+		return -EINVAL;
+	}
+#endif
+
 	ddata = kzalloc(sizeof(struct gpio_keys_drvdata) +
 			pdata->nbuttons * sizeof(struct gpio_button_data),
 			GFP_KERNEL);
-	input = input_allocate_device();
+	if (pdata->poll_interval) {
+		poll_dev = input_allocate_polled_device();
+		if (poll_dev)
+			input = poll_dev->input;
+	} else
+		input = input_allocate_device();
 	if (!ddata || !input) {
 		dev_err(dev, "failed to allocate state\n");
 		error = -ENOMEM;
 		goto fail1;
 	}
 
-	ddata->input = input;
+	if (pdata->poll_interval)
+		ddata->poll_dev = poll_dev;
+	else
+		ddata->input = input;
 	ddata->n_buttons = pdata->nbuttons;
 	mutex_init(&ddata->disable_lock);
 
 	platform_set_drvdata(pdev, ddata);
 
+	if (pdata->poll_interval) {
+		poll_dev->private = ddata;
+		poll_dev->poll = gpio_keys_poll;
+		poll_dev->poll_interval = pdata->poll_interval;
+	}
+
 	input->name = pdev->name;
 	input->phys = "gpio-keys/input0";
 	input->dev.parent = &pdev->dev;
@@ -460,14 +525,17 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 		bdata->input = input;
 		bdata->button = button;
 
+		input_set_capability(input, type, button->code);
+
+		if (pdata->poll_interval)
+			continue;
+
 		error = gpio_keys_setup_key(pdev, bdata, button);
 		if (error)
 			goto fail2;
 
 		if (button->wakeup)
 			wakeup = 1;
-
-		input_set_capability(input, type, button->code);
 	}
 
 	error = sysfs_create_group(&pdev->dev.kobj, &gpio_keys_attr_group);
@@ -477,7 +545,10 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 		goto fail2;
 	}
 
-	error = input_register_device(input);
+	if (pdata->poll_interval)
+		error = input_register_polled_device(poll_dev);
+	else
+		error = input_register_device(input);
 	if (error) {
 		dev_err(dev, "Unable to register input device, error: %d\n",
 			error);
@@ -497,7 +568,9 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 	sysfs_remove_group(&pdev->dev.kobj, &gpio_keys_attr_group);
  fail2:
 	while (--i >= 0) {
-		free_irq(gpio_to_irq(pdata->buttons[i].gpio), &ddata->data[i]);
+		if (!pdata->poll_interval)
+			free_irq(gpio_to_irq(pdata->buttons[i].gpio),
+				&ddata->data[i]);
 		if (pdata->buttons[i].debounce_interval)
 			del_timer_sync(&ddata->data[i].timer);
 		cancel_work_sync(&ddata->data[i].work);
@@ -506,7 +579,10 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
  fail1:
-	input_free_device(input);
+	if (pdata->poll_interval)
+		input_free_polled_device(poll_dev);
+	else
+		input_free_device(input);
 	kfree(ddata);
 
 	return error;
@@ -516,7 +592,8 @@ static int __devexit gpio_keys_remove(struct platform_device *pdev)
 {
 	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
 	struct gpio_keys_drvdata *ddata = platform_get_drvdata(pdev);
-	struct input_dev *input = ddata->input;
+	struct input_dev *input;
+	struct input_polled_dev *poll_dev;
 	int i;
 
 	sysfs_remove_group(&pdev->dev.kobj, &gpio_keys_attr_group);
@@ -524,15 +601,25 @@ static int __devexit gpio_keys_remove(struct platform_device *pdev)
 	device_init_wakeup(&pdev->dev, 0);
 
 	for (i = 0; i < pdata->nbuttons; i++) {
-		int irq = gpio_to_irq(pdata->buttons[i].gpio);
-		free_irq(irq, &ddata->data[i]);
+		if (!pdata->poll_interval) {
+			int irq = gpio_to_irq(pdata->buttons[i].gpio);
+			free_irq(irq, &ddata->data[i]);
+		}
 		if (pdata->buttons[i].debounce_interval)
 			del_timer_sync(&ddata->data[i].timer);
 		cancel_work_sync(&ddata->data[i].work);
 		gpio_free(pdata->buttons[i].gpio);
 	}
 
-	input_unregister_device(input);
+	if (pdata->poll_interval) {
+		poll_dev = ddata->poll_dev;
+		input_unregister_polled_device(poll_dev);
+		input_free_polled_device(poll_dev);
+	} else {
+		input = ddata->input;
+		input_unregister_device(input);
+		input_free_device(input);
+	}
 
 	return 0;
 }
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index cd0b3f3..7dd075b 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -17,6 +17,7 @@ struct gpio_keys_platform_data {
 	struct gpio_keys_button *buttons;
 	int nbuttons;
 	unsigned int rep:1;		/* enable input subsystem auto repeat */
+	unsigned int poll_interval;	/* polling interval in ms */
 };
 
 #endif
-- 
1.7.1
