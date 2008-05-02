From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: [PATCH][RESEND] gpio-keys debouncing support
Date: Fri, 2 May 2008 15:20:48 +0400
Message-ID: <20080502112048.GA8664@doriath.ww600.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:51353 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114AbYEBLU4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 May 2008 07:20:56 -0400
Received: by fg-out-1718.google.com with SMTP id 19so908934fgg.17
        for <linux-input@vger.kernel.org>; Fri, 02 May 2008 04:20:55 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dtor@mail.ru

Sometimes gpio line can generate jitter while transitioning from one state
to another one. Implement a way to filter such noise during transitions.

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 drivers/input/keyboard/gpio_keys.c |  102 ++++++++++++++++++++++++++++++++---
 include/linux/gpio_keys.h          |    2 +
 2 files changed, 95 insertions(+), 9 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index bbd00c3..c5f7a3d 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -26,23 +26,72 @@
 
 #include <asm/gpio.h>
 
+struct gpio_button_data {
+	struct platform_device *pdev;
+	struct gpio_keys_button *button;
+
+	/* For debounce */
+	int state;
+	int count;
+	struct timer_list	timer;
+};
+
+struct gpio_keys_drvdata {
+	struct input_dev *input;
+	struct gpio_button_data data[0];
+};
+
+static void gpio_debounce_timer(unsigned long _data)
+{
+	struct gpio_button_data *data = (struct gpio_button_data *)_data;
+	struct gpio_keys_button *button = data->button;
+	int gpio = button->gpio;
+	unsigned int type = button->type ?: EV_KEY;
+	int state = (gpio_get_value(gpio) ? 1 : 0) ^ button->active_low;
+	struct gpio_keys_drvdata *ddata = platform_get_drvdata(data->pdev);
+	struct input_dev *input = ddata->input;
+
+	if (state != data->state) {
+		data->count = 0;
+		data->state = state;
+		mod_timer(&data->timer, jiffies +
+					msecs_to_jiffies(button->interval));
+	} else if (data->count < button->count) {
+		data->count ++;
+		mod_timer(&data->timer, jiffies +
+					msecs_to_jiffies(button->interval));
+	} else {
+		input_event(input, type, button->code, !!state);
+		input_sync(input);
+	}
+}
+
 static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
 {
 	int i;
 	struct platform_device *pdev = dev_id;
 	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
-	struct input_dev *input = platform_get_drvdata(pdev);
+	struct gpio_keys_drvdata *ddata = platform_get_drvdata(pdev);
+	struct input_dev *input = ddata->input;
 
 	for (i = 0; i < pdata->nbuttons; i++) {
 		struct gpio_keys_button *button = &pdata->buttons[i];
+		struct gpio_button_data *data = &ddata->data[i];
 		int gpio = button->gpio;
 
 		if (irq == gpio_to_irq(gpio)) {
-			unsigned int type = button->type ?: EV_KEY;
-			int state = (gpio_get_value(gpio) ? 1 : 0) ^ button->active_low;
-
-			input_event(input, type, button->code, !!state);
-			input_sync(input);
+			if (button->count) {
+				if (!timer_pending(&data->timer))
+					mod_timer(&data->timer, jiffies +
+							msecs_to_jiffies(
+							button->interval));
+			} else {
+				unsigned int type = button->type ?: EV_KEY;
+				int state = (gpio_get_value(gpio) ? 1 : 0) ^ button->active_low;
+
+				input_event(input, type, button->code, !!state);
+				input_sync(input);
+			}
 			return IRQ_HANDLED;
 		}
 	}
@@ -53,15 +102,26 @@ static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
 static int __devinit gpio_keys_probe(struct platform_device *pdev)
 {
 	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
+	struct gpio_keys_drvdata *ddata;
 	struct input_dev *input;
 	int i, error;
 	int wakeup = 0;
 
+	ddata = kzalloc(sizeof(struct gpio_keys_drvdata) +
+			sizeof(struct gpio_button_data) * pdata->nbuttons,
+			GFP_KERNEL);
+
+	if (!ddata)
+		return -ENOMEM;
+
 	input = input_allocate_device();
-	if (!input)
+	if (!input) {
+		kfree(ddata);
 		return -ENOMEM;
+	}
+	ddata->input = input;
 
-	platform_set_drvdata(pdev, input);
+	platform_set_drvdata(pdev, ddata);
 
 	input->evbit[0] = BIT_MASK(EV_KEY);
 
@@ -78,6 +138,10 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 		struct gpio_keys_button *button = &pdata->buttons[i];
 		int irq;
 		unsigned int type = button->type ?: EV_KEY;
+		struct gpio_button_data *data = &ddata->data[i];
+
+		data->pdev = pdev;
+		data->button = button;
 
 		error = gpio_request(button->gpio, button->desc ?: "gpio_keys");
 		if (error < 0) {
@@ -104,6 +168,16 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 			gpio_free(button->gpio);
 			goto fail;
 		}
+		if (button->count && button->interval) {
+			data->state = -1;
+
+			init_timer(&data->timer);
+			data->timer.function = gpio_debounce_timer;
+			data->timer.data = (unsigned long)data;
+
+			mod_timer(&data->timer, jiffies +
+					msecs_to_jiffies(button->interval));
+		}
 
 		error = request_irq(irq, gpio_keys_isr,
 				    IRQF_SAMPLE_RANDOM | IRQF_TRIGGER_RISING |
@@ -113,7 +187,10 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 		if (error) {
 			pr_err("gpio-keys: Unable to claim irq %d; error %d\n",
 				irq, error);
+			if (button->count)
+				del_timer_sync(&data->timer);
 			gpio_free(button->gpio);
+
 			goto fail;
 		}
 
@@ -137,11 +214,15 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
  fail:
 	while (--i >= 0) {
 		free_irq(gpio_to_irq(pdata->buttons[i].gpio), pdev);
+		if (pdata->buttons[i].count) {
+			del_timer_sync(&ddata->data[i].timer);
+		}
 		gpio_free(pdata->buttons[i].gpio);
 	}
 
 	platform_set_drvdata(pdev, NULL);
 	input_free_device(input);
+	kfree(ddata);
 
 	return error;
 }
@@ -149,7 +230,8 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 static int __devexit gpio_keys_remove(struct platform_device *pdev)
 {
 	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
-	struct input_dev *input = platform_get_drvdata(pdev);
+	struct gpio_keys_drvdata *ddata = platform_get_drvdata(pdev);
+	struct input_dev *input = ddata->input;
 	int i;
 
 	device_init_wakeup(&pdev->dev, 0);
@@ -157,6 +239,8 @@ static int __devexit gpio_keys_remove(struct platform_device *pdev)
 	for (i = 0; i < pdata->nbuttons; i++) {
 		int irq = gpio_to_irq(pdata->buttons[i].gpio);
 		free_irq(irq, pdev);
+		if (pdata->buttons[i].count)
+			del_timer_sync(&ddata->data[i].timer);
 		gpio_free(pdata->buttons[i].gpio);
 	}
 
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index c6d3a9d..5d09862 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -9,6 +9,8 @@ struct gpio_keys_button {
 	char *desc;
 	int type;		/* input event type (EV_KEY, EV_SW) */
 	int wakeup;		/* configure the button as a wake-up source */
+	int count;		/* debounce ticks count */
+	int interval;		/* debounce ticks interval in msecs */
 };
 
 struct gpio_keys_platform_data {
-- 
1.5.5


-- 
With best wishes
Dmitry

