From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 1/4] Input: gpio_keys - store a pointer to driver_data in button_data
Date: Mon, 30 Oct 2017 18:40:47 +0100
Message-ID: <20171030174050.30375-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932673AbdJ3Rkz (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 30 Oct 2017 13:40:55 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

Instead of a pointer to the input_dev, store a pointer the
gpio_keys_drvdata struct in struct gpio_button_data, so that per button
ISRs can access the entire driver-data struct and we don't need to
store a copy of global state (e.g. the suspended flag) for each button.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
-This is a new patch in v3 of this patch-set
---
 drivers/input/keyboard/gpio_keys.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 87e613dc33b8..36ab7daba957 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -31,9 +31,11 @@
 #include <linux/of_irq.h>
 #include <linux/spinlock.h>
 
+struct gpio_keys_drvdata;
+
 struct gpio_button_data {
 	const struct gpio_keys_button *button;
-	struct input_dev *input;
+	struct gpio_keys_drvdata *ddata;
 	struct gpio_desc *gpiod;
 
 	unsigned short *code;
@@ -360,7 +362,7 @@ static const struct attribute_group gpio_keys_attr_group = {
 static void gpio_keys_gpio_report_event(struct gpio_button_data *bdata)
 {
 	const struct gpio_keys_button *button = bdata->button;
-	struct input_dev *input = bdata->input;
+	struct input_dev *input = bdata->ddata->input;
 	unsigned int type = button->type ?: EV_KEY;
 	int state;
 
@@ -388,19 +390,20 @@ static void gpio_keys_gpio_work_func(struct work_struct *work)
 	gpio_keys_gpio_report_event(bdata);
 
 	if (bdata->button->wakeup)
-		pm_relax(bdata->input->dev.parent);
+		pm_relax(bdata->ddata->input->dev.parent);
 }
 
 static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
 {
 	struct gpio_button_data *bdata = dev_id;
+	struct input_dev *input = bdata->ddata->input;
 
 	BUG_ON(irq != bdata->irq);
 
 	if (bdata->button->wakeup) {
 		const struct gpio_keys_button *button = bdata->button;
 
-		pm_stay_awake(bdata->input->dev.parent);
+		pm_stay_awake(input->dev.parent);
 		if (bdata->suspended  &&
 		    (button->type == 0 || button->type == EV_KEY)) {
 			/*
@@ -408,7 +411,7 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
 			 * already released by the time we got interrupt
 			 * handler to run.
 			 */
-			input_report_key(bdata->input, button->code, 1);
+			input_report_key(input, button->code, 1);
 		}
 	}
 
@@ -422,7 +425,7 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
 static void gpio_keys_irq_timer(struct timer_list *t)
 {
 	struct gpio_button_data *bdata = from_timer(bdata, t, release_timer);
-	struct input_dev *input = bdata->input;
+	struct input_dev *input = bdata->ddata->input;
 	unsigned long flags;
 
 	spin_lock_irqsave(&bdata->lock, flags);
@@ -437,7 +440,7 @@ static void gpio_keys_irq_timer(struct timer_list *t)
 static irqreturn_t gpio_keys_irq_isr(int irq, void *dev_id)
 {
 	struct gpio_button_data *bdata = dev_id;
-	struct input_dev *input = bdata->input;
+	struct input_dev *input = bdata->ddata->input;
 	unsigned long flags;
 
 	BUG_ON(irq != bdata->irq);
@@ -446,7 +449,7 @@ static irqreturn_t gpio_keys_irq_isr(int irq, void *dev_id)
 
 	if (!bdata->key_pressed) {
 		if (bdata->button->wakeup)
-			pm_wakeup_event(bdata->input->dev.parent, 0);
+			pm_wakeup_event(input->dev.parent, 0);
 
 		input_event(input, EV_KEY, *bdata->code, 1);
 		input_sync(input);
@@ -493,7 +496,7 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	int irq;
 	int error;
 
-	bdata->input = input;
+	bdata->ddata = ddata;
 	bdata->button = button;
 	spin_lock_init(&bdata->lock);
 
-- 
2.14.2

