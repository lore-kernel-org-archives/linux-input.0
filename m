From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] Input: gpio-keys - add gpiolib debounce support
Date: Sat, 26 Jun 2010 20:33:56 +0300
Message-ID: <1277573636-10345-1-git-send-email-notasas@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61128 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395Ab0FZReG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Jun 2010 13:34:06 -0400
Received: by wyb38 with SMTP id 38so886884wyb.19
        for <linux-input@vger.kernel.org>; Sat, 26 Jun 2010 10:34:01 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <me@felipebalbi.com>, Grazvydas Ignotas <notasas@gmail.com>

gpiolib now has debounce support added in .35, so let's make use of it.
This allows to use hardware GPIO debouncing on some platforms like OMAP.

In case gpiolib debounce setup fails for some GPIO, the driver will fall
back to timer based debouncing, which is what it used before.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/input/keyboard/gpio_keys.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index b8213fd..a9fd147 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -31,6 +31,7 @@ struct gpio_button_data {
 	struct input_dev *input;
 	struct timer_list timer;
 	struct work_struct work;
+	int timer_debounce;	/* in msecs */
 	bool disabled;
 };
 
@@ -109,7 +110,7 @@ static void gpio_keys_disable_button(struct gpio_button_data *bdata)
 		 * Disable IRQ and possible debouncing timer.
 		 */
 		disable_irq(gpio_to_irq(bdata->button->gpio));
-		if (bdata->button->debounce_interval)
+		if (bdata->timer_debounce)
 			del_timer_sync(&bdata->timer);
 
 		bdata->disabled = true;
@@ -347,9 +348,9 @@ static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
 
 	BUG_ON(irq != gpio_to_irq(button->gpio));
 
-	if (button->debounce_interval)
+	if (bdata->timer_debounce)
 		mod_timer(&bdata->timer,
-			jiffies + msecs_to_jiffies(button->debounce_interval));
+			jiffies + msecs_to_jiffies(bdata->timer_debounce));
 	else
 		schedule_work(&bdata->work);
 
@@ -383,6 +384,14 @@ static int __devinit gpio_keys_setup_key(struct platform_device *pdev,
 		goto fail3;
 	}
 
+	if (button->debounce_interval) {
+		error = gpio_set_debounce(button->gpio,
+					  button->debounce_interval * 1000);
+		/* use timer if gpiolib doesn't provide debounce */
+		if (error < 0)
+			bdata->timer_debounce = button->debounce_interval;
+	}
+
 	irq = gpio_to_irq(button->gpio);
 	if (irq < 0) {
 		error = irq;
@@ -498,7 +507,7 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
  fail2:
 	while (--i >= 0) {
 		free_irq(gpio_to_irq(pdata->buttons[i].gpio), &ddata->data[i]);
-		if (pdata->buttons[i].debounce_interval)
+		if (ddata->data[i].timer_debounce)
 			del_timer_sync(&ddata->data[i].timer);
 		cancel_work_sync(&ddata->data[i].work);
 		gpio_free(pdata->buttons[i].gpio);
@@ -526,7 +535,7 @@ static int __devexit gpio_keys_remove(struct platform_device *pdev)
 	for (i = 0; i < pdata->nbuttons; i++) {
 		int irq = gpio_to_irq(pdata->buttons[i].gpio);
 		free_irq(irq, &ddata->data[i]);
-		if (pdata->buttons[i].debounce_interval)
+		if (ddata->data[i].timer_debounce)
 			del_timer_sync(&ddata->data[i].timer);
 		cancel_work_sync(&ddata->data[i].work);
 		gpio_free(pdata->buttons[i].gpio);
-- 
1.6.3.3

