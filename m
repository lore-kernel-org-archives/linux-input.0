From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH][RESEND] gpio-keys debouncing support
Date: Tue, 6 May 2008 09:57:47 -0400
Message-ID: <20080506095530.ZZRA012@mailhub.coreip.homeip.net>
References: <20080502112048.GA8664@doriath.ww600.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:28067 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755116AbYEFN5z (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 May 2008 09:57:55 -0400
Received: by wr-out-0506.google.com with SMTP id c48so110878wra.1
        for <linux-input@vger.kernel.org>; Tue, 06 May 2008 06:57:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080502112048.GA8664@doriath.ww600.siemens.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

On Fri, May 02, 2008 at 03:20:48PM +0400, Dmitry Baryshkov wrote:
> Sometimes gpio line can generate jitter while transitioning from one state
> to another one. Implement a way to filter such noise during transitions.
>

I don't think we need to do both count and interval and you don't
really need to track state... What do you think about the patch below?

-- 
Dmitry

From: Dmitry Baryshkov <dbaryshkov@gmail.com>

Input: gpio-keys debouncing support

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/keyboard/gpio_keys.c |   88 ++++++++++++++++++++++++++++---------
 include/linux/gpio_keys.h          |    1 
 2 files changed, 69 insertions(+), 20 deletions(-)

Index: linux/drivers/input/keyboard/gpio_keys.c
===================================================================
--- linux.orig/drivers/input/keyboard/gpio_keys.c
+++ linux/drivers/input/keyboard/gpio_keys.c
@@ -26,23 +26,54 @@
 
 #include <asm/gpio.h>
 
+struct gpio_button_data {
+	struct gpio_keys_button *button;
+	struct input_dev *input;
+	struct timer_list timer;
+};
+
+struct gpio_keys_drvdata {
+	struct input_dev *input;
+	struct gpio_button_data data[0];
+};
+
+static void gpio_keys_report_event(struct gpio_keys_button *button,
+				   struct input_dev *input)
+{
+	unsigned int type = button->type ?: EV_KEY;
+	int state = (gpio_get_value(button->gpio) ? 1 : 0) ^ button->active_low;
+
+	input_event(input, type, button->code, !!state);
+	input_sync(input);
+}
+
+static void gpio_check_button(unsigned long _data)
+{
+	struct gpio_button_data *data = (struct gpio_button_data *)_data;
+
+	gpio_keys_report_event(data->button, data->input);
+}
+
 static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
 {
-	int i;
 	struct platform_device *pdev = dev_id;
 	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
-	struct input_dev *input = platform_get_drvdata(pdev);
+	struct gpio_keys_drvdata *ddata = platform_get_drvdata(pdev);
+	int i;
 
 	for (i = 0; i < pdata->nbuttons; i++) {
 		struct gpio_keys_button *button = &pdata->buttons[i];
-		int gpio = button->gpio;
 
-		if (irq == gpio_to_irq(gpio)) {
-			unsigned int type = button->type ?: EV_KEY;
-			int state = (gpio_get_value(gpio) ? 1 : 0) ^ button->active_low;
+		if (irq == gpio_to_irq(button->gpio)) {
+			struct gpio_button_data *bdata = &ddata->data[i];
+
+			if (button->debounce_interval)
+				mod_timer(&bdata->timer,
+					  jiffies +
+					  msecs_to_jiffies(button->debounce_interval));
+			else
+				gpio_keys_report_event(button, bdata->input);
 
-			input_event(input, type, button->code, !!state);
-			input_sync(input);
 			return IRQ_HANDLED;
 		}
 	}
@@ -53,17 +84,20 @@ static irqreturn_t gpio_keys_isr(int irq
 static int __devinit gpio_keys_probe(struct platform_device *pdev)
 {
 	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
+	struct gpio_keys_drvdata *ddata;
 	struct input_dev *input;
 	int i, error;
 	int wakeup = 0;
 
+	ddata = kcalloc(pdata->nbuttons, sizeof(struct gpio_keys_drvdata),
+			GFP_KERNEL);
 	input = input_allocate_device();
-	if (!input)
-		return -ENOMEM;
-
-	platform_set_drvdata(pdev, input);
+	if (!ddata || !input) {
+		error = -ENOMEM;
+		goto fail1;
+	}
 
-	input->evbit[0] = BIT_MASK(EV_KEY);
+	platform_set_drvdata(pdev, ddata);
 
 	input->name = pdev->name;
 	input->phys = "gpio-keys/input0";
@@ -74,16 +108,23 @@ static int __devinit gpio_keys_probe(str
 	input->id.product = 0x0001;
 	input->id.version = 0x0100;
 
+	ddata->input = input;
+
 	for (i = 0; i < pdata->nbuttons; i++) {
 		struct gpio_keys_button *button = &pdata->buttons[i];
+		struct gpio_button_data *bdata = &ddata->data[i];
 		int irq;
 		unsigned int type = button->type ?: EV_KEY;
 
+		bdata->input = input;
+		setup_timer(&bdata->timer,
+			    gpio_check_button, (unsigned long)bdata);
+
 		error = gpio_request(button->gpio, button->desc ?: "gpio_keys");
 		if (error < 0) {
 			pr_err("gpio-keys: failed to request GPIO %d,"
 				" error %d\n", button->gpio, error);
-			goto fail;
+			goto fail2;
 		}
 
 		error = gpio_direction_input(button->gpio);
@@ -92,7 +133,7 @@ static int __devinit gpio_keys_probe(str
 				" direction for GPIO %d, error %d\n",
 				button->gpio, error);
 			gpio_free(button->gpio);
-			goto fail;
+			goto fail2;
 		}
 
 		irq = gpio_to_irq(button->gpio);
@@ -102,7 +143,7 @@ static int __devinit gpio_keys_probe(str
 				" for GPIO %d, error %d\n",
 				button->gpio, error);
 			gpio_free(button->gpio);
-			goto fail;
+			goto fail2;
 		}
 
 		error = request_irq(irq, gpio_keys_isr,
@@ -114,7 +155,7 @@ static int __devinit gpio_keys_probe(str
 			pr_err("gpio-keys: Unable to claim irq %d; error %d\n",
 				irq, error);
 			gpio_free(button->gpio);
-			goto fail;
+			goto fail2;
 		}
 
 		if (button->wakeup)
@@ -127,21 +168,25 @@ static int __devinit gpio_keys_probe(str
 	if (error) {
 		pr_err("gpio-keys: Unable to register input device, "
 			"error: %d\n", error);
-		goto fail;
+		goto fail2;
 	}
 
 	device_init_wakeup(&pdev->dev, wakeup);
 
 	return 0;
 
- fail:
+ fail2:
 	while (--i >= 0) {
 		free_irq(gpio_to_irq(pdata->buttons[i].gpio), pdev);
+		if (pdata->buttons[i].debounce_interval)
+			del_timer_sync(&ddata->data[i].timer);
 		gpio_free(pdata->buttons[i].gpio);
 	}
 
 	platform_set_drvdata(pdev, NULL);
+ fail1:
 	input_free_device(input);
+	kfree(ddata);
 
 	return error;
 }
@@ -149,7 +194,8 @@ static int __devinit gpio_keys_probe(str
 static int __devexit gpio_keys_remove(struct platform_device *pdev)
 {
 	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
-	struct input_dev *input = platform_get_drvdata(pdev);
+	struct gpio_keys_drvdata *ddata = platform_get_drvdata(pdev);
+	struct input_dev *input = ddata->input;
 	int i;
 
 	device_init_wakeup(&pdev->dev, 0);
@@ -157,6 +203,8 @@ static int __devexit gpio_keys_remove(st
 	for (i = 0; i < pdata->nbuttons; i++) {
 		int irq = gpio_to_irq(pdata->buttons[i].gpio);
 		free_irq(irq, pdev);
+		if (pdata->buttons[i].debounce_interval)
+			del_timer_sync(&ddata->data[i].timer);
 		gpio_free(pdata->buttons[i].gpio);
 	}
 
Index: linux/include/linux/gpio_keys.h
===================================================================
--- linux.orig/include/linux/gpio_keys.h
+++ linux/include/linux/gpio_keys.h
@@ -9,6 +9,7 @@ struct gpio_keys_button {
 	char *desc;
 	int type;		/* input event type (EV_KEY, EV_SW) */
 	int wakeup;		/* configure the button as a wake-up source */
+	int debounce_interval;	/* debounce ticks interval in msecs */
 };
 
 struct gpio_keys_platform_data {
