From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/2] Input: gpio-keys: do not reference platform_data after .probe exits
Date: Tue, 19 Jul 2011 00:45:07 +0800
Message-ID: <1311007508-8096-2-git-send-email-shawn.guo@linaro.org>
References: <1311007508-8096-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33349 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171Ab1GRQeI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jul 2011 12:34:08 -0400
Received: by iyb12 with SMTP id 12so3245474iyb.19
        for <linux-input@vger.kernel.org>; Mon, 18 Jul 2011 09:34:07 -0700 (PDT)
In-Reply-To: <1311007508-8096-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>, Phil Blundell <pb@handhelds.org>, Dmitry Torokhov <dtor@mail.ru>

The patch makes a copy of platform data into driver data, so that any
reference to platform_data after .probe exits can be avoided.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Phil Blundell <pb@handhelds.org>
Cc: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/keyboard/gpio_keys.c |   45 +++++++++++++++++------------------
 1 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 97bada4..85b5685 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -27,7 +27,7 @@
 #include <linux/gpio.h>
 
 struct gpio_button_data {
-	struct gpio_keys_button *button;
+	struct gpio_keys_button button;
 	struct input_dev *input;
 	struct timer_list timer;
 	struct work_struct work;
@@ -111,7 +111,7 @@ static void gpio_keys_disable_button(struct gpio_button_data *bdata)
 		/*
 		 * Disable IRQ and possible debouncing timer.
 		 */
-		disable_irq(gpio_to_irq(bdata->button->gpio));
+		disable_irq(gpio_to_irq(bdata->button.gpio));
 		if (bdata->timer_debounce)
 			del_timer_sync(&bdata->timer);
 
@@ -132,7 +132,7 @@ static void gpio_keys_disable_button(struct gpio_button_data *bdata)
 static void gpio_keys_enable_button(struct gpio_button_data *bdata)
 {
 	if (bdata->disabled) {
-		enable_irq(gpio_to_irq(bdata->button->gpio));
+		enable_irq(gpio_to_irq(bdata->button.gpio));
 		bdata->disabled = false;
 	}
 }
@@ -167,13 +167,13 @@ static ssize_t gpio_keys_attr_show_helper(struct gpio_keys_drvdata *ddata,
 	for (i = 0; i < ddata->n_buttons; i++) {
 		struct gpio_button_data *bdata = &ddata->data[i];
 
-		if (bdata->button->type != type)
+		if (bdata->button.type != type)
 			continue;
 
 		if (only_disabled && !bdata->disabled)
 			continue;
 
-		__set_bit(bdata->button->code, bits);
+		__set_bit(bdata->button.code, bits);
 	}
 
 	ret = bitmap_scnlistprintf(buf, PAGE_SIZE - 2, bits, n_events);
@@ -215,11 +215,11 @@ static ssize_t gpio_keys_attr_store_helper(struct gpio_keys_drvdata *ddata,
 	for (i = 0; i < ddata->n_buttons; i++) {
 		struct gpio_button_data *bdata = &ddata->data[i];
 
-		if (bdata->button->type != type)
+		if (bdata->button.type != type)
 			continue;
 
-		if (test_bit(bdata->button->code, bits) &&
-		    !bdata->button->can_disable) {
+		if (test_bit(bdata->button.code, bits) &&
+		    !bdata->button.can_disable) {
 			error = -EINVAL;
 			goto out;
 		}
@@ -230,10 +230,10 @@ static ssize_t gpio_keys_attr_store_helper(struct gpio_keys_drvdata *ddata,
 	for (i = 0; i < ddata->n_buttons; i++) {
 		struct gpio_button_data *bdata = &ddata->data[i];
 
-		if (bdata->button->type != type)
+		if (bdata->button.type != type)
 			continue;
 
-		if (test_bit(bdata->button->code, bits))
+		if (test_bit(bdata->button.code, bits))
 			gpio_keys_disable_button(bdata);
 		else
 			gpio_keys_enable_button(bdata);
@@ -319,7 +319,7 @@ static struct attribute_group gpio_keys_attr_group = {
 
 static void gpio_keys_report_event(struct gpio_button_data *bdata)
 {
-	struct gpio_keys_button *button = bdata->button;
+	struct gpio_keys_button *button = &bdata->button;
 	struct input_dev *input = bdata->input;
 	unsigned int type = button->type ?: EV_KEY;
 	int state = (gpio_get_value_cansleep(button->gpio) ? 1 : 0) ^ button->active_low;
@@ -351,7 +351,7 @@ static void gpio_keys_timer(unsigned long _data)
 static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
 {
 	struct gpio_button_data *bdata = dev_id;
-	struct gpio_keys_button *button = bdata->button;
+	struct gpio_keys_button *button = &bdata->button;
 
 	BUG_ON(irq != gpio_to_irq(button->gpio));
 
@@ -494,7 +494,7 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 		unsigned int type = button->type ?: EV_KEY;
 
 		bdata->input = input;
-		bdata->button = button;
+		bdata->button = *button;
 
 		error = gpio_keys_setup_key(pdev, bdata, button);
 		if (error)
@@ -550,7 +550,6 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 
 static int __devexit gpio_keys_remove(struct platform_device *pdev)
 {
-	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
 	struct gpio_keys_drvdata *ddata = platform_get_drvdata(pdev);
 	struct input_dev *input = ddata->input;
 	int i;
@@ -559,13 +558,13 @@ static int __devexit gpio_keys_remove(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 0);
 
-	for (i = 0; i < pdata->nbuttons; i++) {
-		int irq = gpio_to_irq(pdata->buttons[i].gpio);
+	for (i = 0; i < ddata->n_buttons; i++) {
+		int irq = gpio_to_irq(ddata->data[i].button.gpio);
 		free_irq(irq, &ddata->data[i]);
 		if (ddata->data[i].timer_debounce)
 			del_timer_sync(&ddata->data[i].timer);
 		cancel_work_sync(&ddata->data[i].work);
-		gpio_free(pdata->buttons[i].gpio);
+		gpio_free(ddata->data[i].button.gpio);
 	}
 
 	input_unregister_device(input);
@@ -579,12 +578,13 @@ static int __devexit gpio_keys_remove(struct platform_device *pdev)
 static int gpio_keys_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
+	struct gpio_keys_drvdata *ddata = platform_get_drvdata(pdev);
 	int i;
 
 	if (device_may_wakeup(&pdev->dev)) {
-		for (i = 0; i < pdata->nbuttons; i++) {
-			struct gpio_keys_button *button = &pdata->buttons[i];
+		for (i = 0; i < ddata->n_buttons; i++) {
+			struct gpio_keys_button *button =
+						&ddata->data[i].button;
 			if (button->wakeup) {
 				int irq = gpio_to_irq(button->gpio);
 				enable_irq_wake(irq);
@@ -599,12 +599,11 @@ static int gpio_keys_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct gpio_keys_drvdata *ddata = platform_get_drvdata(pdev);
-	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
 	int i;
 
-	for (i = 0; i < pdata->nbuttons; i++) {
+	for (i = 0; i < ddata->n_buttons; i++) {
 
-		struct gpio_keys_button *button = &pdata->buttons[i];
+		struct gpio_keys_button *button = &ddata->data[i].button;
 		if (button->wakeup && device_may_wakeup(&pdev->dev)) {
 			int irq = gpio_to_irq(button->gpio);
 			disable_irq_wake(irq);
-- 
1.7.4.1

