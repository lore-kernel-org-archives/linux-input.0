From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: Re: [PATCH] gpio-keys debouncing support
Date: Tue, 22 Apr 2008 05:14:48 +0400
Message-ID: <20080422011448.GA16851@doriath.ww600.siemens.net>
References: <20080319221323.GA2710@doriath.ww600.siemens.net> <20080421144019.GA6516@doriath.ww600.siemens.net> <20080421155516.GD6884@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:20034 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757085AbYDVBPA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2008 21:15:00 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1979506fgb.17
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2008 18:14:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080421155516.GD6884@anvil.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi,

On Mon, Apr 21, 2008 at 11:55:16AM -0400, Dmitry Torokhov wrote:
> Hi Dmitry,
> 
> On Mon, Apr 21, 2008 at 06:40:19PM +0400, Dmitry Baryshkov wrote:
> > Hi,
> > 
> > What about this patch? I still got no comments.
> > 
> 
> I thought I CCed you form slightly different thread. I don't think that
> this should be a separate Kconfig option, we shoudl make it permanent
> in the driver. I also wonder if it would be better to allocate debounce
> data once for all buttons instead of nickel-and-dime-ing memory
> allocator with tiny requests. Timer shoudl be moved into debounce data
> too BTW.

Please review the updated patch:

>From acf6027db75bca502d1baf45e48418ddb7aadcb7 Mon Sep 17 00:00:00 2001
From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Date: Tue, 22 Apr 2008 05:12:07 +0400
Subject: [PATCH] gpio-keys debouncing support

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 drivers/input/keyboard/gpio_keys.c |  102 ++++++++++++++++++++++++++++++++---
 include/linux/gpio_keys.h          |    2 +
 2 files changed, 95 insertions(+), 9 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 6a9ca4b..33901e4 100644
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
 		}
 	}
 
@@ -52,15 +101,26 @@ static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
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
 
@@ -77,6 +137,10 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 		struct gpio_keys_button *button = &pdata->buttons[i];
 		int irq;
 		unsigned int type = button->type ?: EV_KEY;
+		struct gpio_button_data *data = &ddata->data[i];
+
+		data->pdev = pdev;
+		data->button = button;
 
 		error = gpio_request(button->gpio, button->desc ?: "gpio_keys");
 		if (error < 0) {
@@ -103,6 +167,16 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
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
@@ -112,7 +186,10 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 		if (error) {
 			pr_err("gpio-keys: Unable to claim irq %d; error %d\n",
 				irq, error);
+			if (button->count)
+				del_timer_sync(&data->timer);
 			gpio_free(button->gpio);
+
 			goto fail;
 		}
 
@@ -136,11 +213,15 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
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
@@ -148,7 +229,8 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 static int __devexit gpio_keys_remove(struct platform_device *pdev)
 {
 	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
-	struct input_dev *input = platform_get_drvdata(pdev);
+	struct gpio_keys_drvdata *ddata = platform_get_drvdata(pdev);
+	struct input_dev *input = ddata->input;
 	int i;
 
 	device_init_wakeup(&pdev->dev, 0);
@@ -156,6 +238,8 @@ static int __devexit gpio_keys_remove(struct platform_device *pdev)
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

