From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] input: gpio_keys: Polling mode support.
Date: Wed, 26 Nov 2008 05:43:58 +0900
Message-ID: <20081125204358.GA31335@linux-sh.org>
References: <20081021083816.GA29345@linux-sh.org> <20081028101857.GA25523@linux-sh.org> <20081029035123.GB27906@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta23.gyao.ne.jp ([125.63.38.249]:26357 "EHLO mx.gate01.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752682AbYKYUpR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Nov 2008 15:45:17 -0500
Content-Disposition: inline
In-Reply-To: <20081029035123.GB27906@anvil.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-sh@vger.kernel.org

On Tue, Oct 28, 2008 at 11:51:23PM -0400, Dmitry Torokhov wrote:
> On Tue, Oct 28, 2008 at 07:18:57PM +0900, Paul Mundt wrote:
> > On Tue, Oct 21, 2008 at 05:38:16PM +0900, Paul Mundt wrote:
> > > This implements an optional polling mode for the gpio_keys driver,
> > > necessary for GPIOs that are not able to generate IRQs.
> > > 
> > > Polling mode is done device granular, and can not be toggled for
> > > individual GPIOs in order to maintain simplicity. Platforms with both
> > > IRQ capable and incapable GPIOs are required to register multiple
> > > times, once for each case.
> > > 
> > >  
> > > -	input_unregister_device(input);
> > > +	if (pdata->polling)
> > > +		input_unregister_polled_device(poll_dev);
> 
> You also need to do input_free_polled_device (but not input_free_device
>  - yeah, I know, its confusing... The reason is that input_dev is
>    refcounted while input_polled_dev is not).

Thanks, fixed.

> > > +	else
> > > +		input_unregister_device(poll_dev->input);
> > >  
> 
> I also concerned with unconditionally polling INPUT_POLLDEV for all
> users of gpio-keys. Maybe we could make polling support optional?
> 
I thought that was what my patch was doing? I couldn't think of a clean
way to do it on a per-gpio basis, so the cleanest way seemed to be to
regster in polled and non-polled blocks. ie, polled devices will set
pdata->polling and register those for gpio_keys to set up a polled dev.
Devices that do not set pdata->polling will remain unaffected.

If you have some suggestions on how to toggle this on a per-gpio basis,
I am quite happy to change the code. If your concern is the select of
INPUT_POLLDEV, I can just select it from my platform code if you prefer.
This does mean that we would need nopped definitions in
linux/input-polldev.h though, or litter gpio_keys with ifdefs, which is
what I was trying to avoid in the first place. Let me know what you
prefer here, and I'll update accordingly.

For now, here is an updated version..

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 drivers/input/keyboard/Kconfig     |    1 
 drivers/input/keyboard/gpio_keys.c |   92 ++++++++++++++++++++++++++++---------
 include/linux/gpio_keys.h          |    1 
 3 files changed, 73 insertions(+), 21 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index efd70a9..a8cefe9 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -283,6 +283,7 @@ config KEYBOARD_AAED2000
 config KEYBOARD_GPIO
 	tristate "GPIO Buttons"
 	depends on GENERIC_GPIO
+	select INPUT_POLLDEV
 	help
 	  This driver implements support for buttons connected
 	  to GPIO pins of various CPUs (and some other chips).
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 05f3f43..e7a46f8 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -1,7 +1,8 @@
 /*
- * Driver for keys on GPIO lines capable of generating interrupts.
+ * Driver for keys on GPIO lines, either IRQ-driven or polled.
  *
  * Copyright 2005 Phil Blundell
+ * Copyright 2008 Paul Mundt
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -9,7 +10,6 @@
  */
 
 #include <linux/module.h>
-
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/interrupt.h>
@@ -22,7 +22,7 @@
 #include <linux/platform_device.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
-
+#include <linux/input-polldev.h>
 #include <asm/gpio.h>
 
 struct gpio_button_data {
@@ -32,7 +32,8 @@ struct gpio_button_data {
 };
 
 struct gpio_keys_drvdata {
-	struct input_dev *input;
+	struct gpio_keys_platform_data *pdata;
+	struct input_polled_dev *poll_dev;
 	struct gpio_button_data data[0];
 };
 
@@ -54,6 +55,33 @@ static void gpio_check_button(unsigned long _data)
 	gpio_keys_report_event(data);
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
+static void gpio_keys_poll(struct input_polled_dev *dev)
+{
+	struct gpio_keys_drvdata *ddata = dev->private;
+	struct gpio_keys_platform_data *pdata = ddata->pdata;
+	int i;
+
+	for (i = 0; i < pdata->nbuttons; i++) {
+		struct gpio_keys_button *button = &pdata->buttons[i];
+		struct gpio_button_data *bdata = &ddata->data[i];
+
+		bdata->input = dev->input;
+		bdata->button = button;
+
+		gpio_handle_button_event(button, bdata);
+	}
+}
+
 static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
 {
 	struct gpio_button_data *bdata = dev_id;
@@ -61,11 +89,7 @@ static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
 
 	BUG_ON(irq != gpio_to_irq(button->gpio));
 
-	if (button->debounce_interval)
-		mod_timer(&bdata->timer,
-			jiffies + msecs_to_jiffies(button->debounce_interval));
-	else
-		gpio_keys_report_event(bdata);
+	gpio_handle_button_event(button, bdata);
 
 	return IRQ_HANDLED;
 }
@@ -74,6 +98,7 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 {
 	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
 	struct gpio_keys_drvdata *ddata;
+	struct input_polled_dev *poll_dev;
 	struct input_dev *input;
 	int i, error;
 	int wakeup = 0;
@@ -81,14 +106,19 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 	ddata = kzalloc(sizeof(struct gpio_keys_drvdata) +
 			pdata->nbuttons * sizeof(struct gpio_button_data),
 			GFP_KERNEL);
-	input = input_allocate_device();
-	if (!ddata || !input) {
+	poll_dev = input_allocate_polled_device();
+	if (!ddata || !poll_dev) {
 		error = -ENOMEM;
 		goto fail1;
 	}
 
 	platform_set_drvdata(pdev, ddata);
 
+	poll_dev->private = ddata;
+	poll_dev->poll = gpio_keys_poll;
+	poll_dev->poll_interval = 50; /* msec */
+
+	input = poll_dev->input;
 	input->name = pdev->name;
 	input->phys = "gpio-keys/input0";
 	input->dev.parent = &pdev->dev;
@@ -98,7 +128,8 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 	input->id.product = 0x0001;
 	input->id.version = 0x0100;
 
-	ddata->input = input;
+	ddata->poll_dev = poll_dev;
+	ddata->pdata = pdata;
 
 	for (i = 0; i < pdata->nbuttons; i++) {
 		struct gpio_keys_button *button = &pdata->buttons[i];
@@ -127,6 +158,15 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 			goto fail2;
 		}
 
+		input_set_capability(input, type, button->code);
+
+		/*
+		 * Skip the IRQ setup and wakeup source initialization if
+		 * we are going to be polled.
+		 */
+		if (pdata->polling)
+			continue;
+
 		irq = gpio_to_irq(button->gpio);
 		if (irq < 0) {
 			error = irq;
@@ -151,11 +191,12 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 
 		if (button->wakeup)
 			wakeup = 1;
-
-		input_set_capability(input, type, button->code);
 	}
 
-	error = input_register_device(input);
+	if (pdata->polling)
+		error = input_register_polled_device(poll_dev);
+	else
+		error = input_register_device(input);
 	if (error) {
 		pr_err("gpio-keys: Unable to register input device, "
 			"error: %d\n", error);
@@ -168,7 +209,9 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 
  fail2:
 	while (--i >= 0) {
-		free_irq(gpio_to_irq(pdata->buttons[i].gpio), &ddata->data[i]);
+		if (!pdata->polling)
+			free_irq(gpio_to_irq(pdata->buttons[i].gpio),
+				 &ddata->data[i]);
 		if (pdata->buttons[i].debounce_interval)
 			del_timer_sync(&ddata->data[i].timer);
 		gpio_free(pdata->buttons[i].gpio);
@@ -176,7 +219,7 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
  fail1:
-	input_free_device(input);
+	input_free_polled_device(poll_dev);
 	kfree(ddata);
 
 	return error;
@@ -186,20 +229,27 @@ static int __devexit gpio_keys_remove(struct platform_device *pdev)
 {
 	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
 	struct gpio_keys_drvdata *ddata = platform_get_drvdata(pdev);
-	struct input_dev *input = ddata->input;
+	struct input_polled_dev *poll_dev = ddata->poll_dev;
 	int i;
 
 	device_init_wakeup(&pdev->dev, 0);
 
 	for (i = 0; i < pdata->nbuttons; i++) {
-		int irq = gpio_to_irq(pdata->buttons[i].gpio);
-		free_irq(irq, &ddata->data[i]);
+		if (!pdata->polling) {
+			int irq = gpio_to_irq(pdata->buttons[i].gpio);
+			free_irq(irq, &ddata->data[i]);
+		}
+
 		if (pdata->buttons[i].debounce_interval)
 			del_timer_sync(&ddata->data[i].timer);
 		gpio_free(pdata->buttons[i].gpio);
 	}
 
-	input_unregister_device(input);
+	if (pdata->polling) {
+		input_unregister_polled_device(poll_dev);
+		input_free_polled_device(poll_dev);
+	} else
+		input_unregister_device(poll_dev->input);
 
 	return 0;
 }
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index ec6ecd7..e869752 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -15,6 +15,7 @@ struct gpio_keys_button {
 struct gpio_keys_platform_data {
 	struct gpio_keys_button *buttons;
 	int nbuttons;
+	int polling;		/* force polling mode */
 };
 
 #endif
