From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] input: gpio_keys: Add support for GPIO descriptors
Date: Fri, 19 Feb 2016 11:16:20 +0100
Message-ID: <1455876982-6743-2-git-send-email-geert+renesas@glider.be>
References: <1455876982-6743-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1455876982-6743-1-git-send-email-geert+renesas@glider.be>
Sender: linux-gpio-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Lu <aaron.lu@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Vincent Pelletier <plr.vincent@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-input@vger.kernel.org

GPIO descriptors are the preferred way over legacy GPIO numbers
nowadays. Convert the driver to use GPIO descriptors internally but
still allow passing legacy GPIO numbers from platform data to support
existing platforms.

Based on commits 633a21d80b4a2cd6 ("input: gpio_keys_polled: Add support
for GPIO descriptors") and 1ae5ddb6f8837558 ("Input: gpio_keys_polled -
request GPIO pin as input.").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/input/keyboard/gpio_keys.c | 42 +++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 29093657f2ef8233..d2b6c3acd9c32f1d 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -26,6 +26,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/workqueue.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/of_gpio.h>
@@ -140,7 +141,7 @@ static void gpio_keys_disable_button(struct gpio_button_data *bdata)
 		 */
 		disable_irq(bdata->irq);
 
-		if (gpio_is_valid(bdata->button->gpio))
+		if (!IS_ERR_OR_NULL(bdata->button->gpiod))
 			cancel_delayed_work_sync(&bdata->work);
 		else
 			del_timer_sync(&bdata->release_timer);
@@ -358,19 +359,18 @@ static void gpio_keys_gpio_report_event(struct gpio_button_data *bdata)
 	const struct gpio_keys_button *button = bdata->button;
 	struct input_dev *input = bdata->input;
 	unsigned int type = button->type ?: EV_KEY;
-	int state = gpio_get_value_cansleep(button->gpio);
+	int state = gpiod_get_value_cansleep(button->gpiod);
 
 	if (state < 0) {
 		dev_err(input->dev.parent, "failed to get gpio state\n");
 		return;
 	}
 
-	state = (state ? 1 : 0) ^ button->active_low;
 	if (type == EV_ABS) {
 		if (state)
 			input_event(input, type, button->code, button->value);
 	} else {
-		input_event(input, type, button->code, !!state);
+		input_event(input, type, button->code, state);
 	}
 	input_sync(input);
 }
@@ -456,7 +456,7 @@ static void gpio_keys_quiesce_key(void *data)
 {
 	struct gpio_button_data *bdata = data;
 
-	if (gpio_is_valid(bdata->button->gpio))
+	if (!IS_ERR_OR_NULL(bdata->button->gpiod))
 		cancel_delayed_work_sync(&bdata->work);
 	else
 		del_timer_sync(&bdata->release_timer);
@@ -465,7 +465,7 @@ static void gpio_keys_quiesce_key(void *data)
 static int gpio_keys_setup_key(struct platform_device *pdev,
 				struct input_dev *input,
 				struct gpio_button_data *bdata,
-				const struct gpio_keys_button *button)
+				struct gpio_keys_button *button)
 {
 	const char *desc = button->desc ? button->desc : "gpio_keys";
 	struct device *dev = &pdev->dev;
@@ -478,18 +478,32 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	bdata->button = button;
 	spin_lock_init(&bdata->lock);
 
-	if (gpio_is_valid(button->gpio)) {
+	/*
+	 * Legacy GPIO number so request the GPIO here and
+	 * convert it to descriptor.
+	 */
+	if (!button->gpiod && gpio_is_valid(button->gpio)) {
+		unsigned flags = GPIOF_IN;
+
+		if (button->active_low)
+			flags |= GPIOF_ACTIVE_LOW;
 
-		error = devm_gpio_request_one(&pdev->dev, button->gpio,
-					      GPIOF_IN, desc);
+		error = devm_gpio_request_one(&pdev->dev, button->gpio, flags,
+					      desc);
 		if (error < 0) {
 			dev_err(dev, "Failed to request GPIO %d, error %d\n",
 				button->gpio, error);
 			return error;
 		}
 
+		button->gpiod = gpio_to_desc(button->gpio);
+		if (!button->gpiod)
+			return -EINVAL;
+	}
+
+	if (!IS_ERR_OR_NULL(button->gpiod)) {
 		if (button->debounce_interval) {
-			error = gpio_set_debounce(button->gpio,
+			error = gpiod_set_debounce(button->gpiod,
 					button->debounce_interval * 1000);
 			/* use timer if gpiolib doesn't provide debounce */
 			if (error < 0)
@@ -500,12 +514,12 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 		if (button->irq) {
 			bdata->irq = button->irq;
 		} else {
-			irq = gpio_to_irq(button->gpio);
+			irq = gpiod_to_irq(button->gpiod);
 			if (irq < 0) {
 				error = irq;
 				dev_err(dev,
 					"Unable to get irq number for GPIO %d, error %d\n",
-					button->gpio, error);
+					desc_to_gpio(button->gpiod), error);
 				return error;
 			}
 			bdata->irq = irq;
@@ -575,7 +589,7 @@ static void gpio_keys_report_state(struct gpio_keys_drvdata *ddata)
 
 	for (i = 0; i < ddata->pdata->nbuttons; i++) {
 		struct gpio_button_data *bdata = &ddata->data[i];
-		if (gpio_is_valid(bdata->button->gpio))
+		if (!IS_ERR_OR_NULL(bdata->button->gpiod))
 			gpio_keys_gpio_report_event(bdata);
 	}
 	input_sync(input);
@@ -771,7 +785,7 @@ static int gpio_keys_probe(struct platform_device *pdev)
 		__set_bit(EV_REP, input->evbit);
 
 	for (i = 0; i < pdata->nbuttons; i++) {
-		const struct gpio_keys_button *button = &pdata->buttons[i];
+		struct gpio_keys_button *button = &pdata->buttons[i];
 		struct gpio_button_data *bdata = &ddata->data[i];
 
 		error = gpio_keys_setup_key(pdev, input, bdata, button);
-- 
1.9.1

